Date: Sun, 6 Nov 2022 10:57:14 +0100 (CET)
Message-Id: <202211060957.2A69vE6X014485@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220831134140.913337-1-arne@...1227...>
References: <20220831134140.913337-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Always include ACKs for the
 last seen control packets
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

Applying Frank's ACK on v1 to v2, since the code is the same - just
context changes, and renaming of lru to mru.

Ran through server and client side testing, all works.

This also adds a unit test, which is very welcome :-) - complex stuff,
this, and not really easy to test ("I need to drop ACK #3 of the
handshake to see if the other end will do a retransmit or if it is
ACKed en passant with the next packet").

Stared a bit at the code, and while I'm not sure I understand all
details of the reliable code well enough, the parts that I *do* understand
look reasonable enough (and no memory-unsafe stuff etc).

Your patch has been applied to the master branch.

(I will push this together with 29/28)

commit c879609534e455471bc1e8091c78cbd9427d402b
Author: Arne Schwabe
Date:   Wed Aug 31 15:41:39 2022 +0200

     Always include ACKs for the last seen control packets

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20220831134140.913337-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25143.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


