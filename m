Message-Id: <200210170203.g9H23xL13456@...41...>
From: "James Yonan" <jim@...41...>
Subject: [Openvpn-devel] New pre-1.3.2 beta available, please test
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
Date: Wed Oct 16 19:05:02 2002
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

Here is the latest pre-1.3.2 beta that now supports IPv6 over tun on Linux.  Please test.  I plan to release 1.3.2 shortly if there are no problems reported.

Download from CVS or

http://openvpn.sourceforge.net/beta/openvpn-1.3.1.7.tar.gz

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
* Added "Important Note on the use of commercial certificate
  authorities (CAs) with OpenVPN" to HOWTO based on
  issues raised on the openvpn-users list.

James



