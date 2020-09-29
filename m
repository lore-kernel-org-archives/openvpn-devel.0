Date: Tue, 29 Sep 2020 12:18:03 +0200 (CEST)
Message-Id: <202009291018.08TAI3DX019277@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200922170841.13729-1-themiron@...2010...>
References: <20200922170841.13729-1-themiron@...2010...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix update_time() and
 openvpn_gettimeofday() coexistence
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
To: Vladislav Grishenko <themiron@...2010...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

I think this is a good first patch for the problem at hand, and it 
might actually fix one of our (old!) open trac tickets, claiming that 
the shaper is not (always) working correctly on Linux - Trac#91

For master, we should look more closely into always using "one of
the usec providing" time functions, and not mixing time() and
gettimeofday() - at least on platforms where this can be done 
without adverse effects, even if virtualization is involved
(making *some* time related functions horribly slow).

I have read the context (otime.h, otime.c), agree with your
conclusions, *and* have tested it client-side on Linux and
FreeBSD - nothing broke.  I have not tested the shaper.

Your patch has been applied to the master and release/2.5 branch.

commit e9e47f498674f6db8c3b88b32c877c5beb09a888 (master)
commit 51ee3574faade4dae5762140ea9f3a5eadc9d1e3 (release/2.5)
Author: Vladislav Grishenko
Date:   Tue Sep 22 22:08:41 2020 +0500

     Fix update_time() and openvpn_gettimeofday() coexistence

     Signed-off-by: Vladislav Grishenko <themiron@...2010...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20200922170841.13729-1-themiron@...2010...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21070.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


