Date: Tue, 2 Aug 2022 15:26:36 +0200 (CEST)
Message-Id: <202208021326.272DQaeO072511@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220520213250.3126372-3-arne@...1227...>
References: <20220520213250.3126372-3-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Cleanup receive_auth_failed and
 simplify method
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

As Frank said, "best viewed with diff -w" :-) - the cleanup bits are
also straightforward.

I do not have a good test case for this - but my usual client tests with
"expect AUTH_FAILED..." all pass.

Your patch has been applied to the master branch.

commit 88823adebac31958cee83572241cff9fc775a601
Author: Arne Schwabe
Date:   Fri May 20 23:32:48 2022 +0200

     Cleanup receive_auth_failed and simplify method

     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20220520213250.3126372-3-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24412.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


