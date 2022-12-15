From: selva.nair@...277...
Date: Thu, 15 Dec 2022 18:21:04 -0500
Message-Id: <20221215232104.1181936-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Persist DCO client data channel traffic
 stats on restart
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

Signed-off-by: Selva Nair <selva.nair@...277...>
---
Tested on Windows which is the only platform that currently 
supports stats from DCO in client mode.

 src/openvpn/init.c    | 11 +++++++++++
 src/openvpn/init.h    |  2 ++
 src/openvpn/manage.c  |  9 +++++++++
 src/openvpn/manage.h  |  3 +++
 src/openvpn/openvpn.c |  2 ++
 5 files changed, 27 insertions(+)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 74b38032..e0b42e1e 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -4164,6 +4164,17 @@ uninit_management_callback(void)
 #endif
 }
 
+void
+persist_client_stats(struct context *c)
+{
+#ifdef ENABLE_MANAGEMENT
+    if (management)
+    {
+        man_persist_client_stats(management, c);
+    }
+#endif
+}
+
 /*
  * Initialize a tunnel instance, handle pre and post-init
  * signal settings.
diff --git a/src/openvpn/init.h b/src/openvpn/init.h
index f53b65ee..d0fb6ea1 100644
--- a/src/openvpn/init.h
+++ b/src/openvpn/init.h
@@ -147,4 +147,6 @@ void write_pid_file(const char *filename, const char *chroot_dir);
 
 void remove_pid_file(void);
 
+void persist_client_stats(struct context *c);
+
 #endif /* ifndef INIT_H */
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 9349b62a..82832436 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -4068,6 +4068,15 @@ management_check_bytecount(struct context *c, struct management *man, struct tim
     }
 }
 
+void
+man_persist_client_stats(struct management *man, struct context *c)
+{
+    if (dco_enabled(&c->options) && (dco_get_peer_stats(c) == 0))
+    {
+        management_bytes_client(man, c->c2.dco_read_bytes, c->c2.dco_write_bytes);
+    }
+}
+
 #else  /* ifdef ENABLE_MANAGEMENT */
 
 void
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index 700b15cf..30291e42 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -548,6 +548,9 @@ management_bytes_server(struct management *man,
     }
 }
 
+void
+man_persist_client_stats(struct management *man, struct context *c);
+
 #endif /* ifdef ENABLE_MANAGEMENT */
 
 /**
diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c
index 15e21452..413a750b 100644
--- a/src/openvpn/openvpn.c
+++ b/src/openvpn/openvpn.c
@@ -97,6 +97,8 @@ tunnel_point_to_point(struct context *c)
         perf_pop();
     }
 
+    persist_client_stats(c);
+
     uninit_management_callback();
 
     /* tear down tunnel instance (unless --persist-tun) */
-- 
2.34.1


