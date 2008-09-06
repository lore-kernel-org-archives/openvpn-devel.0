Message-ID: <48C2056D.2090600@...1123...>
Date: Sat, 06 Sep 2008 06:22:05 +0200
From: Peter Rabbitson <rabbit+list@...1123...>
MIME-Version: 1.0
References: <48AC1C11.60107@...1123...> <48ADA320.9090708@...41...>
	<48ADA8AA.4040704@...1123...> <48C04733.4080108@...41...>
In-Reply-To: <48C04733.4080108@...41...>
Subject: Re: [Openvpn-devel] Followup to CVE-2008-3459 fix
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: James Yonan <jim@...41...>
Cc: Openvpn-devel@lists.sourceforge.net

James Yonan wrote:
> 
> 
> Peter Rabbitson wrote:
>> James Yonan wrote:
>>> Peter Rabbitson wrote:
>>
>>>> Eventually the best way to deal with this is to test for
>>>> ip_addr_dotted_quad_safe and is_special_addr, and then attempt a dns
>>>> lookup on the string supplied for route. If anything comes back - use
>>>> the result as the routed IPs. Otherwise warn and carry on. This would
>>>> also fix this long-outstanding (not mine) wishlist:
>>>> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=237251
>>> I agree that this should be fixed, probably via a --route-fqdn-pull
>>> option (as suggested) on the client to permit DNS lookups on option
>>> parameters that previously allowed them.
>>>
>>
>> I think if you go with my second suggestion (above) the option becomes
>> redundant. You can attempt a DNS lookup with pretty much anything (as
>> far as string goes), and if nothing comes back - well nothing comes back.
>>
>> In any case, I'm glad this didn't fall off the radar.
>>
>> Thank you for the excellent software!
> 
> This fix has been committed and will be released in 2.1-rc10.
> 
> ------------------------------------------------------------------------
> r3307 | james | 2008-09-04 14:35:09 -0600 (Thu, 04 Sep 2008) | 7 lines
> Changed paths:
>    M /branches/BETA21/openvpn/openvpn.8
>    M /branches/BETA21/openvpn/options.c
>    M /branches/BETA21/openvpn/options.h
>    M /branches/BETA21/openvpn/socket.c
>    M /branches/BETA21/openvpn/socket.h
> 
> Added --allow-pull-fqdn option which allows client to pull DNS names
> from server (rather than only IP address) for --ifconfig, --route, and
> --route-gateway.  OpenVPN versions 2.1_rc7 and earlier allowed DNS names
> for these options to be pulled and translated to IP addresses by
> default. Now --allow-pull-fqdn will be explicitly required on the client
> to enable DNS-name to IP-address translation of pulled options.
> 
> ------------------------------------------------------------------------
> 
> James

Excellent!

May I be a total pain in the ass and point out the following:
* you validate the passed string with CC_NAME|CC_DASH|CC_DOT
* which after aliasing comes back as (perl re) /[A-Za-z0-9\_\-\.]/
* while http://tools.ietf.org/html/rfc3696#section-2 insists on LHR
(i.e. no underscore)

Also it doesn't seem that you are checking the length of the string
passed in, whereas FQDNs are generally limited to 255 bytes.

Other than that - excellent patch, exactly what the doctor ordered.
Thank you!

