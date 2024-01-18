Date: Thu, 18 Jan 2024 18:06:54 +0100 (CET)
Message-Id: <202401181706.40IH6sid094155@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240118164903.22519-1-gert@...1296...>
References: <20240118164903.22519-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: proxy-options.rst: Add proper
 documentation for --http-proxy-user-pass
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

Your patch has been applied to the master and release/2.6 branch (docs).

(2.6 needed conflict resultion because of the "NTLMv1 has been removed"
line)

commit d3f84afedd33734416704d5d92e8d3ac639ef491 (master)
commit 7b1f2009ce9670e2e0ffea0c01b1c4922a2d4369 (release/2.6)
Author: Frank Lichtenheld
Date:   Thu Jan 18 17:49:03 2024 +0100

     proxy-options.rst: Add proper documentation for --http-proxy-user-pass

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20240118164903.22519-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28083.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


