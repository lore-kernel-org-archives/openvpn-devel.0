From: Gert Doering <gert@...1296...>
Date: Mon, 24 Mar 2025 14:54:33 +0100
Message-ID: <20250324135441.26725-1-gert@...1296...>
In-Reply-To: <gerrit.1742821192000.Ifc7443974345042ab9945d6a10e1d1b4525e5e05@...2715...>
References: <gerrit.1742821192000.Ifc7443974345042ab9945d6a10e1d1b4525e5e05@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Improve documentation for
 override-username
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

- Mention that pushing auth-token-user only happens when OpenVPN also
  generates the auth-token.
- mention that OpenVPN will only accept the original and overridden username
  from a client
- suggest to use auth-token-user when a user generates the auth-token

Change-Id: Ifc7443974345042ab9945d6a10e1d1b4525e5e05
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/914
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/doc/man-sections/server-options.rst b/doc/man-sections/server-options.rst
index e93b04d..ccc1374 100644
--- a/doc/man-sections/server-options.rst
+++ b/doc/man-sections/server-options.rst
@@ -432,7 +432,12 @@
 
   The changed username will be picked up by the status output and also by
   the ``--auth-gen-token`` option. It will also be pushed to the client
-  using ``--auth-token-user``.
+  using ``--auth-token-user`` if ``--auth-gen-token`` is enabled.
+
+  Internally on all subsequent renegotiations the client provided username
+  will be replaced by the username provided by ``--override-username``.
+  If the client changes to a username that is different from both the initial
+  and the overridden username, the client will be rejected.
 
   Special care should be taken that both the initial username of the client
   and the overridden username are handled correctly when using
@@ -444,6 +449,10 @@
   can be used for ``--auth-gen-token`` to allow providing a username in
   these scenarios.
 
+  If the ``--auth-token`` directive is pushed by another script/plugin or
+  management interface, consider also generating and pushing
+  ``--auth-token-user``.
+
 --port-share args
   Share OpenVPN TCP with another service
 

