Message-Id: <200210240241.g9O2f1e15971@...41...>
From: "James Yonan" <jim@...41...>
Subject: [Openvpn-devel] OpenVPN 1.3.2 Released
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Wed Oct 23 19:42:02 2002
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-users@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net, openvpn-announce@lists.sourceforge.net

Well here it is at last... Thanks to everyone who contributed!

James

********************

Download:

https://sourceforge.net/projects/openvpn/

Change Log:

* Added SSL_CTX_set_client_CA_list call
  to follow the canonical form for TLS initialization
  recommended by the OpenSSL docs.  This change allows
  better support for intermediate CAs and has no impact
  on security.
* Added build-inter script to easy-rsa package, to
  facilitate the generation of intermediate CAs.
* Ported to NetBSD (Dimitri Goldin).
* Fixed minor bug in easy-rsa/sign-req.  It refers to
  openssl.cnf file, instead of $KEY_CONFIG, like all
  other scripts (Ernesto Baschny).
* Added --days 3650 to the root CA generation command
  in the HOWTO to override the woefully small 30 day
  default (Dominik 'Aeneas' Schnitzer).
* Fixed bug where --ping-restart would sometimes
  not re-resolve remote DNS hostname.
* Added --tun-ipv6 option and related infrastructure
  support for IPv6 over tun.
* Added IPv6 over tun support for Linux (Aaron Sethman).
* Added FreeBSD 4.1.1+ TUN/TAP driver notes to
  INSTALL (Matthias Andree).
* Added inetd/xinetd support (--inetd) including
  documentation in the HOWTO.
* Added "Important Note on the use of commercial certificate
  authorities (CAs) with OpenVPN" to HOWTO based on
  issues raised on the openvpn-users list.


