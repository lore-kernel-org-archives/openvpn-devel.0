Date: Thu, 15 Jan 2026 11:06:27 +0100 (CET)
Message-Id: <202601151006.60FA6R8p052507@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260115092552.25011-1-gert@...1296...>
References: <20260115092552.25011-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: error: Remove our
 implementation of static_assert
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

Easy enough, and BB agrees that it still compiles fine on all formally
supported platforms (= we did not test Haiku or AIX, but even those have
gcc and should be fine).

URL links to sf.net today, because mail-archive.org is not working right.

Your patch has been applied to the master branch.

commit 6768ef1dab5cb6c1dbc210c20cf92820a64dace3
Author: Frank Lichtenheld
Date:   Thu Jan 15 10:25:47 2026 +0100

     error: Remove our implementation of static_assert

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1471
     Message-Id: <20260115092552.25011-1-gert@...1296...>
     URL: https://sourceforge.net/p/openvpn/mailman/message/59283672/
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


