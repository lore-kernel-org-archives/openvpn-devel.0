Date: Mon, 3 May 2021 08:53:43 +0200 (CEST)
Message-Id: <202105030653.1436rhYu037621@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210422152939.2134046-1-arne@...1227...>
References: <20210422152939.2134046-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Avoid failing_test unused
 warning in example_test
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

Acked-by: Gert Doering <gert@...1296...>

Acked-by: Gert Doering <gert@...1296...>

This might break compilation of the example test on non-gcc/clang platforms.

I do not have one at hand, though - my OpenSolaris box has no Sun CC, so
is using gcc...  and on AIX, I do not compile the test suite anyway (no
cmocka).  So this might come back one day as a patch with #ifdef GCC
around the __attribute__

Your patch has been applied to the master branch.

commit 7f600bd39d6e2b034e5a16f65bc639623ff96ae0
Author: Arne Schwabe
Date:   Thu Apr 22 17:29:34 2021 +0200

     Avoid failing_test unused warning in example_test

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20210422152939.2134046-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22205.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


