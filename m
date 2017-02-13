References: <CAOAUwZH8aRg-5XLJaYjpzw6y9yptx-ma7QJVPJT-yKFE7cmUrw@...278...>
	<c3f91fee-f629-fd60-c66c-19d45df6f24f@...1856...>
	<CAOAUwZF0LYNAYESg1fKeNUhJr70pLcf89HTyxTQmf2S3RnoUBA@...278...>
	<0cdcbed7-801c-9cec-cd03-1252c06b4466@...1856...>
	<CAOAUwZEiSjAEmTka=w-4TePAoGEZBZG1r_5gS-wpXL+TLX7qCQ@...278...>
	<20170213083137.GK93896@...1296...>
	<CAOAUwZF2-KXfMTwOuLj-B3wzWtD-i-8NytNkbS3gyvexaCpWGw@...278...>
	<20170213175000.GU93896@...1296...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <b38fcbe0-fc2b-1bd5-ac98-f930334b6925@...2080...>
Date: Mon, 13 Feb 2017 20:37:13 +0100
MIME-Version: 1.0
In-Reply-To: <20170213175000.GU93896@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ipCT4wTfdNfFIQ1NrT8D6u98bNbtT9P1u"
Subject: Re: [Openvpn-devel] [PATCH] Fix building with LibreSSL 2.5.1 by
 cleaning a hack.
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Olivier W <olivierw.ml@...277...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ipCT4wTfdNfFIQ1NrT8D6u98bNbtT9P1u
Content-Type: multipart/mixed; boundary="3ae7Br10mcKh9kvcAcso3FjWPVRgOM5FI";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Olivier W <olivierw.ml@...277...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net
Message-ID: <b38fcbe0-fc2b-1bd5-ac98-f930334b6925@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Fix building with LibreSSL 2.5.1 by
	cleaning a hack.
References: <CAOAUwZH8aRg-5XLJaYjpzw6y9yptx-ma7QJVPJT-yKFE7cmUrw@...278...>
	<c3f91fee-f629-fd60-c66c-19d45df6f24f@...1856...>
	<CAOAUwZF0LYNAYESg1fKeNUhJr70pLcf89HTyxTQmf2S3RnoUBA@...278...>
	<0cdcbed7-801c-9cec-cd03-1252c06b4466@...1856...>
	<CAOAUwZEiSjAEmTka=w-4TePAoGEZBZG1r_5gS-wpXL+TLX7qCQ@...278...>
	<20170213083137.GK93896@...1296...>
	<CAOAUwZF2-KXfMTwOuLj-B3wzWtD-i-8NytNkbS3gyvexaCpWGw@...278...>
	<20170213175000.GU93896@...1296...>
In-Reply-To: <20170213175000.GU93896@...1296...>

--3ae7Br10mcKh9kvcAcso3FjWPVRgOM5FI
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 13/02/17 18:50, Gert Doering wrote:
> Hi,
>=20
> On Mon, Feb 13, 2017 at 06:46:11PM +0100, Olivier W wrote:
[...snip...]
>> Now I'm fighting with git which doesn't want to use gmail's smtp
>> server to send the email. My .gitconfigure file is similar to:
>> https://git-scm.com/docs/git-send-email#_example and I've added
>> "smtpsslcertpath =3D /etc/ssl/cert.pem" but I'm getting this error:
>> "STARTTLS failed!  at /usr/local/libexec/git-core/git-send-email line
>> 1371."
>> I'm currently searching for a solution.

smtpsslcertpath needs to point at a CA certificate which issued the SMTP
server certificate.  You can easily verify that things are correct by
grabbing the server certificate using openssl:

    $ openssl s_client -connect $SMTP_SERVER:$PORT -starttls smtp

Copy the certificate blob printed to stdout to a file.  Then take your
CA certificate (including full chain in a single file, where the root CA
certificate is the last one in file) and run this command:

    $ openssl verify -CAfile $CA_CERT_CHAIN $SERVER_CERT

The output should display the file of the server certificate and ": OK".

> That's a not exactly helpful error message... :( - I tend to just turn
> off SSL on stuff that goes to public mailing lists anyway if it causes
> issues...

OpenSSL errors requires quite some efforts to get used to.  And in
addition the git-send-email errors on top doesn't always make life easier.

>> BTW: sorry about the previous email: "[SPAM] [PATCH] Fix building with
>> LibreSSL 2.5.1 by cleaning a hack." :-/ I'm trying to not post anymore
>> buggy email here.

No worries!  As long as you don't spam us completely with non-sense, we
can handle a few misfires ;-)

> I've created my share of weird git e-mails in the past :-) - so what I've
> started to do is "send the mail to myself" (if possible, on a different
> account) and then verify if the result is what I want to see...

That's a good advice :)

--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--3ae7Br10mcKh9kvcAcso3FjWPVRgOM5FI--

--ipCT4wTfdNfFIQ1NrT8D6u98bNbtT9P1u
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJYogrtAAoJEIbPlEyWcf3ydZQQALKmteMKgJOoBnscYPVFv0Gx
T4HU1g35y2MDsCvG1b6Ee78R6plaIQnLGqOkBt6/a3WUYgUb9g7I06S7AgbPn41o
+YHVW9aMBlKxQGymVWqoH5dOLCqmoaMQMEe8Magxa4KGt3AIeSVTg+ePQ/x2NRhb
4ffa/zGtBwMqiBISuboC552kcn/V1FGf+202ETeg8+2FofKoclHQeiVpMIDe6jRt
voBIdKt2lZSf/N+INnIks7GAUdwUMTp53vP01zIUmxnM0GsXjaUZKlKh9p4wFsHX
x5T++bO/cIYhy5oHo6E/h016yX6UH9sPa+Tb1JQvLKXSpRoksOFVJxRvM+LSo76I
wiHPDrDczyh7aZVY9R4jzbHIbS7i5oKsX3VDoq/txvQTS+3YTyncE6PI+QYscu+b
IEbwPwScSWO9CHSCeYBGyNr4X3uOs/UerqgxUD+rviev1uLVRWzB2u5H1p5wKi6b
V5qKeoF3OiR6ReH1TAf8Ys5/98vUUvF5/G1FAXBJR8fKAh/oSPSy0g2pzC98gn2x
X53rpcwmPAT85ZZGO3D50kEVAKmUL/6UN1YB/aOd/4sa2g7rITHqdjycVJ2o7qqx
vVckPFZV0GUxvunuoFMvZZ7wu7iW2/OHog+Mk0dqc+0p7dRamavly3qmWGeM9kHA
NtA3DrfL3ll6YOFgeato
=sAAQ
-----END PGP SIGNATURE-----

--ipCT4wTfdNfFIQ1NrT8D6u98bNbtT9P1u--

