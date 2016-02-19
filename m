Date: Fri, 19 Feb 2016 18:37:09 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20160219173709.GB24952@...1296...>
References: <CAP=zTkOduThZFBXdewpYv1RQyi9z0Hzaz6MPuRXSt5HkbMTewQ@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5l0S+RwDFSjq0D/N"
Content-Disposition: inline
In-Reply-To: <CAP=zTkOduThZFBXdewpYv1RQyi9z0Hzaz6MPuRXSt5HkbMTewQ@...278...>
Subject: Re: [Openvpn-devel] Enabling TLS Session Resumption in OpenVPN
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Shubham Chauhan <shubham13099@...2124...>
Cc: openvpn-devel@lists.sourceforge.net

--5l0S+RwDFSjq0D/N
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Feb 19, 2016 at 07:02:21PM +0530, Shubham Chauhan wrote:
> I am currently working on a project that requires SSL VPN to use session
> resumptions.
>=20
> I need to add the TLS Session Resumption functionality to OpenVPN. Any
> starters as in how I could achieve this?
> I know about the SSL_OP_NO_TICKET flag added to disable the resumption
> process. Will deleting it from the code enable SSL resumption automatical=
ly?

Unless I'm misunderstanding the lore, there are so many lurking risks in
SSL session resumption that we're just not doing this, period.

With peer-id TLS floating, there is not any need for it in OpenVPN anyway.

gert


--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--5l0S+RwDFSjq0D/N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVsdSxKkuBuNlUUl1AQL5ZgP/WCfqv0MKutzWSkEjRLMorfu3ttxoeVRi
ZqaThRvzxVT15KNbxTzb22T3IVaa2I15k9+ckZAiVw43YYfM6yTZxRXm/t7d3nPu
uJHwsYQ2Xy7GAbfrQQs5U2xasVyJyuLFHX/fJ2TyRlGQ9i3yShNZZMIko43yEqLm
O8FF3xxTl1U=
=rP/A
-----END PGP SIGNATURE-----

--5l0S+RwDFSjq0D/N--

