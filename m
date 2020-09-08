From: Gert Doering <gert@...1296...>
Date: Tue,  8 Sep 2020 13:15:11 +0200
Message-Id: <20200908111511.9271-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Document that --push-remove is generally
 more suitable than --push-reset
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

It's a long-standing and well-known problem that --push-reset removes
"critical" options from the push list (like "topology subnet") which
will then lead to non-working client configs.  This can not be
reasonably fixed, because the list of "critical" options depends on
overall server config.

So just document the fact, and point people towards --push-remove as
a more selective tool.

Trac: #29

Signed-off-by: Gert Doering <gert@...1296...>
---
 doc/man-sections/server-options.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/doc/man-sections/server-options.rst b/doc/man-sections/server-options.rst
index f1f0667a..2009953c 100644
--- a/doc/man-sections/server-options.rst
+++ b/doc/man-sections/server-options.rst
@@ -530,6 +530,14 @@ fast hardware. SSL/TLS authentication must be used in this mode.
   ``--client-config-dir`` configuration file. This option will ignore
   ``--push`` options at the global config file level.
 
+  *NOTE*: ``--push-reset`` is very thorough: it will remove almost
+  all options from the list of to-be-pushed options.  In many cases,
+  some of these options will need to be re-configured afterwards -
+  specifically, ``--topology subnet`` and ``--route-gateway`` will get
+  lost and this will break client configs in many cases.  Thus, for most
+  purposes, ``--push-remove`` is better suited to selectively remove
+  push options for individual clients.
+
 --server args
   A helper directive designed to simplify the configuration of OpenVPN's
   server mode. This directive will set up an OpenVPN server which will
-- 
2.26.2


