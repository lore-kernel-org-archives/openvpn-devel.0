Message-ID: <462C562F.1050107@...41...>
Date: Mon, 23 Apr 2007 00:46:07 -0600
From: James Yonan <jim@...41...>
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN 2.1_rc3 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-users@lists.sourceforge.net, Openvpn-devel@lists.sourceforge.net

This release should fix all known Vista issues, on both x86 and x64, 
however the TAP driver will not install on Vista x64 unless driver 
signing enforcement is disabled. 

I've also added the excellent OpenVPN GUI (Mathias Sundman version) as a 
Windows install option.

ChangeLog:

2007.04.22 -- Version 2.1_rc3

* Additional fixes to TAP driver for Windows x64.  Driver
  now runs successfully on Vista x64 if driver signing
  enforcement is disabled.
    
* The Windows Installer and TAP driver are now signed by
  OpenVPN Solutions LLC (in addition to the usual GnuPG
  signatures).

* Added OpenVPN GUI (Mathias Sundman version) as install
  option in Windows installer.

* Clean up configure on FreeBSD for recent autotool versions
  that require that all .h files have to be compiled.
  Also, FreeBSD install does not support GNU long options
  which the Makefile in easy-rsa/2.0 uses (not checked the
  others as we don't install those on Gentoo) (Roy Marples).

* Added additional scripts to easy-rsa/Windows for working
  with password-protected keys; also add -extensions server
  option when generating server cert via
  build-key-server-pass.bat (Daniel Zauft).

James


