=pod
    vuldb_api_demo - Perl VulDB API Demo

    License: GPL-3.0
    Required Dependencies: 
        * strict
        * warnings
        * LWP
        * HTTP
    Optional Dependencies: None
=cut

use strict;
use warnings;
use LWP::UserAgent;
use HTTP::Request;
 
# API URL
my $url = "https://vuldb.com/?api";

# Headers for authentication
my $personal_api_key = ""; # Enter your personal API key here
my $user_agent = "VulDB API Advanced Perl Demo Agent";

# Request body parameters
my $recent  = "5"; 		# Default is 5
my $details = "0"; 		# Default is 0
my $id      = undef;		# Example: "290848", enter specific VulDB id to search for (Default value is undef)
my $cve     = undef;		# Example: "CVE-2024-1234", enter a CVE to search for (Default value is undef)

# Construct the request body
my $request_body;
if (!defined $id && !$cve) {
    $request_body = "recent=$recent&details=$details";
} elsif ($cve) {
    $request_body = "search=$cve&details=$details";
} else {
    $request_body = "id=$id&details=$details";
}

# Initialize the HTTP client
my $ua = LWP::UserAgent->new();
$ua->agent($user_agent);

# Create the HTTP request
my $request = HTTP::Request->new(POST => $url);
$request->header('X-VulDB-ApiKey' => $personal_api_key);
$request->content_type('application/x-www-form-urlencoded');
$request->content($request_body);

# Send the request
my $response = $ua->request($request);

# Handle the response
if ($response->is_success) {
    print "Response:\n" . $response->decoded_content . "\n";
} else {
    print "Request failed: " . $response->status_line . "\n";
}
