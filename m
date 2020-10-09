Date: Fri, 9 Oct 2020 20:09:00 +0200 (CEST)
Message-Id: <202010091809.099I90i7069795@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20201009115453.4279-1-arne@...1227...>
References: <20201009115453.4279-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Implement generating data
 channel keys via EKM/RFC 5705
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

In addition to the thorough review from Steffan, I have tortured
this patch on the client and server side (read: patched client 
talking to an old server, old clients talking to a patched server,
patched client talking to patched server, with/without NCP) and
everything succeeded/failed as expected.

I have actually seen the handshake happen between openssl client
and server, and mbedtls 2.24.0 (gentoo) client / openssl server
(I have not checked if the handshake had any actual *effect*, just
if I could see it in the PUSH_REPLY message, and that ping worked
afterwards).

"PUSH_REPLY ... cipher none,key-derivation tls-ekm" looks weird :-)

Your patch has been applied to the master branch.

commit 6dc09d0d4520483716530e12a444b156720cdfcc
Author: Arne Schwabe
Date:   Fri Oct 9 13:54:53 2020 +0200

     Implement generating data channel keys via EKM/RFC 5705

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Steffan Karger <steffan.karger@...2507...>
     Message-Id: <20201009115453.4279-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21187.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


