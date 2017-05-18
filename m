References: <20170518155020.GN97029@...1296...>
	<20170518192015.28402-1-davids@...515...>
	<20170518203703.GS97029@...1296...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <5cd03d58-abbc-be1e-b20f-444f8c9056bf@...2080...>
Date: Thu, 18 May 2017 22:48:32 +0200
MIME-Version: 1.0
In-Reply-To: <20170518203703.GS97029@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ULgRWNVRLIXLAJUgp2Kks3UjF5Kjo9Q4O"
Subject: Re: [Openvpn-devel] [PATCH] distro: Remove outdated RPM .spec file
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
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ULgRWNVRLIXLAJUgp2Kks3UjF5Kjo9Q4O
Content-Type: multipart/mixed; boundary="DkGbEPJXEH96pFBRE2LqwWiJRceuxGi6r";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Message-ID: <5cd03d58-abbc-be1e-b20f-444f8c9056bf@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] distro: Remove outdated RPM .spec file
References: <20170518155020.GN97029@...1296...>
	<20170518192015.28402-1-davids@...515...>
	<20170518203703.GS97029@...1296...>
In-Reply-To: <20170518203703.GS97029@...1296...>

--DkGbEPJXEH96pFBRE2LqwWiJRceuxGi6r
Content-Language: en-GB
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 18/05/17 22:37, Gert Doering wrote:
> Hi,
>=20
> On Thu, May 18, 2017 at 09:20:15PM +0200, David Sommerseth wrote:
>> Each RPM based distro have their own set of packaging guidelines.  We
>> don't adhere to any of them and we're bad at keeping this up-to-date.
>> Rather let distros take care of this job.
>=20
> Generally speaking, I'm fine with the change and the reasoning behind
> this.
>=20
> I do wonder, though, where a naive user would / should go looking for
> "the right .spec file" for his distribution now?  Say, I download this
> tarball, and want to build a RH RPM from it...  does it make sense
> to have a "spec-README.rst" or something that points to the spec files
> "the major distributions" use?

I don't know much out how those other package managers like yum/dnf does
it.  But there you just do:

    $ yumdownloader --source openvpn-2.4.2

 or

    $ dnf download --source openvpn-2.4.2

The SUSE universe uses, zypper instead of yum/dnf, so I presume there is
something similar.

In addition, anyone who have touched Fedora packaging also knows how to
use "fedpkg clone openvpn".

> (In case this is not obvious: I have no idea what I'm talking about,
> the only RPMs I've ever built are on AIX... :-) )

Ahh, AIX uses RPMs ... that is, well, kind of funny :)  Does it use any
tools on top of rpm itself?  (yum/dnf/zypper)


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--DkGbEPJXEH96pFBRE2LqwWiJRceuxGi6r--

--ULgRWNVRLIXLAJUgp2Kks3UjF5Kjo9Q4O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJZHgigAAoJEIbPlEyWcf3yMGcP/i1GObntYVvXXRopdpU9lxGH
3ojw/UAqJUs48qmxpLBf8qt+TWhrNciZAsLnE3gx9/2DR4reZkhJyFAFJj1yWyGw
hdjwqUumPuW1OqplZH2ksjGyJ1m7ZNNrPawwO7DXZZTAPr3KautvuXtHMjfx0JXn
meLXhh9x5RpMfil4kyBDjkBxcbZGTnslxai39AwLuTehPokbgo0TBFLrSQI9N1EC
fgHJab66qjdj2cfEe7nsroGW+WiJC5vNIYx0tKLVU5EsiNHx05IRAj/w5wMkoGOL
p5XeGO5/nGWaoQfpGABYz0UAedISmUOtUU2Wh3qUcyEt6ZXBaTaUmAvuRVtQAjxW
CvjlMJGFnp4qM/gLIu13rS3uccNeEulrNfFfC+ytNAKRXz+APh/+SZwt2HsuBGn6
rnz8OSrZb/QMSA3Ml5TNSdWMa2vNwjrDG7fHuPOVj/VaCBuovKrIKRzyfOCH61JH
+s+3rZZ5DOhLWEagBRxd4MCyG6O60YTwyRWg/cyL4XKub+jP7h80T+dZ4C5vitiu
hrCsSWmPgdRwd6aochiSzcr8WF8teyPZitpLdElA4d2Oemcvvq4PtlS9b4VkcCj9
Bc7UGLZz+7xym325R3tmJVGTGmynM8LBNSf5GF4nIPnrTN5VeTleoSvf6Ki97F2I
LTQBwTyE1OZ2vxz5/1R8
=kfTA
-----END PGP SIGNATURE-----

--ULgRWNVRLIXLAJUgp2Kks3UjF5Kjo9Q4O--

