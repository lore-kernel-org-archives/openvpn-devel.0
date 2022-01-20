Date: Thu, 20 Jan 2022 14:57:16 +0100 (CET)
Message-Id: <202201201357.20KDvGAf079283@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20211214165928.30676-3-selva.nair@...277...>
References: <20211214165928.30676-3-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Implement KEYMGMT in the xkey
 provider
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

Only compile-tested on Linux / OpenSSL 3.0.1 (and briefly glanced over
the code to see what happens).  It breaks...

xkey_provider.c:223:16: error: 'XKEY_KEYDATA' has no member named 'free'
  223 |             key->free = (XKEY_PRIVKEY_FREE_fn *) EVP_PKEY_free;
      |                ^~
xkey_provider.c:223:26: error: 'XKEY_PRIVKEY_FREE_fn' undeclared (first use in this function)
  223 |             key->free = (XKEY_PRIVKEY_FREE_fn *) EVP_PKEY_free;
      |                          ^~~~~~~~~~~~~~~~~~~~

*but* this is fixed in 03/18 - and as the whole patchset is basically
a no-op before all is in (it will break compilation with 3.0.1, so
might annoy someone doing bisect in the future, hitting just that commit
by chance...) I'll still merge & push.

Your patch has been applied to the master branch.

commit 44509116da50b53a5588318fb27b2e4a3da4ab6c
Author: Selva Nair
Date:   Tue Dec 14 11:59:12 2021 -0500

     Implement KEYMGMT in the xkey provider

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20211214165928.30676-3-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23438.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


