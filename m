Date: Sun, 15 Jan 2017 10:12:01 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20170115091201.GQ78624@...1296...>
References: <20170115061718.3218-1-praiskup@...1347...>
	<3821af27-817b-9ee5-29db-bf3516bcdad3@...1856...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HditFSw+SJxJh6AP"
Content-Disposition: inline
In-Reply-To: <3821af27-817b-9ee5-29db-bf3516bcdad3@...1856...>
Subject: Re: [Openvpn-devel] [PATCH] options: allow setting default --ca
 argument value
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

--HditFSw+SJxJh6AP
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Jan 15, 2017 at 09:52:46AM +0100, Steffan Karger wrote:
> On 15-01-17 07:17, Pavel Raiskup wrote:
[..]
> > This option is primarily designed for systems where users are
> > allowed to manage trusted authorities for whole system (in one
> > consolidated file; usually implemented in 'ca-certificates'
> > package).
[..]
>=20
> Feature-NAK.  OpenVPN should use it's own CA, not the system CA list.

I could see the use-case (enterprise wide list of trusted CAs, and
use of it compiled into an enterprise-distribute openvpn bundle),
but I agree with Steffan that it's not something we need to have in
OpenVPN - "--ca" can reference to a CA bundle today, and enterprise-
distributed config files reference the enterprise-maintained CA bundle,
it will just work without code changes.

My main reason for not liking this is "another compile-time option" -
someone has to maintain and test this, with and without this option,
which adds to our maintenance nightmare.  So the gain has to be=20
significant.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--HditFSw+SJxJh6AP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYezzgAAoJEB2Cnv7KVigSHFYMAIJCPhViF3Ww0CPTWaDQ8lQG
tJ1YISBRBrKL8aXm1G5eZ2UB5GGZWj7rZ4Yp2eIhZakPSfyIeI7EfMA9kKYxGJ8F
DTh5RBB0J1C2m+Mc1cbmcOA2HvtUT6+R7ZFJ2WcyYcP9/FaSCGX820P2+RnKx19W
5ofUe6efuv6Z7Ca95CySJV0OiObWUaEKy9+1DXnRF0eohlmUkuPKDTBNdTvbFugd
31fmNg8IQNMCO/mkg5Ql9DueSs3FACVSCCkLdGmSgcWbOmSdOOM9FiMCEPEl4jJu
MyEK75QHg2gkDzM+jvIXSHh0v/ySsyA3kaiq8DqDdkUmHs845kit3/yLeCD9WATi
TmrKvKv0FKQ4DYD9dqlsNTCcRbb70RLtuUa8Bb2ZLt1eoY0QP2UbOOyyBhU4YBZM
7J+sJn86D4IbIjgImov9Hzx4Dzjv+xOX+/jQwpRJJGgFEPl1Va0KzCZti6+eHMip
LxRdxsO96R5+ITRSF3CQ18pjnemSRNl3luSPMP7PkA==
=nFx4
-----END PGP SIGNATURE-----

--HditFSw+SJxJh6AP--

