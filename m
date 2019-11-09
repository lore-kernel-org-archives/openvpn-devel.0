Date: Sat, 9 Nov 2019 18:32:22 +0100 (CET)
Message-Id: <201911091732.xA9HWMwT083916@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20191109163714.25506-1-a@...2181...>
References: <20191109163714.25506-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: socks: use the right function
 when printing struct openvpn_sockaddr
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
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Thanks for fixing my oversight (amazing we both did not see the
warning in the first patch...).   socks.c compiles without warning
now, and still prints the right address.

Your patch has been applied to the master and release/2.4 branch (bugfix).

commit 6c39b4dc4766594c6517043af59aeea53ea009d0 (master)
commit 0ba4f91667b8931684e704d1836d71c893e3b9f6 (resolve/2.4)
Author: Antonio Quartulli
Date:   Sat Nov 9 17:37:14 2019 +0100

     socks: use the right function when printing struct openvpn_sockaddr

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20191109163714.25506-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg19073.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


