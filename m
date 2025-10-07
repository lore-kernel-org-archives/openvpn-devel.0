Date: Tue, 7 Oct 2025 18:00:24 +0200 (CEST)
Message-Id: <202510071600.597G0OLO043983@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251007122747.16064-1-gert@...1296...>
References: <20251007122747.16064-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: sitnl: Clean up type handling
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

Stared at code (the whitespace change surrounding SITNL_NEST_END() took
a bit to understand where it came from... thanks, clang-format) - quite
a few changes...  look reasonable, ACK from the "code owner".

Tested on Linux/Sitnl client/server, just to be sure :-) - all still works.

Your patch has been applied to the master branch.

commit d4993125b9e51940960834fbc33c3cf292b8e899
Author: Frank Lichtenheld
Date:   Tue Oct 7 14:27:41 2025 +0200

     sitnl: Clean up type handling

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Antonio Quartulli <antonio@...2726...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1251
     Message-Id: <20251007122747.16064-1-gert@...1296...>
     URL: https://sourceforge.net/p/openvpn/mailman/message/59243289/
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


