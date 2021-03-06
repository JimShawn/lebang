package com.youmayon.lebang.service.impl;

import com.youmayon.lebang.data.UserTaskRepository;
import com.youmayon.lebang.domain.*;
import com.youmayon.lebang.enums.Role;
import com.youmayon.lebang.enums.UserStatus;
import com.youmayon.lebang.enums.UserTaskStatus;
import com.youmayon.lebang.service.TaskService;
import com.youmayon.lebang.service.UserService;
import com.youmayon.lebang.service.UserTaskLogService;
import com.youmayon.lebang.service.UserTaskService;
import com.youmayon.lebang.util.TimeUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import javax.persistence.TypedQuery;
import javax.persistence.criteria.CriteriaQuery;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Jawinton on 17/05/04.
 */
@Service
public class UserTaskServiceImpl implements UserTaskService {
    @Autowired
    UserTaskRepository userTaskRepository;

    @Autowired
    TaskService taskService;

    @Autowired
    UserTaskLogService userTaskLogService;

    @Autowired
    UserService userService;

    @Override
    @Transactional
    public UserTask receiveTask(UserTask userTask, Task task) {
        // check task amount limit
        if (task.getEachPersonLimit() > 0) {
            Assert.isTrue(count(userTask.getAppId(), userTask.getAppUserId(), userTask.getTaskId()) < task.getEachPersonLimit(), "您领取的任务数量已达到上限。");
        }

        // check task day cycle
        if (task.getRecycleDaysLimit() > 0) {
            UserTask latestReceivedUserTask = findOne(userTask.getAppId(), userTask.getAppUserId(), userTask.getTaskId());
            if (latestReceivedUserTask != null) {
                Assert.isTrue(TimeUtil.daysBetween(latestReceivedUserTask.getCreatedTime(), userTask.getCreatedTime()) >= task.getRecycleDaysLimit(), "您最近" + task.getRecycleDaysLimit() + "天已领取过该任务。");
            }
        }

        // decrease task left amount.
        Assert.isTrue(task.getLeftAmount() > 0, "No task any more.");
        task.setLeftAmount(task.getLeftAmount() - 1);
        taskService.save(task);

        // save user task
        UserTask savedUserTask = userTaskRepository.save(userTask);

        // save log
        UserTaskLog userTaskLog = new UserTaskLog();
        userTaskLog.setUserTaskId(savedUserTask.getId());
        userTaskLog.setOperatorAppId(userTask.getAppId());
        userTaskLog.setOperatorAppUserId(userTask.getAppUserId());
        userTaskLog.setCreatedTime(userTask.getCreatedTime());
        userTaskLog.setFromStatus(userTask.getStatus());
        userTaskLog.setToStatus(userTask.getStatus());
        userTaskLogService.save(userTaskLog);

        return savedUserTask;
    }

    @Override
    @Transactional
    public UserTask completeTask(UserTask userTask, Task task, int fromStatus) {
        // set review end time
        long reviewHours = (task.getReviewPeriod() == null || task.getReviewPeriod() == 0L) ? Integer.MAX_VALUE / 3600 : task.getReviewPeriod();
        userTask.setReviewEndTime(userTask.getCompletedTime() + reviewHours * 3600);

        // set reviewer user id.
        User reviewerUser = userService.findOneRandomUser(Role.ROLE_TASK_REVIEWER.name(), UserStatus.NORMAL.value());
        if (reviewerUser != null) {
            userTask.setReviewerUserId(reviewerUser.getId());
        }

        // save user task
        UserTask savedUserTask = userTaskRepository.save(userTask);

        // increase task completed amount.
        task.setCompletedAmount(task.getCompletedAmount() + 1);
        taskService.save(task);

        // save log
        UserTaskLog userTaskLog = new UserTaskLog();
        userTaskLog.setUserTaskId(savedUserTask.getId());
        userTaskLog.setOperatorAppId(userTask.getAppId());
        userTaskLog.setOperatorAppUserId(userTask.getAppUserId());
        userTaskLog.setCreatedTime(userTask.getCompletedTime());
        userTaskLog.setFromStatus(fromStatus);
        userTaskLog.setToStatus(savedUserTask.getStatus());
        userTaskLogService.save(userTaskLog);

        return savedUserTask;
    }

    @Override
    public UserTask reviewTask(User user, UserTask userTask, Task task, int toStatus) {
        // save user task
        UserTask savedUserTask = userTaskRepository.save(userTask);

        // increase task accepted amount.
        if (toStatus == UserTaskStatus.ACCEPTED.value()) {
            task.setAcceptedAmount(task.getAcceptedAmount() + 1);
            taskService.save(task);
        }

        // save log
        UserTaskLog userTaskLog = new UserTaskLog();
        userTaskLog.setUserTaskId(savedUserTask.getId());
        userTaskLog.setOperatorUserId(user.getId());
        userTaskLog.setCreatedTime(userTask.getCompletedTime());
        userTaskLog.setFromStatus(UserTaskStatus.COMPLETED.value());
        userTaskLog.setToStatus(toStatus);
        userTaskLogService.save(userTaskLog);

        return savedUserTask;
    }

    @Override
    public UserTask findOne(long id) {
        return userTaskRepository.findOne(id);
    }

    @Override
    public UserTask findOne(String appId, String appUserId, long taskId) {
        return userTaskRepository.findFirstByAppIdAndAppUserIdAndTaskIdOrderByCreatedTimeDesc(appId, appUserId, taskId);
    }

    @Override
    public int count(String appId, String appUserId, long taskId) {
        return userTaskRepository.countByAppIdAndAppUserIdAndTaskId(appId, appUserId, taskId);
    }

    @Override
    public List<TaskAppStatistics> receivedAmountOfTaskIdAndAppId(long beginTime, long endTime) {
        List<Object[]> resultList = userTaskRepository.taskAppReceivedAmount(beginTime, endTime);
        List<TaskAppStatistics> taskAppStatisticsList = new ArrayList<>();
        for (Object[] objects : resultList) {
            if (objects.length != 2) {
                continue;
            }
            UserTask userTask = (UserTask) objects[0];
            Long receivedAmount = (Long) objects[1];
            TaskAppStatistics taskAppStatistics = new TaskAppStatistics();
            taskAppStatistics.setTaskId(userTask.getTaskId());
            taskAppStatistics.setAppId(userTask.getAppId());
            taskAppStatistics.setBeginTime(beginTime);
            taskAppStatistics.setEndTime(endTime);
            taskAppStatistics.setReceivedAmount(receivedAmount);
            taskAppStatisticsList.add(taskAppStatistics);
        }
        return taskAppStatisticsList;
    }

    @Override
    public List<TaskAppStatistics> completedAmountOfTaskIdAndAppId(long beginTime, long endTime) {
        List<Object[]> resultList = userTaskRepository.taskAppCompletedAmount(beginTime, endTime);
        List<TaskAppStatistics> taskAppStatisticsList = new ArrayList<>();
        for (Object[] objects : resultList) {
            if (objects.length != 2) {
                continue;
            }
            UserTask userTask = (UserTask) objects[0];
            Long completedAmount = (Long) objects[1];
            TaskAppStatistics taskAppStatistics = new TaskAppStatistics();
            taskAppStatistics.setTaskId(userTask.getTaskId());
            taskAppStatistics.setAppId(userTask.getAppId());
            taskAppStatistics.setBeginTime(beginTime);
            taskAppStatistics.setEndTime(endTime);
            taskAppStatistics.setCompletedAmount(completedAmount);
            taskAppStatisticsList.add(taskAppStatistics);
        }
        return taskAppStatisticsList;
    }

    @Override
    public List<TaskAppStatistics> acceptedAmountAndTotalFlowOfTaskIdAndAppId(long beginTime, long endTime) {
        List<Object[]> resultList = userTaskRepository.taskAppAcceptedAmountAndTotalFlow(beginTime, endTime);
        List<TaskAppStatistics> taskAppStatisticsList = new ArrayList<>();
        for (Object[] objects : resultList) {
            if (objects.length != 3) {
                continue;
            }
            UserTask userTask = (UserTask) objects[0];
            Long acceptedAmount = (Long) objects[1];
            Double totalFlow = (Double) objects[2];
            TaskAppStatistics taskAppStatistics = new TaskAppStatistics();
            taskAppStatistics.setTaskId(userTask.getTaskId());
            taskAppStatistics.setAppId(userTask.getAppId());
            taskAppStatistics.setBeginTime(beginTime);
            taskAppStatistics.setEndTime(endTime);
            taskAppStatistics.setAcceptedAmount(acceptedAmount);
            taskAppStatistics.setTotalFlow(totalFlow);
            taskAppStatisticsList.add(taskAppStatistics);
        }
        return taskAppStatisticsList;
    }

    @Override
    public List<ReviewerTaskStatistics> acceptedAmountOfReviewer(long beginTime, long endTime) {
        List<Object[]> resultList = userTaskRepository.reviewerTaskAcceptedAmount(beginTime, endTime);
        List<ReviewerTaskStatistics> reviewerTaskStatisticsList = new ArrayList<>();
        for (Object[] objects : resultList) {
            if (objects.length != 2) {
                continue;
            }
            UserTask userTask = (UserTask) objects[0];
            Long acceptedAmount = (Long) objects[1];
            ReviewerTaskStatistics reviewerTaskStatistics = new ReviewerTaskStatistics();
            reviewerTaskStatistics.setReviewerUserId(userTask.getReviewerUserId());
            reviewerTaskStatistics.setBeginTime(beginTime);
            reviewerTaskStatistics.setEndTime(endTime);
            reviewerTaskStatistics.setAcceptedAmount(acceptedAmount);
            reviewerTaskStatisticsList.add(reviewerTaskStatistics);
        }
        return reviewerTaskStatisticsList;
    }

    @Override
    public List<ReviewerTaskStatistics> reviewedAmountOfReviewer(long beginTime, long endTime) {
        List<Object[]> resultList = userTaskRepository.reviewerTaskReviewedAmount(beginTime, endTime);
        List<ReviewerTaskStatistics> reviewerTaskStatisticsList = new ArrayList<>();
        for (Object[] objects : resultList) {
            if (objects.length != 2) {
                continue;
            }
            UserTask userTask = (UserTask) objects[0];
            Long reviewedAmount = (Long) objects[1];
            ReviewerTaskStatistics reviewerTaskStatistics = new ReviewerTaskStatistics();
            reviewerTaskStatistics.setReviewerUserId(userTask.getReviewerUserId());
            reviewerTaskStatistics.setBeginTime(beginTime);
            reviewerTaskStatistics.setEndTime(endTime);
            reviewerTaskStatistics.setReviewedAmount(reviewedAmount);
            reviewerTaskStatisticsList.add(reviewerTaskStatistics);
        }
        return reviewerTaskStatisticsList;
    }
}
