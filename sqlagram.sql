CREATE SCHEMA IF NOT EXISTS `sqlagram`;
USE `sqlagram`;

-- -----------------------------------------------------
-- Table `sqlagram`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sqlagram`.`users` (
  `user_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(32) NOT NULL,
  `password` VARCHAR(40) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `first_name` VARCHAR(255) NOT NULL,
  `last_name` VARCHAR(255) NOT NULL,
  `date_created` TIMESTAMP NOT NULL,
  PRIMARY KEY (`user_id`));

-- -----------------------------------------------------
-- Table `sqlagram`.`photos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sqlagram`.`photos` (
  `photo_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `caption` VARCHAR(255) NULL DEFAULT NULL,
  `image_path` VARCHAR(255) NOT NULL,
  `date_created` TIMESTAMP NOT NULL,
  `user_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`photo_id`, `user_id`),
  INDEX `fk_photos_users1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_photos_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `sqlagram`.`users` (`user_id`)
    ON DELETE CASCADE);

-- -----------------------------------------------------
-- Table `sqlagram`.`comments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sqlagram`.`comments` (
  `comment_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `comment` VARCHAR(255) NOT NULL,
  `photo_id` INT UNSIGNED NOT NULL,
  `user_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`comment_id`, `photo_id`, `user_id`),
  INDEX `fk_comments_photos1_idx` (`photo_id` ASC) VISIBLE,
  INDEX `fk_comments_users1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_comments_photos1`
    FOREIGN KEY (`photo_id`)
    REFERENCES `sqlagram`.`photos` (`photo_id`)
    ON DELETE CASCADE,
  CONSTRAINT `fk_comments_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `sqlagram`.`users` (`user_id`)
    ON DELETE CASCADE);

-- -----------------------------------------------------
-- Table `sqlagram`.`followers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sqlagram`.`followers` (
  `follower_id` INT UNSIGNED NOT NULL,
  `user_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`user_id`, `follower_id`),
  CONSTRAINT `fk_followers_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `sqlagram`.`users` (`user_id`)
    ON DELETE CASCADE);

-- -----------------------------------------------------
-- Table `sqlagram`.`likes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sqlagram`.`likes` (
  `user_id` INT UNSIGNED NOT NULL,
  `photo_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`user_id`, `photo_id`),
  INDEX `fk_likes_photos1_idx` (`photo_id` ASC) VISIBLE,
  CONSTRAINT `fk_likes_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `sqlagram`.`users` (`user_id`)
    ON DELETE CASCADE,
  CONSTRAINT `fk_likes_photos1`
    FOREIGN KEY (`photo_id`)
    REFERENCES `sqlagram`.`photos` (`photo_id`)
    ON DELETE CASCADE);