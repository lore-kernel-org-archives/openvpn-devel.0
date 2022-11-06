Date: Sun, 6 Nov 2022 11:25:35 +0100 (CET)
Message-Id: <202211061025.2A6APZdg021070@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220831134140.913337-2-arne@...1227...>
References: <20220831134140.913337-2-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add workaround for Softether
 server dropping P_ACK_V1 with >= 5 acks
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

This is straightforward.  The detection "what makes a softether server?"
is a bit annoying... and this code will be with us forever...

I have not specifically tested this ("no softether server around") but
ran the normal server/client tests.

Your patch has been applied to the master branch.

commit 036517d5e06c1254233d51893b3a196a3cd37492
Author: Arne Schwabe
Date:   Wed Aug 31 15:41:40 2022 +0200

     Add workaround for Softether server dropping P_ACK_V1 with >= 5 acks

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220831134140.913337-2-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25142.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


