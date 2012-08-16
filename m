From: Heiko Hund <heiko.hund@...1489...>
Date: Thu, 16 Aug 2012 10:38:15 +0200
Message-ID: <1345106302-22850-1-git-send-email-heiko.hund@...1489...>
MIME-Version: 1.0
Subject: [Openvpn-devel] GOST algorithm support for OpenVPN
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

OpenSSL since version 1.0.0 supports the Russian cryptographic
standard algorithms, commonly called GOST algorithms. Use of GOST in
SSL/TLS is standardized by the IETF, thus openvpn is the VPN software
of choice for Russian users when constrained to use GOST algorithms.

With this patch series, users can choose to use GOST by using the
algorithms in the X.509 PKI and configuring openvpn with, e.g.

  --engine gost
  --auth gost-mac
  --cipher gost89
  --tls-cipher GOST2001-GOST89-GOST89

More information about the GOST algorithms can be found in IETF RFCs:

  4357  Additional Cryptographic Algorithms for Use with GOST Algorithms
  4490  GOST Algorithms with the Cryptographic Message Syntax (CMS)
  4491  GOST Algorithms with the Internet X.509 Public Key Infrastructure (PKI)
  5830  GOST 28147-89 Block Cipher and MAC Algorithms
  5831  GOST R 34.11-94 Hash Function Algorithm
  5832  GOST R 34.10-2001 Digital Signature Algorithm



