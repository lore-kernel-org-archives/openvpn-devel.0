Date: Sun, 13 Apr 2014 15:39:20 +0200
From: Cedric Tabary <cedric+openvpn@...1891...>
Message-ID: <20140413133920.GA28182@...1890...>
References: <20140409232527.GA3061@...1890...>
	<20140413125641.GQ16637@...1296...>
MIME-Version: 1.0
In-Reply-To: <20140413125641.GQ16637@...1296...>
Subject: Re: [Openvpn-devel] BUG: Windows netsh interface ipv6 delete address
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

Bug is still there in this build,
I think you patched the route removal but not the ipv6 address removal
on the interface itself.

C=E9dric


* Gert Doering <gert@...1296...> [2014-04-13 14:56 +0200]:
> Hiya,
>=20
> On Thu, Apr 10, 2014 at 01:25:27AM +0200, Cedric wrote:
> > I get an error on latest release 2.3.3 (and previous ones), on windows =
8.1.
> >=20
> > NETSH: C:\WINDOWS\system32\netsh.exe interface ipv6 delete address OPEN=
VPN 2a02:xxxx:xxxx:ffff::1000
>=20
> So.  here we go :-)
>=20
> Patch (for 2.3.3, but should apply as well to master) is appended.
>=20
> Windows installers for x32 and x64 can be found here:
>=20
>   http://www.greenie.net/ipv6/openvpn-install-2.3.3-routefix-I099-i686.exe
>   http://www.greenie.net/ipv6/openvpn-install-2.3.3-routefix-I099-x86_64.=
exe
>=20
> Please test, and report if that fixes it for you.
>=20
> The sources in there are "pristine 2.3.3 plus the appended patch", built
> with pkcs11-helper 1.11 and openssl 1.0.1g.
>=20
> gert
> --=20
> USENET is *not* the non-clickable part of WWW!
>                                                            //www.muc.de/~=
gert/
> Gert Doering - Munich, Germany                             gert@...1296...
> fax: +49-89-35655025                        gert@...1297...

> From fce0349d035b77e738cb19856d05d92f8cc907bd Mon Sep 17 00:00:00 2001
> From: Gert Doering <gert@...1296...>
> Date: Sun, 13 Apr 2014 13:12:02 +0200
> Subject: [PATCH] IPv6 route delete fix for Win8
>=20
> Use "store=3Dactive" for IPv6 route deletion as well - seems to be requir=
ed
> on Windows 8 and up, and will break OpenVPN reconnection, as old routes
> are not properly deleted, thus new routes cannot be added.
>=20
> Reported-by: Cedric <cedric+openvpn@...1891...>
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>  src/openvpn/route.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/src/openvpn/route.c b/src/openvpn/route.c
> index 6333ee7..78d9c83 100644
> --- a/src/openvpn/route.c
> +++ b/src/openvpn/route.c
> @@ -1974,10 +1974,16 @@ delete_route_ipv6 (const struct route_ipv6 *r6, c=
onst struct tuntap *tt, unsigne
>      argv_printf_cat (&argv, "METRIC %d", r->metric);
>  #endif
>=20=20
> +  /* Windows XP to 7 "just delete" routes, wherever they came from, but
> +   * in Windows 8(.1?), if you create them with "store=3Dactive", this is
> +   * how you have to delete them as well (pointed out by Cedric)
> +   */
> +  argv_printf_cat( &argv, " store=3Dactive" );
> +
>    argv_msg (D_ROUTE, &argv);
>=20=20
>    netcmd_semaphore_lock ();
> -  openvpn_execve_check (&argv, es, 0, "ERROR: Windows route add ipv6 com=
mand failed");
> +  openvpn_execve_check (&argv, es, 0, "ERROR: Windows route delete ipv6 =
command failed");
>    netcmd_semaphore_release ();
>=20=20
>  #elif defined (TARGET_SOLARIS)
> --=20
> 1.8.3.2
>=20




