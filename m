Date: Wed, 18 Dec 2019 21:10:40 +0100 (CET)
Message-Id: <201912182010.xBIKAevL014872@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20191112144400.1359-1-lstipakov@...277...>
References: <20191112144400.1359-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: wintun: clear adapter settings
 on tun close
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

Fixed the "char *foo" comment Selva had on the fly.

Test built on Ubuntu 1604/mingw.  No further tests.

Stared a bit at the code.  Not sure I like the way this overloads
v4/v6 into the same function just to be able to share a bit of common
code (at the expense of lots of conditionals which make the resulting
function not easy to read, and a local variable "ifconfig_ip_local"
which could be IPv4 or IPv6 now).  Antonio has just *separated*
IPv4 and IPv6 ifconfig into two independent functions to make the code 
more readable...

commit ef9b34044ec354902cd24bbcee244c6a494b6c7c
Author: Lev Stipakov
Date:   Tue Nov 12 16:44:00 2019 +0200

     wintun: clear adapter settings on tun close

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Selva Nair <selva.nair@...277...>
     Message-Id: <20191112144400.1359-1-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg19124.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


