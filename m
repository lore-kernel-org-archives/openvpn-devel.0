From: Steffan Karger <steffan.karger@...1435...>
Date: Tue, 8 Nov 2016 21:18:17 +0100
Message-ID: <1478636302-9678-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Add control channel encryption (--tls-crypt)
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

This patch set implements the control channel encryption feature proposed on
this list in msg <b7d9be2a-b8e1-e565-198f-a5177e11d0c2@...1435...>
(https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg12357.html).

This patch set requires patch 1/7 of Heiko's struct argv overhaul (and my
suggested fixup) to be applied first.

See the commit messages for further details.

-Steffan


