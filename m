Message-ID: <4E14939F.9020708@...1432...>
Date: Wed, 06 Jul 2011 18:55:59 +0200
From: Markus Koetter <koetter@...1432...>
MIME-Version: 1.0
References: <4E12BE97.3000308@...1432...>
	<4E130E87.4070202@...1114...>
In-Reply-To: <4E130E87.4070202@...1114...>
Content-Type: multipart/mixed; boundary="------------000608070705000300080705"
Subject: Re: [Openvpn-devel] Bug: extended x509-username-field broken in git
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------000608070705000300080705
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 07/05/2011 03:15 PM, David Sommerseth wrote:
> Can you please use git bisect to locate the offending commit?

I figured out this never really worked with openvpn git at all.
During discussing the patch, the check for the error_depth disappeared.
So, if the root certificate lacked the extension, it would fail.

Therefore, attached a patch which accepts this kind of error if the 
error_depth is != 0 - the lowest level of the cert is not reached yet.
This duplicates the behavior which is used for the fields.

I was wondering why the script tries to extract values from certificates 
for any level but 0 anyway?


MfG
Markus

--------------000608070705000300080705
Content-Type: text/x-diff;
 name="error_depth.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="error_depth.diff"

diff --git a/ssl.c b/ssl.c
index a0493ff..48c6be1 100644
--- a/ssl.c
+++ b/ssl.c
@@ -977,12 +977,15 @@ verify_callback (int preverify_ok, X509_STORE_CTX * ctx)
     {
       if (!extract_x509_extension (ctx->current_cert, x509_username_field+4, common_name, sizeof(common_name)))
         {
-          msg (D_TLS_ERRORS, "VERIFY ERROR: could not extract %s extension from X509 subject string ('%s') "
+          if (!ctx->error_depth)
+            {
+              msg (D_TLS_ERRORS, "VERIFY ERROR: could not extract %s extension from X509 subject string ('%s') "
                              "-- note that the username length is limited to %d characters",
                              x509_username_field+4,
                              subject,
                              TLS_USERNAME_LEN);
-          goto err;
+              goto err;
+            }
         }
     } else
 #endif

--------------000608070705000300080705--

