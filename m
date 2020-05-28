From: David Sommerseth <openvpn@...2080...>
Message-ID: <cfd28619-9250-d563-2e17-b2686f11e4c0@...2080...>
Date: Thu, 28 May 2020 16:55:20 +0200
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="SZglT4unQnjXhvxrv0Rw5x5rK19xsVmkh"
Subject: [Openvpn-devel] man page overhaul project
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SZglT4unQnjXhvxrv0Rw5x5rK19xsVmkh
Content-Type: multipart/mixed; boundary="TyXTeG2a99YIbrvqq1ZQ0TD1lPjkrZgwH";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: "openvpn-devel@lists.sourceforge.net"
 <openvpn-devel@lists.sourceforge.net>
Message-ID: <cfd28619-9250-d563-2e17-b2686f11e4c0@...2080...>
Subject: man page overhaul project

--TyXTeG2a99YIbrvqq1ZQ0TD1lPjkrZgwH
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


Hi,

For the OpenVPN 2.5 we decided to do an overhaul to the man page.  The first
step in this project has been completed, converting the man page into an .r=
st
based text file instead - which hopefully will be much easier to edit for m=
ore
people.  This .rst file will then be converted to proper man and html files
when we produce the source tarballs during releases.

You can all follow the work in my own git repository where I'm pulling
together various changes before they are sent to the mailing list for proper
vetting and ACKs.

The repository can be found here: https://gitlab.com/dazo/openvpn/
And the git branch is dev/man-reformatting

Feel free to submit patches or gitlab pull-requests or gitlab issues as you
see it fits with suggestions for improving the man page.

If you are new to the .rst formatting, I would recommend you to pay close
attention to how things are done in the current openvpn.8.rst [0] file, as
well as the .rst markup docs [1, 2]

[0]
<https://gitlab.com/dazo/openvpn/-/blob/dev/man-reformatting/doc/openvpn.8.=
rst>
[1] Quickstart: <https://docutils.sourceforge.io/docs/user/rst/quickstart.h=
tml
>
[2] .rst spec:
<https://docutils.sourceforge.io/docs/ref/rst/restructuredtext.html>

Also, even though both gitlab and github does automatic "html rendering",
there might be some artifacts in the rendered result.  We will try to make =
it
look as nice as possible everywhere, but the rst2man output will be the main
target which will trump most rendering conflicts.  If it doesn't render well
as a text based man page, it is not good enough.

For the OpenVPN 2.5 release we will also keep everything in a single man pa=
ge.
 For future releases we might reconsider the organization of the man page. =
 So
any discussions which might appear regarding to split this file up will be
postponed until after the v2.5 release.

Other than that, I think we can be our best efforts to make this file even
easier to read and not the least, more up-to-date.  This man page is getting
closer to 20 years old or so, so a clean-up of older and less useful
information for this day and age is welcome.

Looking forward to hear back from you, whenever you have some input how to
make the man page better.

--=20
kind regards,

David Sommerseth
OpenVPN Inc



--TyXTeG2a99YIbrvqq1ZQ0TD1lPjkrZgwH--

--SZglT4unQnjXhvxrv0Rw5x5rK19xsVmkh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJez9DdAAoJEIbPlEyWcf3yCQcP/jvFPJkUciiV3aCBi2CFTsvQ
6dwHdMifAdK4BKi8+Qgjd4cIr+RxF2y1OxecktxcRLS9kCcs3E/BK/qtfSqYdlAl
63ozp0KJElaMUClgyD8WvIALBiw2SwdStwU+ZDL/qIFOhcCOxSdJAug2fmwk/bo4
WPqdR146vf563u2bPxu0NOJS7x7Ue64pVmjMz0G5Q/utSprEja/mgtGm3JMzhCmm
rCCaiZVRZLrqLEIx3CWUbcjBYuxTdx0WSVjdoPjcDkyVGAUqf6AooARBmw0NY4lB
PaHiIzioD7KuTqXUHvy6kG9PhG1OEspk/rbj5F1G/jwzgZh+XTyRHxhSKNhFtJRQ
Suw7WVhN18cT/0oZxjka7Qzjwj1Bw48oVbA73x8cBVPhdEcnYkN3k1pn/N9MYHmm
fy7Pb37J3XNsZYWkF6o6nvwD01ahUZlhmnZ4BS2X3htS1U7uP9/wGxVZhRSzvms2
/Z+YEomcsaaly6ysS4PcyGsF9+4SmO9Hm5W4dgC5HThq4w19clesNGBtoGsDFK6V
acmhos5Jp9gJB0Z/eFSHQZk8tqvMuP10Vm8HcOJxdAWILpgvQjxmHBnpsLsKRk/Y
9PqeL0zflH+wvmwS23nHQFQW5ilXL/aWco5Vfh1moCkIOLhPxlQ/SDAQTt18W/ME
wYSiBgUXXdSMTDfY06dC
=CmBj
-----END PGP SIGNATURE-----

--SZglT4unQnjXhvxrv0Rw5x5rK19xsVmkh--

