Date: Fri, 2 Apr 2021 18:10:48 +0200 (CEST)
Message-Id: <202104021610.132GAmvf022107@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210401131337.3684-15-arne@...1227...>
References: <20210401131337.3684-15-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove do_init_socket_2 and
 do_init_socket_1 wrapper function
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

Just *looking* at these functions with the insane number of arguments
make my head hurt.  So I can't claim to have thoroughly reviewed that
every single argument goes to wherever it wanted to go before.  What
I saw looked good, though.

BUT - we have good test coverage on these (tcp, udp, socks, http proxy, 
ipv4, ipv6) in the t_client test set.  So I let my machines worry :-)

Linux and FreeBSD both claim that the end result still works
(it might have broken the SRV patch, but we'll see).

Your patch has been applied to the master branch.

commit 343b61195b76796632b8948674fd1068889bb6c7
Author: Arne Schwabe
Date:   Thu Apr 1 15:13:37 2021 +0200

     Remove do_init_socket_2 and do_init_socket_1 wrapper function

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20210401131337.3684-15-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21954.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


