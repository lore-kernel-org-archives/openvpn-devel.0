Message-ID: <42312881.7080401@...355...>
From: TomWalsh <tomw-junk01@...355...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] RPM build of 2.0-rc16 fails on MandrakeSoft
References: <4220EC61.1000005@...355...> <Pine.LNX.4.58.0502270152590.23437@...41...> <42220B98.2010001@...355...> <42223300.1050402@...355...> <Pine.LNX.4.58.0502271404010.23437@...41...> <42253BF4.1050000@...355...> <Pine.LNX.4.58.0503071446420.1122@...41...> <423074F9.3010107@...355...> <Pine.LNX.4.58.0503101852000.2608@...41...>
In-Reply-To: <Pine.LNX.4.58.0503101852000.2608@...41...>
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
Date: Thu Mar 10 21:12:14 2005
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: James Yonan <jim@...41...>
Cc: openvpn-devel@lists.sourceforge.net

James Yonan wrote:
> On Thu, 10 Mar 2005, TomWalsh wrote:
> 
> 
>>James Yonan wrote:
>>
>>>On Tue, 1 Mar 2005, TomWalsh wrote:
>>>
>>>
>>>
>>>>James Yonan wrote:
>>>>
>>>>
>>>>>>I will let the package maintainer of liblzo1 of the problem of it not 
>>>>>>saying it provides "liblzo" while the liblzo1-devel does say that.
>>>>>>
>>>>>>The correct statement which works around the Mandrake 10.1 problem would be:
>>>>>>
>>>>>>============================ fix ===============================
>>>>>>%if "%{_vendor}" == "MandrakeSoft"
>>>>>>%{!?without_lzo:BuildRequires: liblzo1-devel >= 1.07}
>>>>>>%{!?without_lzo:Requires:      liblzo1       >= 1.07}
>>>>>>%else
>>>>>>%{!?without_lzo:BuildRequires: lzo-devel >= 1.07}
>>>>>>%{!?without_lzo:Requires:      lzo       >= 1.07}
>>>>>>%endif
>>>>>>============================ snip ==============================
>>>>>>
>>>>>>Either way, there would still be an issue with Mandrake as I see that 
>>>>>>the lzo package of SuSE 9.1 provides "lzo" not "liblzo".
>>>>>
>>>>>
>>>>>The problem I have with this patch is that it assumes that Mandrake will
>>>>>continue to follow the broken behavior.  The ideal solution would be one
>>>>>which doesn't break when Mandrake gets around to using the same standard
>>>>>LZO RPM spec which everyone else is using.
>>>>>
>>>>
>>>>Yeah, probably the best solution. However, I see that they have been 
>>>>calling it liblzo1 since their 8.1 distro, and, technically, it is a 
>>>>library?
>>>>
>>>>The package maintainer has added the missing provide for "liblzo", this 
>>>>is now in liblzo1-devel-1.08-5mdk.i586.rpm and the 
>>>>liblzo1-1.08-5mdk.i586.rpm.  That would at least clear up some confusion 
>>>>between liblzo1 vs. liblzo
>>>
>>>
>>>Where are we on this?
>>>
>>>Should we work around this in the openvpn.spec file, or just leave as-is
>>>for 2.0, and wait for the lzo spec to be fixed?
>>>
>>
>>You're not going to see that, at least I doubt it.  I'll contact the 
>>maintainer for his views on the subject and perhaps some insight as to 
>>where Mandrake is going with naming (LSB and all).
> 
> 
> Okay, though I'll need your best try at a workaround patch for
> openvpn.spec very soon to have any chance of making it into 2.0 final.
> 
> James
> 
> 
Give me a date or 24hours warning.  I'm still awaiting a response from 
the MandrakeSoft package maintainer.  If he doesn't answer by the time 
you need to freeze, I'll give you what I've got.

TomW


-- 
Tom Walsh - WN3L - Embedded Systems Consultant
email at http://openhardware.net?file=emailcomment.php
any ReplyTo direct email will disappear (blackhole).
----------------------------------------------------


