Message-ID: <4220EC61.1000005@...355...>
From: TomWalsh <tomw-junk01@...355...>
MIME-Version: 1.0
Subject: [Openvpn-devel] RPM build of 2.0-rc16 fails on MandrakeSoft
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
Date: Sat Feb 26 13:41:01 2005
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Just a note to say that the openvpn.spec file seems to have a problem 
building an RPM on a Mandrake system.  The build system info:

Mandrake 10.1 Official PowerPack  (stock distro, not upgraded).
RPM version 4.2.2


The problem seems to be with rpmbuild incorrectly identifying / seeing 
liblzo-devel, this is the error:

===============  error ===============
[tom@...356... openvpn]$ rpmbuild -tb 
../../../dev-rpms/openvpn-2.0_rc16.tar.gz
error: Failed build dependencies:
        lzo-devel >= 1.07 is needed by openvpn-2.0_rc16-1
================ snip ===============


Querying the rpm database for liblzo-devel, it reports:

=============== rpm -q ===============
[tom@...356... openvpn-2.0_rc16]$ rpm -q --provides liblzo1-devel
liblzo1-devel = 1.08-4mdk
liblzo-devel = 1.08-4mdk
devel(liblzo)
===============  snip ================

 From the above query, it does appear that rpmbuild is really stupid and 
won't bother reading beyond the first provides line!?  :P


This patch corrects the problem on Mandrake 10.1 and still achieves the 
same result:

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


-- 
Tom Walsh - WN3L - Embedded Systems Consultant
email at http://openhardware.net?file=emailcomment.php
any ReplyTo direct email will disappear (blackhole).
----------------------------------------------------


