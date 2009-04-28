Message-ID: <49F6C33B.8000903@...1212...>
Date: Tue, 28 Apr 2009 10:50:03 +0200
From: Aleksandar Ivanisevic <aleksandar@...1212...>
MIME-Version: 1.0
References: <m3prf3sag3.fsf@...1213...>	
	<9e0cf0bf0904231043x61f0776dm4b463b113fa5ff33@...278...>	
	<49F6BDDB.1020200@...1212...>
	<9e0cf0bf0904280129i6810505by2545ef210709466e@...278...>
In-Reply-To: <9e0cf0bf0904280129i6810505by2545ef210709466e@...278...>
Content-Type: multipart/mixed; boundary="------------010409050503080509020800"
Subject: Re: [Openvpn-devel] rc15 rpm spec glitches
Reply-To: aleksandar@...1212...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------010409050503080509020800
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


ok, attached

Alon Bar-Lev wrote:
> Yes, I don't think it is maintained.
> 
> Please send uniform diff.
> 
> Use: "diff -urNp"
> 


--------------010409050503080509020800
Content-Type: text/x-patch;
 name="openvpn.spec.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="openvpn.spec.patch"

--- openvpn.spec.in.orig	2009-04-28 10:14:48.000000000 +0200
+++ openvpn.spec.in	2009-04-28 10:47:30.000000000 +0200
@@ -52,8 +52,10 @@ Requires:      openssl       >= 0.9.6
 %{!?without_pam:BuildRequires: pam-devel}
 %{!?without_pam:Requires:      pam}
 
+%if "%{_vendor}" == "MandrakeSoft" || "%{_vendor}" == "suse" || "%{_vendor}" == "pc"
 %{!?with_pkcs11:BuildRequires: pkcs11-helper-devel}
 %{!?with_pkcs11:Requires:      pkcs11-helper}
+%endif 
 
 #
 # Description
@@ -223,9 +225,12 @@ fi
 %endif
 
 # Install extra %doc stuff
-%doc contrib/ easy-rsa/ management/ sample-*/ plugin/README.*
+%doc contrib/ easy-rsa/ sample-*/ plugin/README.*
 
 %changelog
+* Tue Apr 28 2009 Aleksandar Ivanisevic <aleksandar@...1212...>
+- %doc cleanup and RHEL compatibility fixes
+
 * Thu Dec 14 2006 Alon Bar-Lev
 - Added with_pkcs11
 

--------------010409050503080509020800--

