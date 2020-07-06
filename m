Date: Mon, 6 Jul 2020 17:43:01 +0200 (CEST)
Message-Id: <202007061543.066Fh1vv046421@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200630095443.7188-1-cschenk@...2502...>
References: <20200630095443.7188-1-cschenk@...2502...>
Subject: [Openvpn-devel] [PATCH applied] Re: Unified success messages for
 setting mtu
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
To: Christopher Schenk <cschenk@...2502...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Thanks :-) - given that this is somewhat trivial, I have not actually
run a binary to look at the messages.  I have counted arguments and done
a test build to see if new warnings show up (no).

I *do* see an old warning...

tun.c: In function 'windows_set_mtu':
tun.c:5523:21: warning: format '%u' expects argument of type 'unsigned int', but argument 5 has type 'DWORD {aka long unsigned int}' [-Wformat=]
         msg(M_WARN, "TUN: Setting %s mtu failed: %s [status=%u if_index=%d]",

mmmh...

Your patch has been applied to the master branch.

commit efe01d52e36c597484b6fa24c4820b6345d08ae6
Author: Christopher Schenk
Date:   Tue Jun 30 11:54:44 2020 +0200

     Unified success messages for setting mtu

     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20200630095443.7188-1-cschenk@...2502...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg20171.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


