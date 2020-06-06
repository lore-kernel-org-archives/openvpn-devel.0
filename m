Date: Sat, 6 Jun 2020 16:27:39 +0200 (CEST)
Message-Id: <202006061427.056ERdOL024499@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200530000600.1680-4-a@...2181...>
References: <20200530000600.1680-4-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: allow usage of --server-ipv6
 even when no --server is specified
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

Stared-at-code and tested on the t_server setup.  Sufficiently trivial
change :-) - but also all the other code parts that assume "if you do
--server-ipv6, you must have done --server as well!!" have been adjusted
in previous patches (ipv6-only ifconfig, ipv6-only pools).

Your patch has been applied to the master branch.

commit 7d65aad8973fa85a007a3de8907b9cbced20b2b4
Author: Antonio Quartulli
Date:   Sat May 30 02:05:56 2020 +0200

     allow usage of --server-ipv6 even when no --server is specified

     Signed-off-by: Antonio Quartulli <antonio@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20200530000600.1680-4-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg19949.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


