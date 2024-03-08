From: Frank Lichtenheld <frank@...2641...>
Date: Fri,  8 Mar 2024 15:01:12 +0100
Message-Id: <20240308140112.4015131-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] remove repetitive words in documentation
 and comments
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
Cc: wellweek <xiezitai@...2047...>

From: wellweek <xiezitai@...2047...>

Change-Id: I4f349963b41ebe155d3866da8955f2d7245d0394
Signed-off-by: wellweek <xiezitai@...2047...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---
 Changes.rst                              | 2 +-
 contrib/OCSP_check/OCSP_check.sh         | 2 +-
 doc/man-sections/cipher-negotiation.rst  | 2 +-
 doc/man-sections/vpn-network-options.rst | 4 ++--
 sample/sample-config-files/server.conf   | 2 +-
 src/openvpn/fragment.h                   | 2 +-
 src/openvpn/misc.c                       | 2 +-
 src/openvpnserv/interactive.c            | 2 +-
 8 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/Changes.rst b/Changes.rst
index 4cded980..54e59809 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -794,7 +794,7 @@ Control channel encryption (``--tls-crypt``)
 Asynchronous push reply
     Plug-ins providing support for deferred authentication can benefit from a more
     responsive authentication where the server sends PUSH_REPLY immediately once
-    the authentication result is ready, instead of waiting for the the client to
+    the authentication result is ready, instead of waiting for the client to
     to send PUSH_REQUEST once more.  This requires OpenVPN to be built with
     ``./configure --enable-async-push``.  This is a compile-time only switch.
 
diff --git a/contrib/OCSP_check/OCSP_check.sh b/contrib/OCSP_check/OCSP_check.sh
index 26757889..e4fec834 100644
--- a/contrib/OCSP_check/OCSP_check.sh
+++ b/contrib/OCSP_check/OCSP_check.sh
@@ -89,7 +89,7 @@ if [ $check_depth -eq -1 ] || [ $cur_depth -eq $check_depth ]; then
     #
     # NOTE: It is needed to check the exit code of OpenSSL explicitly.  OpenSSL
     #       can in some circumstances give a "good" result if it could not
-    #       reach the the OSCP server.  In this case, the exit code will indicate
+    #       reach the OSCP server.  In this case, the exit code will indicate
     #       if OpenSSL itself failed or not.  If OpenSSL's exit code is not 0,
     #       don't trust the OpenSSL status.
 
diff --git a/doc/man-sections/cipher-negotiation.rst b/doc/man-sections/cipher-negotiation.rst
index 888ffa6f..949ff862 100644
--- a/doc/man-sections/cipher-negotiation.rst
+++ b/doc/man-sections/cipher-negotiation.rst
@@ -8,7 +8,7 @@ different backwards compatibility mechanism with older server and clients.
 OpenVPN 2.5 and later behaviour
 --------------------------------
 When both client and server are at least running OpenVPN 2.5, that the order of
-the ciphers of the server's ``--data-ciphers`` is used to pick the the data cipher.
+the ciphers of the server's ``--data-ciphers`` is used to pick the data cipher.
 That means that the first cipher in that list that is also in the client's
 ``--data-ciphers`` list is chosen. If no common cipher is found the client is rejected
 with a AUTH_FAILED message (as seen in client log):
diff --git a/doc/man-sections/vpn-network-options.rst b/doc/man-sections/vpn-network-options.rst
index 41d367bf..abe474f7 100644
--- a/doc/man-sections/vpn-network-options.rst
+++ b/doc/man-sections/vpn-network-options.rst
@@ -235,7 +235,7 @@ routing.
   address and subnet mask just as a physical ethernet adapter would be
   similarly configured. If you are attempting to connect to a remote
   ethernet bridge, the IP address and subnet should be set to values which
-  would be valid on the the bridged ethernet segment (note also that DHCP
+  would be valid on the bridged ethernet segment (note also that DHCP
   can be used for the same purpose).
 
   This option, while primarily a proxy for the ``ifconfig``\(8) command,
@@ -584,7 +584,7 @@ These two standalone operations will require ``--dev`` and optionally
   One of the advantages of persistent tunnels is that they eliminate the
   need for separate ``--up`` and ``--down`` scripts to run the appropriate
   ``ifconfig``\(8) and ``route``\(8) commands. These commands can be
-  placed in the the same shell script which starts or terminates an
+  placed in the same shell script which starts or terminates an
   OpenVPN session.
 
   Another advantage is that open connections through the TUN/TAP-based
diff --git a/sample/sample-config-files/server.conf b/sample/sample-config-files/server.conf
index 009fe56c..97732c62 100644
--- a/sample/sample-config-files/server.conf
+++ b/sample/sample-config-files/server.conf
@@ -42,7 +42,7 @@ proto udp
 # and bridged it with your ethernet interface.
 # If you want to control access policies
 # over the VPN, you must create firewall
-# rules for the the TUN/TAP interface.
+# rules for the TUN/TAP interface.
 # On non-Windows systems, you can give
 # an explicit unit number, such as tun0.
 # On Windows, use "dev-node" for this.
diff --git a/src/openvpn/fragment.h b/src/openvpn/fragment.h
index cc6829aa..2d13dbb7 100644
--- a/src/openvpn/fragment.h
+++ b/src/openvpn/fragment.h
@@ -314,7 +314,7 @@ void fragment_free(struct fragment_master *f);
  *    reassembly buffer.  If the incoming part completes the packet being
  *    reassembled, the \a buf argument is modified to point to the fully
  *    reassembled packet.  If, on the other hand, reassembly is not yet
- *    complete, then the the \a buf buffer is set to empty.
+ *    complete, then the \a buf buffer is set to empty.
  *  - Any other value: error.
  *
  * If an error occurs during processing, an error message is logged and
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 08f274db..ac6df65e 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -129,7 +129,7 @@ auth_user_pass_mgmt(struct user_pass *up, const char *prefix, const unsigned int
  * Parses an authentication challenge string and returns an auth_challenge_info structure.
  * The authentication challenge string should follow the dynamic challenge/response protocol.
  *
- * See doc/management-notes.txt for more info on the the dynamic challenge/response protocol
+ * See doc/management-notes.txt for more info on the dynamic challenge/response protocol
  * implemented here.
  *
  * @param auth_challenge The authentication challenge string to parse. Can't be NULL.
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 32c8996c..a6a2c7c6 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -1207,7 +1207,7 @@ CmpWString(LPVOID item, LPVOID str)
 
 /**
  * Set interface specific DNS domain suffix
- * @param  if_name    name of the the interface
+ * @param  if_name    name of the interface
  * @param  domain     a single domain name
  * @param  lists      pointer to the undo lists. If NULL
  *                    undo lists are not altered.
-- 
2.34.1


