From: Gert Doering <gert@...1296...>
Date: Wed,  5 Feb 2025 18:02:32 +0100
Message-ID: <20250205170232.3473-1-gert@...1296...>
In-Reply-To: <gerrit.1738773918000.I59e34058d6e0611208767fbcf39d1b91784ebcf9@...2715...>
References: <gerrit.1738773918000.I59e34058d6e0611208767fbcf39d1b91784ebcf9@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] add missing (void) to win32 function
 declarations
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

mingw complains about "old-style function definition" and since we
use explicit (void) everyhwere else...

Change-Id: I59e34058d6e0611208767fbcf39d1b91784ebcf9
Signed-off-by: Gert Doering <gert@...1296...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/886
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index 46b2d03..62d7109 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -502,7 +502,7 @@
 }
 
 const char *
-dco_get_supported_ciphers()
+dco_get_supported_ciphers(void)
 {
     /*
      * this API can be called either from user mode or kernel mode,
diff --git a/src/openvpn/error.c b/src/openvpn/error.c
index ec65d5e..d5bb802 100644
--- a/src/openvpn/error.c
+++ b/src/openvpn/error.c
@@ -505,7 +505,7 @@
 static int orig_stderr;
 
 int
-get_orig_stderr()
+get_orig_stderr(void)
 {
     return orig_stderr ? orig_stderr : _fileno(stderr);
 }

