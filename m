Message-ID: <544EAFFE.80004@...1856...>
Date: Mon, 27 Oct 2014 21:50:06 +0100
From: Steffan Karger <steffan@...1856...>
MIME-Version: 1.0
References: <1414269324-14102-1-git-send-email-steffan@...1856...>
	<1414269324-14102-2-git-send-email-steffan@...1856...>
In-Reply-To: <1414269324-14102-2-git-send-email-steffan@...1856...>
Content-Type: multipart/mixed; boundary="------------090706060506020707030809"
Subject: Re: [Openvpn-devel] [PATCH 1/6] polarssl: add polar_log_err() and
 polar_ok(), to easily log PolarSSL errors
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------090706060506020707030809
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit

Attached a v2 of this patch. The only difference is that it adds a
missing #include <polarssl/error.h>.

On 25-10-14 22:35, Steffan Karger wrote:
> Signed-off-by: Steffan Karger <steffan@...1856...>
> ---
>  src/openvpn/crypto_polarssl.c | 26 ++++++++++++++++++++++++++
>  src/openvpn/crypto_polarssl.h | 40 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 66 insertions(+)
> 
> diff --git a/src/openvpn/crypto_polarssl.c b/src/openvpn/crypto_polarssl.c
> index 1a986db..ce1abd6 100644
> --- a/src/openvpn/crypto_polarssl.c
> +++ b/src/openvpn/crypto_polarssl.c
> @@ -86,6 +86,32 @@ crypto_clear_error (void)
>  {
>  }
>  
> +bool polar_log_err(unsigned int flags, int errval, const char *prefix)
> +{
> +  if (0 != errval)
> +    {
> +      char errstr[256];
> +      polarssl_strerror(errval, errstr, sizeof(errstr));
> +
> +      if (NULL == prefix) prefix = "PolarSSL error";
> +      msg (flags, "%s: %s", prefix, errstr);
> +    }
> +
> +  return 0 == errval;
> +}
> +
> +bool polar_log_func_line(unsigned int flags, int errval, const char *func,
> +    int line)
> +{
> +  char prefix[256];
> +
> +  if (!openvpn_snprintf(prefix, sizeof(prefix), "%s:%d", func, line))
> +    return polar_log_err(flags, errval, func);
> +
> +  return polar_log_err(flags, errval, prefix);
> +}
> +
> +
>  #ifdef DMALLOC
>  void
>  crypto_init_dmalloc (void)
> diff --git a/src/openvpn/crypto_polarssl.h b/src/openvpn/crypto_polarssl.h
> index b6da436..b7ce682 100644
> --- a/src/openvpn/crypto_polarssl.h
> +++ b/src/openvpn/crypto_polarssl.h
> @@ -91,4 +91,44 @@ ctr_drbg_context * rand_ctx_get();
>  void rand_ctx_enable_prediction_resistance();
>  #endif
>  
> +/**
> + * Log the supplied PolarSSL error, then print the supplied error message.
> + *
> + * @param flags		Flags to indicate error type and priority.
> + * @param errval	PolarSSL error code to convert to error message.
> + * @param prefix	Prefix to PolarSSL error message.
> + *
> + * @returns true if no errors are detected, false otherwise.
> + */
> +bool polar_log_err(unsigned int flags, int errval, const char *prefix);
> +
> +/**
> + * Log the supplied PolarSSL error, then print the supplied error message.
> + *
> + * @param flags		Flags to indicate error type and priority.
> + * @param errval	PolarSSL error code to convert to error message.
> + * @param func		Function name where error was reported.
> + * @param line		Line number where error was reported.
> + *
> + * @returns true if no errors are detected, false otherwise.
> + */
> +bool polar_log_func_line(unsigned int flags, int errval, const char *func,
> +    int line);
> +
> +/**
> + * Check errval and log on error.
> + *
> + * Convenience wrapper to put around polarssl library calls, e.g.
> + *   if (!polar_ok(polarssl_func())) return 0;
> + * or
> + *   ASSERT (polar_ok(polarssl_func()));
> + *
> + * @param errval	PolarSSL error code to convert to error message.
> + *
> + * @returns true if no errors are detected, false otherwise.
> + */
> +#define polar_ok(errval) \
> +  polar_log_func_line(D_CRYPT_ERRORS, errval, __func__, __LINE__)
> +
> +
>  #endif /* CRYPTO_POLARSSL_H_ */
> 

--------------090706060506020707030809
Content-Type: text/x-patch;
	name="0001-polarssl-add-polar_log_err-and-polar_ok-to-easily-lo.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0001-polarssl-add-polar_log_err-and-polar_ok-to-easily-lo.pa";
	filename*1="tch"

From eda4b8242c1c65c1dedbe866b8159a96b6552b08 Mon Sep 17 00:00:00 2001
From: Steffan Karger <steffan@...1856...>
Date: Sat, 25 Oct 2014 20:04:33 +0200
Subject: [PATCH 1/6] polarssl: add polar_log_err() and polar_ok(), to easily
 log PolarSSL errors

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/crypto_polarssl.c | 27 +++++++++++++++++++++++++++
 src/openvpn/crypto_polarssl.h | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+)

diff --git a/src/openvpn/crypto_polarssl.c b/src/openvpn/crypto_polarssl.c
index 1a986db..9aedadf 100644
--- a/src/openvpn/crypto_polarssl.c
+++ b/src/openvpn/crypto_polarssl.c
@@ -46,6 +46,7 @@
 #include "misc.h"
 
 #include <polarssl/des.h>
+#include <polarssl/error.h>
 #include <polarssl/md5.h>
 #include <polarssl/cipher.h>
 #include <polarssl/havege.h>
@@ -86,6 +87,32 @@ crypto_clear_error (void)
 {
 }
 
+bool polar_log_err(unsigned int flags, int errval, const char *prefix)
+{
+  if (0 != errval)
+    {
+      char errstr[256];
+      polarssl_strerror(errval, errstr, sizeof(errstr));
+
+      if (NULL == prefix) prefix = "PolarSSL error";
+      msg (flags, "%s: %s", prefix, errstr);
+    }
+
+  return 0 == errval;
+}
+
+bool polar_log_func_line(unsigned int flags, int errval, const char *func,
+    int line)
+{
+  char prefix[256];
+
+  if (!openvpn_snprintf(prefix, sizeof(prefix), "%s:%d", func, line))
+    return polar_log_err(flags, errval, func);
+
+  return polar_log_err(flags, errval, prefix);
+}
+
+
 #ifdef DMALLOC
 void
 crypto_init_dmalloc (void)
diff --git a/src/openvpn/crypto_polarssl.h b/src/openvpn/crypto_polarssl.h
index b6da436..b7ce682 100644
--- a/src/openvpn/crypto_polarssl.h
+++ b/src/openvpn/crypto_polarssl.h
@@ -91,4 +91,44 @@ ctr_drbg_context * rand_ctx_get();
 void rand_ctx_enable_prediction_resistance();
 #endif
 
+/**
+ * Log the supplied PolarSSL error, then print the supplied error message.
+ *
+ * @param flags		Flags to indicate error type and priority.
+ * @param errval	PolarSSL error code to convert to error message.
+ * @param prefix	Prefix to PolarSSL error message.
+ *
+ * @returns true if no errors are detected, false otherwise.
+ */
+bool polar_log_err(unsigned int flags, int errval, const char *prefix);
+
+/**
+ * Log the supplied PolarSSL error, then print the supplied error message.
+ *
+ * @param flags		Flags to indicate error type and priority.
+ * @param errval	PolarSSL error code to convert to error message.
+ * @param func		Function name where error was reported.
+ * @param line		Line number where error was reported.
+ *
+ * @returns true if no errors are detected, false otherwise.
+ */
+bool polar_log_func_line(unsigned int flags, int errval, const char *func,
+    int line);
+
+/**
+ * Check errval and log on error.
+ *
+ * Convenience wrapper to put around polarssl library calls, e.g.
+ *   if (!polar_ok(polarssl_func())) return 0;
+ * or
+ *   ASSERT (polar_ok(polarssl_func()));
+ *
+ * @param errval	PolarSSL error code to convert to error message.
+ *
+ * @returns true if no errors are detected, false otherwise.
+ */
+#define polar_ok(errval) \
+  polar_log_func_line(D_CRYPT_ERRORS, errval, __func__, __LINE__)
+
+
 #endif /* CRYPTO_POLARSSL_H_ */
-- 
1.9.1


--------------090706060506020707030809--

