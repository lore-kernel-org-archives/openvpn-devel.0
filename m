MIME-Version: 1.0
From: Kenny Root <kenny@...1827...>
Date: Mon, 3 Jun 2013 17:14:32 -0700
Message-ID: <CALkG1NxZC7DT+SZHuSYemyyaH8dVsx_0PAm-7pTYY9EYMbZBgQ@...278...>
Subject: [Openvpn-devel] Adding support for AEAD cipher modes (AES-GCM,
	et al.)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

I wrote a patch to add AEAD cipher modes to OpenVPN. This is one of
NIST's recommended modes and newer Intel chips supporting the AES-NI
(with PCLMULQDQ) have excellent support for acceleration in this mode.
I posted the initial version at
https://community.openvpn.net/openvpn/ticket/301 and that ticket has
some of the performance numbers on an Ivy Bridge class chip.

It also doesn't appear PolarSSL has added AES-GCM to their main crypto API yet.

(You can also comment at Github at
https://github.com/kruton/openvpn/commit/a8c6701c8b47429c32da5c01f4398f9e0b293c01)

