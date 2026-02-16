Date: Mon, 16 Feb 2026 15:54:24 +0100 (CET)
Message-Id: <202602161454.61GEsOSs067658@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260211150648.113547-1-frank@...2641...>
References: <20260211150648.113547-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: rework all occurrences of
 'M_ERR | M_ERRNO'
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Thanks for the review.

"Testing" this is somewhat hard (as not all of these error conditions can
be triggered at will), but as the patch is fairly straightforward and
only affects error-handling branches, "it compiles" is good enough for me ;-)

Your patch has been applied to the master and release/2.7 branch (bugfix).

commit f349b0a61499d3d36e69e2aa4dbbb7692b7d1df8 (master)
commit 158f1fa1ef139bad82ecaad284265fecdee6be66 (release/2.7)
Author: Gert Doering
Date:   Wed Feb 11 16:06:48 2026 +0100

     rework all occurrences of 'M_ERR | M_ERRNO'

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1517
     Message-Id: <20260211150648.113547-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35594.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


