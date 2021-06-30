References: <20210520150932.2565217-1-arne@...1227...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <2c95ab22-455a-8900-cbdc-5927f9903e00@...2080...>
Date: Wed, 30 Jun 2021 19:29:11 +0200
MIME-Version: 1.0
In-Reply-To: <20210520150932.2565217-1-arne@...1227...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="WYFuBS6XJDLfAfRCa2bXDdf7E0ZPVXLwM"
Subject: Re: [Openvpn-devel] [PATCH v2 1/2] Move examples into
 openvpn-examples(5) man page
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WYFuBS6XJDLfAfRCa2bXDdf7E0ZPVXLwM
Content-Type: multipart/mixed; boundary="plli11pTI8sRSUUUsqOQCoyFosX7u2gUY";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net
Message-ID: <2c95ab22-455a-8900-cbdc-5927f9903e00@...2080...>
Subject: Re: [Openvpn-devel] [PATCH v2 1/2] Move examples into
 openvpn-examples(5) man page
References: <20210520150932.2565217-1-arne@...1227...>
In-Reply-To: <20210520150932.2565217-1-arne@...1227...>

--plli11pTI8sRSUUUsqOQCoyFosX7u2gUY
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable

On 20/05/2021 17:09, Arne Schwabe wrote:
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>   .gitignore                 |  2 ++
>   doc/Makefile.am            | 25 +++++++++++++++++++++----
>   doc/openvpn-examples.5.rst | 17 +++++++++++++++++
>   doc/openvpn.8.rst          |  2 +-
>   4 files changed, 41 insertions(+), 5 deletions(-)
>   create mode 100644 doc/openvpn-examples.5.rst
>=20
> diff --git a/.gitignore b/.gitignore
> index 25d06235b..178076ede 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -49,6 +49,8 @@ version.sh
>   msvc-env-local.bat
>   config-msvc-local.h
>   config-msvc-version.h
> +doc/openvpn-examples.5
> +doc/openvpn-examples.5.html
>   doc/openvpn.8
>   doc/openvpn.8.html
>   /doc/doxygen/html/
> diff --git a/doc/Makefile.am b/doc/Makefile.am
> index e411f5f9d..1dbbddf58 100644
> --- a/doc/Makefile.am
> +++ b/doc/Makefile.am
> @@ -20,6 +20,7 @@ dist_doc_DATA =3D \
>   dist_noinst_DATA =3D \
>   	README.plugins interactive-service-notes.rst \
>   	openvpn.8.rst \
> +    openvpn-examples.5.rst \

TAB vs spaces.  Makefile.am uses TABs.  This might not be a real issue=20
anymore, but there are some older Make versions which will choke on spaces.

This can be fixed during commit.


[...snip...]

>   if HAVE_PYDOCUTILS
> -dist_noinst_DATA +=3D openvpn.8
> -dist_html_DATA =3D openvpn.8.html
> +dist_noinst_DATA +=3D openvpn.8 openvpn-examples.5
> +dist_html_DATA =3D openvpn.8.html openvpn-examples.5.html
>=20=20=20
>   # Failsafe - do not delete these files unless we can recreate them
>   CLEANFILES =3D \
> -	 openvpn.8 openvpn.8.html
> +	 openvpn.8 openvpn.8.html openvpn-examples.5 openvpn-examples.5.html
>=20=20=20
>   endif
>=20=20=20
> @@ -74,4 +91,4 @@ else
>   dist_man_MANS =3D openvpn.8

You missed openvpn-examples.5 here.  But I do have a patch ready which=20
avoids lots of the rule duplications.  Gert got a copy of a preliminary=20
patch to test on some BSD hosts.  So we can ignore this for now.

Except of these two really minor things, this is good to go.

Acked-By: David Sommerseth <davids@...515...>


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--plli11pTI8sRSUUUsqOQCoyFosX7u2gUY--

--WYFuBS6XJDLfAfRCa2bXDdf7E0ZPVXLwM
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEgDq5E1p1aZrNLFFkhs+UTJZx/fIFAmDcqecACgkQhs+UTJZx
/fL8OA/5ATiGyntgybym1qFHqYUZN+58m+l8rGcbLZYZrI1Hx8BQNXCqYfozQMnL
68uW0sYi0EtA/8rfj8sFq0JC8GcqFHcz8K6X2lKYaD03y+3lr+xrrb+WGKhAz4XP
35lEZgT3577USHXw+f4qd9Y89gdi2Pe5Jdxgu+fupa18Fd1aUNMGG37jtLaLcjek
+ijS7L/1nrjz8hhvu8q8Qvtmcl6ys72gpq1rV2caI81kFJH/xGviW6rj/nauf+qZ
SukGNcpzmQXnxspMaA4sAsvBeDf7YO1d6QaOcyarQMMK9d/d7xUwq6/Xlh3i2dnI
rqTwC3iD2XQTP+oDT/6XwrJgWZqj93rqJ6silBonod2Y7lM5enfN74LwtK3Jl37Z
7M/j6s6yEv+N0BQKGFCfA8flZtP0Saqgy7bkb1/CqRosTmJ7OBU8iJoLnsVO2cH0
uBYkoUeEGMK9kgVR7tO5sSKWG9IuGN9j/1cuKAuXW0nhSWIRiHAlln16740S/Wvv
U0eAOorEnJcJ+g+uxDjfhWLj0k1vd9RXHQJmpOcaYW8Ar4BGo+duQluMF48CvpfL
WwU0FvofPEAk0GLxrd71i+kO+/6G2+4lnZWYhU3+vXFszkZmxwJTpNW+JCoOxvdB
Hj9sS70Kxwhdy0kBDOeZRChsbYoT8rz6d5XIJK+OmJAXg26Ghwc=
=vkD4
-----END PGP SIGNATURE-----

--WYFuBS6XJDLfAfRCa2bXDdf7E0ZPVXLwM--

