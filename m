Date: Thu, 30 Oct 2025 17:37:17 +0100 (CET)
Message-Id: <202510301637.59UGbHQt016289@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251030150214.4161-1-gert@...1296...>
References: <20251030150214.4161-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: iservice: use interface index
 with netsh
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
To: Heiko Hund <heiko@...2662...>
Cc: openvpn-devel@lists.sourceforge.net

Patch looks good, makes sense, BB is happy, and so is Lev :-)

Test compiled on mingw/ubuntu22.04 (which broke due to 05a8ba808, but
that is a different finding - this one is good).

Your patch has been applied to the master branch.

I think it should go to release/2.6 as well (hardening against something
managing to send broken interface names and breaking WINS config that 
way) - it does not apply straightforward, due to "too large surrounding
code changes".  Could you...? ;-)

commit 5f6b5e38ca0d8aa5f1da0e5465bcf9d7384ccb41
Author: Heiko Hund
Date:   Thu Oct 30 16:01:49 2025 +0100

     iservice: use interface index with netsh

     Signed-off-by: Heiko Hund <heiko@...2662...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1308
     Message-Id: <20251030150214.4161-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34037.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


