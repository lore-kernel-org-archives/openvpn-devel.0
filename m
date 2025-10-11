Date: Sat, 11 Oct 2025 10:32:50 +0200 (CEST)
Message-Id: <202510110832.59B8Wohq012636@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251011082217.27568-1-gert@...1296...>
References: <20251011082217.27568-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Move build_dhcp_options_string
 from tun to dhcp
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

"git show --color-moved" confirms that this is just moving stuff out
of tun.c (good thing) plus a few #ifdefs / static / prototypes.

BB tests are all green, so I only did a quick MinGW sanity check compile
(passes).

Your patch has been applied to the master branch.

commit f63e6c03eabaa87d0775354b60e146a6f28c718e
Author: Frank Lichtenheld
Date:   Sat Oct 11 10:22:11 2025 +0200

     Move build_dhcp_options_string from tun to dhcp

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1265
     Message-Id: <20251011082217.27568-1-gert@...1296...>
     URL: https://sourceforge.net/p/openvpn/mailman/message/59245240/
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


