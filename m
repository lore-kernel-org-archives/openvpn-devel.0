Date: Sat, 11 Oct 2025 13:48:51 +0200 (CEST)
Message-Id: <202510111148.59BBmpHr078609@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251011111417.11802-1-gert@...1296...>
References: <20251011111417.11802-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: redirect-gateway: only redirect
 traffic through TUN if address families match
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
To: Marco Baffo <marco@...2726...>
Cc: openvpn-devel@lists.sourceforge.net

So, this is still fixing an edge case when reconnecting and having
stale data around - a better fix, I think, would be to properly extend
pre-connect save/restore to the RG flags (and remove this check again)
- but for now, it does the job.  I have added a reference to the
new GH issue (863) for the subsequent cleanup.

Not tested beyond "BB confirms it's not breaking platforms" and a bit
of stare-at-code.

Your patch has been applied to the master branch.

commit 1b423f508e7ebf70e711c90bc9cf2e57c1f197f0
Author: Marco Baffo
Date:   Sat Oct 11 13:14:11 2025 +0200

     redirect-gateway: only redirect traffic through TUN if address families match

     Signed-off-by: mrbff <marco@...2726...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1210
     Message-Id: <20251011111417.11802-1-gert@...1296...>
     URL: https://sourceforge.net/p/openvpn/mailman/message/59245295/
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


