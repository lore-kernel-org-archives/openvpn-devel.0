Message-ID: <40A5F0E7.9040703@...61...>
From: Julien TOUCHE <julien.touche@...61...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] openvpn 1.x: route on darwin
References: <twig.1084557936.3304@...41...> <200405151135.03079.vda@...216...>
In-Reply-To: <200405151135.03079.vda@...216...>
Content-Type: multipart/mixed;
 boundary="------------040307030209010106010608"
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
Date: Sat May 15 03:29:05 2004
To: Denis Vlasenko <vda@...216...>
Cc: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------040307030209010106010608
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Denis Vlasenko wrote:
> On Friday 14 May 2004 21:05, James Yonan wrote:
> 
>>Right now all new patches are going into 2.0, but I'm certainly amenable to
>>merging localized patches such as the route patch for darwin into 1.x.
>>
>>I will add to the todo list for 1.6.1.
> 
> 
> Hmm. On Unixlike systems it typically easier to
> call sh script to do this kind of config changes.
> This looks like superior solution to me.

both are available.
it's also very simple to do all things in one config file.

patch join (same than 2.0, build ok)

Regards

		Julien

--------------040307030209010106010608
Content-Type: text/plain;
 name="patch-route_c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-route_c"

--- route.c.orig	Sat May 15 11:22:02 2004
+++ route.c	Sat May 15 11:22:18 2004
@@ -634,6 +634,23 @@
   if (r->metric_defined)
     buf_printf (&buf, " -rtt %d", r->metric);
 #endif
+#elif defined(TARGET_DARWIN)
+
+  buf_printf (&buf, ROUTE_PATH " add");
+
+#if 0
+  if (r->metric_defined)
+    buf_printf (&buf, " -rtt %d", r->metric);
+#endif
+
+  buf_printf (&buf, " -net %s %s %s",
+              network,
+              gateway,
+              netmask);
+
+  msg (D_ROUTE, "%s", BSTR (&buf));
+  status = system_check (BSTR (&buf), "ERROR: FreeBSD route add command failed", false);
+
 
   buf_printf (&buf, " -net %s %s -netmask %s",
 	      network,
@@ -723,6 +740,17 @@
   msg (D_ROUTE, "%s", BSTR (&buf));
   system_check (BSTR (&buf), "ERROR: OpenBSD route delete command failed", false);
 
+#elif defined(TARGET_DARWIN)
+
+  buf_printf (&buf, ROUTE_PATH " delete -net %s %s %s",
+              network,
+              gateway,
+              netmask);
+
+  msg (D_ROUTE, "%s", BSTR (&buf));
+  system_check (BSTR (&buf), "ERROR: Darwin route delete command failed", false);
+
+
 #else
   msg (M_FATAL, "Sorry, but I don't know how to do 'route' commands on this operating system.  Try putting your routes in a --route-up script");
 #endif
@@ -859,6 +887,23 @@
   rtm.rtm_version = RTM_VERSION;
   rtm.rtm_seq = ++seq;
   rtm.rtm_addrs = rtm_addrs; 
+
+#elif defined(TARGET_DARWUB)
+
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <netinet/in.h>
+
+/* all of this is taken from <net/route.h> in Darwin */
+#define RTA_DST     0x1
+#define RTA_GATEWAY 0x2
+#define RTA_NETMASK 0x4
+
+#define RTM_GET     0x4
+#define RTM_VERSION 5
+
+#define RTF_UP      0x1
+#define RTF_GATEWAY 0x2
 
   so_dst.sa_family = AF_INET;
   so_dst.sa_len = sizeof(struct sockaddr_in);

--------------040307030209010106010608--

