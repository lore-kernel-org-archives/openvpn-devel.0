Date: Mon, 6 Dec 2021 10:17:46 +0100 (CET)
Message-Id: <202112060917.1B69Hk37023241@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20211206010151.3072787-1-arne@...1227...>
References: <20211206010151.3072787-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove key_type->cipher_length
 field
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

Thanks for the "*8" in the v2 :-) - verified that this is the only change,
and the rest already looked good in v1.  Messages are fine now as well

  2021-12-06 10:02:27 Incoming Data Channel: Cipher 'BF-CBC' initialized with 128 bit key
  2021-12-06 10:03:36 Incoming Data Channel: Cipher 'AES-256-GCM' initialized with 256 bit key

Tested client-side (make check, t_client) with OpenSSL and mbedTLS builds.

Your patch has been applied to the master branch.

commit 9cc7fdcf851f87cb4fd5f9f249f790565f7b8e33
Author: Arne Schwabe
Date:   Mon Dec 6 02:01:51 2021 +0100

     Remove key_type->cipher_length field

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20211206010151.3072787-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23304.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


