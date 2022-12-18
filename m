From: selva.nair@...277...
Date: Sun, 18 Dec 2022 14:58:10 -0500
Message-Id: <20221218195810.1216368-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Reduce default restart pause to 1 second
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

From: Selva Nair <selva.nair@...277...>

Current value of restart pause is 5 seconds which feels
unduly long. Reduce it to 1 second.

User can still customize the delay using the first parameter for
"--connect-retry".

Also improve the description of "--connect-retry" in the
man page.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
Whle reviewing commit 5d429efd9720109b9c9f1265f5d351a75a401942
Arne had suggested this, but I failed to follow up:

Quoting from Message ID 11772d2a-4877-0ed0-2484-7ef66e059737@...1227...
<quote arne@...1227... on 03-07-2016>
Btw. if we introduce this backoff mechansim I think it is safe to lower
the connect-retry small time from 5 to 1 since the potential for looping
very fast through the connection entries is not there anymore.
</quote>

 doc/man-sections/client-options.rst | 2 +-
 src/openvpn/options.c               | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/man-sections/client-options.rst b/doc/man-sections/client-options.rst
index 07651479..37d24044 100644
--- a/doc/man-sections/client-options.rst
+++ b/doc/man-sections/client-options.rst
@@ -138,7 +138,7 @@ configuration.
   Set ``--verb 6`` for debugging info showing the transformation of
   src/dest addresses in packets.
 
---connect-retry n
+--connect-retry n [max]
   Wait ``n`` seconds between connection attempts (default :code:`5`).
   Repeated reconnection attempts are slowed down after 5 retries per
   remote by doubling the wait time after each unsuccessful attempt. An
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 4383c953..4442697f 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -815,7 +815,7 @@ init_options(struct options *o, const bool init_gc)
     o->ce.proto = PROTO_UDP;
     o->ce.af = AF_UNSPEC;
     o->ce.bind_ipv6_only = false;
-    o->ce.connect_retry_seconds = 5;
+    o->ce.connect_retry_seconds = 1;
     o->ce.connect_retry_seconds_max = 300;
     o->ce.connect_timeout = 120;
     o->connect_retry_max = 0;
-- 
2.34.1


