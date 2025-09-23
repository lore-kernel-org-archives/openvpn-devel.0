Date: Tue, 23 Sep 2025 14:42:01 +0200 (CEST)
Message-Id: <202509231242.58NCg1Vt014862@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250923103429.1257-1-gert@...1296...>
References: <20250923103429.1257-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Clean up conversion warnings
 related to base64_{en, de}code
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

This is a bit bigger than "just int", and the functions are not that
easy to understand... so I stared a bit longer, and also ran all the
t_server self tests (because there's plugins that use username/password
and auth-token, so, base64 should better work - it does).

Reference link to sf.net...

Your patch has been applied to the master branch.

commit f32844b25c3b3b352bad0b250fd8721656ae9bc0
Author: Frank Lichtenheld
Date:   Tue Sep 23 12:34:23 2025 +0200

     Clean up conversion warnings related to base64_{en, de}code

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1148
     Message-Id: <20250923103429.1257-1-gert@...1296...>
     URL: https://sourceforge.net/p/openvpn/mailman/message/59237399/
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


