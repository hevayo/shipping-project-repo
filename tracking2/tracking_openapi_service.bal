import ballerina/http;
import ballerina/io;
import ballerina/os;

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

string order_url = os:getEnv("ORDER_URL");
string order_key = os:getEnv("ORDER_CONSUMER_KEY");
string order_secret = os:getEnv("ORDER_CONSUMER_SECRET");
string order_token_url = os:getEnv("ORDER_TOKEN_URL");

http:Client orderClient = check new (order_url,
    auth = {
        tokenUrl: order_token_url,
        clientId: order_key,
        clientSecret: order_secret
    }
);

http:Client shippingClient = check new ("http://shippingservice-858154062:9090/");

type Order record {
    int id;
    string trackingNumber;
};

type WayPointsItem record {
    string location;
    string timestamp;
};

type ShippingResponse record {
    string trackingId;
    string status;
    string companyName;
    WayPointsItem[] wayPoints;
};

service / on new http:Listener(9090) {

    resource function get track(string orderId) returns TrackingResponse|http:NotFound|http:InternalServerError|string {

        Order|error orderRes = orderClient->get("/order/" + orderId);

        if (orderRes is error) {
            io:println("Error in getting order details");
            return <http:NotFound>{
                body: "Order not found"
            };
        }

        ShippingResponse|error shippingRes = shippingClient->get("/track/?trackingId=" + orderRes.trackingNumber);
        if (shippingRes is error) {
            io:println("Error occurred: ", shippingRes);
            return <http:NotFound>{body: "Tracking Not Found"};
        }

        return convert(orderRes, shippingRes);
    }
}

function convert(Order orderRes, ShippingResponse shippingRes) returns TrackingResponse => {
    orderId: orderRes.id.toString(),
    shippingCompany: shippingRes.companyName,
    previousLocations: shippingRes.wayPoints,
    status: shippingRes.status
};
