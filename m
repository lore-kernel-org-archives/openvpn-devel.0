From: Vladislav Grishenko <themiron@...2010...>
Date: Fri,  4 Dec 2020 20:55:16 +0500
Message-Id: <20201204155516.10267-1-themiron@...2010...>
In-Reply-To: <20201204140135.GX976@...1296...>
References: <20201204140135.GX976@...1296...>
Subject: [Openvpn-devel] [PATCH] Drop EAI_NODATA,
 absent on FreeBSD and obsoleted by RFC3493
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
Cc: gert@...1296...

---
 src/openvpn/socket.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index bd085e8f..31e8fe9a 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -625,10 +625,8 @@ query_servinfo(const char *domain, int proto,
             break;
 
         case DNS_ERROR_RCODE_NAME_ERROR:
-            return EAI_NONAME; /* HOST_NOT_FOUND */
-
         case DNS_INFO_NO_RECORDS:
-            return EAI_NODATA; /* NO_DATA */
+            return EAI_NONAME; /* HOST_NOT_FOUND */
 
         case DNS_ERROR_NO_DNS_SERVERS:
         case DNS_ERROR_RCODE_FORMAT_ERROR:
@@ -642,7 +640,7 @@ query_servinfo(const char *domain, int proto,
             return EAI_AGAIN; /* TRY_AGAIN */
 
         default:
-            return EAI_NODATA;
+            return EAI_FAIL;
     }
 
     struct servinfo *list = NULL, *first = NULL;
@@ -682,7 +680,7 @@ query_servinfo(const char *domain, int proto,
     }
     else
     {
-        status = EAI_NODATA;
+        status = EAI_FAIL;
     }
 
 done:
@@ -717,13 +715,11 @@ query_servinfo(const char *domain, int proto,
         switch (h_errno)
         {
             case HOST_NOT_FOUND:
-                return EAI_NONAME;
-
             case NO_ADDRESS:
 #if NO_ADDRESS != NO_DATA
             case NO_DATA:
 #endif
-                return EAI_NODATA;
+                return EAI_NONAME;
 
             case NO_RECOVERY:
                 return EAI_FAIL;
@@ -782,7 +778,7 @@ query_servinfo(const char *domain, int proto,
     }
     else
     {
-        status = EAI_NODATA;
+        status = EAI_FAIL;
     }
 
 done:
-- 
2.17.1


