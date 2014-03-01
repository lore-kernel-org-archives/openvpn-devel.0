From: Steffan Karger <steffan@...1856...>
Date: Sat,  1 Mar 2014 15:36:13 +0100
Message-Id: <1393684575-28112-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Clean up --show-tls output for OpenSSL
	builds
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

The following two (small) patches are usability improvements.

1/2 removes some of the warnings OpenVPN-with-OpenSSL issue when a user
specifies valid OpenSSL TLS cipher group names with --tls-cipher. PolarSSL does
not support group names, so these are not applicable for PolarSSL.

2/2 changes the default cipher list for OpenSSL to explicitly disable a number
of unsupported TLS cipher groups. Although ECDH support is not yet in, I did
not add it here because, well, it should get in soon. This should reduce the
problems described in ticket #304.

-Steffan


