import ballerina/http;

type Package record {
    string packageId;
    string status;
    string sender;
    string recipient;
    string origin;
    string destination;
    string weight;
    string dimensions;
    string trackingId;
};

Package[] packages = [
    {packageId: "1", status: "Delivered", sender: "", recipient: "", origin: "", destination: "", weight: "", dimensions: "", trackingId: ""},
    {packageId: "2", status: "In Transit", sender: "", recipient: "", origin: "", destination: "", weight: "", dimensions: "", trackingId: ""},
    {packageId: "3", status: "Pending", sender: "", recipient: "", origin: "", destination: "", weight: "", dimensions: "", trackingId: ""}
];

type TrackingResponse record {
    string trackingId;
    string status;
    string companyName;
    WayPoint[] wayPoints;
};

type WayPoint record {
    string location;
    string timestamp;
};

service / on new http:Listener(9090) {

    resource function get track(string trackingId) returns TrackingResponse|error {
        return {
            trackingId: trackingId,
            status: "In Transit",
            companyName: "FedEx",
            wayPoints: [
                {location: "WH in Denver", timestamp: "2023-01-01T10:00:00Z"},
                {location: "Transit Hub UK", timestamp: "2023-01-03T14:00:00Z"},
                {location: "Sri Lanka Customs", timestamp: "2023-01-05T15:00:00Z"}
            ]
        };
    }

    resource function get packages() returns Package[]|error {
        // Logic to list all packages

        return packages;
    }

    resource function post packages(Package postData) returns Package|error {
        // Logic to add a new package
        return postData;
    }

    resource function get packages/[string id](string packageId) returns Package|error {
        // Logic to retrieve package details
        return {packageId: packageId, status: "In Transit", sender: "", recipient: "", origin: "", destination: "", weight: "", dimensions: "", trackingId: ""};
    }

    resource function put packages/[string id](string packageId, Package packageDetails) returns Package|error {
        // Logic to update package details
        return packageDetails;
    }

    resource function delete packages/[string id](string packageId) returns Package|error {
        // Logic to delete a package
        return {packageId: packageId, status: "Deleted", sender: "", recipient: "", origin: "", destination: "", weight: "", dimensions: "", trackingId: ""};
    }

}
