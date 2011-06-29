From: samuli@...515...
Date: Wed, 29 Jun 2011 11:24:06 +0300
Message-Id: <1309335848-14414-1-git-send-email-samuli@...515...>
In-Reply-To: <1308302282-27985-1-git-send-email-samuli@...515...>
References: <1308302282-27985-1-git-send-email-samuli@...515...>
Subject: [Openvpn-devel] Fixes to Trac ticket #125
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

These patches fix remaining outstanding easy-rsa issues. The first patch fixes 
Trac ticket #125 and the second patch fixes a regression caused by the first one 
in domake-win / MinGW builds.

These patches do not address the issue that domake-win build system is somewhat 
outdated and won't work without several undocumented manual steps.


