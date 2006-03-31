From: Roy Marples <uberlord@...594...>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_P/PLEZB6rWfHT91"
Message-Id: <200603311109.19551.uberlord@...594...>
Subject: [Openvpn-devel] PATCH: Remove route with metrics
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Fri Mar 31 02:10:06 2006
To: openvpn-devel@lists.sourceforge.net

--Boundary-00=_P/PLEZB6rWfHT91
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi list!

I set my openvpn server to dish out default routes with a high metric. This 
allows me to prefer hard wired LAN over the vpn, whilst allowing the same 
openvpn server to provide default routes for my wireless. Config is like so

push "route 0.0.0.0 0.0.0.0 10.73.1.1 500"

This works great! However, when the openvpn client stops it tears down all 
default routes - which is not desirable.

Attached is a patch that only tears down routes on the metric given, so if a 
route was created with a metric, tear down the route with that metric. Only 
patched for Linux systems as I'm unsure of the command for others - although 
its probably very similar.

Thanks
-- 
Roy Marples <uberlord@...594...>
Gentoo Linux Developer

--Boundary-00=_P/PLEZB6rWfHT91
Content-Type: text/x-diff;
  charset="us-ascii";
  name="openvpn-2.0.5-route-del-metric.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="openvpn-2.0.5-route-del-metric.patch"

--- route.c
+++ route.c
@@ -832,6 +832,8 @@
 	      network,
 	      netmask);
 #endif /*CONFIG_FEATURE_IPROUTE*/
+  if (r->metric_defined)
+    buf_printf (&buf, " metric %d", r->metric);
   msg (D_ROUTE, "%s", BSTR (&buf));
   system_check (BSTR (&buf), es, 0, "ERROR: Linux route delete command failed");

--Boundary-00=_P/PLEZB6rWfHT91--

