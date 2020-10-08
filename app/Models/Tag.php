<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Tag extends Model
{
    protected $table    = 'tag';
    protected $fillable = [
        'name', 'detail', 'hasDetail'
    ];

    public function scopeGetAllTag($query)
    {
        return $query->select('id', 'name', 'detail', 'hasDetail')->get();
    }
}
