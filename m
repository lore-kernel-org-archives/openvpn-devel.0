Date: Mon, 8 Jun 2020 20:23:16 +0200 (CEST)
Message-Id: <202006081823.058INGNF090409@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200608153239.2260-1-a@...2181...>
References: <20200608153239.2260-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: options: enable IPv4
 redirection logic only if really required
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

Thanks :-)

Tested with "redirect-private", "redirect-gateway", "redirect-gateay !ipv4",
and it seems to do what we want - not fumble any hostroutes if !ipv4 is
set, but *do* fumble them if needed.

If you do "--redirect-private --redirect-gateway !ipv4 ipv6", it will
unset the effect of "--redirect-private" (which is expected).  If you
do it the other way round, it will actually do what you told it to -
redirect IPv6 default, and add a /32 host route for IPv4.  So even 
in this somewhat very special case, we're not losing functionality, 
but if it might need reordering of config options.

There is changed behaviour for anything that has "!ipv4" in it - if
you do "redirect-gateway !ipv4 block-local", before this patch, we'd
"route the local lan into the tunnel, but not the default gateway" -
now, we will just ignore the "block-local" bit.  Anything with IPv4,
actually, as RG_ENABLE gets dropped.  This was not intentional, but
it is actually making sense - you said "!ipv4", after all.


Your patch has been applied to the master branch.

commit 070319c13524125d8325a0df15fe795cc2a4bcf2
Author: Antonio Quartulli
Date:   Mon Jun 8 17:32:39 2020 +0200

     options: enable IPv4 redirection logic only if really required

     Signed-off-by: Antonio Quartulli <antonio@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20200608153239.2260-1-a@...2181...>
     URL: https://www.mail-archive.com/search?l=mid&q=20200608153239.2260-1-a@...2181...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


