Date: Sun, 19 Jan 2020 11:19:10 +0100 (CET)
Message-Id: <202001191019.00JAJAiP057873@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20191219132953.375-1-lstipakov@...277...>
References: <20191219132953.375-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: options.c: do not force route
 delay when not using DHCP
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

Your patch has been applied to the master branch.

(Stared a bit at the code, sounds reasonable, no testing whatsoever)

commit dd4647acf40b26bb8d7403debc00a342c663d618
Author: Lev Stipakov
Date:   Thu Dec 19 15:29:53 2019 +0200

     options.c: do not force route delay when not using DHCP

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-By: Simon Rozman <simon@...2293...>
     Message-Id: <20191219132953.375-1-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg19257.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


