Date: Sat, 7 Jun 2014 21:00:35 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140607190035.GX1118@...1296...>
References: <1402080235-24409-1-git-send-email-gert@...1296...>
	<539334C9.8080009@...1856...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="U7F658e60E1K4csu"
Content-Disposition: inline
In-Reply-To: <539334C9.8080009@...1856...>
Subject: Re: [Openvpn-devel] [PATCH] Drop incoming fe80:: packets silently
	now.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

--U7F658e60E1K4csu
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Jun 07, 2014 at 05:50:33PM +0200, Steffan Karger wrote:
> Maybe put the IPv6 link-local address comment on a single line?

Yeah.  That one started as a multi-line comment :-) - I'll change it=20
to

> > -		  msg (D_MULTI_DROPPED, "MULTI: bad source address from client [%s],=
 packet dropped",
> > -		       mroute_addr_print (&src, &gc));
> > +		  /* IPv6 link-local address (fe80::xxx)? */
> > +		  if ( (src.type & MR_ADDR_MASK) =3D=3D MR_ADDR_IPV6 &&
> > +		        src.addr[0] =3D=3D 0xfe && src.addr[1] =3D=3D 0x80 )
> > +		    {

... as I go.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--U7F658e60E1K4csu
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBU5NhUqkuBuNlUUl1AQL2pgQAmjc3NruI9tCeWxh8zZhRKTuoPF+YDBRd
lWetBrPUo9Hjh27EFyvyDcO0tVjYI7PXdFYFYI7P4nIiJ75Cuq4Dxv7yR9a9wCqP
c0gmNQi25Kyz+F+yVc3gFIiFjC7XxpMy3bYr9mJ3aaNeptg0WUgEhYaC4tvr3GxN
6KGmVXL8vC4=
=oud4
-----END PGP SIGNATURE-----

--U7F658e60E1K4csu--

