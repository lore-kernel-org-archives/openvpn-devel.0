Date: Tue, 31 May 2016 17:56:07 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160531155607.GA53051@...1296...>
References: <1464668569-6480-1-git-send-email-selva.nair@...277...>
	<61d8d41f-4c77-5235-a202-642983d494a3@...1227...>
	<CAKuzo_gyWfFnOe72CKkyPfAHAfN5uF8jWqp2jCosdZkJBYwoBw@...278...>
	<574DAECE.8000202@...2080...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="v4m8UQm9xjrlzbb4"
Content-Disposition: inline
In-Reply-To: <574DAECE.8000202@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Add an option to filter options
 received from server
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--v4m8UQm9xjrlzbb4
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, May 31, 2016 at 05:33:34PM +0200, David Sommerseth wrote:
> I think a fixed list of 64 slots is more than good enough in this case.
> I even considered suggesting 32 slots, but 64 is reasonable as a maximum
> currently.  An average openvpn config is probably roughly 10-15 lines
> all in all (not considering inline files). If someone pushes more than
> 50-60 options, then something more funky is probably going on as well.

This is not to be *pushed* but local sanity control for pushed stuff :-)

ValdikSS is pushing well over 1000 routes, so "60" is really not much
in that regard...

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--v4m8UQm9xjrlzbb4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBV020FqkuBuNlUUl1AQIOkgQAmc1Oqiu+6JN4l2zwb3re22bd7kFixoDq
Qi3saJMiWiJr9nSMX25cdizx3sD78b/71Mg5VtsF9btHwsV5HR3yOzY/kspilR77
wRC9utO7k8d9LnjAnr++xv87f2fLSO83fvRzCJ8b+AcGD3lsYaylyMLa5dhheMXr
Nsy7oxINUdE=
=vZrw
-----END PGP SIGNATURE-----

--v4m8UQm9xjrlzbb4--

