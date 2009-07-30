Message-ID: <4A71C8AE.2070402@...1114...>
Date: Thu, 30 Jul 2009 18:22:06 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1248969135.4162.35.camel@...1251...>
In-Reply-To: <1248969135.4162.35.camel@...1251...>
Subject: Re: [Openvpn-devel] [Openvpn-users] Compiling 2.1RC19 rpms for
	CentOS
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
To: Nico De Ranter <nico@...1250...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, Openvpn Users <openvpn-users@lists.sourceforge.net>

Nico De Ranter wrote:
> Hi,
> 
> I'm trying to create rpms of 2.1RC19 for CentOS 5.3.  When I run
> 'rpmbuild -tb openvpn-2.1_rc19.tar.gz' I get an error in the end saying 
> 
> ...
> cp: cannot stat `management/': No such file or directory
> ...
> 
> There is indeed no management/ directory in the tar file.  Am I missing
> some files or is this an error in the rpm spec file?

That seems to be either a .spec file error, or a missing directory in the 
source tree.   There are 2 solutions ... Both builds on Fedora.

---- SUGGESTION 1: ----------------------------------------------

diff --git a/configure.ac b/configure.ac
index c6d19f9..5fbf7fd 100644
--- a/configure.ac
+++ b/configure.ac
@@ -871,6 +871,7 @@ AC_OUTPUT([
         openvpn.spec
         config-win32.h
         images/Makefile
+        management/Makefile
         service-win32/Makefile
         install-win32/Makefile
         install-win32/settings
diff --git a/management/Makefile.in b/management/Makefile.in
new file mode 100644
index 0000000..e69de29
-----------------------------------------------------------------
Caveats: The rpm file will add a Makefile to 
/usr/share/doc/openvpn-2.1_rc19/management/

** OR **

---- SUGGESTION 2: ----------------------------------------------
diff --git a/openvpn.spec b/openvpn.spec
index 5a52037..c15b48a 100644
--- a/openvpn.spec
+++ b/openvpn.spec
@@ -223,9 +223,12 @@ fi
  %endif

  # Install extra %doc stuff
-%doc contrib/ easy-rsa/ management/ sample-*/ plugin/README.*
+%doc contrib/ easy-rsa/ sample-*/ plugin/README.*

  %changelog
+* Thu Jul 30 2009 David Sommerseth <dazo@...384...>
+- Removed management/ directory from %doc
+
  * Thu Dec 14 2006 Alon Bar-Lev
  - Added with_pkcs11
-----------------------------------------------------------------

Not sure which patch the upstream developers prefer most.  But as long as 
the management/ directory is not present in the source tree, I believe 
SUGGESTION 2 is more the way to go.


kind regards,

David Sommerseth

