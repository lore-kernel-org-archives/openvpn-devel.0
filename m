Date: Wed, 16 Sep 2020 22:31:45 +0200 (CEST)
Message-Id: <202009162031.08GKVj84043163@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200916195616.30633-1-davids@...515...>
References: <20200916195616.30633-1-davids@...515...>
Subject: [Openvpn-devel] [PATCH applied] Re: build: Fix make
 distclean/distcheck
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
To: David Sommerseth <davids@...515...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

I haven't tested this (my "distcheck capable" machine is still down),
but it looks reasonable.

Your patch has been applied to the master and release/2.5 branch.

commit 6345cea86bde14b22a8024cad5026a7d302db25c (master)
commit 55f4fe3a0d04b35f0e817c5a34246d9bda40e936 (release/2.5)
Author: David Sommerseth
Date:   Wed Sep 16 21:56:16 2020 +0200

     build: Fix make distclean/distcheck

     Signed-off-by: David Sommerseth <davids@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20200916195616.30633-1-davids@...515...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21026.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


