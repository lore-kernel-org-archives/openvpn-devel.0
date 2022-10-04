Date: Tue, 4 Oct 2022 18:39:02 +0200 (CEST)
Message-Id: <202210041639.294Gd2QC003484@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20221004153127.527-1-gert@...1296...>
References: <20221004153127.527-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: un-break
 undo_ifconfig_ipv4()/_ipv6() on all non-linux/non-win32 platforms
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Verified that it doesn't break any other platforms using buildbot
on all platforms.

Patch has been applied to the master branch (offending code is not in 2.5).

commit d4c34b5246e58f83ee8b87249173521a28de6993 (master)
Author: Gert Doering
Date:   Tue Oct 4 17:31:27 2022 +0200

     un-break undo_ifconfig_ipv4()/_ipv6() on all non-linux/non-win32 platforms

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Antonio Quartulli <a@...2181...>
     Message-Id: <20221004153127.527-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25337.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


