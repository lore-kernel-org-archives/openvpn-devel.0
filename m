From: Steven Haigh <netwiz@...2277...>
Date: Sat, 08 Jul 2017 02:27:08 +1000
Message-ID: <3012771.c7NFhoKYci@...2289...>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2061514.rZSe0U6Upi";
	micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: [Openvpn-devel] RFCv2: Yubikey authentication for OpenVPN
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

--nextPart2061514.rZSe0U6Upi
Content-Type: multipart/mixed; boundary="nextPart2116710.z68aUiNQX9"
Content-Transfer-Encoding: 7Bit

This is a multi-part message in MIME format.

--nextPart2116710.z68aUiNQX9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

I have attached this script for comment to be considered for inclusion in t=
he=20
contrib section of openvpn to use the Yubico Yubicloud authentication for t=
he=20
Yubikey OTP.

Setup instructions are included in the top of the script file.

There is a current patch pending merging to fix client operation for auth=20
tokens by ordex and dazo.

Ticket details:
https://community.openvpn.net/openvpn/ticket/904

Happy to receive feedback on the script, its operation, or implementation.

--=20
Steven Haigh

=F0=9F=93=A7 netwiz@...2277...       =F0=9F=92=BB http://www.crc.id.au
=F0=9F=93=9E +61 (3) 9001 6090    =F0=9F=93=B1 0412 935 897=

--nextPart2116710.z68aUiNQX9
Content-Disposition: attachment; filename="yubikey-auth-tokens"
Content-Transfer-Encoding: 7Bit
Content-Type: application/x-perl; name="yubikey-auth-tokens"

#!/usr/bin/perl
# Copyright (c) 2017 Steven Haigh <netwiz@...2277...>
# https://www.crc.id.au
# Licensed under the GPL version 2

# PURPOSE: This script automatically can be used to handle authentication
# of Yubikey enabled accounts for One Time Password (OTP) use.

# INSTALL NOTES:
# Place this script in /etc/openvpn and use the following in your server
# configuration file:

# script-security 2
# client-connect          /etc/openvpn/yubikey-auth-tokens
# client-disconnect       /etc/openvpn/yubikey-auth-tokens
# auth-user-pass-verify   /etc/openvpn/yubikey-auth-tokens via-file
# client-cert-not-required

# If you wish to use Client Certificate + username + OTP for authentication
# exclude the 'client-cert-not-required' option and use any other guide on
# how to manage the certificate side of authentication.

# USAGE NOTES:
# To set up your Yubikey in Yubico OTP mode, use the personalisation tool
# in "Yubico OTP mode", and choose 'Quick' setup. Be sure to generate new
# values and then use the 'Upload to Yubico' to activate your key within
# the Yubico Validation Server.

# Edit the %yubikeys definition below to include your chosen username and
# the first 12 digits of one of your Yubico OTP passwords.

# If you have a Yubico API ID, you may substitute the $yubico_id value
# for your own, or use the default '16'.

# The token store specified in $tokenstore should point to a file in a
# directory that openvpn can write to. Tokens will be stored here between
# renegotions. The token will be deleted at last access + 2 hours, or
# when the client disconnects.

# NOTE: Tokens are only removed when something triggers a read of the
# tokens file. This can be a new client connecting, a renegotiation or
# a client disconnecting.

# ------------------ CODE BEGINS HERE -----------------
use strict;
use warnings;
use Fcntl qw( :flock );
use Storable qw( retrieve store_fd );
use LWP::UserAgent;
use LWP::Protocol::https;
use MIME::Base64 qw( encode_base64 );

my $yubico_id = '16';
my %yubikeys = (
	# username		#yubikey ID
	'yubikey'	=> "vvaaaaaaaaaa",
);
my $tokenstore = "/etc/openvpn/jail/token_store.bin";

$| = 1;

sub load_tokenstore(){
	my %tokens = ();
	if ( -f $tokenstore ) { 
		%tokens = %{ retrieve($tokenstore) };
	}

	## Expire tokens that should be expired.
	foreach my $key ( keys %tokens ) {
		if ( $tokens{$key}{expires} < time ) {
			delete $tokens{$key};
		}
	}

	return %tokens;
}

sub write_tokenstore(\%) {
	my $hashref = shift;
	open ( my $STORE, ">$tokenstore" ) || die "Unable to open token store: $!\n";
	flock $STORE, LOCK_EX;
	store_fd $hashref, \*$STORE;
	close $STORE;
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
	if ( $password =~ m/^Token:/ ) {
		print "Performing token authentication for user: $username\n";
		$password =~ s/^Token://g;

		## Load the token database.
		my %tokens = load_tokenstore(); 
		my $key = $ENV{'dev'} . '-' . $ENV{'trusted_ip'} . '-' . $ENV{'trusted_port'};
		$tokens{$key}{'expires'} = time + 7200; ## Push the expiry back another 2 hours
		write_tokenstore(%tokens);

		if ( $password eq $tokens{$key}{'token'} ) {
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
	my $key = $ENV{'dev'} . '-' . $ENV{'trusted_ip'} . '-' . $ENV{'trusted_port'};
	
	## Create our random data.
	open ( my $random, "<", "/dev/random");
	read $random, my $random_data, 128;
	close $random;
	my $token = encode_base64($random_data, "");

	my $push = 'push "auth-token Token:' . $token . '"' . "\n";
	print "Pushing Auth-Token: $token\n";

	## Add the token to the token store.
	my %tokens = load_tokenstore(); 
	$tokens{$key}{'token'} = $token;
	$tokens{$key}{'expires'} = time + 7200; ## Expire in now + 2 hours.
	write_tokenstore(%tokens);

	open my $fh, '>', $ARGV[0];
	print $fh $push . "\n";
	close $fh;
	exit 0;
}

## Handle client disconnects by nuking the token.
elsif ( $ENV{'script_type'} eq "client-disconnect" ) {
	print "Handling client disconnect. Nuking token\n";
	my $key = $ENV{'dev'} . '-' . $ENV{'trusted_ip'} . '-' . $ENV{'trusted_port'};
	my %tokens = load_tokenstore();
	if ( defined( $tokens{$key} ) ) {
		delete $tokens{$key};
	}
	write_tokenstore(%tokens);
}

else {
	print "We should never get here unless we have the wrong config!\n";
	exit 1;
}

exit 1;

--nextPart2116710.z68aUiNQX9--

--nextPart2061514.rZSe0U6Upi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEFHf0gfgNrH6ofcYGQa811Xp9MdwFAllftlwACgkQQa811Xp9
MdwuUw/9EEvAkVjNg2HtGFFxXcRrhTr3slnSvgJol5Oh66JI1THAgpwv7hBgOHNk
XFVxDYiE0445SKH/SeiGaAwK7kROAWB/745qqvT/ozFsvDxLB1PWIleTmcLtBVPz
hEfqxhIDQNO3PhXH9exLg59XD/Bc51Q1DJHSMU17X2z3/ZotF72bSfuaS7kq2FhM
cSP0gM4W14V01AMHochyXdev+qRlEeugDKPlJhKJGjwV13ecFRohAvhoMpgnE0O4
4QBjQV7T3RnGosZGrJwAvoBi8wWNw4EWnoGLKoDMFh00MTHQHOd/RNNFW9Eyg4Nb
NZukr7oD1s7fw1GfdhWNl7u5C/aSIjJRP2oqLCjXjWlwrL87NbaU5bf+kR02Nf0X
wuqo4TocNQltSxXc5liyfUsmte7X9R+kNMtcwX6WwtqqjuB39q3ICtOMPFLszH75
YkvgXZc8ihDO9J5/RRUAxG7snlYlThkFmmDS6dtto1DDDA3gxWoBsJYjHYRgMrqH
78ncs0jwp0L47b6RSAMMcHyAGbAatAwGgpn5fL8Us/YUbJExfnswPrRsdhEfcuLg
g/n1LerEKRUAdR2qePqmR1Qicma2su/sDONoyclpnioq4sFC5oNYk1lAAkz2smFB
Bk5KZjSE93wQDMypvchFKwH4MR46LFp7/9r+W+GwehD36KMKPr4=
=vUB+
-----END PGP SIGNATURE-----

--nextPart2061514.rZSe0U6Upi--


