References: <8925EED7-0E13-4DEE-B3F8-1A5E3E970F4A@...277...>
	<20170517191418.GF97029@...1296...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <7e53d2f9-40c3-a009-e34f-983cbc3d509b@...2080...>
Date: Thu, 18 May 2017 17:06:43 +0200
MIME-Version: 1.0
In-Reply-To: <20170517191418.GF97029@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="QGuQoRT8wFprvSwFOmgHkaMGaSgp97lH3"
Subject: Re: [Openvpn-devel] [PATCH] OpenVPN rpm packaging - iproute2 support
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, Adam ??tevko <adam.stevko@...277...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QGuQoRT8wFprvSwFOmgHkaMGaSgp97lH3
Content-Type: multipart/mixed; boundary="VRx73xWRAnuWUku2Uhs7OFaPPkc3XQp1g";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Gert Doering <gert@...1296...>, Adam ??tevko <adam.stevko@...277...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <7e53d2f9-40c3-a009-e34f-983cbc3d509b@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] OpenVPN rpm packaging - iproute2 support
References: <8925EED7-0E13-4DEE-B3F8-1A5E3E970F4A@...277...>
	<20170517191418.GF97029@...1296...>
In-Reply-To: <20170517191418.GF97029@...1296...>

--VRx73xWRAnuWUku2Uhs7OFaPPkc3XQp1g
Content-Language: en-GB
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 17/05/17 21:14, Gert Doering wrote:
> Hi,
>=20
> On Wed, May 17, 2017 at 10:53:58AM +0200, Adam ??tevko wrote:
>> this patch adds support to build openvpn rpms with iproute2 support. It'=
s a rather simple change, which defaults to off. Please review.
>=20
> Is there a particular reason not to *always* build with iproute2 support?
>=20
> David, what can a program expect to find on RPM based distributions?

It would surprise me if any of them these days don't have iproutes
available.

> (Is this .spec file what Fedora builds use?)

Far from that. This .spec file is again horridly outdated, and I've done
a ton of updates on the Fedora .spec files.

To be very honest, I've been considering to strip the .spec file from
our project.  The approach of shipping a .spec made sense in the "old
days" when the .spec file was merely just a script tackling a source
tarball and patches; when distros where not that different from each
other.  But just looking at difference in the packaging guidelines
between SUSE and Fedora today is just the first headache.  Even though
they mostly agree, they also have subtle different preferences on how to
do things.  Like, is the package called iproute or iproute2 ?

Of course we could have a massive .spec file doing all the right things
with lots of %if blocks .... but ... no, thank you very much! :)

So then we would need to pick a flavour, or having a spec file per
distro.  And if we're doing that, we can rather just gather a list of
pointers to various RPM distros' .spec files instead - with a "pick the
one closest to your need".  Those .spec files are hopefully better
maintained than our .spec file will most likely be.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--VRx73xWRAnuWUku2Uhs7OFaPPkc3XQp1g--

--QGuQoRT8wFprvSwFOmgHkaMGaSgp97lH3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJZHbiPAAoJEIbPlEyWcf3y4c4P/2aZF6hk+jNIvGJ5vn3KsFe4
a2rawh7AqYcXfJiA0o7omV37vI8V0AhGAOyARNUR4ilqD5e4XNKb1JSyDSufQbjP
ZzwW4BuG8foR+wecGFoY0h2b+O2/NvLuML/ENW4gtafEVSgyGW8DAIzQ6AXXQkSo
IKJoFcrI5j6QHW4XZdCRutWStWbakw2as0Ow9WG2UlL4gnFCqYZu6nBRMd+8XMiA
BftCXfcunZHfWcCI/6Nvrbng+z7Waragbo70HwXee2KpqAL47nDpS5yONWcgx+ba
wNGBbFlHPsCPq4ihBOnm5552G9QLRZl2ZwbwIs13Uv3ykUTct/fWiOr1p5gyyfpi
YTXxwbQSiU/znnoi37PQw/eyOye9tnVPNKIkGwMkAbwrw0Lnl+ABjgxVFIxTp8wJ
PZ1BiV3YJsbH53iLkcezAYtynvq3gpLbcj/No4FAcrkcNrPrn/+6DZfi9vVp6lZ7
T5QSlfj0RrlNO45Deli3U9xchIMsn87feOWbyrYTnEsdtErlwJJG1duH1MXUFBbo
1cbYpwT1HkGyQeYdtc3H24dOviaCejI1+soI2WgLZs9qKJe2oc1zzfGokfDhcAVI
CZFGGTMAKLvvK+QlborS6z7OLGm6Ql9wPQDviQQjit5Frw3giRcaSFhWcL8mlp4L
/Xj6erHZubNVyENKRMh+
=mLmk
-----END PGP SIGNATURE-----

--QGuQoRT8wFprvSwFOmgHkaMGaSgp97lH3--

