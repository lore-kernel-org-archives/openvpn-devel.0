From: Gert Doering <gert@...1296...>
Date: Thu, 27 Nov 2025 12:57:32 +0100
Message-ID: <20251127115737.3598-1-gert@...1296...>
In-Reply-To: <gerrit.1764239370000.Ib15bd4148872db39a4c8291796a5da211bb20a87@...2715...>
References: <gerrit.1764239370000.Ib15bd4148872db39a4c8291796a5da211bb20a87@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Remove remainders of --no-name-remaping
 option
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

This option was removed in 2.5 (commit c3f565f059) but still showed
up in the ``openvpn --help`` text and in a Q&A section of the man page.

Change-Id: Ib15bd4148872db39a4c8291796a5da211bb20a87
Signed-off-by: Gert Doering <gert@...1296...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1411
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1411
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/doc/man-sections/script-options.rst b/doc/man-sections/script-options.rst
index 670cd33..cadd464 100644
--- a/doc/man-sections/script-options.rst
+++ b/doc/man-sections/script-options.rst
@@ -571,8 +571,8 @@
     a filename, etc.
 
 *Q: Can string remapping be disabled?*
-    Yes, by using the ``--no-name-remapping`` option, however this
-    should be considered an advanced option.
+    No.  The options ``--no-name-remapping`` and ``--compat-names`` have
+    been removed in 2.5 because they were considered too insecure.
 
 Here is a brief rundown of OpenVPN's current string types and the
 permitted character class for each string:
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 4794315..0257418f 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -474,8 +474,6 @@
     "                  for generated tokens can be set.\n"
     "--auth-user-pass-optional : Allow connections by clients that don't\n"
     "                  specify a username/password.\n"
-    "--no-name-remapping : (DEPRECATED) Allow Common Name and X509 Subject to include\n"
-    "                      any printable character.\n"
     "--client-to-client : Internally route client-to-client traffic.\n"
     "--duplicate-cn  : Allow multiple clients with the same common name to\n"
     "                  concurrently connect.\n"

