Date: Fri, 8 Apr 2022 12:50:53 +0200 (CEST)
Message-Id: <202204081050.238AornW080250@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220407094146.7684-1-a@...2181...>
References: <20220407094146.7684-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: networking: implement
 net_iface_new and net_iface_del APIs
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

I like the new style much more - thanks (and it's actually quite a few
less lines of code - good that we're not paid *cough* by LoC produced).

I have fixed one indent that uncrustify complained about - second line
of the net_iface_new() function declaration in networking_iproute2.c
(but not in networking_sitnl.c).  Your editor fighting the whitespace
dragon?

On the actual code change - this is not doing much yet, as t_net.sh
isn't even calling it yet... - but calling "networking_testdriver" 
manually, I see that it creates an interface, and then removes it 
again, for SITNL builds.  For IPROUTE2 builds, the testdriver is 
not built (and not trivial to do), so I did not test that one,
but "it looks correct".

Your patch has been applied to the master branch.

commit c838a9f98fa2d8b6d7b2658e8399bc9d19ec60e0
Author: Antonio Quartulli
Date:   Thu Apr 7 11:41:46 2022 +0200

     networking: implement net_iface_new and net_iface_del APIs

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220407094146.7684-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24088.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


