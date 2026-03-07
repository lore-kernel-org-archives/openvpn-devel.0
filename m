Date: Sat, 7 Mar 2026 10:10:40 +0100 (CET)
Message-Id: <202603070910.6279Ae1D028106@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260306163337.2756-1-gert@...1296...>
References: <20260306163337.2756-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix various sign-compare
 warnings due to write return value
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

While I do have some question about this and -Wsign-conversion, the
patch as it looks reasonable (and in the first hunk, improves readability
as well).  BB all green, here we go :-)

Your patch has been applied to the master branch.

commit 0401eacfe255ccd7b41fa594e004fddeb8ba1a24
Author: Frank Lichtenheld
Date:   Fri Mar 6 17:33:31 2026 +0100

     Fix various sign-compare warnings due to write return value

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1513
     Message-Id: <20260306163337.2756-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35963.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


