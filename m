From: David Sommerseth <openvpn@...2080...>
Date: Wed, 11 Nov 2015 14:01:39 +0100
Message-Id: <1447246899-22769-1-git-send-email-openvpn@...2080...>
Subject: [Openvpn-devel] [PATCH] Avoid partial authentication state when
	using --disabled in CCD configs
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

If an openvpn server is configured with --client-config-dir and a client
configuration file contains 'disabled', it is supposed to tell the client
it is not authorized to use the service.

This patch will ensure that the internal state in this scenario is a
complete CAS_FAILED state, and not CAS_PARTIAL if other authorization
steps passed.

Trac: #521
Tested-by: Eric Crist <ecrist@...1286...>
Signed-off-by: David Sommerseth <davids@...1347...>
---
 src/openvpn/multi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 7c3aaac..e999450 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -1858,6 +1858,7 @@ multi_connection_established (struct multi_context *m, struct multi_instance *mi
 	{
 	  msg (D_MULTI_ERRORS, "MULTI: client has been rejected due to 'disable' directive");
 	  cc_succeeded = false;
+	  cc_succeeded_count = 0;
 	}
 
       if (cc_succeeded)
-- 
1.8.3.1


