From: Matthias Andree <matthias.andree@...32...>
Subject: Re: [Openvpn-devel] Default MTU
Message-ID: <20020710093001.GB23249@...33...>
References: <01c101c225f3$932d10c0$1000000a@...4...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XWOWbaMNXpFDWE00"
Content-Disposition: inline
In-Reply-To: <01c101c225f3$932d10c0$1000000a@...4...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=openvpn-devel>
Date: Wed Jul 10 02:31:02 2002
To: openvpn-devel@lists.sourceforge.net

--XWOWbaMNXpFDWE00
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sun, 07 Jul 2002, James Yonan wrote:

> (1) Static, pre-shared key mode is stateless and handshake-free, so there
> isn't really an existing context in which PMTU discovery could be
> implemented.

Must the MTU be known to the protocol after all? It might be assymmetric
when asymmetric routing (satellite downlink with ISDN uplink) is in
place.

Is not it sufficient if your own secure PMTU discovery is done
independently for either side? Sorry, I'm still not acquainted with the
OpenVPN protocol for lack of time.

> (2) Path MTU discovery could work in TLS mode, however every time the the
> MTU changes, the tun or tap device would need to be re-ifconfiged -- this
> might also involve closing and reopening the tun device which would fail =
if
> root privileges have been dropped.

If you do it in the application, yes. If you leave it to the kernel,
then it's not necessary.

> So at this point a static default is certainly the simpler way to go, but
> any changes to the static default should be carefully considered since th=
ey
> would introduce backward incompatibility issues.

--=20
Matthias Andree

--XWOWbaMNXpFDWE00
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9K/6ZFmbjPHp/pcMRAimMAJ9qO+HXqR6qnNjq4FexT1QG7aYAggCghpBl
ntnbsC6Rqp0c1qV91PPa/jo=
=Fuok
-----END PGP SIGNATURE-----

--XWOWbaMNXpFDWE00--

