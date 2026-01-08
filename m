Date: Thu, 8 Jan 2026 16:51:48 +0100 (CET)
Message-Id: <202601081551.608FpmWf097133@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260108154248.21706-1-gert@...1296...>
References: <20260108154248.21706-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix building test_tls_crypt
 with cmocka 2.0
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

As it says on the lid :-) - the change affects only UT test code, is
straightforward, and the tests still pass for old libcmocka versions.

Onwards!

Your patch has been applied to the master branch.

commit 20f8127bcd31918af6f97570765d136ebf0fb801
Author: Frank Lichtenheld
Date:   Thu Jan 8 16:42:43 2026 +0100

     Fix building test_tls_crypt with cmocka 2.0

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1460
     Message-Id: <20260108154248.21706-1-gert@...1296...>
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


