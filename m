Date: Fri, 2 Apr 2021 20:49:00 +0200 (CEST)
Message-Id: <202104021849.132In0wS041212@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210401110003.19689-1-arne@...1227...>
References: <20210401110003.19689-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Always disable TLS
 renegotiations
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

I have taken Antonio's ACK on v2, and added my own on v3 (since
I NAKed the v2).  This is basically the same patch just with a 
conditional on SSL_OP_NO_RENEGOTIATION - so for everything Antonio
has tested, we know it works, and in addition it does not break
OpenSSL 1.0.x builds.

Built and cliend-side tested on FreeBSD and Linux with mbedTLS
2.16 and 2.26.0 and OpenSSL 1.0.2 and 1.1.1

Your patch has been applied to the master and release/2.5 branch.

commit 9e702a5d0f1d8ca0443d95ba13fc821deaa81d48 (master)
commit a31c4b73f56e1dddda64ba15b27f0c5b2c6a26d4 (release/2.5)
Author: Arne Schwabe
Date:   Thu Apr 1 13:00:03 2021 +0200

     Always disable TLS renegotiations

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20210401110003.19689-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21939.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


