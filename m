Date: Thu, 20 Jun 2013 19:54:47 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20130620175447.GT20843@...1296...>
References: <1370600111-5983-1-git-send-email-dazo@...384...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5/WRjDpoVSxzWgzy"
Content-Disposition: inline
In-Reply-To: <1370600111-5983-1-git-send-email-dazo@...384...>
Subject: Re: [Openvpn-devel] [PATCH 1/3] man page: Update man page about the
	tls_digest_{n} environment variable
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

--5/WRjDpoVSxzWgzy
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jun 07, 2013 at 12:15:11PM +0200, David Sommerseth wrote:
> From: David Sommerseth <davids@...1347...>
>=20
> Signed-off-by: David Sommerseth <davids@...1347...>

ACK - 2.3.3 and 2.4.

(If you put this in 2.3.3, but not the "removal of #ifdef EUREPHIA" patch,
then it would need a note that this is only enabled if compiled with
eurephia support.  So better remove all the #ifdef from 2.3 as well :) )

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--5/WRjDpoVSxzWgzy
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUcNB56kuBuNlUUl1AQK+8AQAh47PKZGsj3BXp+0+nodlfVX0JZYNmxPP
nJvcpY79/ElAYpmWHGhtc4lYj1LUEP8+j/QMqMRpsQ9wHcxIa68/9IlpqeDIq1cu
vaoCTlNYtCPO/PqEscLXTDu9pwW4GsXqA7k7E7BxEL6AhsXiWBboVOJiJtaOtEw6
BjHZzUZ4/kc=
=IArm
-----END PGP SIGNATURE-----

--5/WRjDpoVSxzWgzy--

