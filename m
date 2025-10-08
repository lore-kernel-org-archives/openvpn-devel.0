Date: Wed, 8 Oct 2025 12:43:57 +0200 (CEST)
Message-Id: <202510081043.598Ahvvq081573@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251008103001.7696-1-gert@...1296...>
References: <20251008103001.7696-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: buffer: Fix buf_parse eating
 input
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

So - stared at code, typical "we have a character here that we can not
handle right now, oops, where is did it disappear to?" thing, and the
peek() fix makes sense.  Also, tested against #1247, which fails without
this patch, and succeeds afterwards.  BB is happy as well, and we get
a new UT test...

Recorded the second +2 in gerrit here in the commit, the mail does not
show it due to "fingers too fast" timing :) - but gerrit has it.

Your patch has been applied to the master branch.

commit f5a2e2319bc7c3cce7f5cdccae44b9bae3e33375
Author: Frank Lichtenheld
Date:   Wed Oct 8 12:29:55 2025 +0200

     buffer: Fix buf_parse eating input

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1246
     Message-Id: <20251008103001.7696-1-gert@...1296...>
     URL: https://sourceforge.net/p/openvpn/mailman/message/59243829/
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


