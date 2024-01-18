From: Gert Doering <gert@...1296...>
Date: Thu, 18 Jan 2024 17:49:03 +0100
Message-ID: <20240118164903.22519-1-gert@...1296...>
In-Reply-To: <gerrit.1705068839000.I7a754d0b4a76a9227bf922f65176cd9ec4d7670c@...2715...>
References: <gerrit.1705068839000.I7a754d0b4a76a9227bf922f65176cd9ec4d7670c@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] proxy-options.rst: Add proper
 documentation for --http-proxy-user-pass
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

From: Frank Lichtenheld <frank@...2641...>

And extend examples section for authenticated HTTP proxies because
is was misleading.

Change-Id: I7a754d0b4a76a9227bf922f65176cd9ec4d7670c
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/498
This mail reflects revision 1 of this Change.
Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/doc/man-sections/proxy-options.rst b/doc/man-sections/proxy-options.rst
index 9cf311f..ad49c60 100644
--- a/doc/man-sections/proxy-options.rst
+++ b/doc/man-sections/proxy-options.rst
@@ -4,7 +4,7 @@
   is required, a file name to an ``authfile`` file containing a username
   and password on 2 lines can be given, or :code:`stdin` to prompt from
   console. Its content can also be specified in the config file with the
-  ``--http-proxy-user-pass`` option. (See section on inline files)
+  ``--http-proxy-user-pass`` option (See `INLINE FILE SUPPORT`_).
 
   The last optional argument is an ``auth-method`` which should be one
   of :code:`none`, :code:`basic`, or :code:`ntlm2`.
@@ -25,14 +25,43 @@
   Examples:
   ::
 
+     # no authentication
      http-proxy proxy.example.net 3128
+     # basic authentication, load credentials from file
      http-proxy proxy.example.net 3128 authfile.txt
+     # basic authentication, ask user for credentials
      http-proxy proxy.example.net 3128 stdin
-     http-proxy proxy.example.net 3128 auto basic
-     http-proxy proxy.example.net 3128 auto-nct ntlm2
+     # NTLM authentication, load credentials from file
+     http-proxy proxy.example.net 3128 authfile.txt ntlm2
+     # determine which authentication is required, ask user for credentials
+     http-proxy proxy.example.net 3128 auto
+     # determine which authentication is required, but reject basic
+     http-proxy proxy.example.net 3128 auto-nct
+     # determine which authentication is required, but set credentials
+     http-proxy proxy.example.net 3128 auto
+     http-proxy-user-pass authfile.txt
+     # basic authentication, specify credentials inline
+     http-proxy proxy.example.net 3128 "" basic
+     <http-proxy-user-pass>
+     username
+     password
+     </http-proxy-user-pass>
 
   Note that support for NTLMv1 proxies was removed with OpenVPN 2.7.
 
+--http-proxy-user-pass userpass
+  Overwrite the username/password information for ``--http-proxy``. If specified
+  as an inline option (see `INLINE FILE SUPPORT`_), it will be interpreted as
+  username/password separated by a newline. When specified on the command line
+  it is interpreted as a filename same as the third argument to ``--http-proxy``.
+
+  Example::
+
+    <http-proxy-user-pass>
+    username
+    password
+    </http-proxy-user-pass>
+
 --http-proxy-option args
   Set extended HTTP proxy options. Requires an option ``type`` as argument
   and an optional ``parameter`` to the type.  Repeat to set multiple

