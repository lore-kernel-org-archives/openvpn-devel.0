Message-ID: <42223300.1050402@...355...>
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
Date: Sun Feb 27 12:54:15 2005
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

Hmm, although the build of the RPM will succeed, the package won't 
install.  Doing a mere "urpmi openvpn" results in:

================== error ====================
[root@...23... root]# urpmi openvpn
Some package requested cannot be installed:
openvpn-2.0_rc16-3.i586 (due to unsatisfied liblzo[>= 1.07])
Continue? (Y/n)
==================== snip ===================

Ok, I see the problem, the MandrakeSoft "liblzo1-devel" rpm claims that 
it would provide "liblzo" while the "liblzo1" rpm only claims provision 
of "liblzo1".  Apparently something is getting confused, in the 
rpmbuild, as to what is what?

rpmbuild must be scanning provide lists and finds mention of liblzo and 
later when urpmi attempts to install a liblzo package, it cannot find 
one.  This is true, liblzo1 is the correct package but lacks the liblzo 
provision:

=================== liblzo1 vs. liblzo1-devel ===================
[root@...356... openvpn]# rpm -q --provides liblzo1-devel-1.08-4mdk
liblzo1-devel = 1.08-4mdk
liblzo-devel = 1.08-4mdk
devel(liblzo)

[root@...23... root]# rpm -q --provides liblzo1-1.08-4mdk
liblzo.so.1
liblzo1 = 1.08-4mdk
========================= snip ==================================

I will let the package maintainer of liblzo1 of the problem of it not 
saying it provides "liblzo" while the liblzo1-devel does say that.

The correct statement which works around the Mandrake 10.1 problem would be:

============================ fix ===============================
%if "%{_vendor}" == "MandrakeSoft"
%{!?without_lzo:BuildRequires: liblzo1-devel >= 1.07}
%{!?without_lzo:Requires:      liblzo1       >= 1.07}
%else
%{!?without_lzo:BuildRequires: lzo-devel >= 1.07}
%{!?without_lzo:Requires:      lzo       >= 1.07}
%endif
============================ snip ==============================

Either way, there would still be an issue with Mandrake as I see that 
the lzo package of SuSE 9.1 provides "lzo" not "liblzo".


Thanks,

TomW


-- 
Tom Walsh - WN3L - Embedded Systems Consultant
email at http://openhardware.net?file=emailcomment.php
any ReplyTo direct email will disappear (blackhole).
----------------------------------------------------


