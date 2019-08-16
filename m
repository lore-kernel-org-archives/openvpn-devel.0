Date: Fri, 16 Aug 2019 20:14:46 +0200 (CEST)
Message-Id: <201908161814.x7GIEkpt028089@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20190815155319.28249-1-gert@...1296...>
References: <20190815155319.28249-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Increase listen() backlog queue
 to 32
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

Wow, more ACKs than actual lines of codes affected .-) - I hear you
wrt "have a #define somewhere" (and yes, we could do that) or "make it
easier to configure for users" (nah... for the reasons Antonio gave) :-)

Patch has been applied to the master and release/2.4 branch.

2.4, because (see the discussion in the ticket) this effectively 
acknowledges the changing nature of the internet, with ubiquitous
background scanning on well-known ports like TCP/443 - thus getting
in the way of production openvpn setups with "listen(s,1)".

commit 6d8380c78bf77766454b93b49ab2ebf713b0be48 (master)
commit ec0ca68f4ed1e6aa6f08f470b18e0198b7e5a4da (release/2.4)
Author: Gert Doering
Date:   Thu Aug 15 17:53:19 2019 +0200

     Increase listen() backlog queue to 32

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Acked-by: David Sommerseth <davids@...515...>
     Message-Id: <20190815155319.28249-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg18758.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


