From: Alberto Gonzalez Iniesta <agi@...64...>
Message-ID: <20041017102652.GC1621@...30...>
Mime-Version: 1.0
Subject: [Openvpn-devel] OpenVPN 2.0 and udev
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
Date: Sun Oct 17 03:26:03 2004
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: OpenVPN devel <openvpn-devel@lists.sourceforge.net>

Hi all,

After I decided to push OpenVPN 2.0 into Debian for future inclusion in
Sarge, I got this [1] bug report from one Debian user. It seems that 2.0
doesn't get along well with udev, as opposed to 1.6. I don't use udev,
so I can't really tell, but has anything changed from 1.6 to 2.0 in the
way the device is handled?

The suspicious message is:

Oct 16 16:31:12 gimli wait_for_sysfs[5873]: error: wait_for_sysfs needs an update to handle the device '/class/net/tun0' properly, please report to <linux-hotplug-devel@lists.sourceforge.net>

The bug submitter claims that OpenVPN 1.6 deals correctly with it. Maybe
it has something to do with device probing?

Thanks,

Alberto

[1] http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=276799


P.S. James, did you find out anything about this [2]? Do you think it
could be due to hardware (RAM) problem? I'm thinking about tagging it
irreproducible.

[2] http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=265632

-- 
Alberto Gonzalez Iniesta    | BOFH excuse #175:
agi@(inittab.org|debian.org)| OS swapped to disk
Encrypted mail preferred    | 

Key fingerprint = 9782 04E7 2B75 405C F5E9  0C81 C514 AF8E 4BA4 01C3

