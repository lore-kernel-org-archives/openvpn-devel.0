Date: Sun, 31 May 2015 22:45:47 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20150531204547.GK382@...1296...>
References: <1433104918-9523-1-git-send-email-gert@...1296...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LpveMUvXs97SUkgl"
Content-Disposition: inline
In-Reply-To: <1433104918-9523-1-git-send-email-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] On signal reception,
	return EAI_SYSTEM from openvpn_getaddrinfo().
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--LpveMUvXs97SUkgl
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, May 31, 2015 at 10:41:58PM +0200, Gert Doering wrote:
> A signal (except SIGUSR1) received while waiting for getaddrinfo() is
> considered fatal, so openvpn_getaddrinfo() is destroying the returned
> information with freeaddrinfo(), but still signalled "success" (0)
> to the caller - so if the caller accessed *res before checking
> *signal_received, it would access just-free()ed memory, which on some
> platforms still worked and on others caused a crash.
>=20
> Also, ensure that *ai is also NULLed in the caller now.

This is actually "Trac #276" :-) - need to add this to the commit note.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--LpveMUvXs97SUkgl
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVWty+qkuBuNlUUl1AQJNdQQAsNblzMkjE7UZYucNZse7pOLH6MCB8c2z
BlMqVMa7cG5SAFTsiHhv19xfTrAXAoUTElnx2oxngwnPjK4YHtJJUg+E1nB52MQ9
+xI0llUI1GVNpQfcpdzg+nAWKtaVNoqiLUrmupHjoTSuVttu7juY9xp85ductNOM
rBBExGV8fyM=
=IMUJ
-----END PGP SIGNATURE-----

--LpveMUvXs97SUkgl--

