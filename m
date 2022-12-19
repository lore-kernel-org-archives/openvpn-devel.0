From: selva.nair@...277...
Date: Mon, 19 Dec 2022 10:04:35 -0500
Message-Id: <20221219150435.1222451-1-selva.nair@...277...>
In-Reply-To: <20221218195810.1216368-1-selva.nair@...277...>
References: <20221218195810.1216368-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Reduce default restart pause to 1 second
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

v2 changes:
- fix incomplete man page edit as pointed out by Arne Schwabe
- fix man page (rst) changes as suggested by Frank Lichtenheld

Signed-off-by: Selva Nair <selva.nair@...277...>
---
I've changed the rst edits following how other similar options
are described -- though I do not like referring to 'arg' as 'n'
first and then "explaining" it in valid-syntaxes...
Will be happy to revise if there is a better way.

reST is not for me: feels like I'm forced to write a paper
in Word instead of LaTeX.

 doc/man-sections/client-options.rst | 17 ++++++++++++-----
 src/openvpn/options.c               |  2 +-
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/doc/man-sections/client-options.rst b/doc/man-sections/client-options.rst
index 07651479..974cc992 100644
--- a/doc/man-sections/client-options.rst
+++ b/doc/man-sections/client-options.rst
@@ -138,12 +138,19 @@ configuration.
   Set ``--verb 6`` for debugging info showing the transformation of
   src/dest addresses in packets.
 
---connect-retry n
-  Wait ``n`` seconds between connection attempts (default :code:`5`).
+--connect-retry args
+  Wait ``n`` seconds between connection attempts (default :code:`1`).
   Repeated reconnection attempts are slowed down after 5 retries per
-  remote by doubling the wait time after each unsuccessful attempt. An
-  optional argument ``max`` specifies the maximum value of wait time in
-  seconds at which it gets capped (default :code:`300`).
+  remote by doubling the wait time after each unsuccessful attempt.
+
+  Valid syntaxes:
+  ::
+
+     connect retry n
+     connect retry n max
+
+  If the optional argument ``max`` is specified, the maximum wait time in
+  seconds gets capped at that value (default :code:`300`).
 
 --connect-retry-max n
   ``n`` specifies the number of times each ``--remote`` or
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


