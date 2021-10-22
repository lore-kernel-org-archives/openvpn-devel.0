Date: Fri, 22 Oct 2021 19:43:35 +0200 (CEST)
Message-Id: <202110221743.19MHhZRK084314@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20211019183127.614175-8-arne@...1227...>
References: <20211019183127.614175-8-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove DES key fixup code
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

Looks reasonable, passes client side tests (with 1.1.1 only, lazy) :-)

It might bite up for NTLM (as I see it's used there as well, and that
is the only place where we really continue to need DES).  Seems I need
to set up a NTLM proxy auth environment to test this...

Your patch has been applied to the master branch.

commit e23c152aa58f533a224df4bc3d433e2be967f64b
Author: Arne Schwabe
Date:   Tue Oct 19 20:31:13 2021 +0200

     Remove DES key fixup code

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Max Fillinger <maximilian.fillinger@...2507...>
     Message-Id: <20211019183127.614175-8-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23014.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


