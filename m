Message-ID: <4F4B49C0.6040205@...1114...>
Date: Mon, 27 Feb 2012 10:15:44 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1329787361-26096-1-git-send-email-alon.barlev@...277...>
	<1329787361-26096-12-git-send-email-alon.barlev@...277...>
In-Reply-To: <1329787361-26096-12-git-send-email-alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH 11/35] Remove install-win32
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 21/02/12 02:22, Alon Bar-Lev wrote:
> 
> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...> --- Makefile.am
> |    5 +- configure.ac                           |    3 - 
> images/.svnignore                      |    2 - images/Makefile.am
> |   41 -- images/icon.ico                        |  Bin 22486 -> 0
> bytes images/install-whirl.bmp               |  Bin 25820 -> 0 bytes 
> install-win32/.svnignore               |    4 - 
> install-win32/GetWindowsVersion.nsi    |  109 ---- 
> install-win32/Makefile.am              |   97 ---- 
> install-win32/build-pkcs11-helper.sh   |   24 - 
> install-win32/buildinstaller           |   14 - 
> install-win32/ddk-common               |    2 - install-win32/doclean
> |    6 - install-win32/dosname.pl               |    9 - 
> install-win32/getgui                   |   19 - 
> install-win32/getopenssl               |   19 - 
> install-win32/getpkcs11helper          |   17 - 
> install-win32/getprebuilt              |   10 - install-win32/getxgui
> |   28 - install-win32/ifdef.pl                 |   53 -- 
> install-win32/m4todef.pl               |   15 - install-win32/macro.pl
> |   61 --- install-win32/makeopenvpn              |   67 --- 
> install-win32/maketap                  |   17 - 
> install-win32/maketapinstall           |   15 - install-win32/maketext
> |   59 --- install-win32/openssl/README.txt       |   21 - 
> install-win32/openssl/openssl097.patch |   68 --- 
> install-win32/openssl/openssl098.patch |   56 -- 
> install-win32/openvpn.nsi              |  886
> -------------------------------- install-win32/sample.ovpn
> |  103 ---- install-win32/setpath.nsi              |  231 --------- 
> install-win32/settings.in              |   71 --- 
> install-win32/trans.pl                 |   97 ---- install-win32/u2d.c
> |   20 - install-win32/winconfig                |   18 - 36 files
> changed, 1 insertions(+), 2266 deletions(-) delete mode 100644
> images/.svnignore delete mode 100644 images/Makefile.am delete mode
> 100755 images/icon.ico delete mode 100755 images/install-whirl.bmp 
> delete mode 100644 install-win32/.svnignore delete mode 100644
> install-win32/GetWindowsVersion.nsi delete mode 100644
> install-win32/Makefile.am delete mode 100644
> install-win32/build-pkcs11-helper.sh delete mode 100644
> install-win32/buildinstaller delete mode 100644
> install-win32/ddk-common delete mode 100644 install-win32/doclean 
> delete mode 100644 install-win32/dosname.pl delete mode 100644
> install-win32/getgui delete mode 100644 install-win32/getopenssl 
> delete mode 100644 install-win32/getpkcs11helper delete mode 100644
> install-win32/getprebuilt delete mode 100644 install-win32/getxgui 
> delete mode 100644 install-win32/ifdef.pl delete mode 100644
> install-win32/m4todef.pl delete mode 100644 install-win32/macro.pl 
> delete mode 100755 install-win32/makeopenvpn delete mode 100644
> install-win32/maketap delete mode 100644 install-win32/maketapinstall 
> delete mode 100644 install-win32/maketext delete mode 100644
> install-win32/openssl/README.txt delete mode 100644
> install-win32/openssl/openssl097.patch delete mode 100644
> install-win32/openssl/openssl098.patch delete mode 100755
> install-win32/openvpn.nsi delete mode 100755
> install-win32/sample.ovpn delete mode 100755
> install-win32/setpath.nsi delete mode 100644
> install-win32/settings.in delete mode 100644 install-win32/trans.pl 
> delete mode 100755 install-win32/u2d.c delete mode 100644
> install-win32/winconfig
> 

ACK.


kind regards,

David Sommerseth


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9LScAACgkQDC186MBRfro64ACgr7fZ80f+F23iB2JNciD4JMIp
nkAAn2h4cQv4VEMrahmUqSe/O9D3vRgu
=dqKf
-----END PGP SIGNATURE-----

