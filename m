Date: Fri, 10 Jan 2025 08:14:10 +0100 (CET)
Message-Id: <202501100714.50A7EA9a042574@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250109180537.27686-1-gert@...1296...>
References: <20250109180537.27686-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Implement methods to generate
 and manage OpenVPN Epoch keys
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

Another patch in the series that doesn't actually change anything yet,
but builds infrastructure.  It comes with a fairly extensive unit test,
which passes :-)

The changes look reasonable to me, and have a +2 from MaxF in Gerrit
(who understands crypto much better).

As the patch actually does add a (not yet used) branch to the regular
AEAD cipher path and also changes the "impl_iv_offset" stuff, I stared
a bit harder, and subjected everything to the client/server testbed -
and nothing breaks in the old packet format.

Two comments have been grammar fixed as instructed ("the the -> the" and
"will will -> will").

Your patch has been applied to the master branch.

commit 92adbc88b1b37095cebde2a1c5b6ae242f382678
Author: Arne Schwabe
Date:   Thu Jan 9 19:05:37 2025 +0100

     Implement methods to generate and manage OpenVPN Epoch keys

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: MaxF <max@...2606...>
     Message-Id: <20250109180537.27686-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30390.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


