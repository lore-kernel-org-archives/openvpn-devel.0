From: Steffan Karger <steffan@...1856...>
Date: Thu, 24 Apr 2014 00:43:36 +0200
Message-Id: <1398293018-8581-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH v2] ECDH support (both OpenSSL and PolarSSL
	now)
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

As discussed earlier today, updated patches for ECDH support. See
http://article.gmane.org/gmane.network.openvpn.devel/8308 for the previous
version.

These patches comprise two changes:
1) Because the PolarSSL 1.3 patches have been merged, I updated the code and
   docs to reflect that PolarSSL builds have EC-crypto support too. PolarSSL
   does not support forcing an ECDH curve like OpenSSL does, it can merely
   restrict the available curves.

2) Add #ifdefs around the OpenSSL EC-crypto code, because some distros
   (notably, RHEL) ship with OpenSSL libraries without EC-crypto.

-Steffan


