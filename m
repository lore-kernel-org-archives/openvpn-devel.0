Date: Tue, 27 Dec 2022 20:08:39 +0100 (CET)
Message-Id: <202212271908.2BRJ8dAW018216@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20221227140249.3524943-2-arne@...1227...>
References: <20221227140249.3524943-2-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Replace realloc with new
 gc_realloc function
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

Acked-by: Gert Doering <gert@...1296...>

The initial tests were left to Github/ASAN builds, which are now 
"all green for real" - 
  https://github.com/cron2/openvpn/actions/runs/3789030448

Stare-at-code also looks good, though a bit complicated (and if I'm
reading this right, doing an initial allocation with gc_malloc() and
then calling gc_realloc() on it will double-free(), so *boom*) - sufficient
for the use case at hand (initial allocation also done with gc_realloc()),
but maybe it could be simplified and made robust against this case.

My manual "test one instance with 200 remotes" did what I expected
(and I discovered --management-query-remote ;-) ).

Your patch has been applied to the master and release/2.6 branch.

commit e7f2169772f90f9bf158a17f5656a6a985e74e31 (master)
commit 09267c1ccde6a8f0671c785413ca847e97bbc0a5 (release/2.6)
Author: Arne Schwabe
Date:   Tue Dec 27 15:02:45 2022 +0100

     Replace realloc with new gc_realloc function

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20221227140249.3524943-2-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25829.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


