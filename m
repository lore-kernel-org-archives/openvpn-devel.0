Date: Tue, 20 Apr 2021 12:27:54 +0200 (CEST)
Message-Id: <202104201027.13KARsGN013068@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210418160111.1494779-1-arne@...1227...>
References: <20210418160111.1494779-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Move context_auth from
 context_2 to tls_multi and name it multi_state
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

Taking Antonio's ACK on v2, adding my own to v3.  This fixes the compile
problems with ENABLE_ASYNC_PUSH and the extra comment about p2p / !multi
is indeed very helpful to understand why this is *exactly* the way it
is.  Thanks.  "v3 comment" added to the commit message, stray "t he" fixed.

Subjected together with the 2/2 v2 patch (only hunk 2) to the server 
torture chamber, and it passed nicely...

Test sets succeeded: 1 1a 1b 1c 1d 1e 2 2a 2b 2c 2g 2d 2e 2f 2z1 2z2 3 4 4a 4b 5 5a 5b 5c 5d 5v1 5v2 5v3 5w1 5w2 5w3 5w4 5x1 5x2 5x3 5x4 6 7 7x 7y 8 8a 9 9a.


Backport to 2.5 was done because it is required for the 2/2 bugfix. 
2.5 looks sufficiently different in context and push.c that there
were quite a few conflicts and one extra "context_auth" to adjust - but
nothing that wasn't fairly straightforward to sort out.  2.5 of course
subjected to the same tests...

Your patch has been applied to the master and release/2.5 branch.

commit 0767d5b447044e4cdcfd198058aef1f85f63bbe6 (master)
commit 145110101b70599cb9adcf4ed071856daac9c8af (release/2.5)
Author: Arne Schwabe
Date:   Sun Apr 18 18:01:11 2021 +0200

     Move context_auth from context_2 to tls_multi and name it multi_state

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20210418160111.1494779-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22155.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


