From: Heiko Hund <heiko.hund@...1489...>
Date: Fri, 22 Feb 2013 10:44:19 +0100
Message-ID: <1361526263-1740-1-git-send-email-heiko.hund@...1489...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] revamp X.509 name verification option
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

This patch set tries to do X.509 name verification right. As discussed
during FOSDEM 2013, changing --tls-remote to support RFC 2253 style
subject DNs only was too radical as it broke more configurations than
expected.

This makes --tls-remote work with old configurations again, but
deprecates its use. As a replacement it introduces a new option for
X.509 name verification that takes RFC 2253 subject DNs only.

[PATCH 1/3] reintroduce --no-name-remapping option
[PATCH 2/3] make --tls-remote compatible with pre 2.3 configs
[PATCH 3/3] add new option for X.509 name verification

