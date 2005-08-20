From: Matthias Andree <ma+ovpnd@...31...>
Message-ID: <20050820132104.GA18492@...33...>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline
Subject: [Openvpn-devel] [PATCH] plug fd leak (patch by Jaroslav Klaus)
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
Date: Sat Aug 20 06:22:02 2005
To: openvpn-devel@lists.sourceforge.net

--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Greetings,

the attached patch was submitted to me in my role as FreeBSD
port maintainer by Jaroslav Klaus a while ago, and it hasn't
made openvpn 2.0.1. My fault for not sending this on earlier,
I simply forgot and figured, when doing the 2.0.1 port, that
Jaroslav's patch still applied to the code.

Jaroslav writes:

  "The current version of OpenVPN in ports tree - 2.0 - has a bug
  in route.c in FreeBSD, Darwin, OpenBSD and NetBSD version of
  get_default_gateway.  Allocated socket for route manipulation is
  never freed so number of mbufs continuously growing and exhaust
  system resources after a while..  Patch is attached."

Please consider Jaroslav's patch for inclusion.

-- 
Matthias Andree

--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="patch-route.c"

--- route.c.orig	Mon Apr 11 05:43:56 2005
+++ route.c	Mon May 16 21:13:41 2005
@@ -1380,6 +1380,7 @@
     {
       warn("writing to routing socket");
       gc_free (&gc);
+      close(s);
       return false;
     }
 
@@ -1387,6 +1388,7 @@
     l = read(s, (char *)&m_rtmsg, sizeof(m_rtmsg));
   } while (l > 0 && (rtm.rtm_seq != seq || rtm.rtm_pid != pid));
                         
+  close(s);
 
   rtm_aux = &rtm;
 
@@ -1535,6 +1537,7 @@
     {
       msg (M_WARN, "ROUTE: problem writing to routing socket");
       gc_free (&gc);
+      close(s);
       return false;
     }
 
@@ -1542,6 +1545,7 @@
     l = read(s, (char *)&m_rtmsg, sizeof(m_rtmsg));
   } while (l > 0 && (rtm.rtm_seq != seq || rtm.rtm_pid != pid));
                         
+  close(s);
 
   rtm_aux = &rtm;
 
@@ -1690,6 +1694,7 @@
     {
       warn("writing to routing socket");
       gc_free (&gc);
+      close(s);
       return false;
     }
 
@@ -1697,6 +1702,7 @@
     l = read(s, (char *)&m_rtmsg, sizeof(m_rtmsg));
   } while (l > 0 && (rtm.rtm_seq != seq || rtm.rtm_pid != pid));
                         
+  close(s);
 
   rtm_aux = &rtm;
 

--d6Gm4EdcadzBjdND--

