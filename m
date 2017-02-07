References: <1486364115-9801-1-git-send-email-chipitsine@...277...>
	<20170206104444.12662-1-davids@...515...>
	<13044f0c-953c-af95-79dc-d7b641ae6573@...515...>
	<7cfc9e24-236d-ad55-9ed3-5904c4042a06@...515...>
	<CAFHpkQEWA-yiCu0UreWxb88GRU2Oas8hHdthcp1+SaHSfuJF2A@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <d86dba2c-0de6-eb5d-a8cc-dc47ce914e8c@...2080...>
Date: Tue, 7 Feb 2017 14:11:29 +0100
MIME-Version: 1.0
In-Reply-To: <CAFHpkQEWA-yiCu0UreWxb88GRU2Oas8hHdthcp1+SaHSfuJF2A@...278...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="e5Lx2gc10htXVHRV5nCm0xUpakRe7Cqu6"
Subject: Re: [Openvpn-devel] [PATCH applied] github: Add PR template with
 contributor related information
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>, =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Cc: David Sommerseth <davids@...515...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--e5Lx2gc10htXVHRV5nCm0xUpakRe7Cqu6
Content-Type: multipart/mixed; boundary="dJoC2BbEDxxL0imTmiMrgq0WISIi2VHsg";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>,
	=?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net"
	<openvpn-devel@lists.sourceforge.net>,
	David Sommerseth <davids@...515...>
Message-ID: <d86dba2c-0de6-eb5d-a8cc-dc47ce914e8c@...2080...>
Subject: Re: [Openvpn-devel] [PATCH applied] github: Add PR template with
	contributor related information
References: <1486364115-9801-1-git-send-email-chipitsine@...277...>
	<20170206104444.12662-1-davids@...515...>
	<13044f0c-953c-af95-79dc-d7b641ae6573@...515...>
	<7cfc9e24-236d-ad55-9ed3-5904c4042a06@...515...>
	<CAFHpkQEWA-yiCu0UreWxb88GRU2Oas8hHdthcp1+SaHSfuJF2A@...278...>
In-Reply-To: <CAFHpkQEWA-yiCu0UreWxb88GRU2Oas8hHdthcp1+SaHSfuJF2A@...278...>

--dJoC2BbEDxxL0imTmiMrgq0WISIi2VHsg
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 07/02/17 11:23, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=
=D0=B8=D0=BD wrote:
> as for compliance check, it will always annoy people if it is something
> written somewhere. people will forget to have a look at it.
> can we involve something like that
>=20
> https://github.com/openresty/lua-nginx-module/blob/master/.travis.yml#L61=
-L62
> ?

That check is to test the *code*.  It does not apply to this discussion
at all, as we are here primarily discussing commit messages.  And such a
checks makes no sense on commit messages.  Some times it is needed to
exceed 80 characters, as log lines are quoted to explain what happened
and give reasons for why the patch is needed.

For quality checks, for both code and commit messages, good developers
usually tries to ensure everything is set and in order *before*
submitting a patch.  Heck, most I know even tries to ensure that things
are proper before doing the local commit.  Many calls this process the
"personal hygiene step".  It's a fairly good description of the
importance of doing so.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--dJoC2BbEDxxL0imTmiMrgq0WISIi2VHsg--

--e5Lx2gc10htXVHRV5nCm0xUpakRe7Cqu6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYmceBAAoJEIbPlEyWcf3y0uYP/jH//UEUZv98erA6kGEW0RKj
AsioivrZ/2k6qh6OhpuMMBmP/ObVt3aNNCeTQ4LSM6K/5+fncZbOchDjd+LX4k1K
ps5IXreExLCfOt3sq6he4R9lpGUYMZjv1Fe9imHId77y7ARlz3m2WK4E8hBHmsf1
V2APvXu07aOxG9Sd7f7OCg3BGZOwslM48uWpkaFRBvmB9Y/z/9wEMb/M6X/leI8A
9iNsdDop1EiUy8enAyZQb9nfgvmDICoK04vCmL5NbmPcTEetnTRovtkKqXGG/lu0
qH6rYxksWpJDYhyPhx0pH4CueXuiANGDqS79OnTk7yDMOblsKJn8f6280niIapHl
7d6WI3vrlOKTolgPwjuaLCO+1ICRov1QX4jLOOjh/vEO0RJqa1+HZCZalDzEvMP7
D996F8aZgByvecQra8pp6AJ4jJruwcv4umTET4rnX7/1gfD43kKLhYTMhBRY//Ap
x5nCNM8pqWH59iI8oqPAqEffZjXhIxf1jM25gmk/nzYETAObCUAke3GexncwvYUK
ogMdSi5q5Oso8RcTzIttmO4DyY7NxYWAOT2kYpztkc/G5/kPXt/C9c4KBqMx+G8j
ZphpElIv4NRYYUT2S8iwa6oGGE+h9oJPpO+5geju6Oib36uOyEZTyiD96AmC5cBW
IkDk+J4f0s8bSPAVrCvM
=4sV9
-----END PGP SIGNATURE-----

--e5Lx2gc10htXVHRV5nCm0xUpakRe7Cqu6--

