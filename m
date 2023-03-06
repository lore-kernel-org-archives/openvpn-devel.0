Date: Mon, 6 Mar 2023 14:32:33 +0100 (CET)
Message-Id: <202303061332.326DWXuF022820@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230306053346.796992-1-selva.nair@...277...>
References: <20230306053346.796992-1-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Do not save pointer to 'struct
 passwd' returned by getpwnam etc.
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Well spotted.  Whatever we decide to do with 2/2, this is the
correct way to deal with getpw*() returns.

I have not tested every possible combination of options, but I
have stared-at-code (looks good), had the buildbots test it,
and ran a "--user nobody" DCO instance on Linux (works).

Your patch has been applied to the master and release/2.6 branch.

commit 62024046dffd6ff10309b791cd6600fe80bc46e3 (master)
commit 85ad9d2520d571dff93d2b15002f151c10000804 (release/2.6)
Author: Selva Nair
Date:   Mon Mar 6 00:33:45 2023 -0500

     Do not save pointer to 'struct passwd' returned by getpwnam etc.

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20230306053346.796992-1-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26332.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


