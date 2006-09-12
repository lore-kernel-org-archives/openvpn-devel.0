Message-ID: <45066D08.9000402@...41...>
Date: Tue, 12 Sep 2006 02:17:12 -0600
From: James Yonan <jim@...41...>
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN 2.0.8 and 2.1_beta15 released
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
To: 'openvpn-users' <openvpn-users@lists.sourceforge.net>, OpenVPN devel <openvpn-devel@lists.sourceforge.net>, openvpn-announce@lists.sourceforge.net

2006.09.12 -- Version 2.0.8

* Windows installer updated with OpenSSL 0.9.7k DLLs to fix
  RSA Signature Forgery (CVE-2006-4339).

* No changes to OpenVPN source code between 2.0.7 and 2.0.8.

2006.09.12 -- Version 2.1-beta15

* Windows installer updated with OpenSSL 0.9.7k DLLs to fix
  RSA Signature Forgery (CVE-2006-4339).

* Fixed bug introduced with the --port-share directive
  (back in 2.1-beta9 which causes TLS soft resets
  (1 per hour by default) in TCP server mode to force
  a blockage of tunnel packets and later time-out and
  restart the connection.

* pkcs11 changes:
  1. Modified ssl.c to not FATAL and return to init.c
     so auth-retry will work.
  2. Modifed pkcs11-helper.c to fix some problem with
     multiple providers.
  3. Updated makefile.w32-vc to include lladdr.*, updated
     linkage libraries.
  4. Modified lladdr.c to be compiled under visual C.
  5. Added retry counter to PKCS#11 PIN hook.
  6. Modified PKCS#11 PIN retry loop to return correct error
     code when PIN is incorrect.
  7. Fix handling (ignoring) zero sized attributes.
  8. Fix gcc-2 issues.
  9. Fix openssl 0.9.6 (first version) issues.
  10. easy-rsa Makefile (install) is now available so that
      distribs will be able to install it safely.

* Added two new management states:
   OPENVPN_STATE_RESOLVE      -- DNS lookup
   OPENVPN_STATE_TCP_CONNECT  -- Connecting to TCP server

* Echo management state change to log.

* Minor syshead.h change for NetBSD to allow
  TCP_NODELAY flag to work.

* Modified --port-share code to remove the assumption that
  CMSG_SPACE always evaluates to a constant, to enable
  compilation on NetBSD and possibly other BSDs as well.

* Eliminated gcc 3.3.3 warnings on NetBSD
  when ./configure --enable-strict is used.

* Added optional minimum-number-of-bytes parameter
  to --inactive directive.

James


