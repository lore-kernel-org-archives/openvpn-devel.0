Date: Tue, 10 Jan 2023 08:15:01 +0100 (CET)
Message-Id: <202301100715.30A7F1wn037257@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230110015901.933522-1-arne@...1227...>
References: <20230110015901.933522-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add connect-freq-initial option
 to limit initial connection responses
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

The following tests were all done on v4.  diff v4->v5 is only the extra
MSVC build files, so I did not completely re-test v5.

Stare-at-code looks good now (thanks).  Fixed a bit of wording in the
commit message and reflect_filter.h comments.

Tested on the Linux server test rig, with "normal" traffic, "gremlins"
(~100 UDP gremlins) and "just bombarding with RESET packets".  Everything 
worked fine, and the new logs nicely show what is happening:

Jan  9 20:47:48 gentoo tun-udp-p2mp[1718]: Connection Attempt Note: --connect-freq-initial 100 10 rate limit exceeded, dropping initial handshake packets for the next 1 seconds
Jan  9 20:47:57 gentoo tun-udp-p2mp[1718]: Dropped 920 initial handshake packets due to --connect-freq-initial 100 10


I have also tested actually using the new option to change defaults :-)

2023-01-09 22:38:31 us=987098 Connection Attempt Note: --connect-freq-initial 200 30 rate limit exceeded, dropping initial handshake packets for the next 30 seconds

(and it does that)


MSVC builds succeed now (GHA), with v5, and for good measure I've thrown
in a "make distcheck" ("new source files") which succeeds as well.


Your patch has been applied to the master and release/2.6 branch.

commit b520c68c67b6e52cd71b16675f1c436abf18d4dc (master)
commit 93d8d92319816a36f53ef8772bd6705f6abc2df9 (release/2.6)
Author: Arne Schwabe
Date:   Tue Jan 10 02:59:01 2023 +0100

     Add connect-freq-initial option to limit initial connection responses

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20230110015901.933522-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25938.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


