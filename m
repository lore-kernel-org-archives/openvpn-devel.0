From: Heiko Hund <heiko.hund@...1489...>
Date: Fri, 22 Feb 2013 10:44:21 +0100
Message-ID: <1361526263-1740-3-git-send-email-heiko.hund@...1489...>
In-Reply-To: <1361526263-1740-1-git-send-email-heiko.hund@...1489...>
References: <1361526263-1740-1-git-send-email-heiko.hund@...1489...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/3] make --tls-remote compatible with pre
	2.3 configs
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

In openvpn 2.3.0 the semantics of the --tls-remote option changed.
That broke more configurations than anticipated. To not break
configurations that use --tls-remote with a legacy OpenSSL style DN
anymore, it is now detected when such a DN is configured. When
necessary the --compat-names option is then automatically enabled.

Signed-off-by: Heiko Hund <heiko.hund@...1489...>
---
 src/openvpn/options.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index dd38bc9..7fda76f 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -6528,6 +6528,12 @@ add_option (struct options *options,
   else if (streq (p[0], "tls-remote") && p[1])
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
+      /*
+       * Enable legacy openvpn format for DNs that have not been converted
+       * yet and X.509 common names (not containing an '=' or ', ')
+       */
+      if (p[1][0] == '/' || !strchr (p[1], '=') || !strstr (p[1], ", "))
+        compat_flag (COMPAT_FLAG_SET | COMPAT_NAMES);
       options->tls_remote = p[1];
     }
   else if (streq (p[0], "ns-cert-type") && p[1])
-- 
1.7.9.5


