From: Kristof Provost <kprovost@...2661...>
Date: Wed, 13 Apr 2022 17:04:54 +0200
Message-Id: <20220413150455.85338-1-kprovost@...2661...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH DCO]: FreeBSD DCO support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

This is my second attempt at sending in the updated FreeBSD DCO support
patch. (The previous version had a cleanup patch but nothing else).

The main difference to the previous version is that is passes the
peer_id in most calls. There have been some changes on the driver side
to improve server mode support, which required this information.

This requires the FreeBSD driver in https://reviews.freebsd.org/D34340

Best regards,
Kristof



