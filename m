From: Steffan Karger <steffan@...1856...>
Date: Wed, 26 Aug 2015 00:29:13 +0200
Message-Id: <1440541753-9172-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Add missing strdup() return value checks
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

As reported by Bill Parker in trac #600, strdup() return values are not
always correctly checked for failed allocations.  This patch adds missing
checks.

Note that in misc.c and options.c, the check is after the dirname() or
basename() call, because these can deal with NULL params and we need to
keep MSVC happy with its ancient no-declaration-after-statement policy.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/cryptoapi.c    | 1 +
 src/openvpn/init.c         | 1 +
 src/openvpn/misc.c         | 1 +
 src/openvpn/options.c      | 1 +
 src/openvpn/ssl_polarssl.c | 1 +
 5 files changed, 5 insertions(+)

diff --git a/src/openvpn/cryptoapi.c b/src/openvpn/cryptoapi.c
index b7fc11e..62f30be 100644
--- a/src/openvpn/cryptoapi.c
+++ b/src/openvpn/cryptoapi.c
@@ -127,6 +127,7 @@ static char *ms_error_text(DWORD ms_err)
 		    break;
 	    }
     }
+    check_malloc_return(rv);
     return rv;
 }
 
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index b7c153b..0809cc7 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -817,6 +817,7 @@ init_options_dev (struct options *options)
 {
   if (!options->dev && options->dev_node) {
     char *dev_node = strdup(options->dev_node); /* POSIX basename() implementaions may modify its arguments */
+    check_malloc_return(dev_node);
     options->dev = basename (dev_node);
   }
 }
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index a5bad0d..b543b65 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -1608,6 +1608,7 @@ argv_extract_cmd_name (const char *path)
     {
       char *path_cp = strdup(path); /* POSIX basename() implementaions may modify its arguments */
       const char *bn = basename (path_cp);
+      check_malloc_return(path_cp);
       if (bn)
 	{
 	  char *ret = string_alloc (bn, NULL);
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 2784580..dba7c9d 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2588,6 +2588,7 @@ check_file_access(const int type, const char *file, const int mode, const char *
     {
       char *fullpath = strdup(file);  /* POSIX dirname() implementaion may modify its arguments */
       char *dirpath = dirname(fullpath);
+      check_malloc_return(fullpath);
 
       if (platform_access (dirpath, mode|X_OK) != 0)
           errcode = errno;
diff --git a/src/openvpn/ssl_polarssl.c b/src/openvpn/ssl_polarssl.c
index 3fc811e..673dbbe 100644
--- a/src/openvpn/ssl_polarssl.c
+++ b/src/openvpn/ssl_polarssl.c
@@ -198,6 +198,7 @@ tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, const char *ciphers)
   /* Parse allowed ciphers, getting IDs */
   i = 0;
   tmp_ciphers_orig = tmp_ciphers = strdup(ciphers);
+  check_malloc_return(tmp_ciphers);
 
   token = strtok (tmp_ciphers, ":");
   while(token)
-- 
2.1.4


