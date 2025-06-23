Date: Mon, 23 Jun 2025 16:34:16 +0200 (CEST)
Message-Id: <202506231434.55NEYGWL039660@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250623140748.13960-1-gert@...1296...>
References: <20250623140748.13960-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco linux: avoid redefining
 ovpn enums
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
To: Ralf Lici <ralf@...2726...>
Cc: openvpn-devel@lists.sourceforge.net

Patch looks good, and passes compile & smoke tests on Ubuntu 20.04
(with and without --disable-dco) & Gentoo.  No other platforms affected.

BB fails are due to infra issues (socks server refusing v6), unrelated
to this patch.

Your patch has been applied to the master branch.

commit 1d3c2b67a73a0aa011c13e62f876d24e49d41df0
Author: Ralf Lici
Date:   Mon Jun 23 16:07:43 2025 +0200

     dco linux: avoid redefining ovpn enums

     Signed-off-by: Ralf Lici <ralf@...2726...>
     Message-Id: <20250623140748.13960-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31961.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


