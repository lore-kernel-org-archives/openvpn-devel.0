Date: Sat, 7 Dec 2013 21:44:34 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20131207204434.GE161@...1296...>
References: <CAFHpkQEdec39CQFOr7M3=+1yDi4myTtoHBdankg9NRnF-ZhzoQ@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6rm81vzJzyBMZFym"
Content-Disposition: inline
In-Reply-To: <CAFHpkQEdec39CQFOr7M3=+1yDi4myTtoHBdankg9NRnF-ZhzoQ@...278...>
Subject: Re: [Openvpn-devel] uninitialized handle fix (serious bug on Win
	8.1), another attempt
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ???? ??????? <chipitsine@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--6rm81vzJzyBMZFym
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Dec 07, 2013 at 09:01:35PM +0600, ???? ??????? wrote:
> if handle is not initialized, orig_stderr variable could take random
> value, which we observe on Windows 8.1 (bug reported here as well:
> https://forums.openvpn.net/topic13246.html )

This can't be the right fix - if the problem is that orig_stderr is
not initialized, wouldn't it be more logical to just ensure orig_stderr
*is* initialized?

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--6rm81vzJzyBMZFym
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUqOIsqkuBuNlUUl1AQJg6QP/bRkZB/OPcZ7dX1Lv3C2eKjiYF+6cWQ2X
hH3fMKf6J0vpYseJLMsJNldgrWy9zWhH65YOvPQFxND9B4emb7404JFNSyV+cxZL
FTx5lLcoprWctBXHvoRC2Q+V33Fb08y4wy+n1paS/QX/i0Xk9vq4jI4QKay68Wyp
4J+LqFC7uHA=
=ySCw
-----END PGP SIGNATURE-----

--6rm81vzJzyBMZFym--

