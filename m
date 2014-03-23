Date: Sun, 23 Mar 2014 13:26:24 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20140323122624.GD16637@...1296...>
References: <1395017376-24554-1-git-send-email-james@...515...>
	<20140317202910.GM16637@...1296...>
	<532775DD.4050106@...515...>
	<1CED409804E2164C8104F9E623B08B90155646D4C1@...1436...>
	<53281720.2050504@...1147...> <5328463F.7090704@...1114...>
	<53284DA8.1010709@...1147...>
	<1CED409804E2164C8104F9E623B08B9016F95AD5DC@...1436...>
	<20140322183508.GZ16637@...1296...>
	<CAA1AbxJMVBtOgeswADw_Q1XuKyK6h_jWmVg-gUqPPtM2XCk1kA@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8WjR6xbrMfF4ccdH"
Content-Disposition: inline
In-Reply-To: <CAA1AbxJMVBtOgeswADw_Q1XuKyK6h_jWmVg-gUqPPtM2XCk1kA@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Set SSL_OP_NO_TICKET flag in SSL
	context for OpenSSL builds,
	to disable TLS stateless session resumption.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--8WjR6xbrMfF4ccdH
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Mar 23, 2014 at 10:22:57AM +0100, Steffan Karger wrote:
> ACK. Message looks correct and clear to me.

Thanks.  Committed and pushed as 2cf9d4e3f06f4a61cb6d159728ac6c8a790d6849.

Can you send the needed patch for master/2.4?

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--8WjR6xbrMfF4ccdH
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUy7S8KkuBuNlUUl1AQL1HAP/WCS7FqHJ8Y7tHDqeItfStRdyH5YfLSZu
QvaEVou+wsqbHiZiimoT2546TaoUKx3Szkd5avmaaqzS37dxjVw6ydLhWH9EWsGJ
hK5Rx18xmyO4cIwgjdXBjSDzdS7W9yjhRoMIdA9yZBTWIGimuXuQ4ThqKo+hIQ9b
7d46pbwmsJE=
=Y0Hi
-----END PGP SIGNATURE-----

--8WjR6xbrMfF4ccdH--

