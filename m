Message-ID: <42253BF4.1050000@...355...>
From: TomWalsh <tomw-junk01@...355...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] RPM build of 2.0-rc16 fails on MandrakeSoft
References: <4220EC61.1000005@...355...> <Pine.LNX.4.58.0502270152590.23437@...41...> <42220B98.2010001@...355...> <42223300.1050402@...355...> <Pine.LNX.4.58.0502271404010.23437@...41...>
In-Reply-To: <Pine.LNX.4.58.0502271404010.23437@...41...>
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
Date: Tue Mar  1 20:09:45 2005
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: James Yonan <jim@...41...>
Cc: openvpn-devel@lists.sourceforge.net

James Yonan wrote:
>>I will let the package maintainer of liblzo1 of the problem of it not 
>>saying it provides "liblzo" while the liblzo1-devel does say that.
>>
>>The correct statement which works around the Mandrake 10.1 problem would be:
>>
>>============================ fix ===============================
>>%if "%{_vendor}" == "MandrakeSoft"
>>%{!?without_lzo:BuildRequires: liblzo1-devel >= 1.07}
>>%{!?without_lzo:Requires:      liblzo1       >= 1.07}
>>%else
>>%{!?without_lzo:BuildRequires: lzo-devel >= 1.07}
>>%{!?without_lzo:Requires:      lzo       >= 1.07}
>>%endif
>>============================ snip ==============================
>>
>>Either way, there would still be an issue with Mandrake as I see that 
>>the lzo package of SuSE 9.1 provides "lzo" not "liblzo".
> 
> 
> The problem I have with this patch is that it assumes that Mandrake will
> continue to follow the broken behavior.  The ideal solution would be one
> which doesn't break when Mandrake gets around to using the same standard
> LZO RPM spec which everyone else is using.
> 

Yeah, probably the best solution. However, I see that they have been 
calling it liblzo1 since their 8.1 distro, and, technically, it is a 
library?

The package maintainer has added the missing provide for "liblzo", this 
is now in liblzo1-devel-1.08-5mdk.i586.rpm and the 
liblzo1-1.08-5mdk.i586.rpm.  That would at least clear up some confusion 
between liblzo1 vs. liblzo

TomW

-- 
Tom Walsh - WN3L - Embedded Systems Consultant
email at http://openhardware.net?file=emailcomment.php
any ReplyTo direct email will disappear (blackhole).
----------------------------------------------------


