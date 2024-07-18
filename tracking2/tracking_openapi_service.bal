import ballerina/http;



public type TrackingResponse record {
    string orderId?;
    string status?;
    string shippingCompany?;
    PreviousLocations[] previousLocations?;
};

public type PreviousLocations record {
    string location?;
    string timestamp?;
};

service / on new http:Listener(9090) {

    resource function get track(string orderId) returns TrackingResponse|http:NotFound|http:InternalServerError|string {
        return "Hello from Tracking";
    }
}
