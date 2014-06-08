From: Steffan Karger <steffan@...1856...>
Date: Sun,  8 Jun 2014 18:16:11 +0200
Message-Id: <1402244175-31462-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Fix remaining issues with OFB/CFB cipher
	modes
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

OFB and CFB cipher modes have been broken for a long time, see trac ticket #89
(https://community.openvpn.net/openvpn/ticket/89). Commit be46a2c enables
support for OFB and CFB again, but leaves some minor problems around. The
following patches resolve the remaining issues.

Patches 1-3 fix some minor issues I encountered while testing OFB/CFB.

Patch 4 extends the t_lpback tests to prevent further regression.

-Steffan


