Date: Wed, 8 Apr 2026 14:39:47 +0200 (CEST)
Message-Id: <202604081239.638CdlTS072960@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260407205235.31126-1-gert@...1296...>
References: <20260407205235.31126-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Clarify operator precedence in
 a & b ? c : d
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

Highly appreciated... (and oops, two of them are mine).  No actual change
in functionality, just ensuring a clear and shared understanding between
compiler and humans reading the code... stared-at-code, test compiled,
BB ran client side tests.

Your patch has been applied to the master branch.

commit 1491fc8e05b01e65aba8b50499407d9af0424d69
Author: Frank Lichtenheld
Date:   Tue Apr 7 22:52:28 2026 +0200

     Clarify operator precedence in a & b ? c : d

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1619
     Message-Id: <20260407205235.31126-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36545.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


