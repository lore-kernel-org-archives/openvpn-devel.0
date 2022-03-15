From: David Sommerseth <openvpn@...2080...>
Date: Tue, 15 Mar 2022 16:53:41 +0100
Message-Id: <20220315155344.37787-1-openvpn@...2080...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2.4 v5 0/3] Disable multiple deferred
 authentication plug-ins
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

From: David Sommerseth <davids@...515...>

This is the same patch set as the v4 [1] patch set, just without the
embarrassing syntax error in the second patch.

[1] <https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23935.html>
    Message-Id: 20220313200715.13518-1-openvpn@...2080...

David Sommerseth (3):
  sample-plugin: New plugin for testing multiple auth plugins
  plug-ins: Disallow multiple deferred authentication plug-ins
  plug-ins: Remove defer/simple.c sample plugin

 doc/openvpn.8                            |  13 +
 doc/tests/authentication-plugins.md      | 153 +++++++
 sample/sample-plugins/defer/README       |   9 +-
 sample/sample-plugins/defer/multi-auth.c | 413 +++++++++++++++++
 sample/sample-plugins/defer/simple.c     | 541 -----------------------
 sample/sample-plugins/defer/simple.def   |   6 -
 src/openvpn/plugin.c                     |  33 +-
 7 files changed, 616 insertions(+), 552 deletions(-)
 create mode 100644 doc/tests/authentication-plugins.md
 create mode 100644 sample/sample-plugins/defer/multi-auth.c
 delete mode 100644 sample/sample-plugins/defer/simple.c
 delete mode 100755 sample/sample-plugins/defer/simple.def

-- 
2.27.0


