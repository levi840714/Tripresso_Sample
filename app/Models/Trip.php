<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Trip extends Model
{
    protected $table    = 'trip';
    protected $fillable = [
        'code', 'title', 'region', 'score', 'tags', 'people', 'days', 'status'
    ];

    const OPEN = '1';
    public function scopeGetAllTrip($query, $status)
    {
        return $query->select('id', 'code', 'title', 'region', 'score', 'tags', 'people', 'days', 'status')
            ->where('status', $status)->get();
    }
}
