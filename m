Date: Tue, 8 Jan 2013 09:52:01 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20130108085201.GM22465@...1296...>
References: <00D1D856-A942-490E-957C-1BBD71ADE4B6@...1286...>
	<E1TsJSY-0007jC-0R@...1797...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="brIPaX2gw1r/QD7O"
Content-Disposition: inline
In-Reply-To: <E1TsJSY-0007jC-0R@...1797...>
Subject: Re: [Openvpn-devel] Correct Man Page: client-to-client
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Davide Brini <dave_br@...1278...>
Cc: openvpn-devel@lists.sourceforge.net

--brIPaX2gw1r/QD7O
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Jan 07, 2013 at 09:38:02PM +0100, Davide Brini wrote:
> The current documentation looks correct to me. When using client-to-clien=
t,
> traffic is not exposed on the tun interface; when not using
> client-to-client, traffic shows up on the tun interface and can be
> firewalled (eg with iptales).

+1

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--brIPaX2gw1r/QD7O
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBUOveMakuBuNlUUl1AQJA9QQAkh7fSZO8yum8s10rzL0j+GJRkz0xAEc5
Gl1HaddAM0gU8f+VQgBH++ocj82LpjEEmKfQa/jr5GyXHx9PRCuwBpY4qyFhZk2I
CNmnhrIdingkBm5g4LtvjlDg98gbXvXwFzPWC36yAQ8TofRoRnzpAfHImUgGjLBn
Wv/CUhtp9Pw=
=fqT/
-----END PGP SIGNATURE-----

--brIPaX2gw1r/QD7O--

