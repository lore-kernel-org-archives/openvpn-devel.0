Date: Thu, 16 Oct 2025 14:12:12 +0200 (CEST)
Message-Id: <202510161212.59GCCCMT031249@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251016103730.5319-1-gert@...1296...>
References: <20251016103730.5319-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: proxy: factor out send code
 common with socks proxy
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

Change looks good (stare-at-code), client/server tests on linux excercising
all the proxies also works fine.  BB all green.

Your patch has been applied to the master branch.

commit 23d70b08a94b150f5df76449e2acbf7a1160146a
Author: Frank Lichtenheld
Date:   Thu Oct 16 12:37:22 2025 +0200

     proxy: factor out send code common with socks proxy

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1279
     Message-Id: <20251016103730.5319-1-gert@...1296...>
     URL: https://sourceforge.net/p/openvpn/mailman/message/59247465/
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


