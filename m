Date: Thu, 15 Jan 2026 10:38:50 +0100 (CET)
Message-Id: <202601150938.60F9conY051867@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260115093235.25635-1-gert@...1296...>
References: <20260115093235.25635-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: ssl_verify: Fix parsing of
 timeout from auth pending file
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

"makes sense", also the text wrapping close by really needed fixing.

Not tested beyond BB compile.

Your patch has been applied to the master branch.

commit b34dc9279d774756a2451ff783d0f71a21d3f42c
Author: Frank Lichtenheld
Date:   Thu Jan 15 10:32:29 2026 +0100

     ssl_verify: Fix parsing of timeout from auth pending file

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1451
     Message-Id: <20260115093235.25635-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35275.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


