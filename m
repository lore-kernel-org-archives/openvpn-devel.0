Date: Fri, 2 Sep 2011 20:46:33 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20110902184633.GX8496@...1296...>
References: <1313046031-14499-1-git-send-email-heiko.hund@...1489...>
	<1314802162-26070-1-git-send-email-heiko.hund@...1489...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2RPzo/4ugryNNa1+"
Content-Disposition: inline
In-Reply-To: <1314802162-26070-1-git-send-email-heiko.hund@...1489...>
Subject: Re: [Openvpn-devel] [PATCH-UPDATE] define IN6_ARE_ADDR_EQUAL macro
	for WIN32
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Heiko Hund <heiko.hund@...1489...>
Cc: openvpn-devel@lists.sourceforge.net

--2RPzo/4ugryNNa1+
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Aug 31, 2011 at 02:49:22PM +0000, Heiko Hund wrote:
> Windows headers do not define the IN6_ARE_ADDR_EQUAL macro. It needs
> to be defined locally when building for WIN32.
>=20
> Signed-off-by: Heiko Hund <heiko.hund@...1489...>
>=20
> Update: remove check for USE_PF_INET6 since commit
> eb23089183745853fac9414d45a559a478ef51d6 removed the definition
> of this macro. IPv6 is now always compiled in.

ACK.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--2RPzo/4ugryNNa1+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTmEkiakuBuNlUUl1AQIriAP+LuUmhZlLfE5f4scyVJax3G/cGZpUZXk6
kR+46Uyuc5yxCJC3YpRtZrtlNsrwPqehSbGub2+IZ7CzrC3s9VH4Q+RoLyzHWBr3
buL38q2y/oQ8FA6yLiI2/Aqxl4n06D5cl4p79OvZLD2Vah/yjsliThIdDQytY2z0
gbJs3V6Vzxk=
=Grcp
-----END PGP SIGNATURE-----

--2RPzo/4ugryNNa1+--

