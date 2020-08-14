From: Vladislav Grishenko <themiron@...2010...>
Date: Fri, 14 Aug 2020 22:12:04 +0500
Message-Id: <20200814171204.22289-1-themiron@...2010...>
In-Reply-To: <98f65e22-a66c-aeea-f705-ad5a0f7a2e28@...1227...>
References: <98f65e22-a66c-aeea-f705-ad5a0f7a2e28@...1227...>
Subject: [Openvpn-devel] [PATCH v2] Allow management to kill client
 instances by CN wildcard
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

In case of some permanent part of common name (ex. domain) and/or
long complex common name consisting of multiple x509 fields, it's
handly to kill client instances via management interface with just
prefix of common name, not by exact match only.

Patch allows to use asterisk as wildcard placeholder in the last
trailing symbol of kill command parameter.
Single asterisk - empty prefix would be too greedy and can be too
harmful, therefore not allowed. Wildcards in the middle of
parameter string are not supported to keep the the things simple at the moment.

v2: fine tune comments

Signed-off-by: Vladislav Grishenko <themiron@...2010...>
---
 doc/management-notes.txt |  2 ++
 src/openvpn/multi.c      | 15 ++++++++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/doc/management-notes.txt b/doc/management-notes.txt
index 61daaf07..91073693 100644
--- a/doc/management-notes.txt
+++ b/doc/management-notes.txt
@@ -195,6 +195,8 @@ Command examples:
 
   kill Test-Client -- kill the client instance having a
                       common name of "Test-Client".
+  kill Test-Cli*   -- kill the client instances having a
+                      common name starting with "Test-Cli".
   kill 1.2.3.4:4000 -- kill the client instance having a
                        source address and port of 1.2.3.4:4000
 
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 13738180..36be5de2 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3820,6 +3820,19 @@ management_callback_kill_by_cn(void *arg, const char *del_cn)
     struct hash_element *he;
     int count = 0;
 
+    /* Check passed string for non-empty prefix with trailing asterisk */
+    size_t len = strlen(del_cn);
+    if (len > 1 && del_cn[len - 1] == '*')
+    {
+        /* Exclude trailing asterisk from string comparison */
+        len--;
+    }
+    else
+    {
+        /* Include terminating NUL char to perform exact string comparison */
+        len++;
+    }
+
     hash_iterator_init(m->iter, &hi);
     while ((he = hash_iterator_next(&hi)))
     {
@@ -3827,7 +3840,7 @@ management_callback_kill_by_cn(void *arg, const char *del_cn)
         if (!mi->halt)
         {
             const char *cn = tls_common_name(mi->context.c2.tls_multi, false);
-            if (cn && !strcmp(cn, del_cn))
+            if (cn && !strncmp(cn, del_cn, len))
             {
                 multi_signal_instance(m, mi, SIGTERM);
                 ++count;
-- 
2.17.1


