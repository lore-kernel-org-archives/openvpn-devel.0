Date: Sat, 23 Sep 2023 12:29:14 +0200 (CEST)
Message-Id: <202309231029.38NATE4t055564@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230922160405.167057-1-frank@...2641...>
References: <20230922160405.167057-1-frank@...2641...>
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

Backport of 846951665a60424b98097ad0a77ec6cb1c3d05ac (taking into
account lack of HAVE_XKEY_PROVIDER tests, I think), smoke tested on
GHA MSVC builds.

Amazing amount of ACKs that accumulated here...

Your patch has been applied to the release/2.6 branch.

commit 4abdb1235833e9e3b9510ec50bd5abd150ba7fa8
Author: Selva Nair
Date:   Fri Sep 22 18:04:05 2023 +0200

     Make cert_data.h and test_cryptoapi/pkcs11.c MSVC compliant

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Heiko Hund <heiko@...515...>
     Acked-by: Selva Nair <selva.nair@...277...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20230922160405.167057-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27084.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


