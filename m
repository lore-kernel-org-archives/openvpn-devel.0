From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] Solution for "non-administrator on Windows" ?
In-Reply-To: <d6aqhm$r3o$1@...165...>
Message-ID: <Pine.LNX.4.58.0505162300230.2777@...41...>
References: <d6aqhm$r3o$1@...165...>
MIME-Version: 1.0
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
Date: Mon May 16 22:12:09 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Melis van Deelen <deelen@...400...>
Cc: openvpn-devel@lists.sourceforge.net

On Mon, 16 May 2005, Melis van Deelen wrote:

> Hello,
> 
> My OpenVPN connection on Windows works perfect if it is started by an 
> administrator or system (=service) user. When i try to start the program 
> by a non-administrator is gives the error:
> 
> CreateFile failed on TAP device: 
> \\.\Global\{5B277664-435A-420B-97A3-454BC5A65CB0}.tap
> 
> This i a know problem. See 
> http://openvpn.net/archive/openvpn-users/2004-07/msg00484.html
> 
> Unfortunately this this is a big problem for the "road warrior vpn" 
> solution we try to implement. We cannot give the road warrior 
> administrator access, and don't want to use services because passwords 
> must be entered.
> 
> I did a intensive search to try to solve the problem. As James Yonan 
> already found out, this not easy. Then I found a possible solution in a 
> post of 25-12-2002 microsoft.public.windowsxp.winlogo of "WHQL, NDIS, 
> and IoCreateDeviceSecure and Security (DACL)":

NDIS miniport drivers are not supposed to use IoCreateDeviceSecure, and 
won't pass WHQL certification if they do.  Microsoft wants you to use 
NdisMRegisterDevice instead which doesn't have a DACL argument.

> Try zero access mask, when you call CreateFile. For FILE_ACCESS_ANY 
> IOCTL, you don't need neither GENERIC_READ nor GENERIC_WRITE access 
> mask. You can also try MAXIMUM_ALLOWED access mask.
> 
> I did some testing with MAXIMUM_ALLOWED and i think it can solve the 
> CreateFile error problem.
> 
> I suggest tying replace GENERIC_READ | GENERIC_WRITE in tun.c by 
> MAXIMUM_ALLOWED to solve the non-administrator connection on Windows

Even if you could get around the non-admin userspace <-> kernel space
communication issues, what about routing table modifications.  OpenVPN
clients must have sufficient privilege to add and remove routes.  This
requires admin privileges.

James


