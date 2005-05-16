From: Melis van Deelen <deelen@...400...>
Message-ID: <d6aqhm$r3o$1@...165...>
Mime-Version: 1.0
Subject: [Openvpn-devel] Solution for "non-administrator on Windows" ?
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
Date: Mon May 16 12:36:03 2005
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hello,

My OpenVPN connection on Windows works perfect if it is started by an 
administrator or system (=service) user. When i try to start the program 
by a non-administrator is gives the error:

CreateFile failed on TAP device: 
\\.\Global\{5B277664-435A-420B-97A3-454BC5A65CB0}.tap

This i a know problem. See 
http://openvpn.net/archive/openvpn-users/2004-07/msg00484.html

Unfortunately this this is a big problem for the "road warrior vpn" 
solution we try to implement. We cannot give the road warrior 
administrator access, and don't want to use services because passwords 
must be entered.

I did a intensive search to try to solve the problem. As James Yonan 
already found out, this not easy. Then I found a possible solution in a 
post of 25-12-2002 microsoft.public.windowsxp.winlogo of "WHQL, NDIS, 
and IoCreateDeviceSecure and Security (DACL)":

Try zero access mask, when you call CreateFile. For FILE_ACCESS_ANY 
IOCTL, you don't need neither GENERIC_READ nor GENERIC_WRITE access 
mask. You can also try MAXIMUM_ALLOWED access mask.

I did some testing with MAXIMUM_ALLOWED and i think it can solve the 
CreateFile error problem.

I suggest tying replace GENERIC_READ | GENERIC_WRITE in tun.c by 
MAXIMUM_ALLOWED to solve the non-administrator connection on Windows

Regards,

Melis van Deelen
http://www.bioscrm.com


