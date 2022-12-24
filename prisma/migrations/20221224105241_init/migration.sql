-- CreateTable
CREATE TABLE `access` (
    `id` BINARY(16) NOT NULL DEFAULT (uuid_to_bin(uuid())),
    `user_id` BINARY(16) NOT NULL,
    `role_id` BINARY(16) NOT NULL,

    UNIQUE INDEX `id_UNIQUE`(`id`),
    INDEX `fk_access_role1_idx`(`role_id`),
    INDEX `fk_access_user_idx`(`user_id`),
    PRIMARY KEY (`id`, `user_id`, `role_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `board` (
    `id` BINARY(16) NOT NULL DEFAULT (uuid_to_bin(uuid())),
    `name` VARCHAR(45) NOT NULL,
    `description` VARCHAR(200) NULL,
    `project_id` BINARY(16) NOT NULL,

    UNIQUE INDEX `id_UNIQUE`(`id`),
    INDEX `fk_board_project1_idx`(`project_id`),
    PRIMARY KEY (`id`, `project_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `grant` (
    `request_type_id` BINARY(16) NOT NULL,
    `role_id` BINARY(16) NOT NULL,

    INDEX `fk_grant_role1_idx`(`role_id`),
    PRIMARY KEY (`request_type_id`, `role_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `operation_type` (
    `id` BINARY(16) NOT NULL DEFAULT (uuid_to_bin(uuid())),
    `name` ENUM('create', 'read', 'update', 'delete') NOT NULL,

    UNIQUE INDEX `id_UNIQUE`(`id`),
    UNIQUE INDEX `name_UNIQUE`(`name`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `project` (
    `id` BINARY(16) NOT NULL DEFAULT (uuid_to_bin(uuid())),
    `name` VARCHAR(45) NOT NULL,
    `description` VARCHAR(45) NULL,
    `manager_id` BINARY(16) NOT NULL,
    `workspace_id` BINARY(16) NOT NULL,

    UNIQUE INDEX `id_UNIQUE`(`id`),
    INDEX `fk_project_user1_idx`(`manager_id`),
    INDEX `fk_project_workspace1_idx`(`workspace_id`),
    PRIMARY KEY (`manager_id`, `workspace_id`, `id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `request_type` (
    `id` BINARY(16) NOT NULL DEFAULT (uuid_to_bin(uuid())),
    `object_id` BINARY(16) NOT NULL,
    `operation_type_id` BINARY(16) NOT NULL,

    UNIQUE INDEX `id_UNIQUE`(`id`),
    INDEX `fk_request_type_operation_type1_idx`(`operation_type_id`),
    PRIMARY KEY (`id`, `object_id`, `operation_type_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `role` (
    `id` BINARY(16) NOT NULL DEFAULT (uuid_to_bin(uuid())),
    `name` ENUM('ProjectManager', 'ProjectUser', 'SystemAdministrator', 'WorkspaceManager') NOT NULL,

    UNIQUE INDEX `id_UNIQUE`(`id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `status` (
    `id` BINARY(16) NOT NULL DEFAULT (uuid_to_bin(uuid())),
    `name` ENUM('Done', 'BugFound', 'InReview', 'InProgress', 'ToDo', 'BackLog') NOT NULL,

    UNIQUE INDEX `id_UNIQUE`(`id`),
    UNIQUE INDEX `name_UNIQUE`(`name`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `task` (
    `id` BINARY(16) NOT NULL DEFAULT (uuid_to_bin(uuid())),
    `title` VARCHAR(45) NOT NULL,
    `description` VARCHAR(200) NULL,
    `photo` VARCHAR(100) NULL,
    `deadline` DATETIME(0) NULL,
    `board_id` BINARY(16) NOT NULL,

    UNIQUE INDEX `id_UNIQUE`(`id`),
    INDEX `fk_task_board1_idx`(`board_id`),
    PRIMARY KEY (`id`, `board_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `task_status` (
    `task_id` BINARY(16) NOT NULL,
    `status_id` BINARY(16) NOT NULL,

    INDEX `fk_task_status_status1_idx`(`status_id`),
    PRIMARY KEY (`task_id`, `status_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `user` (
    `id` BINARY(16) NOT NULL DEFAULT (uuid_to_bin(uuid())),
    `email` VARCHAR(45) NOT NULL,
    `username` VARCHAR(45) NOT NULL,
    `avatar` VARCHAR(100) NULL,

    UNIQUE INDEX `id_UNIQUE`(`id`),
    UNIQUE INDEX `email_UNIQUE`(`email`),
    UNIQUE INDEX `username_UNIQUE`(`username`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `workspace` (
    `id` BINARY(16) NOT NULL DEFAULT (uuid_to_bin(uuid())),
    `name` VARCHAR(45) NOT NULL,
    `description` VARCHAR(200) NULL,
    `owner_id` BINARY(16) NOT NULL,

    UNIQUE INDEX `id_UNIQUE`(`id`),
    UNIQUE INDEX `name_UNIQUE`(`name`),
    UNIQUE INDEX `owner_id_UNIQUE`(`owner_id`),
    INDEX `fk_workspace_user1_idx`(`owner_id`),
    PRIMARY KEY (`id`, `owner_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `access` ADD CONSTRAINT `fk_access_role` FOREIGN KEY (`role_id`) REFERENCES `role`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `access` ADD CONSTRAINT `fk_access_user` FOREIGN KEY (`user_id`) REFERENCES `user`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `board` ADD CONSTRAINT `fk_board_project` FOREIGN KEY (`project_id`) REFERENCES `project`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `grant` ADD CONSTRAINT `fk_grant_request` FOREIGN KEY (`request_type_id`) REFERENCES `request_type`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `grant` ADD CONSTRAINT `fk_grant_role` FOREIGN KEY (`role_id`) REFERENCES `role`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `project` ADD CONSTRAINT `fk_project_user` FOREIGN KEY (`manager_id`) REFERENCES `user`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `project` ADD CONSTRAINT `fk_project_workspace` FOREIGN KEY (`workspace_id`) REFERENCES `workspace`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `request_type` ADD CONSTRAINT `fk_request_operation` FOREIGN KEY (`operation_type_id`) REFERENCES `operation_type`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `task` ADD CONSTRAINT `fk_task_board` FOREIGN KEY (`board_id`) REFERENCES `board`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `task_status` ADD CONSTRAINT `fk_task_status_status` FOREIGN KEY (`status_id`) REFERENCES `status`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `task_status` ADD CONSTRAINT `fk_task_status_task` FOREIGN KEY (`task_id`) REFERENCES `task`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `workspace` ADD CONSTRAINT `fk_workspace_user` FOREIGN KEY (`owner_id`) REFERENCES `user`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
