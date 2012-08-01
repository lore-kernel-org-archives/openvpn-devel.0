From: Heiko Hund <heiko.hund@...1489...>
Date: Wed, 1 Aug 2012 13:37:36 +0200
Message-ID: <1343821058-11456-1-git-send-email-heiko.hund@...1489...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 0/2] Add logging API for plug-ins
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

After some discussion on IRC, here's the mini patch series for adding a
logging API for plug-ins.

Changes from the previous patch:

  * split the changes to error.[ch] into separate patch
  * add a mandatory prefix "PLUGIN <name>: " to each log line
  * never log the instance prefix as it's not thread safe to do so
  * fixed comment for plugin_log() in header file

Heiko Hund (2):
  add x_msg_va() log function
  add plugin_log() API to write to openvpn log

 include/openvpn-plugin.h |   23 +++++++++++++++++++++
 src/openvpn/error.c      |   11 +++++++---
 src/openvpn/error.h      |    2 ++
 src/openvpn/plugin.c     |   51 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 84 insertions(+), 3 deletions(-)

-- 
1.7.9.5


