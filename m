Date: Wed, 4 Jan 2017 19:42:18 +0100
From: Alberto Gonzalez Iniesta <agi@...64...>
Message-ID: <20170104184218.74qpwdpmcsbnxxaj@...30...>
References: <20161121091013.imxgfilt3byyqu7u@...30...>
	<6a902934-903d-840e-059d-2da954486645@...1227...>
MIME-Version: 1.0
In-Reply-To: <6a902934-903d-840e-059d-2da954486645@...1227...>
Subject: Re: [Openvpn-devel] Preparing 2.4-beta1 upload to Debian
 (Experimental)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Arne Schwabe <arne@...1227...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Thanks Arne!

I'll fix this in the next upload.


On Wed, Jan 04, 2017 at 07:21:07PM +0100, Arne Schwabe wrote:
> Am 21.11.16 um 10:10 schrieb Alberto Gonzalez Iniesta:
> > Hi,
> >=20
> > I'm preparing an upload to Debian Experimental of 2.4-beta1 in order to
> > get the maximum exposition as possible. In the meantime I'd like to know
> > your opinion on the following patch that I've been applying to Debian's
> > package for some years:
> > https://bugs.debian.org/cgi-bin/bugreport.cgi?att=3D1;bug=3D367716;file=
name=3Dopenvpn_367716.diff;msg=3D10
> > Fixing this:
> > https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D367716
> >=20
> > Thanks,
> >=20
> > Alberto
> >=20
>=20
> One thing I noticed. Debian still includes a "route_default_nil.patch".
> That patch changes the man page to the command line help which is wrong.
>=20
> The correct thing is to change the command line (patch attached).
>=20
> Arne

> From a88d8ba3e81ca34fc2675805a273cd85875c8973 Mon Sep 17 00:00:00 2001
> From: Arne Schwabe <arne@...1227...>
> Date: Wed, 4 Jan 2017 19:18:46 +0100
> Subject: [PATCH] Change command help to match man page and implementation
>=20
> ---
>  src/openvpn/options.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index bfedb6a..80143e6 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -198,7 +198,7 @@ static const char usage_message[] =3D
>      "                  is established.  Multiple routes can be specified=
.\n"
>      "                  netmask default: 255.255.255.255\n"
>      "                  gateway default: taken from --route-gateway or --=
ifconfig\n"
> -    "                  Specify default by leaving blank or setting to \"=
nil\".\n"
> +    "                  Specify default by leaving blank or setting to \"=
default\".\n"
>      "--route-ipv6 network/bits [gateway] [metric] :\n"
>      "                  Add IPv6 route to routing table after connection\=
n"
>      "                  is established.  Multiple routes can be specified=
.\n"


--=20
Alberto Gonzalez Iniesta    | Formaci=F3n, consultor=EDa y soporte t=E9cnico
mailto/sip: agi@...64... | en GNU/Linux y software libre
Encrypted mail preferred    | http://inittab.com

Key fingerprint =3D 5347 CBD8 3E30 A9EB 4D7D  4BF2 009B 3375 6B9A AA55

