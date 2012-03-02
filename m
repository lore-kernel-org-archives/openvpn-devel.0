Date: Fri, 2 Mar 2012 15:59:01 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20120302145900.GF1359@...1296...>
References: <b7eff4b3227380d9911bac1a18327c69@...1528...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8X7/QrJGcKSMr1RN"
Content-Disposition: inline
In-Reply-To: <b7eff4b3227380d9911bac1a18327c69@...1528...>
Subject: Re: [Openvpn-devel] Running udp and tcp server in the same instance
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: michael-dev <michael-dev@...1528...>
Cc: openvpn-devel@lists.sourceforge.net

--8X7/QrJGcKSMr1RN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Mar 02, 2012 at 03:32:36PM +0100, michael-dev wrote:
> I've got multiple tcp und udp based OpenVPN instances here, that=20
> prevent duplicate login of the same user by running some custom=20
> connect-scripts with some extra user-cannot-connect-anywhere timeslide.
> Are there any plans to support clients connecting via tcp and udp in=20
> the same instance?

I would *love* to have that.  And it's somewhere on my TODO list of things
to implement in OpenVPN (multiple listening sockets in a single process).

Alas, socket.c is not for the faint of heart, and I haven't had the time
yet to do so.  So I'd certainly welcome your patch :-)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--8X7/QrJGcKSMr1RN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBT1DgNKkuBuNlUUl1AQJcFAP/Wx5/vIs+VXWCKavy4aJo8OJBJak1WYfq
ptetMCZ6XtHUrHVlYTfxFWnVC0/E/xEh7psTeiLCD3AMAqiGeGN2ARLNYCvjmlQp
BHDdB7dzwah1KMo6xtl4qUbbGvMkw4rB5/xQ9bGgCGKpgL37BZt0OO6cMYZXyzGG
CmNZSIYTkyI=
=flaQ
-----END PGP SIGNATURE-----

--8X7/QrJGcKSMr1RN--

