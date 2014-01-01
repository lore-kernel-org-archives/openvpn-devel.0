From: Steffan Karger <steffan@...1856...>
Date: Wed,  1 Jan 2014 21:10:20 +0100
Message-Id: <1388607026-12297-1-git-send-email-steffan@...1856...>
In-Reply-To: <20131230205032.GH226@...1296...>
References: <20131230205032.GH226@...1296...>
Subject: [Openvpn-devel] TLS fixes, remove support for ephemeral RSA,
	disable export ciphers
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

This patch set is meant to remove ephemeral RSA support from the master branch,
and disable (weak) export ciphers by default. While coding I came along some
other stuff I fixed along the way:

1/6: Update two old calls to TSLv1*() functions to SSLv23*() function, matching
     the TLS negotiation changes. This patch should be applied to both
     release/2.3 and master branches.

2/6: Update debug output to match the TLS negatiotiation changes. This patch
     should be applied to both release/2.3 and master branches.

3/6: Make --show-tls parse information retrieved from --tls-cipher options, to
     ease debugging and configuration. I think this one belongs in both
     release/2.3 and master too.

4/6: Remove the ephemeral RSA key generation callback, as discussed on the
     mailinglist. This patch is for master only.

5/6: Preparation for 6/6, makes tls_ctx_restrict_ciphers accept a NULL pointer
     for the cipher_list parameter, in which case it will use default settings
     (which for now is 'do nothing'). This one could go into release/2.3,
     because it doesn't really change anything, but is not really needed there
     as 6/6 is master-only.

6/6: Disable export ciphers for OpenSSL builds. This is to avoid confusion,
     because otherwise the export ciphers that require ephemeral RSA would still
     be printed by --show-tls. Furthermore, export cipher are deliberately weak
     and much better alternatives are available. This patch is for master only.

I've tried to exhaustively comment on the changes in the commit messages, but
if there are any remaining questions I'm happy to answer them.

-Steffan


