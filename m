Date: Sat, 24 Dec 2022 22:47:44 +0100 (CET)
Message-Id: <202212242147.2BOLlius008013@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20221224194253.3202231-3-arne@...1227...>
References: <20221224194253.3202231-3-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Always start session in
 TM_INITIAL rather than TM_ACTIVE or TM_INITIAL
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

"Simplifying state machine much good" :-)

I have stared at the code a bit ("seems to make sense") and fed this to
the full test rig - extensive client side tests on Linux and FreeBSD,
full set of server side tests on Linux (DCO and no DCO).  Didn't test
FreeBSD/DCO as this is really just TLS handshakes, and all the weirdness
in the past related to TLS handshake have hit both platforms the same
way.

I did have an extra eye on the p2p TLS tests that tended to fail if
the timing was just right - repaired keepalive already fixed those, 
so I tried without keepalive, with the usual timing (reneg-sec 300,
reconnect after 400s).

Dec 24 22:42:13 ubuntu2004 tun-udp-p2p-tls-sha256[1805147]: TLS: move_session: dest=TM_LAME_DUCK src=TM_ACTIVE reinit_src=1

.. but this still confuses the --tls-server...

Dec 24 22:43:14 ubuntu2004 tun-udp-p2p-tls-sha256[1805147]: TLS Error: TLS key negotiation failed to occur within 60 seconds (check your network connectivity)
Dec 24 22:43:14 ubuntu2004 tun-udp-p2p-tls-sha256[1805147]: TLS Error: TLS handshake failed
Dec 24 22:43:20 ubuntu2004 tun-udp-p2p-tls-sha256[1805147]: TLS Error: Received control packet from unexpected IP addr: [AF_INET6]::ffff:194.97.140.5:49828

.. and it will then fail to establish connections.  So this is no worse
than without this patch (and no better).  The server will eventually
recover (after 3600s), but --keepalive will fix it as well.

Let's see if the "send UDP directly" patch will fix that one.


Your patch has been applied to the master and release/2.6 branch,
squashed together with 1/9.

commit 7dcde87b7a4323ffb173576d4559e14fcfe4e627 (master)
commit 9828c7045a27e7dc5e6f430798323a1abd003fbf (release/2.6)
Author: Arne Schwabe
Date:   Sat Dec 24 20:42:46 2022 +0100

     Always start session in TM_INITIAL rather than TM_ACTIVE or TM_INITIAL

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20221224194253.3202231-3-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25795.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


