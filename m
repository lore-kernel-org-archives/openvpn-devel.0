From: Vladislav Grishenko <themiron@...2010...>
Date: Thu,  3 Sep 2020 16:44:55 +0500
Message-Id: <20200903114455.29341-1-themiron@...2010...>
Subject: [Openvpn-devel] [PATCH] Fix --remote protocol can't be set without
 port argument
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

According client-options.rst additional argumets ``port`` and ``proto``
are both optional and it's allowed to have port absent and protocol set:
    --remote args
      Examples:
         remote server.example.net tcp

But when protocol is set without preceeding port argument, it is being
misparsed as a port with subsequent error:
    RESOLVE: Cannot resolve host address: server.example.net:tcp
    (Servname not supported for ai_socktype)

Since protocol names are predefined and don't match service names, fix
this behavior by checking second argument for valid protocol first.

Signed-off-by: Vladislav Grishenko <themiron@...2010...>
---
 src/openvpn/options.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 8bf82c57..02ac08d8 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -5682,16 +5682,26 @@ add_option(struct options *options,
         re.remote = p[1];
         if (p[2])
         {
-            re.remote_port = p[2];
-            if (p[3])
+            /* Since port is optional, second parameter can be a protocol */
+            int proto = ascii2proto(p[2]);
+            sa_family_t af = ascii2af(p[2]);
+            if (proto < 0)
             {
-                const int proto = ascii2proto(p[3]);
-                const sa_family_t af = ascii2af(p[3]);
-                if (proto < 0)
+                /* Second is not proto, port then. Protocol should be third */
+                re.remote_port = p[2];
+                if (p[3])
                 {
-                    msg(msglevel, "remote: bad protocol associated with host %s: '%s'", p[1], p[3]);
-                    goto err;
+                    proto = ascii2proto(p[3]);
+                    af = ascii2af(p[3]);
+                    if (proto < 0)
+                    {
+                        msg(msglevel, "remote: bad protocol associated with host %s: '%s'", p[1], p[3]);
+                        goto err;
+                    }
                 }
+            }
+            if (proto >= 0)
+            {
                 re.proto = proto;
                 re.af = af;
             }
-- 
2.17.1


