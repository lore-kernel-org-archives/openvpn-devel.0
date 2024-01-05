Date: Fri, 5 Jan 2024 23:14:58 +0100 (CET)
Message-Id: <202401052214.405MEwCs053531@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240105135742.21174-1-steffan@...1856...>
References: <20240105135742.21174-1-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix IPv6 route add/delete
 message log level
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
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

Patch looks good, makes sense, thanks for that.

Interesting enough, the old code had weird formatting ("msg( M_INFO")
which led to weird indenting of the *next* lines - this patch changed
the msg() call to have no leading blank, and uncrustify complained that
now the successive lines had whitespace errors... fixed on the fly.

Not tested beyond "looks reasonable, compiles, and add_route() indeed
uses D_ROUTE for informational msg() calls".

Your patch has been applied to the master and release/2.6 branch.

commit b959b02b4f607628896b4092f7ddfa675e87d929 (master)
commit 9abf74c92c1c13de089523babc1dfeda7bb7255f (release/2.6)
Author: Steffan Karger
Date:   Fri Jan 5 14:57:42 2024 +0100

     Fix IPv6 route add/delete message log level

     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20240105135742.21174-1-steffan@...1856...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27954.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


