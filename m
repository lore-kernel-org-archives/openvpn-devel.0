Date: Mon, 17 Oct 2022 10:25:35 +0200 (CEST)
Message-Id: <202210170825.29H8PZTo017226@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20221016154953.2483509-1-arne@...1227...>
References: <20221016154953.2483509-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Change exit signal in P2P to be
 a SIGUSR1 and delay CC exit in P2MP
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

Tested the whole lot again.  Only difference to v1 is in p2mp mode with 
incoming TLS EEN, which now logs

10:15:34 cron2-freebsd-tc-amd64/194.97.140.21:53341 Exit message received by peer
10:15:34 cron2-freebsd-tc-amd64/194.97.140.21:53341 Delayed exit in 5 seconds
10:15:38 read UDPv6 [ECONNREFUSED]: Connection refused (fd=5,code=111)
10:15:39 us=240199 cron2-freebsd-tc-amd64/194.97.140.21:53341 SIGTERM[soft,delayed-exit] received, client-instance exiting

(the ECONNREFUSED is "the client exited right away, so never saw the
control-plane ACK" - calling "--explicit-exit-notify 10" on the client
makes those last packets succeed, with no adverse effects on unwanted
restarts)

I have worked a bit on the commit message, and a lot on the new comment
block - I hope it is now clearer what could happen, and how this change
avoids the problem.

I have also added a Changes.rst entry (user-visible changes), pointing
out that "--remap-usr1 SIGTERM" will bring back the old behaviour, if
someone relies on it.


Your patch has been applied to the master branch.

commit d468dff7bdfd79059818c190ddf41b125bb658de
Author: Arne Schwabe
Date:   Sun Oct 16 17:49:53 2022 +0200

     Change exit signal in P2P to be a SIGUSR1 and delay CC exit in P2MP

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20221016154953.2483509-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25403.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


