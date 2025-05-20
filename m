From: Gert Doering <gert@...1296...>
Date: Tue, 20 May 2025 09:33:48 +0200
Message-ID: <20250520073354.17091-1-gert@...1296...>
In-Reply-To: <gerrit.1747646372000.I275bf939f43577427e14890e7093d63c5213ae5d@...2715...>
References: <gerrit.1747646372000.I275bf939f43577427e14890e7093d63c5213ae5d@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] dns: fix potential NULL pointer
 dereference
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

From: Heiko Hund <heiko@...2662...>

Fix issue reported by Coverity (CID 1646952): Dereferencing a pointer
that might be NULL dvf when calling env_set_write_file.

In addition to the fix, inline the write_dns_vars_file() helper function.
Also output a log line in case this error happens, because when it
happens it will hinder communication with the updown runner process, i.e.
setting up / tearing down DNS things will not work as expected.

Change-Id: I275bf939f43577427e14890e7093d63c5213ae5d
Signed-off-by: Heiko Hund <heiko@...2662...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1026
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c
index 9927961..3c703cc 100644
--- a/src/openvpn/dns.c
+++ b/src/openvpn/dns.c
@@ -688,18 +688,6 @@
     return true;
 }
 
-static const char *
-write_dns_vars_file(bool up, const struct options *o, const struct tuntap *tt, struct gc_arena *gc)
-{
-    struct env_set *es = env_set_create(gc);
-    const char *dvf = platform_create_temp_file(o->tmp_dir, "dvf", gc);
-
-    updown_env_set(up, &o->dns_options, tt, es);
-    env_set_write_file(dvf, es);
-
-    return dvf;
-}
-
 static void
 run_up_down_command(bool up, struct options *o, const struct tuntap *tt, struct dns_updown_runner_info *updown_runner)
 {
@@ -709,7 +697,7 @@
         return;
     }
 
-    int status;
+    int status = -1;
 
     if (!updown_runner->required)
     {
@@ -728,11 +716,19 @@
         }
 
         struct gc_arena gc = gc_new();
-        int rfd = updown_runner->fds[0];
-        int wfd = updown_runner->fds[1];
-        const char *dvf = write_dns_vars_file(up, o, tt, &gc);
-        size_t dvf_size = strlen(dvf) + 1;
+        const char *dvf = platform_create_temp_file(o->tmp_dir, "dvf", &gc);
+        if (!dvf)
+        {
+            msg(M_ERR, "could not create dns vars file");
+            goto out_free;
+        }
 
+        struct env_set *es = env_set_create(&gc);
+        updown_env_set(up, &o->dns_options, tt, es);
+        env_set_write_file(dvf, es);
+
+        int wfd = updown_runner->fds[1];
+        size_t dvf_size = strlen(dvf) + 1;
         while (1)
         {
             ssize_t len = write(wfd, dvf, dvf_size);
@@ -747,6 +743,7 @@
             break;
         }
 
+        int rfd = updown_runner->fds[0];
         while (1)
         {
             ssize_t len = read(rfd, &status, sizeof(status));
@@ -761,6 +758,7 @@
             break;
         }
 
+out_free:
         gc_free(&gc);
     }
 

