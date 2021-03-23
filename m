Date: Tue, 23 Mar 2021 10:31:45 +0100 (CET)
Message-Id: <202103230931.12N9VjZ6037655@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210317160038.25828-1-arne@...1227...>
References: <20210317160038.25828-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Move restoring pre pull options
 to initialising of c2 context
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master branch.

I do not really have a test rig to test this, currently.  I think it would
need a long-running client instance that connects to a server, receives
a set of options, disconnects (server kicking it out?), reconnects, and
receives *different* options.  Or possibly "not receives options that
were set before", so verify "fall back to default/config file settings".

OTOH staring at the code looks reasonable - we only restore if something
was saved before (o->pre_pull initialized) and if we succeed connecting, 
it's the same amount of energy spent.

I have run this through the enhanced client side tests (including the
"must fail!") tests, but since these all only do single-shot connections,
this is not really excercising the code change.


I do wonder if connection *failures* would cause an increased memory
consumption now... is "&c->c2.gc" cleared eventually?  (Because we 
allocate new copies of route-lists in that GC)... *looking*... ah, yes,
c2.gc lives only for "one instance" (init_instance() to close_instance()),
and since that one talks about "advance connection entry", it looks
like "this dance is done per connection attempt"...

commit 528a78fb144ff6a3d5865c871a402ba98fdfe21e
Author: Arne Schwabe
Date:   Wed Mar 17 17:00:36 2021 +0100

     Move restoring pre pull options to initialising of c2 context

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Message-Id: <20210317160038.25828-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21676.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


