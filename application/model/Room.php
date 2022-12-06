<?php

class Room
{

    static function getRoomById($id)
    {
        global $db;
        $query = "SELECT * FROM room WHERE id='" . $id . "'";
        $result = mysqli_query($db, $query);
        return $result->fetch_array(MYSQLI_ASSOC);
    }

    static function createRoom($id, $chambers, $people, $room_type_title)
    {
        global $db;
        $query = "INSERT INTO room (id, chambers, people, room_type_title) 
                  VALUES (?, ?, ?, ?)";
        $stmt = $db->prepare($query);
        if ($stmt)
            $stmt->bind_param("iiis", $id, $chambers, $people, $room_type_title);
        $room = null;
        if ($stmt->execute()) {
            $room = self::getRoomById($id);
        }
        return $room;
    }

    static function getRoomList()
    {
        global $db;
        $query = "SELECT * FROM room";
        $result = mysqli_query($db, $query);
        return $result->fetch_all(MYSQLI_ASSOC);
    }

    static function updateRoom($id, $chambers, $people, $room_type_title)
    {
        global $db;
        $stmt = $db->prepare("SELECT * FROM room WHERE id = ?;");
        $stmt->bind_param('i', $id);
        $stmt->execute();
        $stmt->store_result();
        if ($stmt->num_rows === 1) {
            $query = "UPDATE room SET chambers = ?, people =?, room_type_title= ? WHERE id= ?;";
            $stmt = $db->prepare($query);
            $stmt->bind_param('iisi',  $chambers, $people, $room_type_title, $id);
        }
        $room = null;
        if ($stmt->execute()) {
            $room = self::getRoomById($id);
        }
        return $room;
    }

    static function deleteRoom($id)
    {
        global $db;
        $stmt = $db->prepare("SELECT * FROM room WHERE id = ?;");
        $stmt->bind_param('i', $id);
        $room = $stmt->execute();
        $stmt->store_result();
        $count = $stmt->num_rows;
        if ($count === 1) {
            $query = "DELETE FROM room WHERE id = ?";
            $stmt = $db->prepare($query);
            $stmt->bind_param('i', $id);
            if ($stmt->execute()) {
                $count = $stmt->num_rows;
            }
        }
        if ($count) {
            return $room;
        }
        else {
            return null;
        }
    }
}