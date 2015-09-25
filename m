From: Steffan Karger <steffan.karger@...1435...>
Date: Fri, 25 Sep 2015 07:39:54 +0000
Message-ID: <58e764220e744239b6346fd53e328987@...2037...>
References: <1443162970-38210-1-git-send-email-gert@...1296...>
In-Reply-To: <1443162970-38210-1-git-send-email-gert@...1296...>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] Repair test_local_addr() on WIN32
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Gert Doering schreef op vrijdag 25 september 2015 8:36:
> Intermediate result was stored in a "bool" variable, but the actual
> range of results is 0/1/2 - so "2" (TLA_LOCAL) never worked.  Change
> to "int".
>=20
> Diagnosed by "dferbas" in trac #609 (thanks).
>=20
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>  src/openvpn/route.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/src/openvpn/route.c b/src/openvpn/route.c
> index d45a02e..7baa3b6 100644
> --- a/src/openvpn/route.c
> +++ b/src/openvpn/route.c
> @@ -3600,7 +3600,7 @@ test_local_addr (const in_addr_t addr, const
> struct route_gateway_info *rgi)
>  {
>    struct gc_arena gc =3D gc_new ();
>    const in_addr_t nonlocal_netmask =3D 0x80000000L; /* routes with
> netmask <=3D to this are considered non-local */
> -  bool ret =3D TLA_NONLOCAL;
> +  int ret =3D TLA_NONLOCAL;
>=20
>    /* get full routing table */
>    const MIB_IPFORWARDTABLE *rt =3D get_windows_routing_table (&gc);
> --
> 2.4.6

ACK

-Steffan

