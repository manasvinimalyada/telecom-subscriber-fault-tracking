-- schema.sql
-- ----------
-- Idi Phase 3 lo run chestam. Ippude create cheysthunnam, kani execute
-- Phase 3 lo MySQL Workbench / terminal nunchi chestam.

CREATE DATABASE IF NOT EXISTS telecom_fault_tracking
  CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE telecom_fault_tracking;

-- ---------------------------------------------------------------
-- users: login + role-based access (Admin / Technician)
-- ---------------------------------------------------------------
CREATE TABLE IF NOT EXISTS users (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    username        VARCHAR(50)  NOT NULL UNIQUE,
    email           VARCHAR(120) NOT NULL UNIQUE,
    password_hash   VARCHAR(255) NOT NULL,
    role            ENUM('admin', 'technician') NOT NULL DEFAULT 'technician',
    status          ENUM('active', 'inactive') NOT NULL DEFAULT 'active',
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- ---------------------------------------------------------------
-- subscribers: telecom customers
-- ---------------------------------------------------------------
CREATE TABLE IF NOT EXISTS subscribers (
    id               INT AUTO_INCREMENT PRIMARY KEY,
    subscriber_code  VARCHAR(20)  NOT NULL UNIQUE,
    full_name        VARCHAR(100) NOT NULL,
    mobile           VARCHAR(15)  NOT NULL UNIQUE,
    email            VARCHAR(120),
    address          VARCHAR(255),
    city             VARCHAR(100),
    area             VARCHAR(100) NOT NULL,
    service_type     VARCHAR(50),
    plan             VARCHAR(50),
    activation_date  DATE,
    status           ENUM('active', 'inactive') NOT NULL DEFAULT 'active',
    created_at       TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at       TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_subscriber_area (area)
);

-- ---------------------------------------------------------------
-- technicians
-- ---------------------------------------------------------------
CREATE TABLE IF NOT EXISTS technicians (
    id               INT AUTO_INCREMENT PRIMARY KEY,
    technician_code  VARCHAR(20)  NOT NULL UNIQUE,
    name             VARCHAR(100) NOT NULL,
    email            VARCHAR(120) NOT NULL UNIQUE,
    phone            VARCHAR(15)  NOT NULL,
    area             VARCHAR(100) NOT NULL,
    specialization   VARCHAR(100),
    availability     ENUM('available', 'busy', 'offline') NOT NULL DEFAULT 'available',
    status           ENUM('active', 'inactive') NOT NULL DEFAULT 'active',
    created_at       TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at       TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_technician_area (area)
);

-- ---------------------------------------------------------------
-- faults: the core complaint-tracking table
-- ---------------------------------------------------------------
CREATE TABLE IF NOT EXISTS faults (
    id                      INT AUTO_INCREMENT PRIMARY KEY,
    fault_code              VARCHAR(20) NOT NULL UNIQUE,
    subscriber_id           INT NOT NULL,
    fault_type              VARCHAR(50) NOT NULL,
    description             TEXT,
    service_affected        VARCHAR(50),
    area                    VARCHAR(100) NOT NULL,
    severity                ENUM('minor', 'moderate', 'major', 'severe') NOT NULL DEFAULT 'minor',
    affected_users          INT DEFAULT 1,
    priority                ENUM('low', 'medium', 'high', 'critical') NOT NULL DEFAULT 'low',
    priority_score          INT DEFAULT 0,
    status                  ENUM('reported', 'assigned', 'in_progress', 'resolved', 'closed') NOT NULL DEFAULT 'reported',
    assigned_technician_id  INT NULL,
    reported_at             TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    assigned_at             TIMESTAMP NULL,
    started_at              TIMESTAMP NULL,
    resolved_at             TIMESTAMP NULL,
    closed_at               TIMESTAMP NULL,
    diagnosis               TEXT,
    resolution_notes        TEXT,
    created_by              INT NOT NULL,
    updated_at              TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    FOREIGN KEY (subscriber_id) REFERENCES subscribers(id) ON DELETE RESTRICT,
    FOREIGN KEY (assigned_technician_id) REFERENCES technicians(id) ON DELETE SET NULL,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE RESTRICT,

    INDEX idx_fault_area (area),
    INDEX idx_fault_status (status),
    INDEX idx_fault_priority (priority)
);

-- ---------------------------------------------------------------
-- fault_history: audit trail of every status change
-- ---------------------------------------------------------------
CREATE TABLE IF NOT EXISTS fault_history (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    fault_id    INT NOT NULL,
    old_status  VARCHAR(20),
    new_status  VARCHAR(20) NOT NULL,
    updated_by  INT NOT NULL,
    remarks     VARCHAR(255),
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (fault_id) REFERENCES faults(id) ON DELETE CASCADE,
    FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE RESTRICT
);
