<?php

class Service
{

    static function getServiceById($title)
    {
        global $db;
        $query = "SELECT * FROM service WHERE title='" . $title . "'";
        $result = mysqli_query($db, $query);
        return $result->fetch_array(MYSQLI_ASSOC);
    }

    static function createService($title, $price, $description)
    {
        global $db;
        $query = "INSERT INTO service (title, price, description) 
                  VALUES (?, ?, ?)";
        $stmt = $db->prepare($query);
        if ($stmt)
            $stmt->bind_param("sds", $title, $price, $description);
        $service = null;
        if ($stmt->execute()) {
            $service = self::getServiceById($title);
        }
        return $service;
    }

    static function getServiceList()
    {
        global $db;
        $query = "SELECT * FROM service";
        $result = mysqli_query($db, $query);
        return $result->fetch_all(MYSQLI_ASSOC);
    }

    static function updateService($title, $price, $description)
    {
        global $db;
        $stmt = $db->prepare("SELECT * FROM service WHERE title = ?;");
        $stmt->bind_param('s', $title);
        $stmt->execute();
        $stmt->store_result();
        if ($stmt->num_rows === 1) {
            $query = "UPDATE service SET price = ?, description =? WHERE title= ?;";
            $stmt = $db->prepare($query);
            $stmt->bind_param('dss',  $price, $description, $title);
        }
        $service = null;
        if ($stmt->execute()) {
            $service = self::getServiceById($title);
        }
        return $service;
    }

    static function deleteService($title)
    {
        global $db;
        $stmt = $db->prepare("SELECT * FROM service WHERE title = ?;");
        $stmt->bind_param('s', $title);
        $service = $stmt->execute();
        $stmt->store_result();
        $count = $stmt->num_rows;
        if ($count === 1) {
            $query = "DELETE FROM service WHERE title = ?";
            $stmt = $db->prepare($query);
            $stmt->bind_param('s', $title);
            if ($stmt->execute()) {
                $count = $stmt->num_rows;
            }
        }
        if ($count) {
            return $service;
        }
        else {
            return null;
        }
    }
}