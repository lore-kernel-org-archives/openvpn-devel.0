From: Steffan Karger <steffan@...1856...>
Date: Sun,  7 Feb 2016 20:47:08 +0100
Message-Id: <1454874438-5081-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Add support for AEAD (GCM) cipher mode
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

Hi,

These patches add support for GCM mode ciphers to OpenVPN.  These are
originally inspired by the patch from kruton (trac #301, and
http://thread.gmane.org/gmane.network.openvpn.devel/7653), but most of the
original code has been rewritten.

As discussed in various IRC meetings and at the hackathons, we used this
opportunity to introduce a new - more efficient - packet format.  See
http://sourceforge.net/p/openvpn/mailman/message/33210313/ and the commit
message of patch 8 for more details.

The first patches (1-7) are refactoring in preparation of adding AEAD modes.
Not all of the changes are strictly required, but they made it easier for me to
understand what was going on and debug my AEAD code.  I think they improve the
understandability of the code.  These should not change any behaviour (apart
from adding better log messages).

Patch 8 actually adds the GCM cipher mode.  See it's commit message for more
information on the implementation.

Patch 9 provides polarssl/mbedtls and openssl config file interoperability.

Patch 10 adds a (very) preliminary version of cipher negotation.  I'm not
entirely sure if we should already apply this patch or wait for full cipher
negotiation support.  I'm also not sure when I will have proper negotiation
patches available.

This implementation has been verified to be compatible with openvpn 3 clients
and servers.  To test this you'll need to pretend to fully support IV_NCP and
IV_TCPNL, see e.g. https://github.com/syzzer/openvpn/tree/aead-cipher-modes13.

This has been a spare-time project, and did not yet receive any thorough review
or field testing.  So both are still very much needed.

-Steffan


