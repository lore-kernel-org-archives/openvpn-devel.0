Date: Sat, 3 Dec 2011 11:09:26 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20111203100926.GE8496@...1296...>
References: <1322823755-18052-1-git-send-email-davids@...1347...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="F9CWS3VM42WKjaeu"
Content-Disposition: inline
In-Reply-To: <1322823755-18052-1-git-send-email-davids@...1347...>
Subject: Re: [Openvpn-devel] [PATCH] Provide an access() wrapper for Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <davids@...1347...>
Cc: openvpn-devel@lists.sourceforge.net

--F9CWS3VM42WKjaeu
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Dec 02, 2011 at 12:02:35PM +0100, David Sommerseth wrote:
> Commit 0f2bc0dd92f43c91e33bba8a66b06b98f281efc1 adds extra file and
> directory checks at startup.  However, this patch makes use of some
> features not directly available in Windows.
>
> This patch avoids #include <unistd.h> on Windows and provides a
> wrapper for the needed access() function.

ACK.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--F9CWS3VM42WKjaeu
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTtn1VakuBuNlUUl1AQK/VQQAoEsCyPXevYKFwZEyU/LlMYOrvdaURVLA
LN2Ox9lLMqr7ayMxdALyeIU8OXpeK7T0xdejpfWQO4DuZuQ5WxUVm+/UFO3q01Pn
3YMKNCNWfeWzw7EgZOdbd0BhqUM40a31PCy1KrHdwSbTud61n7ESBVjcQgAF7dwq
ejsTVpMDBp0=
=vBD6
-----END PGP SIGNATURE-----

--F9CWS3VM42WKjaeu--

