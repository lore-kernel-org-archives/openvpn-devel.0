References: <1440541753-9172-1-git-send-email-steffan@...1856...>
	<20150904205551.GF34798@...1296...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <561130FC.8090008@...1856...>
Date: Sun, 4 Oct 2015 16:00:28 +0200
MIME-Version: 1.0
In-Reply-To: <20150904205551.GF34798@...1296...>
Content-Type: multipart/mixed; boundary="------------020201040803040301030904"
Subject: Re: [Openvpn-devel] [PATCH] Add missing strdup() return value checks
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------020201040803040301030904
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit


On 04-09-15 22:55, Gert Doering wrote:
>> diff --git a/src/openvpn/cryptoapi.c b/src/openvpn/cryptoapi.c
>> index b7fc11e..62f30be 100644
>> --- a/src/openvpn/cryptoapi.c
>> +++ b/src/openvpn/cryptoapi.c
>> @@ -127,6 +127,7 @@ static char *ms_error_text(DWORD ms_err)
>>   		    break;
>>   	    }
>>       }
>> +    check_malloc_return(rv);
>>       return rv;
>>   }
>
> This is not needed, as the code does
>
>          rv = strdup(lpMsgBuf);
>          LocalFree(lpMsgBuf);
>          /* trim to the left */
>          if (rv)
>              for (p = rv + strlen(rv) - 1; p >= rv; p--) {
>                  if (isspace(*p))
>                      *p = '\0';
>                  else
>                      break;
>              }
>      }
>      return rv;
>
> ... so if the strdup() fails, the function falls into "return NULL",
> which is the same return value as for "if (!lpMsgBuf)", so I assume
> the caller expects this - with the extra check, a failure in
> FormatMessage() would be flagged as memory allocation failure (because
> rv is set to NULL at start), which it isn't.
>
> So, just not needed.

This is what I thought at first too.  But when I tried to verify that 
returning NULL could do no harm, I simply couldn't.  The NULL is passed 
as a 'char *' to openssl, which stores it in some kind of error string 
storage.  I could not trivially see that this can not do harm when 
actual error occur, so I decided to fix that as part of the patch.

>> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
>> index b7c153b..0809cc7 100644
>> --- a/src/openvpn/init.c
>> +++ b/src/openvpn/init.c
>> @@ -817,6 +817,7 @@ init_options_dev (struct options *options)
>>   {
>>     if (!options->dev && options->dev_node) {
>>       char *dev_node = strdup(options->dev_node); /* POSIX basename() implementaions may modify its arguments */
>> +    check_malloc_return(dev_node);
>>       options->dev = basename (dev_node);
>>     }
>>   }
>
> I'd need to look into this in more detail, but I think we never modify
> options->dev_node afterward - so a simple strrchr() to find the "/" and
> point options->dev there might be sufficient... but if it actually needs
> to be a true copy, we should just use
>
>    char *dev_node = string_alloc(options->dev_node, NULL)
>
> instead - string_alloc() is OpenVPN's strdup(), and "NULL" tells it
> "do not use gc, use calloc" (side note: someone seriously overengineered
> the "we really want clean memory!" bit here - allocating <n> bytes and
> immediately overwriting with a n-byte memcpy() should be good enough,
> no?) - *and* string_alloc() actually does...
>
>        if (gc) {
> ...
>        } else {
>          ret = calloc(1, n);
>          check_malloc_return(ret);
>        }
>        memcpy (ret, str, n);
>
> ... so the check_malloc_return() is built-in.

You are absolutely right, I forgot about string_alloc().  I updated the 
patch to use string_alloc() instead.

So, attached two patches.

0001 replaces strdup() calls with string_alloc() to automatically check 
the return values.

0002 adds a return value check for the result of ms_error_text()

I ran our test suite on linux and did some smoke tests on Windows, but 
since this is cornercase-code, it is hard to really test.

-Steffan

--------------020201040803040301030904
Content-Type: text/x-patch;
	name="0002-Check-return-value-of-ms_error_text.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="0002-Check-return-value-of-ms_error_text.patch"

From b748ddef2a779a7fa6999cb4c7bba3acf2c38f6f Mon Sep 17 00:00:00 2001
From: Steffan Karger <steffan@...1856...>
Date: Mon, 21 Sep 2015 22:04:19 +0200
Subject: [PATCH 2/2] Check return value of ms_error_text()

ms_error_text() may return NULL, and it is unclear (or, at least
undocumented) whether the OpenSSL ERR code (and our code using the ERR
code) can deal with esd->string being NULL.  So, just to be sure, check
that ms_error_text() succeeded before passing the result to
ERR_load_strings().

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/cryptoapi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/openvpn/cryptoapi.c b/src/openvpn/cryptoapi.c
index 1d54ee7..853c07b 100644
--- a/src/openvpn/cryptoapi.c
+++ b/src/openvpn/cryptoapi.c
@@ -164,6 +164,7 @@ static void err_put_ms_error(DWORD ms_err, int func, const char *file, int line)
 	    err_map[i].ms_err = ms_err;
 	    err_map[i].err = esd->error = i + 100;
 	    esd->string = ms_error_text(ms_err);
+	    check_malloc_return(esd->string);
 	    ERR_load_strings(ERR_LIB_CRYPTOAPI, esd);
 	    ERR_PUT_error(ERR_LIB_CRYPTOAPI, func, err_map[i].err, file, line);
 	    break;
-- 
2.1.4


--------------020201040803040301030904
Content-Type: text/x-patch;
	name="0001-Replace-strdup-calls-for-string_alloc-calls.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0001-Replace-strdup-calls-for-string_alloc-calls.patch"

From 00a71fa221f2265ad525d1b490a8fbfd009c9f23 Mon Sep 17 00:00:00 2001
From: Steffan Karger <steffan@...1856...>
Date: Mon, 21 Sep 2015 20:48:33 +0200
Subject: [PATCH 1/2] Replace strdup() calls for string_alloc() calls

As reported by Bill Parker in trac #600, strdup() return values are not
always correctly checked for failed allocations.  This patch adds missing
checks by using string_alloc(), which performs the required checks.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/buffer.h       | 2 +-
 src/openvpn/cryptoapi.c    | 4 +++-
 src/openvpn/init.c         | 2 +-
 src/openvpn/misc.c         | 2 +-
 src/openvpn/options.c      | 2 +-
 src/openvpn/ssl_polarssl.c | 2 +-
 6 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index 0dc511b..24f52aa 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -898,7 +898,7 @@ gc_reset (struct gc_arena *a)
 }
 
 static inline void
-check_malloc_return (void *p)
+check_malloc_return (const void *p)
 {
   if (!p)
     out_of_memory ();
diff --git a/src/openvpn/cryptoapi.c b/src/openvpn/cryptoapi.c
index b7fc11e..1d54ee7 100644
--- a/src/openvpn/cryptoapi.c
+++ b/src/openvpn/cryptoapi.c
@@ -46,6 +46,8 @@
 #include <ctype.h>
 #include <assert.h>
 
+#include "buffer.h"
+
 /* MinGW w32api 3.17 is still incomplete when it comes to CryptoAPI while
  * MinGW32-w64 defines all macros used. This is a hack around that problem.
  */
@@ -116,7 +118,7 @@ static char *ms_error_text(DWORD ms_err)
 	(LPTSTR) &lpMsgBuf, 0, NULL);
     if (lpMsgBuf) {
 	char *p;
-	rv = strdup(lpMsgBuf);
+	rv = string_alloc(lpMsgBuf, NULL);
 	LocalFree(lpMsgBuf);
 	/* trim to the left */
 	if (rv)
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index f568d87..3decd23 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -822,7 +822,7 @@ void
 init_options_dev (struct options *options)
 {
   if (!options->dev && options->dev_node) {
-    char *dev_node = strdup(options->dev_node); /* POSIX basename() implementaions may modify its arguments */
+    char *dev_node = string_alloc(options->dev_node, NULL); /* POSIX basename() implementaions may modify its arguments */
     options->dev = basename (dev_node);
   }
 }
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 895e9fa..fd1930a 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -1615,7 +1615,7 @@ argv_extract_cmd_name (const char *path)
 {
   if (path)
     {
-      char *path_cp = strdup(path); /* POSIX basename() implementaions may modify its arguments */
+      char *path_cp = string_alloc(path, NULL); /* POSIX basename() implementaions may modify its arguments */
       const char *bn = basename (path_cp);
       if (bn)
 	{
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 5ace1f3..de4fa38 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2578,7 +2578,7 @@ check_file_access(const int type, const char *file, const int mode, const char *
   /* Is the directory path leading to the given file accessible? */
   if (type & CHKACC_DIRPATH)
     {
-      char *fullpath = strdup(file);  /* POSIX dirname() implementaion may modify its arguments */
+      char *fullpath = string_alloc (file, NULL);  /* POSIX dirname() implementaion may modify its arguments */
       char *dirpath = dirname(fullpath);
 
       if (platform_access (dirpath, mode|X_OK) != 0)
diff --git a/src/openvpn/ssl_polarssl.c b/src/openvpn/ssl_polarssl.c
index dd0fab0..11c9ffb 100644
--- a/src/openvpn/ssl_polarssl.c
+++ b/src/openvpn/ssl_polarssl.c
@@ -197,7 +197,7 @@ tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, const char *ciphers)
 
   /* Parse allowed ciphers, getting IDs */
   i = 0;
-  tmp_ciphers_orig = tmp_ciphers = strdup(ciphers);
+  tmp_ciphers_orig = tmp_ciphers = string_alloc (ciphers, NULL);
 
   token = strtok (tmp_ciphers, ":");
   while(token)
-- 
2.1.4


--------------020201040803040301030904--

