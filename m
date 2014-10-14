Date: Tue, 14 Oct 2014 16:23:25 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20141014142324.GR396@...1296...>
References: <54259015.2030005@...1921...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1xx5Q0+Cw+ObE54D"
Content-Disposition: inline
In-Reply-To: <54259015.2030005@...1921...>
Subject: Re: [Openvpn-devel] [PATCH] Implement on-link route adding for
	iproute2
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Philipp Hagemeister <phihag@...1921...>
Cc: openvpn-devel@lists.sourceforge.net

--1xx5Q0+Cw+ObE54D
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Sep 26, 2014 at 06:11:01PM +0200, Philipp Hagemeister wrote:
> Currently, when compiling with --enable-iproute2 , OpenVPN does not
> create a correct route when the user is connected to the Internet
> without a gateway (e.g. via ppp). This patch implements the
> corresponding FIXME.
>=20
> Signed-off-by: Philipp Hagemeister <phihag@...1921...>

ACK - feature-ack, stare-at-code ACK and actually tested it on a ppp0 link =
:)

Your patch was slightly whitespace mangled, so my standard git wrapper
tool refused to apply it - "git am --igore-space-change" worked like
a charm, though...

Anyway - it's in the master and release/2.3 tree.

commit baa195b9884e276c4fd3dc0c9e8a84b89ea71cfb (master)
commit a76fcf1567c912c404e52da1ea5a1b2cca7d601c (release/2.3)

Author: Philipp Hagemeister <phihag@...1921...>
Date:   Fri Sep 26 18:11:01 2014 +0200

    Implement on-link route adding for iproute2
    Signed-off-by: Philipp Hagemeister <phihag@...1921...>
    Acked-by: Gert Doering <gert@...1296...>
    Message-Id: <54259015.2030005@...1921...>
    URL: http://article.gmane.org/gmane.network.openvpn.devel/9056
    Signed-off-by: Gert Doering <gert@...1296...>


sorry it took so long.

gert=20

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--1xx5Q0+Cw+ObE54D
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVD0x3KkuBuNlUUl1AQL/TAQAtPlcF4qC9ZK3QcKVaYYpii7YQKAmcZSR
jYbNeIG9tiLiK5+mHEAN9IbJ4mDC+ApHwJ6+Vn84LFW6TQa6M/PhYdgJ2Eg9d1rT
jbVYmq6GBLvLPtAUdcbTANnp3/UNNnp2WYtbrlEQCBZO7j6Wi9dbGUBt7srd9rwt
pFAAtFZ7nLg=
=R/rU
-----END PGP SIGNATURE-----

--1xx5Q0+Cw+ObE54D--

