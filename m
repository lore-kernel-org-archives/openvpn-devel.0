Date: Sat, 23 Jun 2018 21:02:00 +0200 (CEST)
Message-Id: <201806231902.w5NJ20L5030137@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20180623183108.18684-1-a@...2181...>
References: <20180623183108.18684-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: windows: properly configure TAP
 driver when no IPv4 is configured
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
To: Antonio Quartulli <antonio@...515...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Took us a while to get here, but here we are :-) - it compiles!  (And it
actually *works* - tested v4+v6 and v6-only on Win7/64 - with iservice - and 
it does the right thing and logs useful messages)

Your patch has been applied to the master branch.

commit 125e9df9539a0d3aa7894f959ef966464754f1da
Author: Antonio Quartulli
Date:   Sun Jun 24 02:31:08 2018 +0800

     windows: properly configure TAP driver when no IPv4 is configured

     Signed-off-by: Antonio Quartulli <antonio@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20180623183108.18684-1-a@...2181...>
     URL: https://www.mail-archive.com/search?l=mid&q=20180623183108.18684-1-a@...2181...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


