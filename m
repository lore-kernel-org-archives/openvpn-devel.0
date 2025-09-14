From: Gert Doering <gert@...1296...>
Date: Sun, 14 Sep 2025 15:47:08 +0200
Message-ID: <20250914134713.19315-1-gert@...1296...>
In-Reply-To: <gerrit.1756814708000.I0f2fff8358d4645c4ace504c65ae8559a68794cc@...2715...>
References: <gerrit.1756814708000.I0f2fff8358d4645c4ace504c65ae8559a68794cc@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] ps: Clean up conversion warnings in
 journal_add function
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

From: Frank Lichtenheld <frank@...2641...>

Since these are only local variables, these are trivial
changes.

Change-Id: I0f2fff8358d4645c4ace504c65ae8559a68794cc
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1163
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/ps.c b/src/openvpn/ps.c
index eae03e3..e95a33b 100644
--- a/src/openvpn/ps.c
+++ b/src/openvpn/ps.c
@@ -334,26 +334,22 @@
 static void
 journal_add(const char *journal_dir, struct proxy_connection *pc, struct proxy_connection *cp)
 {
-    struct gc_arena gc = gc_new();
     struct openvpn_sockaddr from, to;
-    socklen_t slen, dlen;
-    int fnlen;
-    char *jfn;
-    int fd;
 
-    slen = sizeof(from.addr);
-    dlen = sizeof(to.addr);
+    socklen_t slen = sizeof(from.addr);
+    socklen_t dlen = sizeof(to.addr);
     if (!getpeername(pc->sd, (struct sockaddr *)&from.addr.sa, &slen)
         && !getsockname(cp->sd, (struct sockaddr *)&to.addr.sa, &dlen))
     {
+        struct gc_arena gc = gc_new();
         const char *f = print_openvpn_sockaddr(&from, &gc);
         const char *t = print_openvpn_sockaddr(&to, &gc);
-        fnlen = strlen(journal_dir) + strlen(t) + 2;
-        jfn = (char *)malloc(fnlen);
+        size_t fnlen = strlen(journal_dir) + strlen(t) + 2;
+        char *jfn = (char *)malloc(fnlen);
         check_malloc_return(jfn);
         snprintf(jfn, fnlen, "%s/%s", journal_dir, t);
         dmsg(D_PS_PROXY_DEBUG, "PORT SHARE PROXY: client origin %s -> %s", jfn, f);
-        fd = platform_open(jfn, O_CREAT | O_TRUNC | O_WRONLY, S_IRUSR | S_IWUSR | S_IRGRP);
+        int fd = platform_open(jfn, O_CREAT | O_TRUNC | O_WRONLY, S_IRUSR | S_IWUSR | S_IRGRP);
         if (fd != -1)
         {
             if (write(fd, f, strlen(f)) != strlen(f))
@@ -368,8 +364,8 @@
             msg(M_WARN | M_ERRNO, "PORT SHARE: unable to write journal file in %s", jfn);
             free(jfn);
         }
+        gc_free(&gc);
     }
-    gc_free(&gc);
 }
 
 /*

