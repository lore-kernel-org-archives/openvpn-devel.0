Date: Tue, 5 Jun 2018 21:27:17 +0200 (CEST)
Message-Id: <201806051927.w55JRH2G075967@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20180605090421.9746-3-a@...2181...>
References: <20180605090421.9746-3-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: pool: restyle ipv4/ipv6 members
 to improve readability
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

While not strictly necessary, it makes the code somewhat easier to
follow ("this is only about IPv4, which does not interest me right now").

Stared-at-code, and tested (t_client + t_server) :-)

Your patch has been applied to the master branch (with some minor grammar
fixes to the commit message).

commit 5d2cd1222e06291021cf5e793f585d5f1485ae9b
Author: Antonio Quartulli
Date:   Tue Jun 5 17:04:18 2018 +0800

     pool: restyle ipv4/ipv6 members to improve readability

     Signed-off-by: Antonio Quartulli <antonio@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20180605090421.9746-3-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg16944.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


