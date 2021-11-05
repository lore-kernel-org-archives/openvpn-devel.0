Date: Fri, 5 Nov 2021 15:56:18 +0100 (CET)
Message-Id: <202111051456.1A5EuIHX084979@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20211029111109.2003101-1-arne@...1227...>
References: <20211029111109.2003101-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Implement DES ECB encrypt via
 EVP_CIPHER api
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

Cliend side tested on OpenSSL 1.1.1 and 3.0.0 - thanks for the in-person
explanation about DES and 3DES-with-same-key :-) and for adding a unit
test.

[ RUN      ] test_des_encrypt
[       OK ] test_des_encrypt

Your patch has been applied to the master branch.

commit c426a3e77ee5377ca1c6254feabb04e41aa6dfed
Author: Arne Schwabe
Date:   Fri Oct 29 13:11:08 2021 +0200

     Implement DES ECB encrypt via EVP_CIPHER api

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Max Fillinger <maximilian.fillinger@...2507...>
     Message-Id: <20211029111109.2003101-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23078.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


