Date: Tue, 1 Apr 2025 16:07:47 +0200 (CEST)
Message-Id: <202504011407.531E7lb2080853@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250325105724.1285-1-gert@...1296...>
References: <20250325105724.1285-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: socket: use remote proto when
 creating client sockets
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
To: Antonio Quartulli <antonio@...2726...>
Cc: openvpn-devel@lists.sourceforge.net

Yeah, too many protos around...  Arne and Lev confirm that this is what
is needed to un-confuse "--local <with proto>" and "--remote <with proto>"
and general "--<proto>" (--udp4 etc) for the client case...

Tested with standard and extended t_client test set (extended = one
stanza that has multiple --remote with different protos *and* --local
bound to a local IP).

There's a number of interesting ways to break things here 
("--local ipv4 --remote ipv6 --proto udp6") but that's all clear
misconfigs - these have never worked, it's just that the error messages
 are bit different with multisocket.  "--local $hostname" with something
that resolves to both an ipv4 and ipv6 address nicely binds to whatever
the "--remote" stanza tries to use (v4/v6).  Good.

Your patch has been applied to the master branch.

commit 39cd7f29cbccd37b07ddc27eb23b8ad270f43e77
Author: Antonio Quartulli
Date:   Tue Mar 25 11:57:24 2025 +0100

     socket: use remote proto when creating client sockets

     Signed-off-by: Antonio Quartulli <antonio@...2726...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Message-Id: <20250325105724.1285-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31234.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


