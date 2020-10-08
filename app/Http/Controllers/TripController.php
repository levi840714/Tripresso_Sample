<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Trip;
use App\Models\Tag;
use App\Models\Trip_group as Group;

class TripController extends Controller
{
    public function GetTrips(Request $request)
    {
        $tags = Tag::GetAllTag();
        $trips = Trip::GetAllTrip(Trip::OPEN);
        if ($trips->isEmpty()) {
            return response()->json(['code' => 1, 'msg' => 'no trip data', 'data' => []], 200);
        }

        $trips = $trips->each(function ($trip) {
            $trip['tags'] = json_decode($trip['tags']);
            $trip['group'] = Group::GetTripGroup($trip['id']);
        });
        return response()->json(['code' => 0, 'msg' => '', 'data' => ['tags' => $tags, 'trips' => $trips]], 200);
    }
}
