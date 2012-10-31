Date: Wed, 31 Oct 2012 10:48:58 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20121031094858.GR742@...1296...>
References: <1351539352-17371-1-git-send-email-dazo@...384...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6yEm4/lbnJMR0xRk"
Content-Disposition: inline
In-Reply-To: <1351539352-17371-1-git-send-email-dazo@...384...>
Subject: Re: [Openvpn-devel] [PATCH] Remove the support for using system()
	when executing external programs or scripts
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

--6yEm4/lbnJMR0xRk
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Oct 29, 2012 at 08:35:52PM +0100, David Sommerseth wrote:
> From: David Sommerseth <davids@...1347...>
>=20
> This patch removes the support for the system() call, and enforces the us=
age of execve()

ACK.

(Did not test it, but reviewed the code.  Relying on Samuli's test results
for "how to run scripts with full cmd.exe invocation on windows")

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--6yEm4/lbnJMR0xRk
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBUJD0CakuBuNlUUl1AQJOrgP/bJw+tq30iSsoaONe6XJg8TK58Bn96d5T
3SGlv9E3vZ4LT/ETUOlGey9H6qA3iHpyWyoZeE1nTmFc7KIKv62Y2Iw115wOEXGP
6VQmIzgBTefN77eIPkmQtsC3biO6OtANvRVbgLCkS0IsnPjg0BWuHZgZvyZcCloy
AhM17qcTsow=
=Yene
-----END PGP SIGNATURE-----

--6yEm4/lbnJMR0xRk--

