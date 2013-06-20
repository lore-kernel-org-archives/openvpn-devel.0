Date: Thu, 20 Jun 2013 19:52:11 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20130620175211.GS20843@...1296...>
References: <1370600123-6029-1-git-send-email-dazo@...384...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XGJ4AFwUsJ5M8gfn"
Content-Disposition: inline
In-Reply-To: <1370600123-6029-1-git-send-email-dazo@...384...>
Subject: Re: [Openvpn-devel] [PATCH 2/3] Remove the --disable-eurephia
	configure option
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

--XGJ4AFwUsJ5M8gfn
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jun 07, 2013 at 12:15:23PM +0200, David Sommerseth wrote:
> From: David Sommerseth <davids@...1347...>
>=20
> This "feature" has been enabled since OpenVPN 2.2 without any reports that
> this has been causing issues.  All it does is to add an extra environment
> variable 'tls_digest_{n}' with the certificate SHA1 fingerprint/digest ha=
sh.
>=20
> Lets just simplify things by removing the possibility to disable this
> environment variable.

ACK.

I'd say this is good for 2.3.3 and 2.4.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--XGJ4AFwUsJ5M8gfn
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUcNBSqkuBuNlUUl1AQIh5QP/aYHRVYIpES+wFIPR6InEpUhky0UpNWZ1
AB4ClPk2g3i+oNop5UavPXE5xUwfMGAPTIcxGSJ+H6+NBxdmqUKlogIAMtwjamnA
an6vkqjmIJOj4MndWCE+k2bhl2AbYLH+GhYznpczjtvZKS8qoAtTHUZo8dBlaa6M
nfGCtQhbjjE=
=ujWR
-----END PGP SIGNATURE-----

--XGJ4AFwUsJ5M8gfn--

