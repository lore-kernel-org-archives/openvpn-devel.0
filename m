Date: Wed, 5 Jun 2024 22:48:47 +0200 (CEST)
Message-Id: <202406052048.455KmlPX018027@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240605123856.26267-1-gert@...1296...>
References: <20240605123856.26267-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Windows: enforce 'block-local'
 with WFP filters
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
To: Heiko Hund <heiko@...2662...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Lev has tested it and confirms that it works, I have stared long and
hard at v5 of the patch, and the diffs v5->v6.  The main difference
v5->v6 is to make it error clean (add a "= 0") *and* that it also
blocks DNS going out of the loopback interface - so if there's magic
DNS proxy software using 127.0.0.1:53, the old "block-outside-dns"
code would have not blocked it, but this new code *will*.  Somewhat
unrelated featurette, but same code path, and same intent "avoid
VPN leaks of any kind, DNS or data".


This is really nice functionality to ward of all "TunnelCrack" or
"TunnelVision" style attacks on Windows clients, by extending the
existing "redirect-gateway block-local" config option to add WFP 
firewall filters to really *really* block everything not going into
the tunnel.

I would have wished for two patches ("one for the renaming, one for
the functional changes") but I already postponed this for too long...

In addition to Lev's tests I have compile-tested on GHA and a local
MinGW build.  No surprises there.


I intend to apply this to release/2.6 as well as master, but want to
have more test coverage first.  So I'll send mails around to solicit
test coverage as soon as I have a git master snapshot installer to test.

Your patch has been applied to the master branch.

commit bf887c95e46c6892ac1f68be5559525f8d975530 (master)
Author: Heiko Hund
Date:   Wed Jun 5 14:38:56 2024 +0200

     Windows: enforce 'block-local' with WFP filters

     Signed-off-by: Heiko Hund <heiko@...2662...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20240605123856.26267-1-gert@...1296...>
     URL: https://www.mail-archive.com/search?l=mid&q=20240605123856.26267-1-gert@...1296...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


