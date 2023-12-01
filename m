From: Frank Lichtenheld <frank@...2641...>
Date: Fri,  1 Dec 2023 12:20:22 +0100
Message-Id: <20231201112022.15337-1-frank@...2641...>
In-Reply-To: <gerrit.1699291967000.Iede3e7c028cbb715e28bc88c7e583f84dadc02c8@...2715...>
References: <gerrit.1699291967000.Iede3e7c028cbb715e28bc88c7e583f84dadc02c8@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Change default of "topology" to "subnet"
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
Cc: Arne Schwabe <arne-openvpn@...1227...>

Change-Id: Iede3e7c028cbb715e28bc88c7e583f84dadc02c8
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/421
This mail reflects revision 2 of this Change.
Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/Changes.rst b/Changes.rst
index 3676dce..3132c84 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -10,6 +10,15 @@
     ``--allow-deprecated-insecure-static-crypto`` but will be removed in
     OpenVPN 2.8.
 
+Default for ``--topology`` changed to ``subnet``
+    Previous releases used ``net30`` as default. This only affects
+    configs with ``--dev tun`` and only IPv4. Note that this
+    changes the semantics of ``--ifconfig``, so if you have manual
+    settings for that in your config but not set ``--topology``
+    your config might fail to parse with the new version. Just adding
+    ``--topology net30`` to the config should fix the problem.
+    By default ``--topology`` is pushed from server to client.
+
 Overview of changes in 2.6
 ==========================
 
diff --git a/doc/man-sections/vpn-network-options.rst b/doc/man-sections/vpn-network-options.rst
index 3fa3ccf..251529f 100644
--- a/doc/man-sections/vpn-network-options.rst
+++ b/doc/man-sections/vpn-network-options.rst
@@ -495,11 +495,17 @@
 
   ``mode`` can be one of:
 
+  :code:`subnet`
+    Use a subnet rather than a point-to-point topology by
+    configuring the tun interface with a local IP address and subnet mask,
+    similar to the topology used in ``--dev tap`` and ethernet bridging
+    mode. This mode allocates a single IP address per connecting client and
+    works on Windows as well. This is the default.
+
   :code:`net30`
     Use a point-to-point topology, by allocating one /30 subnet
     per client. This is designed to allow point-to-point semantics when some
-    or all of the connecting clients might be Windows systems. This is the
-    default.
+    or all of the connecting clients might be Windows systems.
 
   :code:`p2p`
     Use a point-to-point topology where the remote endpoint of
@@ -508,15 +514,8 @@
     connecting client. Only use when none of the connecting clients are
     Windows systems.
 
-  :code:`subnet`
-    Use a subnet rather than a point-to-point topology by
-    configuring the tun interface with a local IP address and subnet mask,
-    similar to the topology used in ``--dev tap`` and ethernet bridging
-    mode. This mode allocates a single IP address per connecting client and
-    works on Windows as well.
-
   *Note:* Using ``--topology subnet`` changes the interpretation of the
-  arguments of ``--ifconfig`` to mean "address netmask", no longer "local
+  arguments of ``--ifconfig`` to mean "address netmask", and not "local
   remote".
 
 --tun-mtu args
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index d238269..764ca7b 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -800,7 +800,7 @@
         o->gc_owned = true;
     }
     o->mode = MODE_POINT_TO_POINT;
-    o->topology = TOP_NET30;
+    o->topology = TOP_SUBNET;
     o->ce.proto = PROTO_UDP;
     o->ce.af = AF_UNSPEC;
     o->ce.bind_ipv6_only = false;

