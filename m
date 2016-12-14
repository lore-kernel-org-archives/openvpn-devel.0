References: <1ffbd3a5-8fa8-8992-2c3d-d353898d74f9@...2080...>
	<f55ae849-32a0-5f7e-829f-1158bc3d68fc@...2080...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <3a78050c-8c18-d54e-fc37-330272de6d44@...2080...>
Date: Wed, 14 Dec 2016 22:18:22 +0100
MIME-Version: 1.0
In-Reply-To: <f55ae849-32a0-5f7e-829f-1158bc3d68fc@...2080...>
Subject: Re: [Openvpn-devel] Coding style clean-up ... phase 1
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 13/12/16 22:42, David Sommerseth wrote:
>=20
> Hi all,
>=20
> So the first phase of the great reformatting is on its way.  I have
> just pushed out a reformatting branch to the following=20
> repositories:
>=20
> https://github.com:OpenVPN/openvpn.git=20
> https://gitlab.com:openvpn/openvpn.git=20
> git://git.code.sf.net/p/openvpn/openvpn
>=20

An updated reformatting branch have been pushed out.  If you have
already fetched the it, git will most likely complain as to make
these tests flow reasonably well without cluttering the git tree
too much we have used forced pushes on this branch.

And again, the The Great Reformatting patch is PGP signed as well,
which can be verified with 'git log --show-signature'.  The
signing key is 0x86CF944C9671FDF2, which is the same as this mail
is signed with.


- --=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYUbceAAoJEIbPlEyWcf3yOnIQAKRMvwhlde6/X/oi4Tu94dRk
Czoqf9nVTeS/ejf/dwWuztVWR8hIfd0rf+gog6eTHBQrRSjvDHPyi62XTH2lkt9z
h+xOHZTOgL7oKyHWrfjiyGPxov2RUgz5HvMyH2nl2s6Pj3o9J/AkrfxFJbtMu/CR
YYk9w5QOn8/XfoulOgZgWh1JXwICGKUVQXFQRBoQpi7m3aVdFpRN/3uHmK+epWe/
ewEQd2kNYJQfPWCRuzDBTPCJfYmr9IDncB/mkvDGw7D08BdcFknOWeVmP1HHn4uM
XWsIqOqfilOf09dPzQnSfLxlgg0zGZW/z8wYBqKAZTM1aVO5z5Jtq6nqevWzB1UX
Nrlws0OaPlIsjGUzeL3BInGQevpYYKSHS3Acyz+cW+X42t3AIGTKUQSCgRQpFJnb
v4cRf+7c7h77t7mMIIsS7ghMJRGgog6ib2NJp07in4o75aHMFeuWHte4FmM3Osrk
vJ9MT1jUkxs1OxkFsxpnrhhzfY1UazCDmosMytoE+CaJzMIkB9HzlH77yR+jxnQK
lT3hineWNGgmEtTjmczZQJHHF68IHivfd7g07mS/xdvXWmRbkgUQNqcKOZujiaQV
OIfjvOkREtkbW1lJLinMeb3c+SW5DggKnkSwdo3yHOHvRfniPraQxVDbpDAd2dVu
0WPlpmIuHmBypIxNBpYc
=3Dagzz
-----END PGP SIGNATURE-----

