Date: Thu, 1 Dec 2016 13:33:06 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20161201123306.GK78624@...1296...>
References: <1480545687-19365-1-git-send-email-davids@...515...>
	<20161201080132.GC78624@...1296...>
	<9796b12f-21c2-d9ed-90e3-51de843b2eb8@...2080...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u65IjBhB3TIa72Vp"
Content-Disposition: inline
In-Reply-To: <9796b12f-21c2-d9ed-90e3-51de843b2eb8@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] push: Provide a warning if
 --ifconfig-push have argument mismatch with --topology
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net
Cc: David Sommerseth <davids@...515...>

--u65IjBhB3TIa72Vp
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Dec 01, 2016 at 01:23:52PM +0100, David Sommerseth wrote:
> > (What you can do is "peek at byte 0", which will always be the same
> > part of the netmask [network byte order!], and which might actually
> > make this easier to read .-) )
>=20
> You mean like this?
>=20
>     in_addr_t nmask =3D htonl(c->c2.push_ifconfig_remote_netmask);
>     if ( nmask[0] =3D=3D 0xff )
>       {
>          ...
>=20

No :-) - if you htonl() it, you need to work with full words and=20
0xff000000 etc. - but if you just peek at=20

   ((uchar *)&c->c2.push_ifconfig_remote_netmask)[0]

you should get the first byte of the netmask, no matter what the=20
host byte order is.  (I'm not absolutely sure it's [0], could be [3],
but in any case, since this is "network byte order", location *in=20
memory* will not be host byte order dependent)

But right now I'm a bit too busy to properly think about this, and
would just postpone to 2.4.1 - it's really minor.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--u65IjBhB3TIa72Vp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYQBh7AAoJEB2Cnv7KVigScbgL/1X+CLs94b+eVxio3XG4QU8R
Ke1fbF73Lu6ZWu70o8oOTYojQ8eWf4Q1jn2bZ8MgeWnuQVCXm+auPg2DEblYPUpK
k/eA+mM161ppts6kzg/85Yr+1e6Cjv+xqkda3MqIqPOH3YVQ9N+rM06gI0Pw+gXx
drc6yc4+yV/7Nzxurh5rf5TsFp8/xWuxxevWckQzNhfqDFlZNKvyGuOP6RJbVDvI
fuo9LerEDOgiArzIG4JvvsNUajhiQEVsJaUIY+/NbOgtdP6RR8g/R14UQlad1KPm
7dCdy91FMlBRYx4djp4bF2/5pGxehU5rMiQ17Y9LW4LHue87BkQxgGZgMbh6ZUtY
JbYc0vkTtELNo95qnjWp8KdHWCzmjdlStbppbKuytCr8/ywmLFNEnWAsxs7FTUAJ
XAkQCmefU7M70uAdMBptVcQ4ow4i+8rlljCvCz42fgfd88hDGaY5utuQ/EsmGnuI
rmZKwTqwnLhFf7da4J6aVV4zUR63aS5+u0NLWsO9dg==
=AFL1
-----END PGP SIGNATURE-----

--u65IjBhB3TIa72Vp--

