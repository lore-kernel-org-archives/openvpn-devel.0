Message-ID: <49F6BDDB.1020200@...1212...>
Date: Tue, 28 Apr 2009 10:27:07 +0200
From: Aleksandar Ivanisevic <aleksandar@...1212...>
MIME-Version: 1.0
References: <m3prf3sag3.fsf@...1213...>
	<9e0cf0bf0904231043x61f0776dm4b463b113fa5ff33@...278...>
In-Reply-To: <9e0cf0bf0904231043x61f0776dm4b463b113fa5ff33@...278...>
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
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net


Hm,

I'm talking about the .spec file within the official source tarball. Is 
this whats not maintained any more?

Maybe you can accept a patch anyway? I've found out that pkcs11-helper 
is an opensuse or Mandriva package, so the patch would look like this:


*** openvpn.spec.in.orig	2009-04-28 10:14:48.000000000 +0200
--- openvpn.spec.in	2009-04-28 10:17:59.000000000 +0200
***************
*** 52,59 ****
--- 52,61 ----
   %{!?without_pam:BuildRequires: pam-devel}
   %{!?without_pam:Requires:      pam}

+ %if "%{_vendor}" == "MandrakeSoft" || "%{_vendor}" == "suse" || 
"%{_vendor}" == "pc"
   %{!?with_pkcs11:BuildRequires: pkcs11-helper-devel}
   %{!?with_pkcs11:Requires:      pkcs11-helper}
+ %endif

   #
   # Description
***************
*** 223,229 ****
   %endif

   # Install extra %doc stuff
! %doc contrib/ easy-rsa/ management/ sample-*/ plugin/README.*

   %changelog
   * Thu Dec 14 2006 Alon Bar-Lev
--- 225,231 ----
   %endif

   # Install extra %doc stuff
! %doc contrib/ easy-rsa/ sample-*/ plugin/README.*

   %changelog
   * Thu Dec 14 2006 Alon Bar-Lev



Alon Bar-Lev wrote:
> I don't think this rpm is maintained, the rpm based distributions has
> a different versions.
> 
> Alon.
> 
> On 4/23/09, Aleksandar Ivanisevic <aleksandar@...1212...> wrote:
>> Hi,
>>
>>  I've been compiling a rpm of rc15 on rhel5 and noticed a couple of
>>  glitches:
>>
>>  %doc lists management/ dir, but its no longer there, so
>>
>>  %doc contrib/ easy-rsa/ management/ sample-*/ plugin/README.*
>>
>>  should be
>>
>>  %doc contrib/ easy-rsa/ sample-*/ plugin/README.*
>>
>>  with_pkcs11 tries to pull in pkcs11-helper, but no such package exists
>>  in RHEL, so it must be distro specific, but don't know which distro
>>
>>  %{!?with_pkcs11:BuildRequires: pkcs11-helper-devel}
>>  %{!?with_pkcs11:Requires:      pkcs11-helper}
>>
>>  it builds fine with --nodeps though.
>>
>>  regards,
>>
>>
>>  ------------------------------------------------------------------------------
>>  Stay on top of everything new and different, both inside and
>>  around Java (TM) technology - register by April 22, and save
>>  $200 on the JavaOne (SM) conference, June 2-5, 2009, San Francisco.
>>  300 plus technical and hands-on sessions. Register today.
>>  Use priority code J9JMT32. http://p.sf.net/sfu/p
>>  _______________________________________________
>>  Openvpn-devel mailing list
>>  Openvpn-devel@lists.sourceforge.net
>>  https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>>
> 

