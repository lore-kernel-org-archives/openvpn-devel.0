Date: Fri, 21 Jan 2022 14:25:59 +0100 (CET)
Message-Id: <202201211325.20LDPxuk033321@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220111150647.267-1-lstipakov@...277...>
References: <20220111150647.267-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: vcpkg-ports/pkcs11-helper:
 indicate OpenSSL EC support
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
To: Lev Stipakov <lev@...515...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

As stated before, I have no idea what this does - but it doesn't touch
code or MinGW building (= not tested anything) and looks reasonable for
the purpose described.

It would be good to have 2.5 test installers with this, to verify that
PKCS#11 and EC do work now...

Your patch has been applied to the master branch.

commit 95b076144933e04782c031182669523dab457f15 (master)
commit a184e790df801bd074619f2c90992866d40d8c3b (HEAD -> release/2.5)
Author: Lev Stipakov
Date:   Tue Jan 11 17:06:47 2022 +0200

     vcpkg-ports/pkcs11-helper: indicate OpenSSL EC support

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220111150647.267-1-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23527.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


