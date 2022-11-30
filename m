Date: Wed, 30 Nov 2022 21:33:49 +0100 (CET)
Message-Id: <202211302033.2AUKXnR2076501@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20221130165705.159610-1-arne@...1227...>
References: <20221130165705.159610-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Introduce connection state for
 reconnecting peer in p2p
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

This fixes the "tls/p2p reconnect with DCO breaks" problem that has 
haunting us for the last months, and does not break anything else - 
subjected to excessive client/server testing on Linux with/without DCO,
FreeBSD with/without DCO, and things look mostly good now.

This is: 
 - on *Linux*, all p2p reconnect problems are gone.
 - on *FreeBSD*, I can see that it instanciates a new peer, but ping
   echo reply packets never arrive at the client - I assume that this
   is due to ovpn(4) having no p2p mode, so "kernel goes multipoint,
   and is confused about IP/peer-id mapping" - we might need a
   "delete peer" call, or kernel-side fixes.

It *also* fixes the long-standing P2P NCP reconnection issue where
"connect with AES-256-GCM, ctrl-c, reconnect with only BF-CBC" would
lead to a confused peers (without any DCO involved).  Now, this just
works.  Party!


I wouldn't claim to understand all the fine grained details, but the
general approach "take note on reconnect that parts of do_up() need
to be redone, and later do that" seems logical, and the code is 
fairly non-hacky.

I've taken the liberty to fix a few more comments ("wihout pull" etc).

Your patch has been applied to the master branch.

commit 6c24767aa5e068ba8a4328c9efec1c01d43d6d9f
Author: Arne Schwabe
Date:   Wed Nov 30 17:57:05 2022 +0100

     Introduce connection state for reconnecting peer in p2p

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20221130165705.159610-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25595.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


