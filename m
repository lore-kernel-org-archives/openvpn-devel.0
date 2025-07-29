Date: Tue, 29 Jul 2025 12:31:30 +0200 (CEST)
Message-Id: <202507291031.56TAVUTH095440@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250729093907.37849-1-kprovost@...2661...>
References: <20250729093907.37849-1-kprovost@...2661...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco-freebsd: always enable
 float notification support
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
To: Kristof Provost <kp@...1376...>
Cc: openvpn-devel@lists.sourceforge.net

That's an easy one :-) - taking out configure stuff and #ifdefs, always
welcome.  Tested on "stock FreeBSD 13.5" which has no if_ovpn, and
"stock FreeBSD 14.2" which has if_ovpn but not the float stuff.

Your patch has been applied to the master branch.

commit 796ad2c55951635382e48ea5b71d13bbb83ebfb1
Author: Kristof Provost
Date:   Tue Jul 29 11:39:07 2025 +0200

     dco-freebsd: always enable float notification support

     Signed-off-by: Kristof Provost <kprovost@...2661...>
     Message-Id: <20250729093907.37849-1-kprovost@...2661...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32402.html
     Acked-by: Gert Doering <gert@...1296...>
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


