From: samuli@...515...
Date: Wed, 13 Jul 2011 17:12:28 -0700
Message-Id: <1310602349-22195-2-git-send-email-samuli@...515...>
In-Reply-To: <1310602349-22195-1-git-send-email-samuli@...515...>
References: <1310602349-22195-1-git-send-email-samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/2] Additional Visual Studio 2008 build
	fixes to tun.c
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

From: Samuli Sepp=C3=A4nen <samuli@...515...>

Signed-off-by: Gert Doering <gert@...1296...>
Tested-by: Samuli Sepp=C3=A4nen <samuli@...515...>
Signed-off-by: Samuli Sepp=C3=A4nen <samuli@...515...>
---
 tun.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/tun.c b/tun.c
index 8cdd248..3cf2e3e 100644
--- a/tun.c
+++ b/tun.c
@@ -4865,6 +4865,7 @@ close_tun (struct tuntap *tt)
     {
       if ( tt->ipv6 && tt->did_ifconfig_ipv6_setup )
         {
+	  const char *ifconfig_ipv6_local;
 	  struct argv argv;
 	  argv_init (&argv);
=20
@@ -4872,7 +4873,7 @@ close_tun (struct tuntap *tt)
 	  delete_route_connected_v6_net(tt, NULL);
=20
 	  /* netsh interface ipv6 delete address \"%s\" %s */
-	  const char * ifconfig_ipv6_local =3D print_in6_addr (tt->local_ipv6, 0,=
 &gc);
+	  ifconfig_ipv6_local =3D print_in6_addr (tt->local_ipv6, 0,  &gc);
 	  argv_printf (&argv,
 		    "%s%sc interface ipv6 delete address %s %s",
 		     get_win_sys_path(),
--=20
1.7.4.1


