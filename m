From: Frank Lichtenheld <frank@...2641...>
Date: Fri, 31 Mar 2023 15:24:29 +0200
Message-Id: <20230331132429.601635-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] doc: run rst2* with --strict to catch
 warnings
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

Basically -Werror for docutils.

Fix all issues raised by this. The following issue
classes were reported:

Possible title underline, too short for the title.
Treating it as ordinary text because it's so short.
(:: at the start of the line directly below text,
either add empty line of merge into : on previous line)

Enumerated list start value not ordinal-1
(error in numbering)

Change-Id: Id3b0f7be4602f70115c60e6ddb89f6ed58e94e64
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 doc/Makefile.am                               |  6 ++-
 doc/man-sections/connection-profiles.rst      |  3 +-
 doc/man-sections/example-fingerprint.rst      |  7 ++-
 doc/man-sections/examples.rst                 | 51 +++++++------------
 .../virtual-routing-and-forwarding.rst        |  6 ++-
 5 files changed, 30 insertions(+), 43 deletions(-)

diff --git a/doc/Makefile.am b/doc/Makefile.am
index 13e6a64e..bb9c935d 100644
--- a/doc/Makefile.am
+++ b/doc/Makefile.am
@@ -68,19 +68,21 @@ openvpn-examples.5 openvpn-examples.5.html: $(openvpn_examples_sections)
 
 SUFFIXES = .8.rst .8 .8.html .5.rst .5 .5.html
 
+RST_FLAGS = --strict
+
 MAINTAINERCLEANFILES = \
 	$(srcdir)/Makefile.in
 
 .8.rst.8 .5.rst.5 :
 if HAVE_PYDOCUTILS
-	$(RST2MAN) $< > $@
+	$(RST2MAN) $(RST_FLAGS) $< > $@
 else
 	@echo "Missing python-docutils - skipping man page generation ($@)"
 endif
 
 .8.rst.8.html .5.rst.5.html :
 if HAVE_PYDOCUTILS
-	$(RST2HTML) $< > $@
+	$(RST2HTML) $(RST_FLAGS) $< > $@
 else
 	@echo "Missing python-docutils - skipping html page generation ($@)"
 endif
diff --git a/doc/man-sections/connection-profiles.rst b/doc/man-sections/connection-profiles.rst
index fd3382b2..c8816e10 100644
--- a/doc/man-sections/connection-profiles.rst
+++ b/doc/man-sections/connection-profiles.rst
@@ -16,8 +16,7 @@ achieves a successful connection.
 ``--remote-random`` can be used to initially "scramble" the connection
 list.
 
-Here is an example of connection profile usage:
-::
+Here is an example of connection profile usage::
 
    client
    dev tun
diff --git a/doc/man-sections/example-fingerprint.rst b/doc/man-sections/example-fingerprint.rst
index 852cca49..7cdda190 100644
--- a/doc/man-sections/example-fingerprint.rst
+++ b/doc/man-sections/example-fingerprint.rst
@@ -34,8 +34,7 @@ Server setup
      SHA256 Fingerprint=00:11:22:33:44:55:66:77:88:99:aa:bb:cc:dd:ee:ff:00:11:22:33:44:55:66:77:88:99:aa:bb:cc:dd:ee:ff
 
 
-3. Write a server configuration (`server.conf`):
-::
+4. Write a server configuration (`server.conf`)::
 
     # The server certificate we created in step 1
     cert server.crt
@@ -65,9 +64,9 @@ Server setup
     # Ping every 60s, restart if no data received for 5 minutes
     keepalive 60 300
 
-4. Add at least one client as described in the client section.
+5. Add at least one client as described in the client section.
 
-5. Start the server.
+6. Start the server.
     - On systemd based distributions move `server.crt`, `server.key` and
       `server.conf` to :code:`/etc/openvpn/server` and start it via systemctl
 
diff --git a/doc/man-sections/examples.rst b/doc/man-sections/examples.rst
index 31486017..94cc726a 100644
--- a/doc/man-sections/examples.rst
+++ b/doc/man-sections/examples.rst
@@ -63,27 +63,23 @@ you will get a weird feedback loop.
 Example 1: A simple tunnel without security (not recommended)
 -------------------------------------------------------------
 
-On bob:
-::
+On bob::
 
    openvpn --remote alice.example.com --dev tun1 \
             --ifconfig 10.4.0.1 10.4.0.2 --verb 9
 
-On alice:
-::
+On alice::
 
    openvpn --remote bob.example.com --dev tun1 \
             --ifconfig 10.4.0.2 10.4.0.1 --verb 9
 
 Now verify the tunnel is working by pinging across the tunnel.
 
-On bob:
-::
+On bob::
 
    ping 10.4.0.2
 
-On alice:
-::
+On alice::
 
    ping 10.4.0.1
 
@@ -96,13 +92,13 @@ Example 2: A tunnel with self-signed certificates and fingerprint
 -----------------------------------------------------------------
 
 First build a self-signed certificate on bob and display its fingerprint.
+
 ::
 
    openssl req -x509 -newkey ec:<(openssl ecparam -name secp384r1) -keyout bob.pem -out bob.pem -nodes -sha256 -days 3650 -subj '/CN=bob'
    openssl x509 -noout -sha256 -fingerprint -in bob.pem
 
-and the same on alice:
-::
+and the same on alice::
 
    openssl req -x509 -newkey ec:<(openssl ecparam -name secp384r1) -keyout alice.pem -out alice.pem -nodes -sha256 -days 3650 -subj '/CN=alice'
    openssl x509 -noout -sha256 -fingerprint -in alice.pem
@@ -113,30 +109,26 @@ that contain both self-signed certificate and key and show the fingerprint of th
 Transfer the fingerprints  over a secure medium such as by using
 the ``scp``\(1) or ``ssh``\(1) program.
 
-On bob:
-::
+On bob::
 
    openvpn --ifconfig 10.4.0.1 10.4.0.2 --tls-server --dev tun --dh none \
            --cert bob.pem --key bob.pem --cipher AES-256-GCM \
            --peer-fingerprint "$fingerprint_of_alices_cert"
 
-On alice:
-::
+On alice::
 
    openvpn --remote bob.example.com --tls-client --dev tun1   \
            --ifconfig 10.4.0.2 10.4.0.1 --cipher AES-256-GCM  \
-           --cert alice.pem --key alice.pem
+           --cert alice.pem --key alice.pem                   \
            --peer-fingerprint "$fingerprint_of_bobs_cert"
 
 Now verify the tunnel is working by pinging across the tunnel.
 
-On bob:
-::
+On bob::
 
    ping 10.4.0.2
 
-On alice:
-::
+On alice::
 
    ping 10.4.0.1
 
@@ -170,8 +162,7 @@ For Diffie Hellman parameters you can use the included file
     and keys included in the OpenVPN distribution are totally
     insecure and should be used for testing only.
 
-On bob:
-::
+On bob::
 
    openvpn --remote alice.example.com --dev tun1    \
            --ifconfig 10.4.0.1 10.4.0.2             \
@@ -179,8 +170,7 @@ On bob:
            --cert client.crt --key client.key       \
            --reneg-sec 60 --verb 5
 
-On alice:
-::
+On alice::
 
    openvpn --remote bob.example.com --dev tun1      \
            --ifconfig 10.4.0.2 10.4.0.1             \
@@ -190,13 +180,11 @@ On alice:
 
 Now verify the tunnel is working by pinging across the tunnel.
 
-On bob:
-::
+On bob::
 
    ping 10.4.0.2
 
-On alice:
-::
+On alice::
 
    ping 10.4.0.1
 
@@ -221,8 +209,7 @@ networks. We will assume that bob's private subnet is *10.0.0.0/24* and
 alice's is *10.0.1.0/24*.
 
 First, ensure that IP forwarding is enabled on both peers. On Linux,
-enable routing:
-::
+enable routing::
 
     echo 1 > /proc/sys/net/ipv4/ip_forward
 
@@ -235,13 +222,11 @@ systems guide on how to configure the firewall.  You typically want to
 allow traffic coming from and going to the tun/tap adapter OpenVPN is
 configured to use.
 
-On bob:
-::
+On bob::
 
    route add -net 10.0.1.0 netmask 255.255.255.0 gw 10.4.0.2
 
-On alice:
-::
+On alice::
 
    route add -net 10.0.0.0 netmask 255.255.255.0 gw 10.4.0.1
 
diff --git a/doc/man-sections/virtual-routing-and-forwarding.rst b/doc/man-sections/virtual-routing-and-forwarding.rst
index 28c13eee..db5f1abc 100644
--- a/doc/man-sections/virtual-routing-and-forwarding.rst
+++ b/doc/man-sections/virtual-routing-and-forwarding.rst
@@ -23,11 +23,13 @@ VRF setup with iproute2
 ```````````````````````
 
 Create VRF :code:`vrf_external` and map it to routing table :code:`1023`
+
 ::
 
       ip link add vrf_external type vrf table 1023
 
 Move :code:`eth0` into :code:`vrf_external`
+
 ::
 
       ip link set master vrf_external dev eth0
@@ -42,8 +44,7 @@ VRF setup with ifupdown
 For Debian based Distributions :code:`ifupdown2` provides an almost drop-in
 replacement for :code:`ifupdown` including VRFs and other features.
 A configuration for an interface :code:`eth0` being part of VRF
-code:`vrf_external` could look like this:
-::
+code:`vrf_external` could look like this::
 
       auto eth0
       iface eth0
@@ -61,6 +62,7 @@ code:`vrf_external` could look like this:
 OpenVPN configuration
 `````````````````````
 The OpenVPN configuration needs to contain this line:
+
 ::
 
       bind-dev vrf_external
-- 
2.34.1


