Date: Thu, 18 Dec 2025 12:47:31 +0100 (CET)
Message-Id: <202512181147.5BIBlV3j015074@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251218104042.5961-1-gert@...1296...>
References: <20251218104042.5961-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: tests/unit_tests: Port to
 cmocka 2.0.0 API
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

Looked at the code change - looks reasonable, and makes the unit tests
build (with "-Werror") on GHA macOS builders with upgraded cmocka again
(and everything still builds and passes UTs on older library versions,
verified by GHA and BB).

We also got a LGTM from Chosi on IRC :-)

Git complained about trailing whitespace in CMakeLists.txt (and fixed
it).  My understanding of CMake is that this should be correct.

Your patch has been applied to the master branch.

It will not "just cherrypick" back to release/2.6, as many of the affected
source lines are not there yet - but GHA tells me "we do not exercise any
of the warning-inducing functions yet", so we don't need it (yet) either.

commit 6db186e0b1d9783ea96e8a945a47fd23b45e4778
Author: Frank Lichtenheld
Date:   Thu Dec 18 11:40:32 2025 +0100

     tests/unit_tests: Port to cmocka 2.0.0 API

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1449
     Message-Id: <20251218104042.5961-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35144.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


