Date: Sun, 9 Sep 2012 20:52:44 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120909185244.GW742@...1296...>
References: <1347154246-20143-1-git-send-email-dazo@...384...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0eh6TmSyL6TZE2Uz"
Content-Disposition: inline
In-Reply-To: <1347154246-20143-1-git-send-email-dazo@...384...>
Subject: Re: [Openvpn-devel] [PATCH] Fix reconnect issues when --push and
	UDP is used on the server
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <dazo@...384...>
Cc: james@...515..., openvpn-devel@lists.sourceforge.net

--0eh6TmSyL6TZE2Uz
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Sep 09, 2012 at 03:30:46AM +0200, David Sommerseth wrote:
> From: David Sommerseth <davids@...1347...>
>=20
> When the server is configured with UDP and --push statements, reconnecting
> often fails by the client never receiving PUSH_REPLY.  The client sends
> PUSH_REQUEST and the server logs these requests but does not send them.
>=20
> This bug got introduced in commit ff65da3a230b658b2c1d52dc1a48612e80a2eb42
> which tries to avoid sending duplicated PUSH messages if the client/server
> connection is slow.
>=20
> This patch keeps this behaviour, but instead of a session wide PUSH_REPLY
> block it sets an expiry time for the PUSH_REPLY block.  The expiry time
> is set to 30 seconds.

Looks good to me.

(I can see the reason why ff65da3a230b658b2c was implemented, and a=20
30-second-delay should handle these cases even for "normally" slow=20
servers or slow connections).

ACK.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--0eh6TmSyL6TZE2Uz
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBUEzle6kuBuNlUUl1AQJv5gP/edPwhiR7pFt6ApWwGb+IVmHSqczMGOhT
7yIiqE1WoeAhA8Hl0t50iDnYir+G6q6vm/ERv0maay5jpOamjj5AFIOIHGpIx3nQ
mIdh5y2TyGn6XVo92a17F2ak6ibgqG5kVm0pXMpdEu/9cKUNHcRXFrbjAjlwD6t4
Fh/m345m05w=
=CqdV
-----END PGP SIGNATURE-----

--0eh6TmSyL6TZE2Uz--

