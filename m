Date: Thu, 1 Apr 2021 16:09:05 +0200 (CEST)
Message-Id: <202104011409.131E95Cq093291@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210401131337.3684-10-arne@...1227...>
References: <20210401131337.3684-10-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Move is_proto function to the
 socket.h header
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

Moved and compacted somewhat, but "the same functions".

Having a "proto_is_dgram()" sounds a bit silly since we're not doing
"openvpn over IPX" or anything other dgram based, but who knows... maybe
we'll grow IPX/SPX support and "proto_is_stream()" one day... :-)

Client-side tested on Linux and FreeBSD, just to be sure.

Your patch has been applied to the master branch.

commit 72e1ecb5b5d282c591cc32bbd378efbebfb03918
Author: Arne Schwabe
Date:   Thu Apr 1 15:13:32 2021 +0200

     Move is_proto function to the socket.h header

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20210401131337.3684-10-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21950.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


