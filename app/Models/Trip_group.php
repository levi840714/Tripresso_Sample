<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Trip_group extends Model
{
    protected $table    = 'trip_group';
    protected $fillable = [
        'trip_id', 'start_date', 'amount', 'reward', 'last_people'
    ];

    // get group by trip id
    public function scopeGetTripGroup($query, $tripId)
    {
        $result = $query->select('id', 'trip_id', 'start_date', 'amount', 'reward', 'last_people')
            ->where('trip_id', $tripId)->get();
        return $result->isEmpty() ? [] : $result;
    }
}
