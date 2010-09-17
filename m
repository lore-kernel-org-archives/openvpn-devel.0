Date: Fri, 17 Sep 2010 18:05:04 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20100917160504.GC10703@...1296...>
References: <1284736735-25248-1-git-send-email-dazo@...384...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FjpD/Rrv9Wf/rbq2"
Content-Disposition: inline
In-Reply-To: <1284736735-25248-1-git-send-email-dazo@...384...>
Subject: Re: [Openvpn-devel] [PATCH] Fixed compiler warnings reported on
	Ubuntu 10.04
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <dazo@...384...>
Cc: openvpn-devel@lists.sourceforge.net

--FjpD/Rrv9Wf/rbq2
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Sep 17, 2010 at 05:18:55PM +0200, David Sommerseth wrote:
> diff --git a/misc.c b/misc.c
> index eafd892..1e863f2 100644

ACK.  Good programming practice.

The format string stuff might be harmless right now (if the input is
well-controlled) but might it's still good practice to be explicit
about it "this is a string, no more".

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--FjpD/Rrv9Wf/rbq2
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (NetBSD)

iQCVAwUBTJORsKkuBuNlUUl1AQKFZQP+JMC9ogybbiKjwsmfAZnUX6ZzCZQXwH2Z
sqOMUQRmNcMbRo0AMYglIC/ezI2Bq17En4Ky6WsJmAmK2vkf3zVR+3v/p8E/pW9D
5VKd0PEIyfZgMcAQuwRkFAA6VC1NJk0ZqhWxi1fsxCYNr9XWQqUoKeapQOUKFox6
qt56DwsE8Oo=
=B1zX
-----END PGP SIGNATURE-----

--FjpD/Rrv9Wf/rbq2--

