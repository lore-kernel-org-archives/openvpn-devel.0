Date: Sun, 14 Sep 2025 15:26:21 +0200 (CEST)
Message-Id: <202509141326.58EDQLjA088857@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250911201505.25582-1-gert@...1296...>
References: <20250911201505.25582-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: options: Factor out usages of
 strtoll and atoll
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

Change looks reasonable, MaxF has ACKed it, the BBs confirm nothing breaks,
and I have actually very lightly tested it (--reneg-pkts, --reneg-bytes,
with easily-achievable values - watch out for DCO...).

For values >2^63, strtoll() truncates to 9223372036854775808 - which
is documented and tested for.  We do not error on this today, but
for what it's used for, clamping is probably fine (because larger
numbers make even less sense).

Your patch has been applied to the master branch.

This time, mail-archive.org (for a change) actually acknowledges existance
of the mail with the patch... yay.

commit 10c42c7407ccc467f75e25f752275e412ff35a91
Author: Frank Lichtenheld
Date:   Thu Sep 11 22:15:00 2025 +0200

     options: Factor out usages of strtoll and atoll

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: MaxF <max@...2606...>
     URL: https://gerrit.openvpn.net/c/openvpn/+/1154
     Message-Id: <20250911201505.25582-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32858.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


