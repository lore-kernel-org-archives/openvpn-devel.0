Date: Mon, 20 Mar 2023 14:34:14 +0100 (CET)
Message-Id: <202303201334.32KDYE4q063500@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230301135353.2811069-1-arne@...1227...>
References: <20230301135353.2811069-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Use key_state instead of multi
 for tls_send_payload parameter
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

Acked-by: Gert Doering <gert@...1296...>

This one is fairly trivial refactoring - moving the "ks = get_key_scan()"
part out of tls_send_payload(), passing in "ks" instead of "multi".

Stared-at-code (straightforward), fed to GH for "maybe it is not?" and
local client side test.

Your patch has been applied to the master branch.

commit 06af538eb7bde36feb20ef63febb171c9607a5e6 (master)
commit 31279f71ab4124516fd0c2143f67a0c3f008ad20 (release/2.6)
Author: Arne Schwabe
Date:   Wed Mar 1 14:53:52 2023 +0100

     Use key_state instead of multi for tls_send_payload parameter

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20230301135353.2811069-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26319.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


