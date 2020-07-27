From: Vladislav Grishenko <themiron@...2010...>
Date: Tue, 28 Jul 2020 03:13:41 +0500
Message-Id: <20200727221341.22544-2-themiron@...2010...>
Subject: [Openvpn-devel] [PATCH 2/2] Allow killing of client instances by cn
 with wildcards
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
part of common name, not by exact match only.

Patch allows to use wildcard placeholder '*' as the last trailing
symbol of kill command parameter.
Single '*' wildcard would be too greedy and can be too harmful,
therefore not allowed. Wildcards in the middle of parameter string
are not supported to keep the the things simple at the moment.

Signed-off-by: Vladislav Grishenko <themiron@...2010...>
---
 doc/management-notes.txt | 2 ++
 src/openvpn/multi.c      | 6 +++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

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
index 9bda38b0..8952658a 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3772,6 +3772,10 @@ management_callback_kill_by_cn(void *arg, const char *del_cn)
     struct hash_element *he;
     int count = 0;
 
+    /* Allow trailing wildcard */
+    int len = strlen(del_cn);
+    len += (len > 1 && del_cn[len-1] == '*') ? -1 : 1;
+
     hash_iterator_init(m->iter, &hi);
     while ((he = hash_iterator_next(&hi)))
     {
@@ -3779,7 +3783,7 @@ management_callback_kill_by_cn(void *arg, const char *del_cn)
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


