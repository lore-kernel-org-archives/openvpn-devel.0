Date: Wed, 29 Mar 2023 11:41:21 +0200 (CEST)
Message-Id: <202303290941.32T9fLW7009198@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230327114937.28246-1-selva.nair@...277...>
References: <20230327114937.28246-1-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Make cert_data.h and
 test_cryptoapi/pkcs11.c MSVC compliant
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

I have only loosely followed the discussion, but since this has an ACK
*and* passes all GHA compiles and tests, this is good enough for me :-)

I have added the "co-authored-by" as requested.

Your patch has been applied to the master branch.

commit 846951665a60424b98097ad0a77ec6cb1c3d05ac
Author: Selva Nair
Date:   Mon Mar 27 07:49:37 2023 -0400

     Make cert_data.h and test_cryptoapi/pkcs11.c MSVC compliant

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20230327114937.28246-1-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26525.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


