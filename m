Date: Thu, 25 Apr 2013 20:18:43 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20130425181842.GL29506@...1296...>
References: <1366467768-16260-1-git-send-email-arne@...1227...>
	<1366467768-16260-3-git-send-email-arne@...1227...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FCF9ydJxlAJsfRTu"
Content-Disposition: inline
In-Reply-To: <1366467768-16260-3-git-send-email-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 3/5] add ability to send/receive file
	descriptors via management interface,
	only used in android so. For now under #ifdef ANDROID
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--FCF9ydJxlAJsfRTu
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I think the code is fine, but I have some nags about the function names:

On Sat, Apr 20, 2013 at 04:22:46PM +0200, Arne Schwabe wrote:
> +#ifdef TARGET_ANDROID
> +static ssize_t write_fd (int fd, void *ptr, size_t nbytes, int flags, in=
t sendfd)
...
> +static ssize_t read_fd(int fd, void *ptr, size_t nbytes, int flags, int =
*recvfd)

To make it somewhat easier to understand what these do (in the context
of the caller), what do you think about renaming them to

   man_send_with_fd()

and

   man_recv_with_fd()

?

(man_ being the general prefix for "management specific functions", and
send()/recv() being the normal function calls "without fd passing")

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--FCF9ydJxlAJsfRTu
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUXlzgqkuBuNlUUl1AQKu8gP/XLoxU4cuB8DrC3SUTpT+70dRL2HNQ5el
3rqpo1YUN8pmbEg9Tgno/LZifcRywg4TQ88ugDe+4n5fLcKu5tQpD41mQ1bzpeXX
dK1xVffOpj1G8+oyKxmmGkL5y5RCEwkbzE+DHYlzEJA/MULcHv0f6yPy0qE/FYwG
CgqwuXLMO5I=
=x4S4
-----END PGP SIGNATURE-----

--FCF9ydJxlAJsfRTu--

