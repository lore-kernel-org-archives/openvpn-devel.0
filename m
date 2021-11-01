Date: Mon, 1 Nov 2021 20:47:05 +0100 (CET)
Message-Id: <202111011947.1A1Jl5He078034@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20211019183127.614175-11-arne@...1227...>
References: <20211019183127.614175-11-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Replace EVP_get_cipherbyname
 with EVP_CIPHER_fetch
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

This patch took at bit of massaging to get in, due to the context 
having SSL_CTX_new_ex() which disappeared during 08 v3->v4 -> replaced 
by proper context (adding #if OPENSSL_VERSION_NUMBER < 0x30000000L).

I have read Selva's comment about mem leaking, and decided to still
merge it - this OSS 3 thing is work in progress, and I want to get 
the later patches in that have ACKs, so the code can get more exposure
(we must not forget to return here and fix it, of course).

I have stared at the code a bit, and given it "make check" treatment - 
this now explodes for 3.0.0 in the ncp_testdriver

  Unsupported cipher in --data-ciphers: BF-CBC
  [  ERROR   ] --- Test failed with exception: Segmentation fault(11)

(but I assume that this will be fixed as soon as the legacy provider
stuff gets in).   t_lpback.sh still fails, but now with a proper error 
message ("Cipher SEED-OFB not supported") - I seem to remember a later
patch fixing the cipher listing part, so SEED-OFB won't even show up
as a candidate.

1.1.1 passes just fine.


Your patch has been applied to the master branch.

commit f40edaa5abe5255710315deacd8c82cdfef12647
Author: Arne Schwabe
Date:   Tue Oct 19 20:31:16 2021 +0200

     Replace EVP_get_cipherbyname with EVP_CIPHER_fetch

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-By: Max Fillinger <maximilian.fillinger@...2507...>
     Message-Id: <20211019183127.614175-11-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23005.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


