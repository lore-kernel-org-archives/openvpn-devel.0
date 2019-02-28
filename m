Date: Thu, 28 Feb 2019 16:26:34 +0100 (CET)
Message-Id: <201902281526.x1SFQYaT041436@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20190224181544.17232-1-simon@...2293...>
References: <20190224181544.17232-1-simon@...2293...>
Subject: [Openvpn-devel] [PATCH applied] Re: Refactor OpenVPNService state
 detection code
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
To: Simon Rozman <simon@...2293...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

(Basically just reworking if/goto into if/else, plus more verbose comments.
"Git show -w --color-moved=zebra" helps in seeing "nothing really changed")

Your patch has been applied to the master branch.

commit 197f8076e43534f3dfe50e3c638143c38f4bad7f
Author: Simon Rozman
Date:   Sun Feb 24 19:15:44 2019 +0100

     Refactor OpenVPNService state detection code

     Signed-off-by: Simon Rozman <simon@...2293...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20190224181544.17232-1-simon@...2293...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg18233.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


