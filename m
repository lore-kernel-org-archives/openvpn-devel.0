Date: Mon, 15 Aug 2022 11:54:21 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YvoXzZNWGa49RJ6D@...1296...>
References: <20220514103717.235-1-timo@...2669...>
 <202208111003.27BA3jBP091528@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="mlCIm+8c30YDmEor"
Content-Disposition: inline
In-Reply-To: <202208111003.27BA3jBP091528@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: platform: Retain
 CAP_NET_ADMIN when dropping privileges
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Timo Rothenpieler <timo@...2669...>
Cc: openvpn-devel@lists.sourceforge.net, berni@...376...

--mlCIm+8c30YDmEor
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

HI,

On Thu, Aug 11, 2022 at 12:03:45PM +0200, Gert Doering wrote:
> I have not tested this myself, but if I had, the test setup would have
> been very similar to what Frank did (so, big thanks) - run a DCO=20
> environment with "owner nobody", and see if things still work.
>=20
> I will add this to my DCO server test environment - run one of the
> iroute-using instances with "nobody", so it is continuously tested.
[..]
> commit 2e359a088226ab1e5ee41fbab27d38d8a8d192ac
> Author: Timo Rothenpieler
> Date:   Sat May 14 12:37:17 2022 +0200
>=20
>      platform: Retain CAP_NET_ADMIN when dropping privileges

Unfortunately, it seems that our approach to "if SITNL is used, we hard
require that setting CAP_NET_ADMIN succeeds" is too strong for the twisted
ways that people use openvpn.

Namely, network-manager...

  https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1017379

... runs openvpn with --ifconfig-noexec / --route-noexec, and insists
on doing all that itself.  I do not like NM's way of trying to control
everything (up to the point that it defaults to redirecting a default
route to OpenVPN even if config and server do not want that), but this
is what Linux people seem to be stuck with, so we need to handle it.


So I think we need to amend this patch twofold

 - if --ifconfig-noexec && --route-noexec are set, do not mandate
   success on CAP_NET_ADMIN (users might want it for using it in --up
   scripts, but if it fails, *openvpn* is not missing functionality)

   --> this should take care of the NM case

 - also, we might want to think long and hard about mandating it if
   --client (that is, --pull) is in use.  We postpone dropping of privileges
   until after the initial ifconfig/route setup has been done, and on
   program end, closing tun/dco interface will (I hope) make the interface
   go away without needing privileges, and the system will remove the=20
   routes together with it.

   --redirect-gateway will break, --redirect-gateway def1 will not.

   Overlapping vpn routes with vpn gateway (=3D install a host route) will
   also be unable to clean up at program end.  But this is no worse than
   2.5.x with --user nobody.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--mlCIm+8c30YDmEor
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJi+hfNAAoJEB2Cnv7KVigSPmgMAJgZvt7BIeqzBs0WGSvf4Php
N0573rLBgJyhf4Itmizq5zXobmVvl40kIRI5lFMLm/OYLImoYWzuwyqVaeZ5lhZd
dnAc9hTNuQYz6SnnNzkL7u+svES0M4vCaoaCNEbtZbDjHCtEGTPhbAsWpwjy3EQr
/panAfEWgdC91l/vlEwNrxrr2JnCI3TeSCe/wIaRoOS0Z5ipOvl1C9eDpTKeDE9k
98hCkeNoKUSvi3SsQKVlfDgWSqvdN/rXgGbeQ9+En7FDla0rVB2gCbBCfx00FlFI
nmL92iDOniPQDmRrsCHeXIZj49qkBJp/RZNR1471/hRmtwDtyudQl1jcOvaZAB3m
nGq1IrAxnWX3Tk2kFSBCf7A9CfeNntAL/bQhvxvhCuvx4X4PlH8e3AS1ro0czbrP
NDunIEw9qvPkXwieIUWgiJV9YG0FSRPsrz6XXexd9453IWbUqcYqNw6KDddkEpfb
MTDslWqdVbAsURcJV7FTiCvZKEdj+KxQBATXtod8Sg==
=s//k
-----END PGP SIGNATURE-----

--mlCIm+8c30YDmEor--

