Date: Mon, 8 Dec 2025 15:41:31 +0100 (CET)
Message-Id: <202512081441.5B8EfVfR014043@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251208113636.9650-1-gert@...1296...>
References: <20251208113636.9650-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: CMake: For VS build,
 switch from /W2 to /W3
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

Windows building, turn on more warnings (welcome), ignoring those that
we do not have fixed yet - makes sense :-) - plus documentation!

Tested via GHA builds.

Your patch has been applied to the master branch.

commit 9a2420fd63265166d1b60a38e8180aa360473ddc
Author: Frank Lichtenheld
Date:   Mon Dec 8 12:36:30 2025 +0100

     CMake: For VS build, switch from /W2 to /W3

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1417
     Message-Id: <20251208113636.9650-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34876.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


