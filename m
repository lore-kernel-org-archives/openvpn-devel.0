From: Alberto Gonzalez Iniesta <agi@...5...>
Message-ID: <20040528142953.GG1243@...30...>
Mime-Version: 1.0
Subject: [Openvpn-devel] route option deleting routes it didn't set
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Fri May 28 07:30:07 2004
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: OpenVPN devel <openvpn-devel@lists.sourceforge.net>

Hi,

We got a bug report at Debian [1] regarding the route option.
It turns out that if a route added by openvpn is later
modified (removed and added to other iface), openvpn will modify
(delete) the later one.

As the bug submitter states, maybe openvpn should specify the device it
wants the route deleted from.


[1] http://bugs.debian.org/251304

-- 
Alberto Gonzalez Iniesta   | BOFH excuse #263:
agi@(agi.as|debian.org)    | It's stuck in the Web.
Encrypted mail preferred   | 

Key fingerprint = 9782 04E7 2B75 405C F5E9  0C81 C514 AF8E 4BA4 01C3

