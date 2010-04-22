Message-ID: <4BD05146.3080504@...41...>
Date: Thu, 22 Apr 2010 07:38:14 -0600
From: James Yonan <jim@...41...>
MIME-Version: 1.0
Subject: [Openvpn-devel] ESET Smart Security interferes with TAP driver
	install
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: OpenVpn-Users <openvpn-users@lists.sourceforge.net>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

I've observed a case on Windows Server 2008R2 where an antivirus product 
called ESET Smart Security prevents install of the TAP driver.

The net effect in tapinstall (devcon) is that 
UpdateDriverForPlugAndPlayDevices returns error code 1450 
(ERROR_NO_SYSTEM_RESOURCES).

Apparently ESET interferes with other VPN clients as well:

http://social.technet.microsoft.com/Forums/en/w7itpronetworking/thread/f92abbdf-a340-4629-a46c-f186f7c82340

James

