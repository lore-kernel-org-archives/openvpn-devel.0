Message-ID: <5217726B.9000304@...1114...>
Date: Fri, 23 Aug 2013 16:32:11 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <51C77F12.1090802@...515...> <5210B1EB.7000409@...1227...>
	<20130821072739.GG16543@...1296...>
	<52147A34.7050406@...1227...> <521684EA.2030202@...1114...>
	<20130823070132.GV16543@...1296...>
In-Reply-To: <20130823070132.GV16543@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="5IBFlqw99GGSIREUBwLknhTWrwmgknMdr"
Subject: Re: [Openvpn-devel] [PATCH] TLS versioning
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: James Yonan <james@...515...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, openvpn-users@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5IBFlqw99GGSIREUBwLknhTWrwmgknMdr
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 23/08/13 09:01, Gert Doering wrote:
> Hi,
>=20
> On Thu, Aug 22, 2013 at 11:38:50PM +0200, David Sommerseth wrote:
>> However, I understand that some firmware "vendors" doesn't have the same=
=20
>> "quick" turn-over as RHEL does.  So I think I would rather let these old=
=20
>> firmwares run OpenVPN 2.0 or 2.1 and let them support their own ancient=
=20
>> code base on their own.  We need to move forward and not cling to the ol=
d=20
>> days forever.
>=20
> This is not about "our source does not compile with 0.96 anymore" -=20
> it's about "2.3 with the TLS changes does not *talk* to OpenVPN=20
> 2.2-compiled-with-0.96 anymore"

Fully understood!

> (so asking the router vendors to
> use OpenVPN 2.1 or 2.0 instead won't exactly improve things as the
> TLS handshake code would be the same).
>=20
> If this hits two users out of the whole Android user base, I tend to
> "well, bad luck, get your router firmware updated"

Well, that was actually _exactly_ what I meant :)

> - if it hits more "mainstream" users, we'll need to have a better
> answer.

I generally have no bad feelings if we state publicly that OpenVPN
doesn't support any older OpenSSL libraries than 0.9.8 (or 0.9.7, if
insisting hard), even if OpenVPN compiles with them.  Running anything
that old is a security risk (and has been for quite a while [1]).  So I
see no reason why we should make it easier for anyone in these cases.
We've ditched Win2k and RHEL4 support for similar convenience reasons as
well.


[1] Last update to 0.9.6 was in March 2004
    Last update to 0.9.7 was in Feb 2007.
    0.9.8 and newer are getting updates.
    <https://www.openssl.org/source/>


--=20
kind regards,

David Sommerseth


--5IBFlqw99GGSIREUBwLknhTWrwmgknMdr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlIXcm4ACgkQDC186MBRfrryrwCgpeDt0No/THC+rr+pHXfBs5d2
J9gAn0WsZ8R9aQZZbm9SenSdl6irYmBp
=OkHR
-----END PGP SIGNATURE-----

--5IBFlqw99GGSIREUBwLknhTWrwmgknMdr--

