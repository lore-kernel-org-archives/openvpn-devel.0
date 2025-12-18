Date: Thu, 18 Dec 2025 11:30:31 +0100 (CET)
Message-Id: <202512181030.5BIAUV5g012560@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251217130743.28786-1-gert@...1296...>
References: <20251217130743.28786-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Ensure wolfSSL uses old pre
 1.1.0 OpenSSL path for getting ciphers
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

While I could care less about tending for WolfSSL oddities, Arne does,
and the FreeBSD people do, and this is quite a reasonable way to approach
their... creative... handling of OPENSSL_VERSION_NUMBER.

I have not tested this, and we currently do not have GHA or BB tests
for WolfSSL.  I guess giving them more attention would warrant adding
at least some basic builds + "make check"...

Your patch has been applied to the master branch.

commit ab5887cfbd3654774cdabe03fb1f98195dcf8b6d
Author: Arne Schwabe
Date:   Wed Dec 17 14:07:38 2025 +0100

     Ensure wolfSSL uses old pre 1.1.0 OpenSSL path for getting ciphers

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1448
     Message-Id: <20251217130743.28786-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35127.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


