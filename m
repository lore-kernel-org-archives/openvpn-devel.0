Date: Fri, 24 May 2013 19:40:09 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20130524174009.GP20843@...1296...>
References: <519F04FA.5050303@...1823...>
	<20130524092300.GL20843@...1296...>
	<519F5ED0.4070109@...1147...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IX4edXMD7HczJcpd"
Content-Disposition: inline
In-Reply-To: <519F5ED0.4070109@...1147...>
Subject: Re: [Openvpn-devel] [PATCH] make "explicit-exit-notify" pullable
	again
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Just Keijser <janjust@...1147...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, Dmitry Melekhov <dm@...1823...>

--IX4edXMD7HczJcpd
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, May 24, 2013 at 02:36:32PM +0200, Jan Just Keijser wrote:
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index d44f835..47df4cb 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c

ACK, and thanks.

Applied to master and release/2.3 branches.

commit 49f714942d5afd5f274aea52c790c896babc8c05 (master)
commit 14dfec07c91fc42df7ee4abeada104b4fb847f8f (release/2.3)

Author: Jan Just Keijser <janjust@...1147...>
Date:   Fri May 24 14:36:32 2013 +0200

    make 'explicit-exit-notify' pullable again
=20=20=20=20
    Acked-by: Gert Doering <gert@...1296...>
    Message-Id: <519F5ED0.4070109@...1147...>
    URL: http://article.gmane.org/gmane.network.openvpn.devel/7605

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--IX4edXMD7HczJcpd
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUZ+l+KkuBuNlUUl1AQL8mgP/aapTd07Dl2QbVX1lqEkO+WhrkYr/wL3s
Lor5IKXqsv7Ki+yO6lO5tpTSAPJJApsGXP7vBqOoCpTpYbo+3hQckXnL4EQ3+Yru
FSKDJjRezTb0RtOmHPZQkwBmaT7A5mWI/qGa2Uj+CnXt4Fo3ZCvqUH1hJX5UKcqe
XuzG3Xi1HBs=
=KOVX
-----END PGP SIGNATURE-----

--IX4edXMD7HczJcpd--

