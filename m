Date: Wed, 29 Mar 2023 11:23:28 +0200 (CEST)
Message-Id: <202303290923.32T9NSQd008766@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230322221456.1660425-2-selva.nair@...277...>
References: <20230322221456.1660425-2-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Unit tests: Test for PKCS#11
 using a softhsm2 token
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

Having pkcs#11 tests available is most welcome.  This said, I have not
really looked into "how can I make this do things for my test beds?",
but will do...

With the #if HAVE_SOFTHSM2, this does not actually do anything for
most build environments yet, but patch 3/3 will enable it for GHA Ubuntu
20/22 builds.

Your patch has been applied to the master branch.

commit 3013fde1c8290830d424b9f4ea84ee7c7dbfb75e
Author: Selva Nair
Date:   Wed Mar 22 18:14:55 2023 -0400

     Unit tests: Test for PKCS#11 using a softhsm2 token

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20230322221456.1660425-2-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26483.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


