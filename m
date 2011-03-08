Date: Tue, 8 Mar 2011 18:52:52 -0300
From: Federico Heinz <fheinz@...277...>
Message-ID: <20110308185252.301d0a1d@...1451...>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/WbqNldqcBY==9nWvN3Hi/d5"
Subject: [Openvpn-devel] [PATCH] Bind only to specified interface
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--MP_/WbqNldqcBY==9nWvN3Hi/d5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Author: Federico Heinz <fheinz@...277...>

Accept "local if:<ifname>" option.

The current 'local' configuration directive allows for two types of
values: IP addresses and DNS hostnames. This is not enough for users
of dynamic DNS services who must restart OpenVPN when their IP
address changes, because their new IP address may not have progagated
yet through DNS when OpenVPN starts, and so they may end up binding
to a bogus address.

This patch introduces a parameter notation that helps solve the
problem: if the option parameter is of the form "if:<ifname>", it
will determine the IP address of the interface and use that as the IP
address to bind to.

The patch is small, and meant to be mininally intrusive: instead of
adding a new option and/or new code paths to handle the new case, it
simply replaces the value supplied by the user by a string
representing the IP address, as if the user had entered it.

I'm not entirely sure I'm using gc_malloc() correctly, and I'd
appreciate feedback on that.

Signed-off-by: Federico Heinz <fheinz@...277...>

--MP_/WbqNldqcBY==9nWvN3Hi/d5
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=bind-to-interface.patch

diff -r 66ad68054f67 openvpn.8
--- a/openvpn.8	Tue Mar 01 10:21:42 2011 +0100
+++ b/openvpn.8	Tue Mar 08 18:36:39 2011 -0300
@@ -197,6 +197,12 @@
 .B \-\-local host
 Local host name or IP address for bind.
 If specified, OpenVPN will bind to this address only.
+If
+.B local
+is of the form
+.B if:ifname,
+OpenVPN will bind only to the IP address of the interface called
+.B ifname.
 If unspecified, OpenVPN will bind to all interfaces.
 .\"*********************************************************
 .TP
diff -r 66ad68054f67 options.c
--- a/options.c	Tue Mar 01 10:21:42 2011 +0100
+++ b/options.c	Tue Mar 08 18:36:39 2011 -0300
@@ -51,6 +51,9 @@
 #include "forward.h"
 #include "configure.h"
 #include <ctype.h>
+#include <sys/socket.h>
+#include <netinet/in.h>
+#include <arpa/inet.h>
 
 #include "memdbg.h"
 
@@ -101,6 +104,7 @@
   "\n"
   "Tunnel Options:\n"
   "--local host    : Local host name or ip address. Implies --bind.\n"
+  "                  Use \"if:<ifname>\" for IP address of interface <ifname>."
   "--remote host [port] : Remote host name or ip address.\n"
   "--remote-random : If multiple --remote options specified, choose one randomly.\n"
   "--remote-random-hostname : Add a random string to remote DNS name.\n"
@@ -4017,8 +4021,32 @@
     }
   else if (streq (p[0], "local") && p[1])
     {
+      static const char if_prefix[] = "if:";
       VERIFY_PERMISSION (OPT_P_GENERAL|OPT_P_CONNECTION);
-      options->ce.local = p[1];
+      options->ce.local = NULL;
+      if (strneq(if_prefix, p[1], sizeof(if_prefix)-1))
+	{
+	  int fd;
+	  struct ifreq ifr;
+
+	  ifr.ifr_addr.sa_family = AF_INET;
+	  strncpy(ifr.ifr_name, &(p[1][sizeof(if_prefix)-1]), IFNAMSIZ-1);
+	  if ((fd = socket(AF_INET, SOCK_DGRAM, 0))>= 0)
+	    {
+	      if (ioctl(fd, SIOCGIFADDR, &ifr) >= 0)
+		{
+		  const char *addr = inet_ntoa(((struct sockaddr_in *)&ifr.ifr_addr)->sin_addr);
+		  char *value = gc_malloc(strlen(addr)+1, true, &options->gc);
+		  strcpy(value, addr);
+		  options->ce.local = value;
+		}
+	      close(fd);
+	    }
+	}
+      if (options->ce.local == NULL)
+	{
+	  options->ce.local = p[1];
+	}
     }
   else if (streq (p[0], "remote-random"))
     {
diff -r 66ad68054f67 options.h
--- a/options.h	Tue Mar 01 10:21:42 2011 +0100
+++ b/options.h	Tue Mar 08 18:36:39 2011 -0300
@@ -563,6 +563,7 @@
 };
 
 #define streq(x, y) (!strcmp((x), (y)))
+#define strneq(x, y, n) (!strncmp((x), (y), (n)))
 
 /*
  * Option classes.

--MP_/WbqNldqcBY==9nWvN3Hi/d5--

