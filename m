From: David Sommerseth <openvpn@...2080...>
References: <20200624180741.426-1-davids@...515...>
Message-ID: <1aeaae81-2bf9-72a7-72fe-c5b06a0d1cb5@...2080...>
Date: Wed, 24 Jun 2020 20:47:34 +0200
MIME-Version: 1.0
In-Reply-To: <20200624180741.426-1-davids@...515...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="eqLayJx3rAAxC7fto9WkzSv1i5YaKzTrX"
Subject: Re: [Openvpn-devel] [PATCH 00/11] man-page overhaul project
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eqLayJx3rAAxC7fto9WkzSv1i5YaKzTrX
Content-Type: multipart/mixed; boundary="KFO8LocK9vkUD1Jm6Mq4AJ9GpmVS3xmZP";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <1aeaae81-2bf9-72a7-72fe-c5b06a0d1cb5@...2080...>
Subject: Re: [Openvpn-devel] [PATCH 00/11] man-page overhaul project
References: <20200624180741.426-1-davids@...515...>
In-Reply-To: <20200624180741.426-1-davids@...515...>

--KFO8LocK9vkUD1Jm6Mq4AJ9GpmVS3xmZP
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 24/06/2020 20:07, David Sommerseth wrote:
> Hi,
>=20
> This is the first real review round of the man-page overhaul project.
> Since the n/groff based openvpn.8 format is fairly cumbersome to edit,
> we agreed at the 2019 Hackathon in Trento to move the man page into
> something more editing and management friendly.
>=20
> This set of patches converts the openvpn.8 file into the
> ReStructuredText format (.rst) which can easily be converted into both
> man and html files using python-docutils.  The advantage of this format
> is that it is easy to edit in any plain text editors and displays
> reasonably well in any terminals.  And it will be easier to review
> patches man page updates sent to the mailing list.
>=20
> To avoid everyone building the OpenVPN source tarball to have the full
> python stack available, the doc/Makefile.am file has been adopted to
> generate the man and html files when we create the source tarball
> we distribute in releases.  Only users only pulling down the source
> directly from git will need to have python-docutils available.
>=20
> As I worked my way through the man page, there were several things
> which was less good.  Lots of options where misplaced in not related
> sections, a few options where documented several places.  And lots
> of the sections overlapped quite a bit.  From patch 5/11 splits
> the whole man page into several smaller files; one file per section.
> This is all tied into a single man-page/html file when running the
> rst2man/rst2html tools.  The following patches just cleans up and
> moves some options into more suitable sections.
>=20
>=20
> I will continue to update my own git branch containing this work as
> review comments come in until this is merged into master.  You can
> find it here:
>=20
>   https://gitlab.com/dazo/openvpn/-/tree/dev/man-reformatting/doc
>=20

So sf.net mailing list is grumpy at me for sending a large mail, patch 5/11=
 is
currently waiting to be unlocked by the list admin.  In the mean time, here=
's
the patch:

<https://gitlab.com/dazo/openvpn/-/commit/6eef9d3b1989166542805644cbc74baa9=
6c72a80.patch>


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--KFO8LocK9vkUD1Jm6Mq4AJ9GpmVS3xmZP--

--eqLayJx3rAAxC7fto9WkzSv1i5YaKzTrX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJe85/GAAoJEIbPlEyWcf3yEjsP/jw6CCk/0sWK9CPyMX6DGYfP
K3FNfDoqMHsQQnMnD6uVIBlNmpGb3ye5TYVPIzBacPM0F6l78pgcCjgQZ/XhNeI0
1PRWUE4JCwDRos3ybaNsX+VRWlkrdKiTYmrwX/pz4aDcxT8UnjDsODzJo64058Nt
72iWdMJ56oSGaIKOX2lT7RZniAC9CYrkvh5U9QcaPnkm0fTADol28BoP4Fd/aru6
ZBFSwo3G0OpwubIWJeAolgCbtzdv62QWWqvWGNeIkmzqghSTgMjPXF5etR277NmM
Wk18b1p/+8Dvh4cbC5hWTi6J/lHDaNMem3x1he6LC0tl75rKtxa+uF4H2q80fH4n
zhAuX/Bxe7Plv0+cYxPnU/w4o/bqQX08rvjC8eYK9GDjodtFichtAqZh6Z6X4qiQ
f1Zemfmt42a+MIScepWNVmmRrHVhqc17564s+IsFW9XBSK1I2z0dHd19wv5QDjDq
+DVtdS0LxDkZ9Eyatz3/FmZ/OF1WNVxpce3I1dY6lnSslPtZbNIMR7souv3d6Ju/
ucwyu1klkyhvRZLjQnPKc1xZM4vDCXUBvr+yMs3cby5RRacUVGftPVQXgqW/p5Uj
8BeH8KpjifOw4qBMAuOg188JkK/FogPAGUP+RfRTqPP3TIYxttUDltfTWBojeGto
tKqklO06p/U7qdYSv9iF
=wX9S
-----END PGP SIGNATURE-----

--eqLayJx3rAAxC7fto9WkzSv1i5YaKzTrX--

