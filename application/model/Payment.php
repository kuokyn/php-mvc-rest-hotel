<?php

class Payment
{
    static function getPaymentList()
    {
        global $db;
        $query = "SELECT booking_id, service_title, count(*) AS amount_of_services, service.price*count(*) AS total_price
                    FROM booking_service
                    JOIN service ON service.title=service_title
                    GROUP BY booking_id, service_title
                    ORDER BY booking_id";
        $result = mysqli_query($db, $query);
        return $result->fetch_all(MYSQLI_ASSOC);
    }
}