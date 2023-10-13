Date: Fri, 13 Oct 2023 19:43:36 +0200 (CEST)
Message-Id: <202310131743.39DHhacY047255@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20231009105832.34762-1-frank@...2641...>
References: <20231009105832.34762-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove ability to use
 configurations without TLS by default
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

Now we have something that is really unique to 2.7 and does not want
to be backported :-) - discussed at Hackathon, and this seems to be
the best way forward.  Pretend that this does not exist anymore, but
if we really break someone's access to their 1000km distant peer
(and they happen to upgrade the local end first!) it's still fixable...

The code change is fairly trivial.  For completeness, subjected to
the client + server side test runs...

Of course it broke test 8 :-)

   ERROR: tun-udp-p2p failed to start (no/empty pid file)

.. so I got to test the nice and shiny option...


Your patch has been applied to the master branch.

commit 392da5bdaaa94ca7e3e32f16084b47fc20b2c22d (master)
Author: Arne Schwabe
Date:   Mon Oct 9 12:58:32 2023 +0200

     Remove ability to use configurations without TLS by default

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20231009105832.34762-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27194.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


