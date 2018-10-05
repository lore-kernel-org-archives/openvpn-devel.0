From: Steffan Karger <steffan@...1856...>
Date: Fri,  5 Oct 2018 17:00:32 +0200
Message-Id: <20181005150032.16541-1-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Simplify --genkey option syntax
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

Instead of requiring users to do "--genkey --secret new.key", allow
them to just do "--genkey new.key".  This has hit me often enough that I
decided to write a patch for it.  Also, the upcoming tls-crypt-v2-genkey
uses a similar syntax and Antonio suggested we should make them consistent.

The documentation is updated to no longer mention the old syntax, but it is
still supported so people who are used to the old syntax can still use it.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 doc/openvpn.8         | 26 ++++++++++++++------------
 src/openvpn/options.c | 12 +++++++-----
 2 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index de1a1928..084c5415 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -5674,20 +5674,22 @@ option.
 Used only for non\-TLS static key encryption mode.
 .\"*********************************************************
 .TP
-.B \-\-genkey
+.B \-\-genkey file
 (Standalone)
-Generate a random key to be used as a shared secret,
-for use with the
+Generate a random key to be used as a shared secret, for use with the
 .B \-\-secret
-option.  This file must be shared with the
-peer over a pre\-existing secure channel such as
-.BR scp (1)
-.
-.\"*********************************************************
-.TP
-.B \-\-secret file
-Write key to
-.B file.
+,
+.B \-\-tls-auth
+or
+.B \-\-tls-crypt
+options.  Stores the key in
+.B file\fR.
+
+If using this for
+.B \-\-secret
+, this file must be shared with the peer over a pre\-existing secure channel
+such as
+.BR scp (1)\fR.
 .\"*********************************************************
 .SS TUN/TAP persistent tunnel config mode:
 Available with Linux 2.4.7+.  These options comprise a standalone mode
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 61fa9833..2199af53 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -739,10 +739,8 @@ static const char usage_message[] =
     "                                 to access TAP adapter.\n"
 #endif /* ifdef _WIN32 */
     "\n"
-    "Generate a random key (only for non-TLS static key encryption mode):\n"
-    "--genkey        : Generate a random key to be used as a shared secret,\n"
-    "                  for use with the --secret option.\n"
-    "--secret file   : Write key to file.\n"
+    "Generate a new key (for use with --secret, --tls-auth or --tls-crypt):\n"
+    "--genkey file   : Generate a new random key and write to file.\n"
 #ifdef ENABLE_FEATURE_TUN_PERSIST
     "\n"
     "Tun/tap config mode (available with linux 2.4+):\n"
@@ -7518,10 +7516,14 @@ add_option(struct options *options,
         }
         options->shared_secret_file = p[1];
     }
-    else if (streq(p[0], "genkey") && !p[1])
+    else if (streq(p[0], "genkey") && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
         options->genkey = true;
+        if (p[1])
+        {
+            options->shared_secret_file = p[1];
+        }
     }
     else if (streq(p[0], "auth") && p[1] && !p[2])
     {
-- 
2.17.1


