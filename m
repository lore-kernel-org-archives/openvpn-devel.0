Date: Wed, 11 Nov 2015 09:16:04 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20151111081604.GU24952@...1296...>
References: <1447079709-17806-1-git-send-email-lstipakov@...277...>
	<20151109145555.GE24952@...1296...>
	<5642F6B7.7090902@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="o/5eNASeIIpuMggS"
Content-Disposition: inline
In-Reply-To: <5642F6B7.7090902@...277...>
Subject: Re: [Openvpn-devel] [PATCH v2] Use adapter index instead of name
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: Olli Mannisto <olmannisto@...277...>, openvpn-devel@lists.sourceforge.net

--o/5eNASeIIpuMggS
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Nov 11, 2015 at 10:05:11AM +0200, Lev Stipakov wrote:
> >
> > It should actually be not very hard - we should be able to set "tt->act=
ual"
> > to read "interface=3Dnnn", and then it should work automagically withou=
t even
> > touching route.c at all
>=20
> Setting "interface=3D<idx>" to "tt->actual_name" will affect all code=20
> branches which use that value, for example "netsh_enable_dhcp". In this=20
> particular case we cannot use index and must use interface name,=20
> according to MS=20
> (https://technet.microsoft.com/en-us/library/cc731521(v=3Dws.10).aspx#BKM=
K_setaddress)

Uh.  Thanks for investigating.  Why, oh why... it was naive of me to expect
consistency here, I should have known better :-(

[..]
> So, if we want to use index also for "add/del route", I'd gently modify=20
> add/del_route_ipv6 and make it use "interface=3D<idx>" (without breaking=
=20
> "vpn server special route" case).

For consistency, I think we should do that.  What I'd avoid is to do
the adapter_index lookup for every single route - which would imply adding
the index to struct tuntap_options or something like that which is=20
available in add/del_route[_ipv6]() already.  But this is less elegant
than I hoped for, and might have to look different for 2.3 and master.

So maybe make this a separate patch?

> > What does surprise me, though, is that it works for you with just speci=
fying
> > the interface index, without "IF" or "interface=3D" before it.
> >
>=20
> MS says "[[ interface=3D] String] Specifies an interface name or index"=20
> for "set address" and "add route". If I read it right, "interface"=20
> prefix can be omitted. But let's use it for consistency with existing cod=
e.

... and make this ("interface=3D<idx>") a v3 patch, only for "set address"
for now, to move forward.

thanks,

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--o/5eNASeIIpuMggS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVkL5Q6kuBuNlUUl1AQKH6QP9EHwsYKiiGWvqm4qx9dGgsfsPK1+05Zrx
s61dTyl0wJnx3KF6pjDuCBGvTIYTue6jI+pSGBsVZ5hL9aav45N9gyk0GsP96faj
lcrDjzoJPnnmFj5h5GDRFEgI0dT3RGIJanjSUO94JL1/HpI3+FLwQsyylfQESbYF
ZcUqI0gBrRA=
=UWSc
-----END PGP SIGNATURE-----

--o/5eNASeIIpuMggS--

