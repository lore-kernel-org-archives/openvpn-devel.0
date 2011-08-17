From: Heiko Hund <heiko.hund@...1489...>
Date: Wed, 17 Aug 2011 13:42:46 +0000
Message-Id: <1313588569-18927-1-git-send-email-heiko.hund@...1489...>
Subject: [Openvpn-devel] [PATCH 0/3] better --auto-proxy support for Windows
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

Hi,

the auto-proxy support for Windows was rather sub-optimal. Since Internet
Explorer 5 proxy settings were configured with the network or VPN connection,
but OpenVPN always queried the settings for the LAN connection. Truely automatic
proxy configuration via WPAD and PAC script was not used, either.

This patch series tries to change that. Auto proxy detetction is done with
WinHTTP which has support for WPAD, PAC and per connection proxy settings.

Another thing that is changed is the time at which the auto proxy config
takes place in OpenVPN. Instead of doing it once during start-up, potentially
changed settings are now fetched once every connect.

Heiko Hund (3):
  add MinGW WinHTTP compatibility layer
  do automatic proxy detection on Windows right
  query auto-proxy information when connecting

 configure.ac |   30 ++++++++++
 init.c       |   23 ++++++-
 openvpn.8    |    9 ++-
 options.c    |   15 ++---
 options.h    |    2 +-
 proxy.c      |  173 +++++++++++++++++++++++++++++++++-------------------------
 proxy.h      |    4 +-
 win32.c      |  108 ++++++++++++++++++++++++++++++++++++
 win32.h      |   61 ++++++++++++++++++++
 9 files changed, 330 insertions(+), 95 deletions(-)

Regards
Heiko
-- 
1.7.5.4


