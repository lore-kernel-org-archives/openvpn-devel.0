Message-ID: <4231EE07.5070103@...355...>
From: TomWalsh <tomw-junk01@...355...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] RPM build of 2.0-rc16 fails on MandrakeSoft
References: <4220EC61.1000005@...355...> <Pine.LNX.4.58.0502270152590.23437@...41...> <42220B98.2010001@...355...> <42223300.1050402@...355...> <Pine.LNX.4.58.0502271404010.23437@...41...> <42253BF4.1050000@...355...> <Pine.LNX.4.58.0503021238020.23437@...41...> <42307C7C.3010804@...355...> <20050311092251.GB14692@...33...>
In-Reply-To: <20050311092251.GB14692@...33...>
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
Date: Fri Mar 11 11:15:14 2005
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Matthias Andree <matthias.andree@...68...>
Cc: James Yonan <jim@...41...>, openvpn-devel@lists.sourceforge.net

Matthias Andree wrote:
> 
> 
> RPM appears to, at least on Red Hat and Novell/SUSE derived machines,
> support the libraries' ELF SONAME, too, which is what my former
> suggestion has been about, and AFAICS, the soname is the same on all
> machines, namely liblzo.so.1 (use readelf -d to figure).
> 

Wouldn't we still be into a conditional situation of resolving which 
liblzo / lzo to call out for based on vendor name?  I'm not sure how the 
readelf works...

If we keep the conditional patch for MandrakeSoft vs. all others, you 
would then cover the Mandrake distros from 8.1 through 10.1.  Not a 
clean solution, but looping back on past mistakes (Mandrakes) never are...


We are spending too much time on this subject?  Here is the patch that 
satisfies the MandrakeSoft mess up:

=============== patch ================
--- openvpn.spec.orig   2005-02-26 16:26:09.922279800 -0500
+++ openvpn.spec        2005-02-26 16:20:11.794723464 -0500
@@ -33,8 +33,13 @@
BuildRequires: openssl-devel >= 0.9.6
Requires:      openssl       >= 0.9.6

+%if "%{_vendor}" == "MandrakeSoft"
+%{!?without_lzo:BuildRequires: liblzo1-devel >= 1.07}
+%{!?without_lzo:Requires:      liblzo1       >= 1.07}
+%else
%{!?without_lzo:BuildRequires: lzo-devel >= 1.07}
%{!?without_lzo:Requires:      lzo       >= 1.07}
+%endif

%{!?without_pam:BuildRequires: pam-devel}
%{!?without_pam:Requires:      pam}
============== snip ==================


============== Changlog ==============
2005.03.11   -- Version 2.0-rc17

* MandrakeSoft liblzo1 RPM only Provides for a 'liblzo1'.
   A conditional test of the vendor has been added to
   Require the appropriately named 'lzo' (liblzo1 / lzo).
   (Tom Walsh - http://openhardware.net)
================ snip =================





-- 
Tom Walsh - WN3L - Embedded Systems Consultant
email at http://openhardware.net?file=emailcomment.php
any ReplyTo direct email will disappear (blackhole).
----------------------------------------------------


