Date: Tue, 14 Feb 2012 17:26:40 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20120214162639.GT7024@...1296...>
References: <1329216527-14035-1-git-send-email-davids@...1347...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6Vw0j8UKbyX0bfpA"
Content-Disposition: inline
In-Reply-To: <1329216527-14035-1-git-send-email-davids@...1347...>
Subject: Re: [Openvpn-devel] [PATCH] Connection entry {tun,
	link}_mtu_defined not set correctly
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

--6Vw0j8UKbyX0bfpA
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Feb 14, 2012 at 11:48:47AM +0100, David Sommerseth wrote:
> Commit 76809cae0eae07817160b423d3f9551df1a1d68e enabled setting MTU
> variables inside <connection> blocks.  But in that process, the
> tun_mtu_defined and link_mtu_defined was not set as it should.
>=20
> By moving this out of the options_postprocess_mutate_invariant()
> function and into options_postprocess_mutate_ce(), these variables
> get these *_mtu_defined variables are set correctly in each connection
> entry.
>=20
> Signed-off-by: David Sommerseth <davids@...1347...>

ACK.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--6Vw0j8UKbyX0bfpA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTzqLP6kuBuNlUUl1AQKhFQP/foRQOiC7cRBC2XwYC8Y/AlSpohdDuzax
3ZorbV3eC1gOe/XvoqselycDPcdLymFlYPgFLK877B0F4EEZ2H8v21D/JBVxTffO
XJNn5uoElMWuebnljU2LGB+Hlift2Eqf9Kna2IfMV4y23/jooknN1ZxR7b8RTJEt
6zSMELNfNOg=
=gXey
-----END PGP SIGNATURE-----

--6Vw0j8UKbyX0bfpA--

