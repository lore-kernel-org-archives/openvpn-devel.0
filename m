Date: Wed, 10 Oct 2018 22:56:37 +0200 (CEST)
Message-Id: <201810102056.w9AKubro087998@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20181009204315.8262-1-steffan@...1856...>
References: <20181009204315.8262-1-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH applied] Re: List ChaCha20-Poly1305 as
 stream cipher
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

"Does what it says on the lid"... before:

CHACHA20-POLY1305  (256 bit key, 8 bit block, TLS client/server mode only)

.. after:

CHACHA20-POLY1305  (256 bit key, stream cipher, TLS client/server mode only)


commit 447997dd83400bffc05db65a91f659dc87b4a367
Author: Steffan Karger
Date:   Tue Oct 9 22:43:15 2018 +0200

     List ChaCha20-Poly1305 as stream cipher

     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Message-Id: <20181009204315.8262-1-steffan@...1856...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg17682.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


