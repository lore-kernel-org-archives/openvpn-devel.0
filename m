Date: Tue, 25 Jul 2023 09:06:32 +0200 (CEST)
Message-Id: <202307250706.36P76WqE072484@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230725065840.24568-1-a@...2181...>
References: <20230725065840.24568-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: configure.ac: fix typ0 in
 LIBCAPNG_CFALGS
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
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Obviously correct (and used only in this place, the definition comes
out of autoconf and has no typos :) ).  Interesting that this wasn't
spotted earlier, seems nobody buildt with "libcapng with non-default
include path" yet.

Not tested whatsoever, just stared at configure/configure.ac

Your patch has been applied to the master and release/2.6 branch.

commit bd95104a2b375f87eb37441d33c8e35bd1c19b1f (master)
commit 2f0e7dd1444e3d29773c6b701f53afa4cadac970 (release/2.6)
Author: Antonio Quartulli
Date:   Tue Jul 25 08:58:40 2023 +0200

     configure.ac: fix typ0 in LIBCAPNG_CFALGS

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20230725065840.24568-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26890.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


