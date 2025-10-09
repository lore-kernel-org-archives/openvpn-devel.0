Date: Thu, 9 Oct 2025 19:33:36 +0200 (CEST)
Message-Id: <202510091733.599HXaXc046289@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251009171916.12811-1-gert@...1296...>
References: <20251009171916.12811-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Preserve ifconfig(_ipv6)_local
 across reconnect
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

Tested, fixes a larger part of the issue in #850, opens the way for a
new issue in #863 (something "not working right" that was working "not
at all" without this).

Your patch has been applied to the master branch.

commit 8a8360fc176b3996bfefee0ea894dc5c8a9ead1a
Author: Lev Stipakov
Date:   Thu Oct 9 19:19:11 2025 +0200

     Preserve ifconfig(_ipv6)_local across reconnect

     Signed-off-by: Lev Stipakov <lev@...515...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1248
     Message-Id: <20251009171916.12811-1-gert@...1296...>
     URL: https://sourceforge.net/p/openvpn/mailman/message/59244523/
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


