Date: Wed, 7 Dec 2016 13:04:30 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20161207120430.GY78624@...1296...>
References: <CAFHpkQFgmWBhUb6YZOGFeR7Eyz34tFbN5BQEzafj0tpqtbmwyQ@...278...>
	<20161206211818.GQ78624@...1296...>
	<CAFHpkQGqHrFwCLMEvu9tEAQg3heWaAWcEQDyidG5z0ZLNgkL_Q@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="g3W8FGNyQaC+nhss"
Content-Disposition: inline
In-Reply-To: <CAFHpkQGqHrFwCLMEvu9tEAQg3heWaAWcEQDyidG5z0ZLNgkL_Q@...278...>
Subject: Re: [Openvpn-devel] fuzz testing by google ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ???????? ?????????????? <chipitsine@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--g3W8FGNyQaC+nhss
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Dec 07, 2016 at 04:51:36PM +0500, ???????? ?????????????? wrote:
> at least, I recall this commit
> https://github.com/OpenVPN/openvpn/commit/0d8da22ae36d5efd03fba36c1d783b9=
07589e321

*That* commit is "the 2.3.6 release", but I see what you mean.

> it used to crash on simple tcp connect (after immediate disconnect), it w=
as
> reproducible to running login/password authentication mode
>=20
> it might have been caught by fuzz testing.

I should point out that this was not a "crash" but an "openvpn detects
invalid input and ASSERT()s out -> well-defined program exit".

Not exactly *friendly* behaviour (and stupid, in this case), but not=20
a *crash*.

But that's exactly why fuzzing openvpn is hard: we detect bad stuff, and
in doubt, we ASSERT() - which is well-defined behaviour, not "crashing
randomly, possibly in a way that can be exploited to get access to
security critical bits"

> > Anyway - so what's necessary to make this google fuzz testing work?  Do
> > we instrument our code, or just tell them "hey, here's a useful piece
> > of software, go figure it out yourself"?
>=20
> we can start with PR to
> https://github.com/google/oss-fuzz/tree/master/projects
> it must been done by someone from "OpenVPN" github organization.

OK, that would then be Samuli, David or me, I think.  We'll investigate...

> if google machinery will not figure out anything, it might be long way wi=
th
> libfuzz-helpers (if we implement such helpers, we can add them to cmoka a=
nd
> travis-ci)

Indeed, but that would be "we have to do it", which nobody seems to have
time right now.

gert


--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--g3W8FGNyQaC+nhss
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYR/rOAAoJEB2Cnv7KVigSU3UMAKXcPtJupP1kQOwed3duvDfe
upmWXGs6fiwpCtpzEi88DoFg/9cnp0xl1CnL/W+YjYpv0CNAQbhvuaqiPHCfpnlH
tt5iWOavymBnZw7xS6USA1lS09Ui1F5DjOtGZ0GyZwQUYQYm35xdMWK+cv01jH6E
GjktauD5+GSHIjt8Z6c04vOmbnyRf1vXhSSaSreNd94jVAi4NkZ+lTH7WYxj6Dlg
dWHE2xDlK7FRkXadqJ8TmzDdrKRkGE5AMDKWAKVyqsuXk4AnP4ejda1MLTB7HoJl
HuKJEh/JVcmyHpB2pErLYPo2qj5OWfFUeoJmOFB380FVa6NSly6jtWtuumoQFHI9
2lYwLZ/OxFftDZNvcL/eyB0YGYWL7rFErCBa14NV7fTIuNAg2CXzg8Aqu6MpMvVS
ZxIO0qSHn4H5JD7TkfzzceItMgqdiUN26CLZiiEwDuFEuQXL2YuSqExOjHukNXmV
hJYcbQoQYlwrxL/zo4AP3GK/CPvis1maPHxj59NWPQ==
=AGF1
-----END PGP SIGNATURE-----

--g3W8FGNyQaC+nhss--

