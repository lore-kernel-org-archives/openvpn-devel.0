From: Steven Haigh <netwiz@...2277...>
Date: Wed, 14 Jun 2017 23:32:41 +1000
Message-ID: <4598001.fBjbu4afFW@...2278...>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2197060.FYnua5RNp7";
	micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: [Openvpn-devel] RFC: Yubikey authentication for OpenVPN.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net
Cc: David Sommerseth <davids@...515...>

--nextPart2197060.FYnua5RNp7
Content-Type: multipart/mixed; boundary="nextPart3447012.pchaQZehC7"
Content-Transfer-Encoding: 7Bit

This is a multi-part message in MIME format.

--nextPart3447012.pchaQZehC7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

No further comments or requests on the openvpn-users lists. Reposting here =
for=20
further criticism / comments :)

I did have one thought though, do I need to put any kind of banner at the t=
op=20
of the script as a 'maintainer' or such?

I have attached this script for comment to be considered for inclusion in t=
he=20
contrib section of openvpn to use the Yubico Yubicloud authentication for t=
he=20
Yubikey OTP.

Place the script in /etc/openvpn and configure as follows:

script-security 2
client-connect          /etc/openvpn/yubikey-auth-tokens
auth-user-pass-verify   /etc/openvpn/yubikey-auth-tokens via-file
client-cert-not-required
username-as-common-name

Right now, this requires 'reneg-sec 0' be set in the openvpn server config=
=20
file due to some issues in handling auth tokens in various configurations -=
=20
however hopefully when this gets fixed, it will keep the connection running=
=20
with an auth-token after the initial authentication by OTP.

Edit the yubikey-auth-tokens script and edit the %yubikeys hash with your l=
ist=20
of usernames and associated yubikey IDs.

Happy to receive feedback on the script, its operation, or implementation.

--=20
Steven Haigh

=F0=9F=93=A7 netwiz@...2277...	=F0=9F=92=BB http://www.crc.id.au
=F0=9F=93=9E +61 (3) 9001 6090	=F0=9F=93=B1 0412 935 897=

--nextPart3447012.pchaQZehC7
Content-Disposition: attachment; filename="yubikey-auth-tokens"
Content-Transfer-Encoding: 7Bit
Content-Type: application/x-perl; name="yubikey-auth-tokens"

#!/usr/bin/perl
use strict;
use warnings;
use LWP::UserAgent;
use LWP::Protocol::https;
use Digest::SHA qw( hmac_sha256_hex );
use MIME::Base64 qw( encode_base64 );

my $yubico_id = '16';
my %yubikeys = (
	# username          #yubikey ID
	'yubikey'	=> "vvaabbccddee",
);

$| = 1;

## Generate the auth-token for use after the OTP has worked.
sub generate_token($) {
	my $time = shift;
	my $to_auth = $time . '-' . $ENV{'common_name'} . '-' . $ENV{'ifconfig_pool_remote_ip'};
	my $secret = $ENV{'trusted_ip'} . '-' . $ENV{'daemon_start_time'} . '-' . $ENV{'daemon_pid'};
	my $digest = encode_base64(hmac_sha256_hex($to_auth, $secret), "");
	return $digest;
}

if ( $ENV{'script_type'} eq "user-pass-verify" ) {
	my $auth_file = $ARGV[0];

	## Read the auth file.
	open my $fh, '<', $auth_file;
	chomp(my @lines = <$fh>);
	close $fh;

	my $username = $lines[0];
	my $password = $lines[1];

	## Ensure we have a valid entry for the expected username.
	if ( ! defined( $yubikeys{$username} ) ) {
		print "No yubikey enabled for $username\n";
		exit 1;
	}

	## If we have the start of a yubikey, validate the OTP against yubico.
	if ( $password =~ m/^${yubikeys{$username}}/ ) {
		## Check the yubikey entry is valid.
		print "Attempting Yubikey authentication for user: $username\n";
		my $ua = LWP::UserAgent->new;
		$ua->timeout(10);
		my $res = $ua->get( "https://api.yubico.com/wsapi/verify?id=$yubico_id&otp=$password" );
	
		## Only go further if the request was successful.
		if ( ! $res->is_success ) {
			print "Error querying the YubiCo Servers: " . $res->status_line . " - " . $res->decoded_content . "\n";
			exit 1;
		}

		## Pull out the status returned from YubiCo.
		my $result = "";
		if ( $res->decoded_content =~ m/status=(\w+)/ ) {
			$result = $1;
		}

		## Allow access on ONLY an OK response.
		if ( $result eq "OK" ) {
			print "Yubikey authentication successful for user: $username\n";
			exit 0;
		} else {
			print "Yubikey authentication for user $username failed with result: $result\n";
			exit 1;
		}
	}

	## We may have a token, not an OTP... Check.
	if ( $password =~ m/^\d{10}:/ ) {
		print "Performing token authentication for $username\n";
		my ($time, $token) = split(/:/, $password);
		my $digest = generate_token($time);
		if ( $digest eq $token ) {
			print "Token authentication successful for user: $username\n";
			exit 0;
		} else {
			print "Token authentication failed for user: $username\n";
			exit 1;
		}
	}

	## Fall back to an authentication failed error.
	print "Authentication failed for user $username\n";
	exit 1;
} 

## Handle generation of the auth-token to be pushed to the client.
elsif ( $ENV{'script_type'} eq "client-connect" ) {
	my $time = time;
	my $digest = generate_token($time);
	my $token = 'push "auth-token ' . $time . ':' . $digest . '"';
	print "Pushing Auth-Token: $token\n";

	open my $fh, '>', $ARGV[0];
	print $fh $token . "\n";
	close $fh;
	exit 0;
}

else {
	print "We should never get here unless we have the wrong config!\n";
	exit 1;
}

exit 1;

--nextPart3447012.pchaQZehC7--

--nextPart2197060.FYnua5RNp7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEFHf0gfgNrH6ofcYGQa811Xp9MdwFAllBOvoACgkQQa811Xp9
MdxsHBAAlt4ip9+4QKercndSLO54YkrT/wDa8k1dgiGjKyYMJ11J+nqo1XkcCfbY
A+EvqT1FZsmZQNwefR1sDQzGH+MB9eFQvqln3YkEsFxgiorOuZS4cRRHCyasOwh/
JOK7uNh8OW240WkcJI/WXBT5ZHIXcyF3Fk5FUglcoO1OgTuqbJGN5JBbtYvLv4MV
Kekw3UwDfzN3vOI+9fWlom0s3XPajphrGX6MFR7QdYOnCxuAngKPR0sqHfRdcp09
CkIOnW3roMe0XSW2trMWxfZfuZARmv9wT6vZy1jRgl37GYF+eikV400dW7F4XSVK
TJ0GoHzjjOb/2OzYT0vRg81KDbjiSqz7Rhnb0kp24dE2GIOCdoXq3tjzuqBQ1Dyp
byBzO3iAWrWHpwrTfnodQBZXx69YuGHLykrmyKmToXCDoFhxeuEuDfD/zuvKPDhf
3zif6U8eGvuUZk5UNfmu/WU0g86ar0Zy32bt5iKUjVzNgvKMMju1bpQ1embxHn/E
+DCDazF1+dL9+SxyIuzUfGC2JkctO1FtBfVpfGCYnqcpW9fHhCGlBY9IuFz0RQD1
fjpHGABdjbLcelCGuwORuTpJ8313BKA8Aoxd+tjHJHE40N9QXIPUxyAUci1HtRU1
hla83JGj7rCe7eRa6azbVHnQ5ktuIQpNbdMKNc+RiiwCm3puLZg=
=vcOe
-----END PGP SIGNATURE-----

--nextPart2197060.FYnua5RNp7--


