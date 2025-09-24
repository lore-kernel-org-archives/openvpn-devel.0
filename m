Date: Wed, 24 Sep 2025 15:16:22 +0200 (CEST)
Message-Id: <202509241316.58ODGMJb073746@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250924124154.15963-1-gert@...1296...>
References: <20250924124154.15963-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Make unit tests -Wconversion
 clean
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

And et voila, the first #ifdef/#pragma set disappears again... and since
this is unit tests, it's easily testing itself :-)

Your patch has been applied to the master branch.

commit 9db98baf657c0aa6f56154019c531535d3d16ded
Author: Frank Lichtenheld
Date:   Wed Sep 24 14:41:48 2025 +0200

     Make unit tests -Wconversion clean

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1205
     Message-Id: <20250924124154.15963-1-gert@...1296...>
     URL: https://sourceforge.net/p/openvpn/mailman/message/59238128/
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


