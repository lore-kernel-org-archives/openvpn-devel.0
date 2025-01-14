From: Frank Lichtenheld <frank@...2641...>
Date: Tue, 14 Jan 2025 14:49:09 +0100
Message-Id: <20250114134909.31334-1-frank@...2641...>
In-Reply-To: <gerrit.1736847832000.I9a12a0c127908af9f09d88fb3a493df3763d0cc5@...2715...>
References: <gerrit.1736847832000.I9a12a0c127908af9f09d88fb3a493df3763d0cc5@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Improve peer fingerpint documentation
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

From: Arne Schwabe <arne@...1227...>

- fix typo in peer-fingerprint
- use ec_paramgen_curve instead of requiring a subshell

Note: we still use -nodes instead of -noenc as it is more compatible.

closes: issue #666

Change-Id: I9a12a0c127908af9f09d88fb3a493df3763d0cc5
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/859
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/doc/man-sections/example-fingerprint.rst b/doc/man-sections/example-fingerprint.rst
index 7cdda19..31ca0c1 100644
--- a/doc/man-sections/example-fingerprint.rst
+++ b/doc/man-sections/example-fingerprint.rst
@@ -18,7 +18,7 @@
 2. Generate a self-signed certificate for the server:
    ::
 
-    openssl req -x509 -newkey ec:<(openssl ecparam -name secp384r1) -keyout server.key -out server.crt -nodes -sha256 -days 3650 -subj '/CN=server'
+    openssl req -x509 -newkey ec -pkeyopt ec_paramgen_curve:secp384r1 -keyout server.key -out server.crt -nodes -sha256 -days 3650 -subj '/CN=server'
 
 3. Generate SHA256 fingerprint of the server certificate
 
@@ -28,7 +28,7 @@
 
     openssl x509 -fingerprint -sha256 -in server.crt -noout
 
-   This output something similar to:
+   This outputs something similar to:
    ::
 
      SHA256 Fingerprint=00:11:22:33:44:55:66:77:88:99:aa:bb:cc:dd:ee:ff:00:11:22:33:44:55:66:77:88:99:aa:bb:cc:dd:ee:ff
@@ -64,6 +64,12 @@
     # Ping every 60s, restart if no data received for 5 minutes
     keepalive 60 300
 
+    # Uncomment the line below if you want to have persistent IP addresses
+    # ifconfig-pool-persist  /etc/openvpn/server/ipp.txt
+
+    # Uncomment the line below to push a DNS server to clients
+    # push "dhcp-option DNS 1.1.1.1"
+
 5. Add at least one client as described in the client section.
 
 6. Start the server.
@@ -85,7 +91,7 @@
    different name for each client.
    ::
 
-      openssl req -x509 -newkey ec:<(openssl ecparam -name secp384r1) -nodes -sha256 -days 3650 -subj '/CN=alice'
+      openssl req -x509 -newkey ec -pkeyopt ec_paramgen_curve:secp384r1 -keyout - -nodes -sha256 -days 3650 -subj '/CN=alice'
 
    This generate a certificate and a key for the client. The output of the command will look
    something like this:
@@ -162,7 +168,7 @@
       <peer-fingerprint>
       ff:ee:dd:cc:bb:aa:99:88:77:66:55:44:33:22:11:00:ff:ee:dd:cc:bb:aa:99:88:77:66:55:44:33:22:11:00
       99:88:77:66:55:44:33:22:11:00:ff:ee:dd:cc:bb:aa:99:88:77:66:55:44:33:22:11:00:88:77:66:55:44:33
-      </peer-fingperint>
+      </peer-fingerprint>
 
 6. (optional) if the client is an older client that does not support the
    :code:`peer-fingerprint` (e.g. OpenVPN 2.5 and older, OpenVPN Connect 3.3

