Message-ID: <4CF7B2FA.9090105@...1147...>
Date: Thu, 02 Dec 2010 15:53:46 +0100
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
Subject: [Openvpn-devel] script-security 1
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
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, OpenVPN Users <openvpn-users@lists.sourceforge.net>

hi all,

the openvpn 2.1 man page on script-security reads:

--script-security level [method]
    This directive offers policy-level control over OpenVPN's usage of 
external programs and scripts. Lower level values are more restrictive, 
higher values are more permissive. Settings for level:

    0 -- Strictly no calling of external programs.
    1 -- (Default) Only call built-in executables such as ifconfig, ip, 
route, or netsh.
    2 -- Allow calling of built-in executables and user-defined scripts.
    3 -- Allow passwords to be passed to scripts via environmental 
variables (potentially unsafe).

but if I try something like
 openvpn --config <serverconf> --script-security 1 --up "/sbin/ip addr 
show eth0"
I still get

Thu Dec  2 15:52:51 2010 /sbin/ip addr show eth0 tun0 1500 1541 
192.168.200.1 255.255.255.0 init
Thu Dec  2 15:52:51 2010 openvpn_execve: external program may not be 
called unless '--script-security 2' or higher is enabled.  Use 
'--script-security 3 system' for backward compatibility with 2.1_rc8 and 
earlier.  See --help text or man page for detailed info.
Thu Dec  2 15:52:51 2010 script failed: external program fork failed
Thu Dec  2 15:52:51 2010 Exiting

what _IS_ the list of built-in executables? I cannot find it in the 
source code either.

cheers,

JJK


