Date: Wed, 8 Oct 2025 11:44:10 +0200 (CEST)
Message-Id: <202510080944.5989iA4g079167@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251008092859.875-1-gert@...1296...>
References: <20251008092859.875-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: crypto: Make some casts to int
 explicit
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
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

What it says on the lid, with the extra length check (for the somewhat
unlikely case that someone feeds us a config file with an inline key
longer than INT_MAX :-) ).  MaxF did an early review and this part
was missing.

BBs say it's good, stare-at-code also makes sense, plus #1252 squashed.

Your patch has been applied to the master branch.

commit e0b5ea5db92f450eba60ed5eab632ba2239b1e56
Author: Frank Lichtenheld
Date:   Wed Oct 8 11:28:54 2025 +0200

     crypto: Make some casts to int explicit

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1217
     Message-Id: <20251008092859.875-1-gert@...1296...>
     URL: https://sourceforge.net/p/openvpn/mailman/message/59243794/
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


