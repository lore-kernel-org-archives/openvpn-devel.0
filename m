From: Gert Doering <gert@...1296...>
Date: Mon, 24 Mar 2025 19:27:26 +0100
Message-ID: <20250324182735.12657-1-gert@...1296...>
In-Reply-To: <gerrit.1742829972000.I1976307a7643c82f31d55ca32c79cbe64b6fffc6@...2715...>
References: <gerrit.1742829972000.I1976307a7643c82f31d55ca32c79cbe64b6fffc6@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Make 'lport 0' no longer sufficient to
 do '--bind'.
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

'lport <anything>' used to trigger 'do socket bind', which is not
useful in itself for the 'lport 0' case (port 0 -> OS assigns a
random port, as it is done for unbound sockets) unless also binding
to a particular local IP address ('--local 192.0.2.1').

The trigger for 'lport has been used, do socket bind' is
ce.local_port_defined -> change the code to test for "0", and
only set this for non-0 ports (NOTE: this is a string match,
so if you really really want the old "lport 0" behaviour, using
"lport 00" still does that...).

The ce.local_port value is still set, so '--lport 0' together
with '--local 192.0.2.1' will give you a random port number
bound to that IP address - without 'lport 0' it would default
to 1194 or the value of '--port' (if not using '--rport').

Summary:  socket bind is now only done if one of these is set
  - --port <port> with <port> not "0"
  - --bind  (default on the client is "--nobind")
  - --local <address>

Change-Id: I1976307a7643c82f31d55ca32c79cbe64b6fffc6
Signed-off-by: Gert Doering <gert@...1296...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/916
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/doc/man-sections/link-options.rst b/doc/man-sections/link-options.rst
index d48021e..287473e 100644
--- a/doc/man-sections/link-options.rst
+++ b/doc/man-sections/link-options.rst
@@ -122,7 +122,9 @@
 
 --lport port
   Set default TCP/UDP port number. Cannot be used together with
-  ``--nobind`` option.
+  ``--nobind`` option.  A port number of ``0`` is only honoured to
+  achieve "bind() to a random assigned port number" if a bind-to IP
+  address is specified with ``--local``.
 
 --mark value
   Mark encrypted packets being sent with ``value``. The mark value can be
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index ab56609..99dd60a 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -6710,7 +6710,12 @@
     else if (streq(p[0], "lport") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_CONNECTION);
-        options->ce.local_port_defined = true;
+
+        /* only trigger bind() if port is not 0 (or --local is used) */
+        if (!streq(p[1], "0"))
+        {
+            options->ce.local_port_defined = true;
+        }
         options->ce.local_port = p[1];
     }
     else if (streq(p[0], "rport") && p[1] && !p[2])

