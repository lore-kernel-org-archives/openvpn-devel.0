Message-ID: <55A6C46C.5080601@...1856...>
Date: Wed, 15 Jul 2015 22:37:00 +0200
From: Steffan Karger <steffan@...1856...>
MIME-Version: 1.0
References: <CAN-X3HT5xX0kgJsPQLNNcvcWg+ognu9EHBWjoxw=jZcRLEzPsQ@...278...>
In-Reply-To: <CAN-X3HT5xX0kgJsPQLNNcvcWg+ognu9EHBWjoxw=jZcRLEzPsQ@...278...>
Content-Type: multipart/mixed; boundary="------------060603040506080303090808"
Subject: Re: [Openvpn-devel] [PATCH] Fix using management interface to get
 passwords
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
--------------060603040506080303090808
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit


On 15-07-15 20:43, Christian Pellegrin wrote:
> Commits da9b292733e929a2900dc32d37f0424c3d588366 and
> 315f6fbc7f657a7f1127628bd714f468709d5185 broke the use case where we are asking
> password from the management client. The password is always asked before
> daemonization. With this fix we avoid this and ask it via management interface
> in the same spot as before the mentioned commits. Tested on Linux.

Hmm, this 'reorder daemon()' patch is really hunting me.  Sorry for 
breaking your setup.  But in the end all will be better!

Your patch is much appreciated, but I have to NACK it.

--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -502,6 +502,16 @@ context_init_1 (struct context *c)

    init_connection_list (c);

+#ifdef ENABLE_MANAGEMENT
+  if (c->options.management_flags & MF_QUERY_PASSWORDS) {
+#ifdef ENABLE_CLIENT_CR
+    auth_user_pass_setup ("management", &c->options.sc_info);
+#else
+    auth_user_pass_setup ("management", NULL);
+#endif
+  }
+#endif

I think this indeed does fix your setup, but will break others: openvpn 
will now also act as if --auth-user-pass was specified if only 
--management-query-passwords is specified, because there is no
   if (c->options.auth_user_pass_file)
guarding the call to auth_user_pass_setup() anymore.

Could you test the attached patch, and report whether this version also 
fixes the issue for you?  It does fix the issue in my test setup, and 
works as expected when --auth-user-pass is not specified.  (Note that 
init_query_passwords() does all the required checks and is safe to call 
multiple times.)

Thanks again for the patch.  It saved me a lot of time.  If you agree 
with my changes, can we put your name in a signed-off-by line in the 
commit msg?

-Steffan

--------------060603040506080303090808
Content-Type: text/x-patch;
	name="0001-Fix-using-management-interface-to-get-passwords.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0001-Fix-using-management-interface-to-get-passwords.patch"

From e1fe8d4be9510ef3a644f993b9da583d21f7553b Mon Sep 17 00:00:00 2001
From: Steffan Karger <steffan@...1856...>
Date: Wed, 15 Jul 2015 22:13:52 +0200
Subject: [PATCH v2] Fix using management interface to get passwords.

Commits da9b292733e929a2900dc32d37f0424c3d588366 and
315f6fbc7f657a7f1127628bd714f468709d5185 broke the use case where we are asking
password from the management client. The password is always asked before
daemonization. With this fix we avoid this and ask it via management interface
in the same spot as before the mentioned commits. Tested on Linux.

v2: This patch was first submitted by Christian Pellegrin (from Google), and
reworked by Steffan Karger (from the OpenVPN team) to also work for setups
with --management-query-passwords but without --auth-user-pass.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/openvpn.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c
index d05acde..32e326e 100644
--- a/src/openvpn/openvpn.c
+++ b/src/openvpn/openvpn.c
@@ -229,8 +229,12 @@ openvpn_main (int argc, char *argv[])
 	  if (do_test_crypto (&c.options))
 	    break;
 
-	  /* Query passwords before becoming a daemon */
-	  init_query_passwords (&c);
+	  /* Query passwords before becoming a daemon if we don't use the
+	   * management interface to get them. */
+#ifdef ENABLE_MANAGEMENT
+	  if (!(c.options.management_flags & MF_QUERY_PASSWORDS))
+#endif
+	    init_query_passwords (&c);
 
 	  /* become a daemon if --daemon */
 	  if (c.first_time)
@@ -243,6 +247,9 @@ openvpn_main (int argc, char *argv[])
 	  /* open management subsystem */
 	  if (!open_management (&c))
 	    break;
+	  /* query for passwords through management interface, if needed */
+	  if (c.options.management_flags & MF_QUERY_PASSWORDS)
+	    init_query_passwords (&c);
 #endif
 
 	  /* set certain options as environmental variables */
-- 
2.1.4


--------------060603040506080303090808--

