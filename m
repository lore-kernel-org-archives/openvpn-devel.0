Date: Tue, 16 May 2023 18:12:28 +0200 (CEST)
Message-Id: <202305161612.34GGCSwt052425@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230511101253.369196-1-frank@...2641...>
References: <20230511101253.369196-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: tests: Allow to override
 openvpn binary used
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

Acked-by: Gert Doering <gert@...1296...>

Looks good. Existing tests still work (tested in-tree and out-of-tree
builds, but in the end that's both "../src/openvpn/openvpn")

"make check openvpn=$path/openvpn" also runs the specified binary.  

Your patch has been applied to the master branch.

(Since most development happens there, not sure we need this in 2.6)

commit d623aa6c29545a7f00daaa73d87818a9c5b1e942
Author: Frank Lichtenheld
Date:   Thu May 11 12:12:53 2023 +0200

     tests: Allow to override openvpn binary used

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20230511101253.369196-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26648.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


