From: Christian Hesse <list@...1798...>
Date: Sun,  1 Apr 2018 21:13:09 +0200
Message-Id: <20180401191309.32211-4-list@...1798...>
In-Reply-To: <20180401191309.32211-1-list@...1798...>
References: <20180401191309.32211-1-list@...1798...>
Subject: [Openvpn-devel] [RFC 3/3] systemd: create configuration directories
 from tmpfiles
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
To: OpenVPN Development <openvpn-devel@lists.sourceforge.net>
Cc: Christian Hesse <mail@...1798...>

From: Christian Hesse <mail@...1798...>

We have a dedicated user created by systemd-sysusers, so create
configuration directories from systemd-tmpfiles for proper permissions.
This mitigates a race condition at packaging/install time.

Signed-off-by: Christian Hesse <mail@...1798...>
---
 distro/systemd/tmpfiles-openvpn.conf | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/distro/systemd/tmpfiles-openvpn.conf b/distro/systemd/tmpfiles-openvpn.conf
index 835dc1c8..0f96baa5 100644
--- a/distro/systemd/tmpfiles-openvpn.conf
+++ b/distro/systemd/tmpfiles-openvpn.conf
@@ -1,2 +1,4 @@
 d /run/openvpn-client 0750 openvpn openvpn -
 d /run/openvpn-server 0750 openvpn openvpn -
+d /etc/openvpn/client 0750 openvpn openvpn -
+d /etc/openvpn/server 0750 openvpn openvpn -

