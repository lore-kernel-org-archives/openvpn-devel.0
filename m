Message-ID: <50C12AFA.7020103@...1785...>
Date: Fri, 07 Dec 2012 00:32:10 +0100
From: David TAILLANDIER <david.taillandier@...1785...>
MIME-Version: 1.0
Subject: [Openvpn-devel] bug with "ip-win32 netsh"
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
To: openvpn-devel@lists.sourceforge.net


Windows 7 64bit      OpenVPN 2.3_rc1 x86_64-w64-mingw32


If the client configuration file contains "ip-win32 netsh", OpenVPN 
issue the following system command :
c:\windows\system32\netsh.exe interface ip set address Local Area 
Connection 2 static 10.8.0.6 255.255.255.252

The command fails when the interface name contains spaces, so it must be 
surrounded by double-quotes : "Local Area Connection 2"


Workaround : rename the interface to something without spaces.

