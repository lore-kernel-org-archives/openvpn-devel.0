From: Gert Doering <gert@...1296...>
Date: Sun, 19 Apr 2026 15:51:11 +0200
Message-ID: <20260419135116.22170-1-gert@...1296...>
In-Reply-To: <gerrit.1775421558000.Iacf06c113e8db5b7c78270f361ee76938ef1db47@...2715...>
References: <gerrit.1775421558000.Iacf06c113e8db5b7c78270f361ee76938ef1db47@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] Remove various redundant conditionals
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

These are all already proven to be true by
surrounding code.

Identified by cppcheck.

Change-Id: Iacf06c113e8db5b7c78270f361ee76938ef1db47
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1613
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1613
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index c22a2a4..2a3023c 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -1625,10 +1625,7 @@
         }
         else
         {
-            if (p[1])
-            {
-                man_state(man, p[1]);
-            }
+            man_state(man, p[1]);
             if (p[2])
             {
                 man_state(man, p[2]);
@@ -2542,7 +2539,7 @@
         {
             buffer_list_advance(man->connection.out, sent);
         }
-        else if (sent < 0)
+        else
         {
             if (man_io_error(man, "send"))
             {
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index fe210ee..06e3758 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -1837,7 +1837,7 @@
     {
         msg(M_INFO, "PUSH: No NCP or OCC cipher data received from peer.");
 
-        if (o->enable_ncp_fallback && !tls_multi->remote_ciphername)
+        if (o->enable_ncp_fallback)
         {
             msg(M_INFO,
                 "Using data channel cipher '%s' since "
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 70af6d2..0c2866c 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -5304,7 +5304,7 @@
         struct dns_server *server =
             dns_server_get(&options->dns_options.servers, priority, &options->dns_options.gc);
 
-        if (streq(p[3], "address") && p[4])
+        if (streq(p[3], "address"))
         {
             for (int i = 4; p[i]; ++i)
             {
diff --git a/src/openvpn/platform.c b/src/openvpn/platform.c
index 3a6b272..9fa9363 100644
--- a/src/openvpn/platform.c
+++ b/src/openvpn/platform.c
@@ -572,7 +572,7 @@
             close(fd);
             return retfname;
         }
-        else if (fd == -1 && errno != EEXIST)
+        else if (errno != EEXIST)
         {
             /* Something else went wrong, no need to retry.  */
             msg(M_WARN | M_ERRNO, "Could not create temporary file '%s'", retfname);
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index d44f25f..99df49c 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -895,7 +895,7 @@
         {
             /* Must have at least three lines. further lines are ignored for
              * forward compatibility */
-            if (!lines->head || !lines->head->next || !lines->head->next->next)
+            if (!lines->head->next || !lines->head->next->next)
             {
                 msg(M_WARN, "auth pending control file is not at least "
                             "three lines long.");
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 4268214..473a8d3 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -486,7 +486,7 @@
     sud->directory = data;
     len = wcslen(sud->directory) + 1;
     size -= len;
-    if (size <= 0)
+    if (size == 0)
     {
         MsgToEventLog(M_ERR, L"Startup data ends at working directory");
         ReturnError(pipe, ERROR_STARTUP_DATA, L"GetStartupData", 1, &exit_event);
@@ -496,7 +496,7 @@
     sud->options = sud->directory + len;
     len = wcslen(sud->options) + 1;
     size -= len;
-    if (size <= 0)
+    if (size == 0)
     {
         MsgToEventLog(M_ERR, L"Startup data ends at command line options");
         ReturnError(pipe, ERROR_STARTUP_DATA, L"GetStartupData", 1, &exit_event);

