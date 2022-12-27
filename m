Date: Tue, 27 Dec 2022 17:58:21 +0100 (CET)
Message-Id: <202212271658.2BRGwLfc015538@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20221227022404.3468137-3-arne@...1227...>
References: <20221227022404.3468137-3-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Ignore
 OVPN_DEL_PEER_REASON_USERSPACE to avoid race conditions
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

I have not actually seen this particular race (or if I have seen it it
was drowned in lots of other events) - but yeah, to fully ignore this
seems better than "kill peer <x> just because we ended a peer with
the very same peer-id <x> a few seconds ago".

To achieve the "some other program might have sent this" original idea,
one would need to add a sending PID ("we ignore everything with our
own PID"), or some sort of ACK mechanism ("we do not re-assign the
peer-id <x> until we have confirmation from the kernel").  This would
certainly be nice, but for now, ignore it is.

Tested on the ubuntu2004 DCO system (client/server), with no gremlins.

Your patch has been applied to the master branch.

commit 6ad66b0c2950c0d7674a5867085fef8115f61d11 (master)
commit eec054a95820ffa7e548f47078ec0101d6949907 (release/2.6)
Author: Arne Schwabe
Date:   Tue Dec 27 03:24:03 2022 +0100

     Ignore OVPN_DEL_PEER_REASON_USERSPACE to avoid race conditions

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20221227022404.3468137-3-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25820.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


