Message-ID: <42221240.20908@...355...>
From: TomWalsh <tomw-junk01@...355...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] RPM build of 2.0-rc16 fails on MandrakeSoft
References: <4220EC61.1000005@...355...> <Pine.LNX.4.58.0502270152590.23437@...41...> <42220B98.2010001@...355...>
In-Reply-To: <42220B98.2010001@...355...>
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
Date: Sun Feb 27 10:36:05 2005
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: James Yonan <jim@...41...>
Cc: openvpn-devel@lists.sourceforge.net

TomWalsh wrote:
> James Yonan wrote:
> 
>>
>> What if you use this instead for the Mandrake section:
>>
>> %{!?without_lzo:BuildRequires: liblzo-devel >= 1.07}
>> %{!?without_lzo:Requires:      liblzo       >= 1.07}
>>
>> James
> 
> 
> 
> Still fails.
> 
> 
Err, I got something mixed up here.  It did work that time using the 
"liblzo" instead of "liblzo1".  I had thought that I tried that, but 
when I did it again it worked.

I've build RPM spec files before, but nothing that actually compiled the 
target code and produced the RPM.  So, I'm a little over my head here. 
Wouldn't something like this work? It would only require a single 
mention of the revision level:

================= begin =================
%if "%{_vendor}" == "MandrakeSoft"
#define _LIBLZO liblzo
%else
#define _LIBLZO lzo
%endif

%{!?without_lzo:BuildRequires: %{_LIBLZO}-devel >= 1.07}
%{!?without_lzo:Requires:      %{_LIBLZO}       >= 1.07}
=================== snip ================

I doesn't though, I think it is a nesting problem with the braces for 
this statement?

TomW


-- 
Tom Walsh - WN3L - Embedded Systems Consultant
email at http://openhardware.net?file=emailcomment.php
any ReplyTo direct email will disappear (blackhole).
----------------------------------------------------


