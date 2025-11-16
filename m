Date: Sun, 16 Nov 2025 12:21:18 +0100 (CET)
Message-Id: <202511161121.5AGBLIcZ037286@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251114115029.17432-1-gert@...1296...>
References: <20251114115029.17432-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: recursive routing: fixes and
 clean-ups
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
To: Lev Stipakov <lev@...515...>
Cc: openvpn-devel@lists.sourceforge.net

Stared at the code, verified that it does not break anything - as for
the original commit, I have no setup with policy routing (yet) that would
actually excercise this, sending packets to "vpn server: different port"
into the tunnel.  Forcing recursive routing by pointing routes into the
tunnel does log what is expected (verb 4).

(Side note - why do we pass in "c" *and* "c->c2.buf"?  I guess the
compiler will optimize this all away, but still...)

Your patch has been applied to the master branch.

commit db241ceb7429c1d5b6ae65deab2051f1be01f867
Author: Lev Stipakov
Date:   Fri Nov 14 12:50:22 2025 +0100

     recursive routing: fixes and clean-ups

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1377
     Message-Id: <20251114115029.17432-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34415.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


