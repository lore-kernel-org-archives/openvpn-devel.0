Date: Tue, 19 Jun 2012 13:05:27 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120619110527.GY1059@...1296...>
References: <1340044749-10694-1-git-send-email-arne@...1227...>
	<1340044749-10694-5-git-send-email-arne@...1227...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sjel/IY1pyoUgMMX"
Content-Disposition: inline
In-Reply-To: <1340044749-10694-5-git-send-email-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 4/6] Remove ENABLE_CONNECTIONS ifdefs,
	connections were always on for a long time. Not that
	ENABLE_MAMAGEMENT_REMOTE was only depending on
	ENABLE_CONNECTIONS and is removed as well
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--sjel/IY1pyoUgMMX
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Jun 18, 2012 at 08:39:07PM +0200, Arne Schwabe wrote:
>  #endif
>=20=20
> -#if MANAGEMENT_QUERY_REMOTE
> -
>  static bool
[..]
>  init_connection_list (struct context *c)
>  {
> -#ifdef ENABLE_CONNECTION
>    struct connection_list *l =3D c->options.connection_list;
>    if (l)
[..]

Same as for 3/6, I'm generally OK with this ("we have way too many #ifdef")
but would like an ACK from James -> Meeting.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--sjel/IY1pyoUgMMX
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBT+Bc96kuBuNlUUl1AQILOgP/f481I0/2lRxNWuSuDLLdOsGaNtINxd2+
/9tzlYA8yH3Pv5v55eW+ZzD45555ZNiPvvGuPtAsyuEQBFTC6a5JbHwz2Hv/qcA6
XDw3MWzTZO9bhP5SuqU8iB8Mw1oq5fQCqZC20IwdadnfezrxHWkId0Rvk9MmCbVZ
F1UE1CnSGfM=
=2PwE
-----END PGP SIGNATURE-----

--sjel/IY1pyoUgMMX--

