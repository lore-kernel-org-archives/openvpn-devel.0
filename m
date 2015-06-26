Message-ID: <558D268B.2070809@...1114...>
Date: Fri, 26 Jun 2015 12:16:43 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <558C0F5D.9060104@...2039...> <558C143F.30400@...1147...>
	<558C217F.7080607@...2039...>
In-Reply-To: <558C217F.7080607@...2039...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="g8UgMHT8kPnscFbTA8wjgI7J1h7xNKiuc"
Subject: Re: [Openvpn-devel] Windows build fix for CVE-2015-4000
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "Joseph S. Testa II" <jtesta@...2039...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--g8UgMHT8kPnscFbTA8wjgI7J1h7xNKiuc
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 25/06/15 17:42, Joseph S. Testa II wrote:
> On 06/25/2015 10:46 AM, Jan Just Keijser wrote:
>> Joseph S. Testa II wrote:
>>> Hi all,
>>>
>>>     I was wondering if an updated Windows build is being planned for
>>> release soon to fix CVE-2015-4000, et. al, as described in
>>> http://www.openssl.org/news/secadv_20150611.txt.
>>>
>>>     I haven't seen anyone talk about this on the mailing list since
>>> the advisory came out two weeks ago, so I thought I'd ask.

[...snip...]

> Thanks for the info.  How about the other CVE's listed in that OpenSSL=20
> advisory?  I'm not able to tell if they're an issue in conjunction with=20
> OpenVPN.  Has anyone done a review on them as well?

I'm no security expert, so bear that in mind.  But I believe I have been
poking long enough in the OpenVPN code base to have a certain overview
of the SSL/TLS stack used by OpenVPN.


* Malformed ECParameters causes infinite loop (CVE-2015-1788)
Elliptic curves support is very limited in OpenVPN and not widely used,
so I doubt this will be an issue on the client side.  Use of --tls-auth
should at least reduce the attack vector to one of your own users.


* Exploitable out-of-bounds read in X509_cmp_time (CVE-2015-1789)
This might be an issue on OpenVPN on the server side.  However,
--tls-auth will reduce the attack vector to one of your own users.

On the client side, I don't see how it could get a bad CRL file
installed and configured, and I don't recall any authentication
callbacks being used on the client side.  In addition, if the client got
a problem - there is an even bigger problem how the client managed to
connect to a faulty OpenVPN server.


* PKCS7 crash with missing EnvelopedContent (CVE-2015-1790)
AFAIR, we don't do much PKCS#7 handling, so most likely not an issue for
OpenVPN.  But this one should be double checked.


* CMS verify infinite loop with unknown hash function (CVE-2015-1792)
I haven't studied how OpenVPN verifies signed data, so this is unknown
at the moment - unless Steffan or James have investigated this.


* Race condition handling NewSessionTicket (CVE-2015-1791)
This is not an issue for OpenVPN in normal situations.  However, if an
attacker writes a special attack client using the OpenVPN protocol and
it uses multiple connections in parallel to the server, this might be an
issue.  But again, --tls-auth to the rescue, which reduces the possible
attacker to one of your own users.


* Invalid free in DTLS (CVE-2014-8176)
OpenVPN does not implement DTLS, so this isn't an issue for OpenVPN.


Bottom line:  --tls-auth is a fairly good protection layer against
OpenSSL (or PolarSSL/mbedTLS) issues.  And I would sleep quite well at
night if clients aren't updated to openssl 1.0.2b or 1.0.1n.


--=20
kind regards,

David Sommerseth


--g8UgMHT8kPnscFbTA8wjgI7J1h7xNKiuc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlWNJowACgkQDC186MBRfrqB5QCfS/fhPTwYCJkLKguB22yPZ4kI
9esAnRxxonXrDrC3Tx55oZyCi2k6QA8F
=c7oP
-----END PGP SIGNATURE-----

--g8UgMHT8kPnscFbTA8wjgI7J1h7xNKiuc--

