// AUTO-GENERATED FILE.
// This file is auto-generated by the Ballerina OpenAPI tool.

public type PreviousLocations record {
    string location?;
    string timestamp?;
};

public type TrackingResponse record {
    string orderId?;
    string status?;
    string location?;
    PreviousLocations[] previousLocations?;
};
