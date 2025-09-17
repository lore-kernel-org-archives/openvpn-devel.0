Date: Wed, 17 Sep 2025 11:59:25 +0200 (CEST)
Message-Id: <202509170959.58H9xP4p026590@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250916155258.6864-1-gert@...1296...>
References: <20250916155258.6864-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Check message id/acked ids too
 when doing sessionid cookie checks
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

So this is basically a cherry-pick of the master commit 518e122b4273
to 2.6 ("because it fixes a real problem for at least one server operator"),
adjusted for clang-format/uncrustify formatting differences.

I have only lightly tested this - it comes with its unit tests, those
pass, and t_client tests also pass *and* the commit looks good, so there's
no rebase accidents here.

I've cleaned up the proliferation of Message-ID and URL:s recorded
here (master + 2.6 version), and added the master commit reference.

Your patch has been applied to the release/2.6 branch.

commit 68c01720eecc1772b3f648b9e043e396d943f632
Author: Arne Schwabe
Date:   Tue Sep 16 17:52:50 2025 +0200

     Check message id/acked ids too when doing sessionid cookie checks

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: MaxF <max@...2606...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1184
     Message-Id: <20250916155258.6864-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32990.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


