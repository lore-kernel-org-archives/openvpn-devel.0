From: David Sommerseth <dazo@...384...>
Date: Thu, 29 Nov 2012 14:16:12 +0100
Message-Id: <1354194972-5388-1-git-send-email-dazo@...384...>
Subject: [Openvpn-devel] [PATCH] The get_default_gateway() function uses
	warn() instead of msg()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

From: David Sommerseth <davids@...1347...>

A report on #openvpn pointed out that in his setup three warnings
appeard on the console when starting up.

    $ sudo /usr/local/etc/rc.d/openvpn restart
    Stopping openvpn.
    Waiting for PIDS: 33031.
    Starting openvpn.
    openvpn: writing to routing socket: No such process
    openvpn: writing to routing socket: No such process
    openvpn: writing to routing socket: No such process
    $

This setup is on FreeBSD using jails with strict access to the
routing table.

After looking at the code path, this error was found in the BSD
sections for get_default_gateway().  But it was using the warn()
call instead of msg(M_WARN|M_ERRNO, ...) which causes these
warnings to go to stderr instead of the log file.

The warning string is also slightly modified to better explain
what fails.

Reported-by: Thomas Steen Rasmussen <thomas@...1782...>
Tested-by: Thomas Steen Rasmussen <thomas@...1782...>
Signed-off-by: David Sommerseth <davids@...1347...>
---
 src/openvpn/route.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 8c3d0dc..dd69d8e 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -2701,7 +2701,7 @@ get_default_gateway (struct route_gateway_info *rgi)
 
   if (write(s, (char *)&m_rtmsg, l) < 0)
     {
-      warn("writing to routing socket");
+      msg(M_WARN|M_ERRNO, "Could not retrieve default gateway from route socket:");
       gc_free (&gc);
       close(s);
       return;
@@ -3067,7 +3067,7 @@ get_default_gateway (struct route_gateway_info *rgi)
 
   if (write(s, (char *)&m_rtmsg, l) < 0)
     {
-      warn("writing to routing socket");
+      msg(M_WARN|M_ERRNO, "Could not retrieve default gateway from route socket:");
       gc_free (&gc);
       close(s);
       return;
-- 
1.7.10.2


