Date: Mon, 17 Feb 2020 19:39:39 +0100 (CET)
Message-Id: <202002171839.01HIddLx075561@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200217144339.3273-3-arne@...1227...>
References: <20200217144339.3273-3-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add strsep compat function
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

Your patch has been applied to the master branch.

Not much to test here, yet, as we're not calling strsep() anywhere yet
(and I do not have a system without strsep() at hand, all my Unix boxes
have it, even AIX).

commit 0a88ef8c2a6b573f9f21b122bd4818265d39d710
Author: Arne Schwabe
Date:   Mon Feb 17 15:43:36 2020 +0100

     Add strsep compat function

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <20200217144339.3273-3-arne@...1227...>
     URL: https://www.mail-archive.com/search?l=mid&q=20200217144339.3273-3-arne@...1227...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


