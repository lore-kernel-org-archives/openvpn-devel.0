Date: Wed, 14 Dec 2022 22:56:12 +0100 (CET)
Message-Id: <202212142156.2BELuCT5059212@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20221214132835.1010-1-lstipakov@...277...>
References: <20221214132835.1010-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Rename dco_get_peer_stats to
 dco_get_peer_stats_multi
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
To: Lev Stipakov <lev@...515...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

This is really trivial renaming of all occurences of that function, 
and nothing else.  "git grep" confirms that ALL occurances have been
caught.  Test compiled for good measure, but as expected, nothing broke.

Your patch has been applied to the master and release/2.6 branch.

commit 6dbf8352ef2151dfdee7f02ccbdd9560b3e2be75 (master)
commit f45a8d80b8ce2f73026d5330a6664c4a78e9afc2 (release/2.6)
Author: Lev Stipakov
Date:   Wed Dec 14 15:28:35 2022 +0200

     Rename dco_get_peer_stats to dco_get_peer_stats_multi

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20221214132835.1010-1-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25690.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


