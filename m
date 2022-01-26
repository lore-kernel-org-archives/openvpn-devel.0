Date: Wed, 26 Jan 2022 14:33:48 +0100 (CET)
Message-Id: <202201261333.20QDXmXB058403@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220121052259.508-2-lstipakov@...277...>
References: <20220121052259.508-2-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: xkey: fix msvc build
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

This time I'm sure I have an ACK :-) - and the changes look reasonable.

Compile tested on linux/3.0.1, just to avoid typos that went unnoticed
(all fine).

Your patch has been applied to the master branch.

commit 627d1a3d286386067a93b755def308ea70060310
Author: Lev Stipakov
Date:   Fri Jan 21 07:22:58 2022 +0200

     xkey: fix msvc build

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Selva Nair <selva.nair@...277...>
     Message-Id: <20220121052259.508-2-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23643.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


