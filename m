Date: Mon, 8 Oct 2018 16:49:41 +0200 (CEST)
Message-Id: <201810081449.w98Enfl9016711@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20181007223035.21179-1-steffan@...1856...>
References: <20181007223035.21179-1-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add support for
 CHACHA20-POLY1305 in the data channel
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
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master branch.

I have done a cursory stare-at code and it matches the grumblings given
on the way to dinner ("check not only for GCM but accept all save ciphers
using this API", IIRC).  My current test rig is too old to do a full
client-server test easily, but at least the mbedTLS and the OpenSSL
1.1.0 build both claim support...

CHACHA20-POLY1305  (256 bit key, 8 bit block, TLS client/server mode only)
CHACHA20-POLY1305  (256 bit key, 8 bit block, TLS client/server mode only)

.. and pass t_client tests both for OpenSSL and mbedTLS...

commit 6d0d0af9883b9ae266c0468f2739557a53e94b68
Author: Steffan Karger
Date:   Mon Oct 8 00:30:34 2018 +0200

     Add support for CHACHA20-POLY1305 in the data channel

     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Message-Id: <20181007223035.21179-1-steffan@...1856...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg17629.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


