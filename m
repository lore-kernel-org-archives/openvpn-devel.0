From: Steffan Karger <steffan@...1856...>
Date: Sun, 25 May 2014 21:18:18 +0200
Message-Id: <1401045501-12343-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Some crypto_openssl.c cleanup
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

The following three patches clean up minor stuff I came along while working
in crypto_openssl.c. No functional changes.

1/3 and 2/3 can be applied to master as well as release/2.3, to keep the code
differences between 2.3 and 2.4 smaller. I'll send rebased patches for these
later on.

3/3 requires OpenSSL 0.9.8 or later, so is for master only.

-Steffan


