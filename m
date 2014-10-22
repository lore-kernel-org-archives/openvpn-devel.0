From: samuli@...515...
Date: Wed, 22 Oct 2014 10:07:38 +0300
Message-Id: <1413961660-19251-1-git-send-email-samuli@...515...>
Subject: [Openvpn-devel] [PATCH 0/2] tap-windows6 interoperability patches
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

These patches fix serious interoperability issues with tap-windows6. Backported
versions of these patches were tested with OpenVPN 2.3.4 because openvpn-build
is currently unable to build from Git "master".

[PATCH 1/2] Modification to address bug where OpenVPN enters state
[PATCH 2/2] Revised fix for code=995 sped bug.


