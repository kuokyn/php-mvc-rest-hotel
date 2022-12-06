<?php

class Booking
{

    static function getBookingById($id)
    {
        global $db;
        $query = "SELECT * FROM booking WHERE id='" . $id . "'";
        $result = mysqli_query($db, $query);
        return $result->fetch_array(MYSQLI_ASSOC);
    }

    static function createBooking($room_id, $user_id, $check_in_date, $check_out_date, $people)
    {
        global $db;
        $query = "INSERT INTO booking (room_id, user_id, check_in_date ,check_out_date, people) 
                  VALUES (?, ?, ?, ?, ?)";
        $stmt = $db->prepare($query);
        if ($stmt) {
            $stmt->bind_param('iissi', $room_id, $user_id, $check_in_date, $check_out_date, $people);
        }
        return $stmt->execute();
    }

    static function getBookingList()
    {
        global $db;
        $query = "SELECT * FROM booking";
        $result = mysqli_query($db, $query);
        return $result->fetch_all(MYSQLI_ASSOC);
    }

    static function updateBooking($id, $room_id, $user_id, $check_in_date, $check_out_date, $people)
    {
        global $db;
        $query = "UPDATE booking SET room_id = ?, user_id=?, check_in_date=?, check_out_date=?, people =? WHERE id= ?";
        $stmt = $db->prepare($query);
        if ($stmt) {
            $stmt->bind_param('iissii', $room_id, $user_id, $check_in_date, $check_out_date, $people, $id);
        }
        $booking = null;
        if ($stmt->execute()) {
            $booking = self::getBookingById($id);
        }
        return $booking;
    }

    static function deleteBooking($id)
    {
        global $db;
        $stmt = $db->prepare("SELECT * FROM booking WHERE id = ?;");
        $stmt->bind_param('i', $id);
        $booking = $stmt->execute();
        $stmt->store_result();
        $count = $stmt->num_rows;
        if ($count === 1) {
            $query = "DELETE FROM booking WHERE id = ?";
            $stmt = $db->prepare($query);
            $stmt->bind_param('i', $id);
            if ($stmt->execute()) {
                $count = $stmt->num_rows;
            }
        }
        if ($count) {
            return null;
        }
        else {
            return $booking;
        }
    }
}
