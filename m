Message-ID: <54F8CC9B.9040104@...1856...>
Date: Thu, 05 Mar 2015 22:37:31 +0100
From: Steffan Karger <steffan@...1856...>
MIME-Version: 1.0
References: <CAB7qsSN2BzxzuY2hfqE59U+5dw4+wdGGOfUrXRQ4YmoMwAt4Mw@...278...>	<54D34AA7.4030902@...1114...>	<CAB7qsSN2+FiBwXb-e+uez+vvCUqngWEQ2k-8-C0qN4XHHrNn=w@...278...>
	<20150205220835.GT8134@...1296...>
In-Reply-To: <20150205220835.GT8134@...1296...>
Content-Type: multipart/mixed; boundary="------------080103040208060903060209"
Subject: Re: [Openvpn-devel] [PATCH] Fix CN maximum length
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
--------------080103040208060903060209
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

On 05-02-15 23:08, Gert Doering wrote:
> On Thu, Feb 05, 2015 at 06:15:21PM -0300, Jorge Luiz Silva Peixoto wrote:
>>> 64 characters according to some specs, but needs to be 65 to allow NULL
>>> termination?  I'm speculating here ... so if I'm right I'd appreciate an
>>> update to the comment above if it includes NULL termination or not.
>>
>> OK. Do I send this patch again to the list? Comment updated below.
>
> Yes, please.  (Please mark as "patch v2").
>
>>   /** Maximum length of common name (rfc5280) + null character byte */
>> -#define TLS_USERNAME_LEN 64
>> +#define TLS_USERNAME_LEN 65
>
> NAK on this approach, see my other mail.
>
> If this is the length, it should be the length - and if we need extra
> space in the buffer, the buffer should have the "+1", and not all the
> other stuff that want the real length a "-1".

Since is has been silent around this one for a while, attached an 
updated patch with the approach suggested by Gert (which indeed is nicer).

-Steffan

--------------080103040208060903060209
Content-Type: text/x-patch;
	name="0001-Allow-for-CN-username-of-64-characters-fixes-off-by-.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0001-Allow-for-CN-username-of-64-characters-fixes-off-by-.pa";
	filename*1="tch"

From fef692c154be3cc358c1c4950034f91eeeb57083 Mon Sep 17 00:00:00 2001
From: Steffan Karger <steffan@...1856...>
Date: Thu, 5 Mar 2015 22:24:49 +0100
Subject: [PATCH] Allow for CN/username of 64 characters (fixes off-by-one)

This is an alternative patch to fix the issue reported in trac #515 by
Jorge Peixoto. Instead of increasing the TLS_USERNAME_LEN define, do +1 at
the relevant places in the code.

Also see Jorge's original patch and the discussion on the maillinglist:
http://thread.gmane.org/gmane.network.openvpn.devel/9438

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/ssl_verify.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index ad50458..c4f56f9 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -592,7 +592,7 @@ verify_cert(struct tls_session *session, openvpn_x509_cert_t *cert, int cert_dep
 {
   result_t ret = FAILURE;
   char *subject = NULL;
-  char common_name[TLS_USERNAME_LEN] = {0};
+  char common_name[TLS_USERNAME_LEN+1] = {0}; /* null-terminated */
   const struct tls_options *opt;
   struct gc_arena gc = gc_new();
 
@@ -615,7 +615,7 @@ verify_cert(struct tls_session *session, openvpn_x509_cert_t *cert, int cert_dep
   string_replace_leading (subject, '-', '_');
 
   /* extract the username (default is CN) */
-  if (SUCCESS != backend_x509_get_username (common_name, TLS_USERNAME_LEN,
+  if (SUCCESS != backend_x509_get_username (common_name, sizeof(common_name),
       opt->x509_username_field, cert))
     {
       if (!cert_depth)
@@ -1163,7 +1163,7 @@ verify_user_pass(struct user_pass *up, struct tls_multi *multi,
     s2 = verify_user_pass_script (session, up);
 
   /* check sizing of username if it will become our common name */
-  if ((session->opt->ssl_flags & SSLF_USERNAME_AS_COMMON_NAME) && strlen (up->username) >= TLS_USERNAME_LEN)
+  if ((session->opt->ssl_flags & SSLF_USERNAME_AS_COMMON_NAME) && strlen (up->username) > TLS_USERNAME_LEN)
     {
       msg (D_TLS_ERRORS, "TLS Auth Error: --username-as-common name specified and username is longer than the maximum permitted Common Name length of %d characters", TLS_USERNAME_LEN);
       s1 = OPENVPN_PLUGIN_FUNC_ERROR;
-- 
2.1.0


--------------080103040208060903060209--

