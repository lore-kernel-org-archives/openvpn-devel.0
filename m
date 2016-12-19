Date: Mon, 19 Dec 2016 16:46:49 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20161219154649.GG78624@...1296...>
References: <CAFHpkQFZD+hYzq_FW075wQt5AopcyCP20BEDzLsTx5Vq6uko3Q@...278...>
	<d48609b7-43df-80d5-a57f-e96e85ad4389@...2080...>
	<CAFHpkQHxVWvHSFK2hS7CV8ytUnxUHi5ZfjSOiuLBfWdufzMrCQ@...278...>
	<9048486e-03d9-7aa1-74f8-892a9cc7c1ee@...515...>
	<CAFHpkQHtPm2gPfHYEngJoMymUxt8iOFA7L0z+p54oVSNEmEPFQ@...278...>
	<4ea0b775-5681-b908-f06d-9251d28e8c8a@...515...>
	<c41ad01c-d1a2-cf2c-4876-c22954ae90a9@...2080...>
	<e93e0d67-963a-d677-7d67-323b46e6c3c7@...515...>
	<CAFHpkQFo-W_4_1_6vmBaDfLk8nTHE_=uCi7ZcGES+1iq0sTKxA@...278...>
	<ad02b1ab-1552-7108-e951-65daa05a6680@...2080...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="efFJd/fQ0cD5Wc37"
Content-Disposition: inline
In-Reply-To: <ad02b1ab-1552-7108-e951-65daa05a6680@...2080...>
Subject: Re: [Openvpn-devel] https://travis-ci.org/OpenVPN/openvpn/builds
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--efFJd/fQ0cD5Wc37
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Dec 19, 2016 at 04:31:26PM +0100, David Sommerseth wrote:
> > I've no idea how to detect osx, but it is rather easy on travis-ci
>=20
> I'm strongly leaning towards a NAK on this approach, unless there exist
> absolutely no other way.  I don't want to see configure.ac carrying
> Travis references for no good reason.

For a change, I agree with David :-)

Given that configure.ac does a good job in OS autodetection already

        *-*-darwin*)
                AC_DEFINE([TARGET_DARWIN], [1], [Are we running on Mac OS X=
?])
                AC_DEFINE_UNQUOTED([TARGET_PREFIX], ["M"], [Target prefix])
                have_tap_header=3D"yes"
                dnl some Mac OS X tendering (we use vararg macros...)
                CPPFLAGS=3D"$CPPFLAGS -no-cpp-precomp"
                ac_cv_type_struct_in_pktinfo=3Dno
                ;;

... it should not be too hard to add a check for "TARGET_DARWIN" to
the CMOCKA_INITIALIZED section.=20=20

Or add a "disable_cmocka=3Dyes" to the *-*-darwin* section and test for
that later on (makes it easier to add other platforms that are not
using GNU ld).

*Or* just check for GNU ld, and disable cmocka testing if that's not
available - we already have a check in there that talks about
"checking for ld used by $CC", which seems to result in=20

  "with_gnu_ld=3Dyes"=20

if, well, GNU ld is used.  So the cmocka init part could just add a
check=20

   if [ yes !=3D "$with_gnu_ld" ] ...

and set CMOCKA_INITIALIZED to "false".  Done.


(I'm not very good in actual coding using the right macros, so I'm not
even suggesting a patch - but I'm happy to help concept-wise and run
tests)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--efFJd/fQ0cD5Wc37
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYWADpAAoJEB2Cnv7KVigSb3EL/0DXTHnQ9TwteYRZkry3RMe/
/vS8stHHGpCJqFGOaFenVoxmK12+uoW7XLTkjAnP0nrdN7cLyyXF1xfWoO17WInq
wFwAxK38dTobFdT1gTzkv4qeFpAVNAXWSBtCSvHv0l9Ln9oGP5iLHH04EYVfSqUj
YFXNttiMm6saeixc9kdko2nqPpcMAT0Tj/zUWIbekDkmJayFnBdPkj6XFTavJcX2
YwQGCuSXum9gEh9R3aFKXzXoBB0o8njzp8BXMIRZrWwXno7J7Zzmlsk8+OXj5Y9D
6Jdf+MfmWqMzW79GfTqgToNJpWBc21C5NMZWA/6yboOLcNY//31eCJc8oQmaJZCP
wABeMZ6sO/X2EI8/IF4+ijaQdMzrCPHkJcu6TlkEyptbs8lwh9QpsHtyGzo+Ju24
cIiwGlDxn9FRwqc3M1M8PZ8jpzkWQDJdOkI8tgzuwQrgvL0GIHffWgSzePbJkHld
74ffM8UuCRq3mXEi4b0mLzI4yZ7kl+/adfRMtLNFCA==
=yB8b
-----END PGP SIGNATURE-----

--efFJd/fQ0cD5Wc37--

