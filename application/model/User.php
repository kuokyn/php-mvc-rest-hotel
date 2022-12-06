<?php

class User
{

    static function getUserByPhone($phone)
    {
        global $db;
        $query = "SELECT * FROM user WHERE phone='" . $phone . "'";
        $result = mysqli_query($db, $query);
        return $result->fetch_array(MYSQLI_ASSOC);
    }

    static function createUser($name, $email, $surname, $password, $authority_title, $phone)
    {
        global $db;
        $query = "INSERT INTO user (phone, name, email, surname, password, authority_title) 
                  VALUES (?, ?, ?, ?,?,?)";
        $stmt = $db->prepare($query);
        if ($stmt)
            $stmt->bind_param("ssssss", $phone, $name, $email, $surname, $password, $authority_title);
        $user = null;
        if ($stmt->execute()) {
            $user = self::getUserByPhone($phone);
        }
        return $user;
    }

    static function getUserList()
    {
        global $db;
        $query = "SELECT * FROM user";
        $result = mysqli_query($db, $query);
        return $result->fetch_all(MYSQLI_ASSOC);
    }

    static function updateUser($name, $email, $surname, $password, $authority_title, $phone)
    {
        global $db;
        $stmt = $db->prepare("SELECT * FROM user WHERE phone = ?;");
        $stmt->bind_param('s', $phone);
        $stmt->execute();
        $stmt->store_result();
        if ($stmt->num_rows === 1) {
            $query = "UPDATE user SET name = ?, email =?, surname= ?,  password= ?,  authority_title= ? WHERE phone= ?;";
            $stmt = $db->prepare($query);
            $stmt->bind_param('ssssss', $name, $email, $surname, $password, $authority_title, $phone);
        }
        $user = null;
        if ($stmt->execute()) {
            $user = self::getUserByPhone($phone);
        }
        return $user;
    }

    static function deleteUser($phone)
    {
        global $db;
        $stmt = $db->prepare("SELECT * FROM user WHERE phone = ?;");
        $stmt->bind_param('s', $phone);
        $user = $stmt->execute();
        $stmt->store_result();
        $count = $stmt->num_rows;
        if ($count === 1) {
            $query = "DELETE FROM user WHERE phone = ?";
            $stmt = $db->prepare($query);
            $stmt->bind_param('s', $phone);
            if ($stmt->execute()) {
                $count = $stmt->num_rows;
            }
        }
        if ($count) {
            return null;
        }
        else {
            return $user;
        }
    }
}