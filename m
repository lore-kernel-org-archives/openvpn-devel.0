Date: Thu, 20 Jan 2022 14:49:38 +0100 (CET)
Message-Id: <202201201349.20KDncpv079059@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20211214165928.30676-2-selva.nair@...277...>
References: <20211214165928.30676-2-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: A built-in provider for using
 external key with OpenSSL 3.0
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

There is not much to test here yet - so what I did was "test that it
does not break with ossl 1.x" (it doesn't), that it does not compile
anything into xkey_provider.o when compiled with 3.0.0 (it doesn't)
and that it *does* with 3.0.1

3.0.0$ size src/openvpn/xkey_provider.o 
   text    data     bss     dec     hex filename
     48       0       0      48      30 src/openvpn/xkey_provider.o

3.0.1$ size src/openvpn/xkey_provider.o 
   text    data     bss     dec     hex filename
   1534     176       0    1710     6ae src/openvpn/xkey_provider.o


As far as I can see, the xkey stuff is not actually referenced anywhere,
so "it is not compiled on MSVC builds" won't break anything *yet*, but
it might as soon as actually linked-in.

Your patch has been applied to the master branch.

commit 5910eb6cd5308720d5e4f197b83763d572fce8a1
Author: Selva Nair
Date:   Tue Dec 14 11:59:11 2021 -0500

     A built-in provider for using external key with OpenSSL 3.0

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20211214165928.30676-2-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23446.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


