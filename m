From: Gert Doering <gert@...1296...>
Date: Wed, 26 Nov 2025 14:04:03 +0100
Message-ID: <20251126130410.19091-1-gert@...1296...>
In-Reply-To: <gerrit.1763574430000.Id429241e1b17a8ff51d9019efc357c910f3bde4c@...2715...>
References: <gerrit.1763574430000.Id429241e1b17a8ff51d9019efc357c910f3bde4c@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v5] Change '--multihome' behaviour regarding
 egress interface selection.
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

Traditional OpenVPN ``--multihome`` behaviour is to send packets out the
same interface that they were received on (copy ipi_ifindex from ingress
to egress packet info).  For some scenarios this makes sense, for other
scenarios it is breaking connectivity when there are no routes pointing
out the ingress interface (intentionally asymmetric traffic).

For 2.7.0, change the default(!) to always send out packets with
ipi_ifindex = 0, to follow normal system interface selection rules.

Add a flag ``--multihome same-interface`` to restore the pre-2.7 behavior
of copying ipi_ifindex from ingress to egress packets.  There are use
cases for this, and we want to give users a chance to read the release
notes and adjust their setups to "not break after upgrading to 2.7.0".

Github: OpenVPN/openvpn#855
Github: OpenVPN/openvpn#554

v2: fix whitespace
v3: turn logic around - new default is "egress ifindex 0" now
v4: typo fixed in commit message
v5: fix invalid rst in Changes.rst

Change-Id: Id429241e1b17a8ff51d9019efc357c910f3bde4c
Signed-off-by: Gert Doering <gert@...1296...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1383
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1383
This mail reflects revision 5 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/Changes.rst b/Changes.rst
index 9077064..40984f5 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -326,6 +326,12 @@
   Win-DCO as well), add printing of the hwid to all adapter outputs, and
   change the default adapter type created to `ovpn-dco`.
 
+- the default for ``multihome`` egress interface handling has changed.
+  2.7.0 will default to ipi_ifindex=0, that is, leave the decision to the
+  routing/policy setup of the operating system.  The pre-2.7 behaviour
+  (force egress = ingress interface) can be achieved with the new
+  ``--multihome same-interface`` sub-option.
+
 Deprecated features
 -------------------
 ``--opt-verify`` feature removed
diff --git a/doc/man-sections/server-options.rst b/doc/man-sections/server-options.rst
index 739be22..3760694 100644
--- a/doc/man-sections/server-options.rst
+++ b/doc/man-sections/server-options.rst
@@ -342,7 +342,7 @@
   by ``--ifconfig-ipv6``, OpenVPN will install a /128 host route for the
   ``ipv6addr`` IP address.
 
---multihome
+--multihome [same-interface]
   Configure a multi-homed UDP server. This option needs to be used when a
   server has more than one IP address (e.g. multiple interfaces, or
   secondary IP addresses), and is not using ``--local`` to force binding
@@ -353,12 +353,18 @@
   default.
 
   *Notes:*
-    -  This option is only relevant for UDP servers.
-    -  If you do an IPv6+IPv4 dual-stack bind on a Linux machine with
-       multiple IPv4 address, connections to IPv4 addresses will not
-       work right on kernels before 3.15, due to missing kernel
-       support for the IPv4-mapped case (some distributions have
-       ported this to earlier kernel versions, though).
+    - This option is only relevant for UDP servers.
+    - Starting with 2.7.0, OpenVPN will ignore the incoming interface of
+      the packet, and leave selection of the outgoing interface to the
+      normal routing/policy mechanisms of the OS ("set ipi_ifindex=0").
+    - if the ``same-interface`` flag is added, OpenVPN will copy the
+      incoming interface index to the outgoing interface index,
+      trying to send the packet out over the same interface where it came
+      in on (= restoring earlier OpenVPN behaviour). This might not work
+      if there are no usable routes on that interface.
+    - the \*BSD systems use a different API for IPv4 that does not provide
+      the interface index anyway (IP_RECVDSTADDR), so there the difference
+      applies only to IPv6.
 
 --iroute args
   Generate an internal route to a specific client. The ``netmask``
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 4794315..62f84dd 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -6335,10 +6335,18 @@
         options->mlock = true;
     }
 #if ENABLE_IP_PKTINFO
-    else if (streq(p[0], "multihome") && !p[1])
+    else if (streq(p[0], "multihome") && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
         options->sockflags |= SF_USE_IP_PKTINFO;
+        if (p[1] && streq(p[1], "same-interface"))
+        {
+            options->sockflags |= SF_PKTINFO_COPY_IIF;
+        }
+        else if (p[1])
+        {
+            msg(msglevel, "Unknown parameter to --multihome: %s", p[1]);
+        }
     }
 #endif
     else if (streq(p[0], "verb") && p[1] && !p[2])
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 8b6e35e..747c7a7 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -2393,7 +2393,8 @@
         {
 #if defined(HAVE_IN_PKTINFO) && defined(HAVE_IPI_SPEC_DST)
             struct in_pktinfo *pkti = (struct in_pktinfo *)CMSG_DATA(cmsg);
-            from->pi.in4.ipi_ifindex = pkti->ipi_ifindex;
+            from->pi.in4.ipi_ifindex =
+                (sock->sockflags & SF_PKTINFO_COPY_IIF) ? pkti->ipi_ifindex : 0;
             from->pi.in4.ipi_spec_dst = pkti->ipi_spec_dst;
 #elif defined(IP_RECVDSTADDR)
             from->pi.in4 = *(struct in_addr *)CMSG_DATA(cmsg);
@@ -2406,7 +2407,8 @@
                  && cmsg->cmsg_len >= CMSG_LEN(sizeof(struct in6_pktinfo)))
         {
             struct in6_pktinfo *pkti6 = (struct in6_pktinfo *)CMSG_DATA(cmsg);
-            from->pi.in6.ipi6_ifindex = pkti6->ipi6_ifindex;
+            from->pi.in6.ipi6_ifindex =
+                (sock->sockflags & SF_PKTINFO_COPY_IIF) ? pkti6->ipi6_ifindex : 0;
             from->pi.in6.ipi6_addr = pkti6->ipi6_addr;
         }
         else if (cmsg != NULL)
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 832d62e..7cf5b72 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -195,6 +195,7 @@
 #define SF_GETADDRINFO_DGRAM (1 << 4)
 #define SF_DCO_WIN           (1 << 5)
 #define SF_PREPEND_SA        (1 << 6)
+#define SF_PKTINFO_COPY_IIF  (1 << 7)
     unsigned int sockflags;
     int mark;
     const char *bind_dev;

