Date: Fri, 27 May 2011 09:58:10 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20110527075746.GE8496@...1296...>
References: <1306398714-10124-1-git-send-email-davids@...1347...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mr0mUbrMtPK4hI3R"
Content-Disposition: inline
In-Reply-To: <1306398714-10124-1-git-send-email-davids@...1347...>
Subject: Re: [Openvpn-devel] [PATCH] Don't define ENABLE_PUSH_PEER_INFO if
	SSL is not available
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

--mr0mUbrMtPK4hI3R
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, May 26, 2011 at 10:31:54AM +0200, David Sommerseth wrote:
> The push_peer_info feature depends on the SSL infrastructure and openvpn
> will fail to build if ./configure --disable-crypto --disable-ssl is
> used.  The solution is to not define ENABLE_PUSH_PEER_INFO if we don't
> have crypto/ssl.

ACK.=20=20

The dependency is somewhat non-obvious - took me a while to find
it, and then David had to point me to it.  options->push_peer_info is
only defined #ifdef USE_SSL, so without USE_SSL, code that tries to
access this variable will not compile.

As the actual pushing happens from within SSL/Crypto functions, trying
to define push_peer_info outside #ifdef USE_SSL would not help anything,
and as such, this is least-invasive cleanup.

--> ACK ;-)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--mr0mUbrMtPK4hI3R
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTd9ZeqkuBuNlUUl1AQKL/wP/ZAgW+uKjLLgdRSK2mi/nfoKvDhyi1FxF
d0BgoLlu5NLKEPZwzTTA763mEISTvlL0x9wKaJc0pUMKO5j3Pr2AsA4UcKRmXhB7
T6qUX8k4TMA0iM98AybIbL+MnpcHxTRQGi7F9b66Ik5ZNjV7lCmJJNmw5UklOCpC
sbJHuxNz+rg=
=ZH9i
-----END PGP SIGNATURE-----

--mr0mUbrMtPK4hI3R--

