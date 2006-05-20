Message-ID: <446F6BDC.1040704@...640...>
From: Stephen Borrill <netbsd@...640...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] port-share and portability
References: <446A021A.4090601@...640...> <446F4063.9090303@...41...>
In-Reply-To: <446F4063.9090303@...41...>
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
Date: Sat May 20 12:20:02 2006
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: James Yonan <jim@...41...>
Cc: openvpn-devel@lists.sourceforge.net

James Yonan wrote:
> Stephen Borrill wrote:
> 
>> Hi,
>>
>> I've been looking at the 2.1 betas and getting excited about the 
>> port-share option. There's numerous caveats about lack of portability 
>> in the source and man page, but I don't know why. sendmsg and recvfrom 
>> have been in BSD since, well, ever, really. NetBSD and FreeBSD have 
>> both had MSG_NOSIGNAL support added (NetBSD very recently in response 
>> to my feedback about OpenVPN), so the only outstanding issue is the 
>> union fdmsg declarationon row 80 of ps.c. On NetBSD (at least) 
>> CMSG_SPACE() isn't static and so can't used in a compile-time context 
>> (it calls a function for CMSG_ALIGN()). Can this be worked around in 
>> OpenVPN to improve portability? Perhaps a static and malloc in the 
>> relevant places in port_share_sendmsg() and 
>> control_message_from_parent()? I guess they don't need to be re-rentrant.
>>
> Feel free to port this to BSD.  Basically the only aspect of the 
> port-share implementation which is problematic from a portability 
> perspective is that it needs the ability to pass an open file descriptor 
> to another process.

That doesn't seem to be a problem at all. The code just works once compiled, 
but required me to manually expand the CMSG_SPACE macro based on the Linux 
version. This is not particular portable as it's dependent upon the unit of 
alignment being the same as long; I suspect this isn't necessary the case 
for all processor architectures. It's just the allocation of the union fdmsg 
that's the problem. I guess you have a preferred memory allocation method 
which could be used to allocate a buffer held in a static in the above 
functions. I could bodge something up, but you'd probably have a 
preferential way to do it.

-- 
Stephen



