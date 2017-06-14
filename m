From: Steven Haigh <netwiz@...2277...>
Date: Thu, 15 Jun 2017 02:17:34 +1000
Message-ID: <5013988.5T9MeTnAcM@...2278...>
In-Reply-To: <eaa0b2b4-f10b-d22c-0252-37545a74df9d@...2080...>
References: <4598001.fBjbu4afFW@...2278...>
	<eaa0b2b4-f10b-d22c-0252-37545a74df9d@...2080...>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6516453.avz6i3pXtb";
	micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [Openvpn-devel] RFC: Yubikey authentication for OpenVPN.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--nextPart6516453.avz6i3pXtb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thursday, 15 June 2017 12:05:49 AM AEST David Sommerseth wrote:
> On 14/06/17 15:32, Steven Haigh wrote:
> > Hi all,
> >=20
> > No further comments or requests on the openvpn-users lists.
> > Reposting here for further criticism / comments :)
> >=20
> > I did have one thought though, do I need to put any kind of banner
> > at the top of the script as a 'maintainer' or such?
>=20
> I have actually quickly tested this script, and it works fine with my
> yubikey test token.
>=20
> One remark which needs to be highlighted is that this implementation
> uses single-factor OTP authentication.  But the OTP code used in this
> mode is fairly long, so it is reasonably secure (and still far better
> than static human passwords).  The token codes are generated using
> keying material which is pre-loaded to a Yubikco server - which
> essentially provides the authentication via a HTTPS request.
>=20
> I think this is a reasonably good starting point.
>=20
> What is needed is to have some kind of copyright header in the top of
> the file (as a "larger" comment block).  This copyright needs to carry
> a license which is compatible to GPLv2.  You can put yourself as the
> copyright holder, which implicitly puts you as a maintainer and
> contact person if there are issues.
>=20
> What would be good in addition is to either inside this Perl script or
> as a README file describing what you need to do to get this working.
> Reasonable "talking points" could be:
>=20
>    - Configuring your Yubikey token  (at least point at Yubikey docs)
>    - Emphasize that the token must be registered at YubiCloud (or the
>      validation server being used)
>    - Highlight what needs to be changed in the Perl script
>      to enable new users.
>=20
> For more advanced topics ... using your own Yubikey validation server,
> like using this one: <https://developers.yubico.com/yubikey-val/>

I've taken this onboard. I've added the following text to the top of the=20
script:

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

# ------------------ CODE BEGINS HERE -----------------

--=20
Steven Haigh

=F0=9F=93=A7 netwiz@...2277...	=F0=9F=92=BB http://www.crc.id.au
=F0=9F=93=9E +61 (3) 9001 6090	=F0=9F=93=B1 0412 935 897=

--nextPart6516453.avz6i3pXtb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEFHf0gfgNrH6ofcYGQa811Xp9MdwFAllBYZ4ACgkQQa811Xp9
Mdxi5w//Uuf+QYJFZ/JTLZSgXrTEeIbSFTWoayU0gH9v88wK3qbV4Q/NbpDcihiv
CFwRMzDfIgKUoFp6tC8xgK7pjVAnrP2TM4wX1M6fwE8jeNdIg/yc0J+XHTNkLwFL
2SllwF0NnJxPTKzp2Ogab9IVtOwNgNokCA+7EaO1UKak11L0adM1+kvFZWs/1uW5
/iwW0ZxquqaDg5VNaJ6LZc3bmJkDd3e9YCXYxWnX5biWnDdJ26L9gcoJdSRBM1Y1
FuyPCw3aerqdVilTDcr8yRDiY1AjagIZ5f4t7MZW04pQcm4N5Q5rh6sD3ZRgz1yG
p/S1mtQvII5soBMSnIUICrRCa+pAUWC1yP3Sq9DydGtOsARzv2vXMySL1GTwOhb3
GCBmUy/FlI9wVpTOnL/akiPFHCs20VmnE0SPDYVI2D6M9Ij40ZHNQjOkRqjvKLbX
WYAEdEV61Mta/7DUt8HNoq0cv3LTgST4E8wxSQW6pUtkHpQoJc0e3LW7FJdRWpr+
HA5w969a84gFvegwEPBCv/4Trc0AaEMF2qDl+jOYUHaqVxB0vW0CRvrH7NDxKr+/
FVL60LpZ6BPUdNzhLoHfYX7Z++zLCWcxprSJi48/uIdbyH9Ka6AClRkhpkveP1Tq
BTsxIN8DY0jjlc90pT8GcXLn6F/PGDRzPUSJ6SR6zo8LAQHGi2U=
=OZR7
-----END PGP SIGNATURE-----

--nextPart6516453.avz6i3pXtb--


