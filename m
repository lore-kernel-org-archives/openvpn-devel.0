Message-ID: <1116277919.42890c9fe2971@...256...>
From: Didier Conchaudron <didier@...255...>
Subject: Re: [Openvpn-devel] Solution for "non-administrator on Windows" ?
References: <d6aqhm$r3o$1@...165...>
In-Reply-To: <d6aqhm$r3o$1@...165...>
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
Date: Mon May 16 18:21:10 2005
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
To: Melis van Deelen <deelen@...400...>
Cc: openvpn-devel@lists.sourceforge.net

Dear Melis,

It's been quite some time since I'vent said that one more time but I was working
 on a patch for the win32 service wrapper that allow to start the openvpn
service via a telnet like interface.

The patch for the service wrapper is still on
http://conchaudron.free.fr/contrib/openvpn/ but it's been a long since I'vent
update it, maybe it's just deprecated considering the new features included
into the actual openvpn service wrapper.

Btw, the aim of thi spatch is to allow a non admin user to order the service
wrapper to start an openvpn tunnel. On last July, Mathias Sundman, who's
working on the famous win32 openvpn-gui, plan to integrate these new features
after openvpn 2.0. The time has probably come to work again on this couple
SW-GUI.

Regards,

Didier

ps: for every good coders, the code I've done is probably bad, feel free to
spend some time to help me improve it ;-)

Selon Melis van Deelen <deelen@...400...>:

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
>
> Try zero access mask, when you call CreateFile. For FILE_ACCESS_ANY
> IOCTL, you don't need neither GENERIC_READ nor GENERIC_WRITE access
> mask. You can also try MAXIMUM_ALLOWED access mask.
>
> I did some testing with MAXIMUM_ALLOWED and i think it can solve the
> CreateFile error problem.
>
> I suggest tying replace GENERIC_READ | GENERIC_WRITE in tun.c by
> MAXIMUM_ALLOWED to solve the non-administrator connection on Windows
>
> Regards,
>
> Melis van Deelen
> http://www.bioscrm.com
>
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by Oracle Space Sweepstakes
> Want to be the first software developer in space?
> Enter now for the Oracle Space Sweepstakes!
> http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>



