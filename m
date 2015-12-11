Date: Fri, 11 Dec 2015 21:07:23 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20151211200722.GU24952@...1296...>
References: <1447079709-17806-1-git-send-email-lstipakov@...277...>
	<20151109145555.GE24952@...1296...>
	<5642F6B7.7090902@...277...>
	<20151111081604.GU24952@...1296...>
	<566B2704.8070500@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dXvN/oL/yBWKZMaf"
Content-Disposition: inline
In-Reply-To: <566B2704.8070500@...277...>
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
Cc: openvpn-devel@lists.sourceforge.net

--dXvN/oL/yBWKZMaf
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Dec 11, 2015 at 09:41:56PM +0200, Lev Stipakov wrote:
> Hi,
>=20
> >> So, if we want to use index also for "add/del route", I'd gently modify
> >> add/del_route_ipv6 and make it use "interface=3D<idx>" (without breaki=
ng
> >> "vpn server special route" case).
> >
> > For consistency, I think we should do that.  What I'd avoid is to do
> > the adapter_index lookup for every single route - which would imply add=
ing
> > the index to struct tuntap_options or something like that which is
> > available in add/del_route[_ipv6]() already.  But this is less elegant
> > than I hoped for, and might have to look different for 2.3 and master.
>=20
> Adding the index - you probably meant to "struct tuntap"?

Sort of.  Struct tuntap has a sub-struct "struct tuntap_options options"
which is mostly empty for all platforms but WIN32, and on WIN32 contains
stuff like

  /* --ip-win32 options */
  bool ip_win32_defined;
  int ip_win32_type;

already (tun.h).  So adding "tuntap_adapter_index" or something like this
here would be fully in line with the existing style of packing windows
specific bits nicely away, but having them available where needed...

route_add() gets passed a "struct tuntap *tt", so the option would be
in tt->options.tuntap_adapter_index...

> Master has member "adapter_index", which seems to be used for "special=20
> case", release/2.3 does not have that.

Now that's an interesting finding.  I never noticed that, but it basically
*is* what I propose above - not in tuntap_options but in the "main"
struct tuntap - and I had no idea that this one existed (I tend to not
look very closely at #ifdef WIN32 bits unless I have to).

It *is* in 2.3, btw :-) - as per "git blame tun.h" it was introduced=20
into James' svn repo before we even had a git repo...


> Do you think it is safe to store adapter index there (would have to add=20
> it to 2.3) without breaking "special case"? I personally not so sure,=20
> since that "adapter_index" is obtained via "adapter_index_of_ip" in=20
> tun.c, which looks quite different from "get_adapter_index_flexible".
>=20
> We might have a semantic problem here.

adapter_index_of_ip() seems to be a "find connect routes" thing, not
tied to the tuntap adapter - but that doesn't seem to be connected to
tt->adapter_index.

Don't confuse with "rgi->adapter_index" - *that* is for routing information,
and might point elsewhere.

tt->adapter_index seems to be set only in two places, namely

tun.c:  tt->adapter_index =3D TUN_ADAPTER_INDEX_INVALID;

and

tun.c:  tt->adapter_index =3D get_adapter_index (device_guid);
  (in open_tun())

... and that one seems to be sort of like "get_adapter_index_flexible()
lite" - the latter can search for guid *or name*, while the former only
searches by guid.


So... I think we can just *use* that in add/del_route*(), and be happy
everafter :-) - it's not available when we do "netsh... set address",
unfortunately, as open_tun() happens *after* do_ifconfig() on windows...

Definitely worth a try.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--dXvN/oL/yBWKZMaf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVmss+qkuBuNlUUl1AQJCXQQAw2N8dL8dXRHUl4P9mnkXprg/WyMP7ezE
dWDLNqQtrg4Zdel06/OnqrNWEd1wVCnBogiQ4AKbuJBCvuNfHDTGRf0xkOihMyqd
J5XzVdP3vynHAscBuv+8VnxFZWxXKUcwxjBBCgni2w9zqyWPjdA8qa9jYKAkh7iB
3Z1HQXuGTvM=
=LiIi
-----END PGP SIGNATURE-----

--dXvN/oL/yBWKZMaf--

