Date: Sun, 7 Jun 2020 13:04:17 +0200 (CEST)
Message-Id: <202006071104.057B4HJJ049341@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200530000600.1680-6-a@...2181...>
References: <20200530000600.1680-6-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: route: warn on IPv4 routes
 installation when no IPv4 is configured
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
To: Antonio Quartulli <antonio@...515...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

"because it makes sense" :-)

Tested on the client side (only) because this is really independent of
client/server setup.  Nicely warns if (and only if) a route for IPv4 or 
IPv6 is encountered without a previous ifconfig/ifconfig-ipv6.

Your patch has been applied to the master branch.

commit 826d8953a335fdbc8d20d800f800a44d0674f00a
Author: Antonio Quartulli
Date:   Sat May 30 02:05:58 2020 +0200

     route: warn on IPv4 routes installation when no IPv4 is configured

     Signed-off-by: Antonio Quartulli <antonio@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20200530000600.1680-6-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg19946.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


