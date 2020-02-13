Date: Thu, 13 Feb 2020 20:21:54 +0100 (CET)
Message-Id: <202002131921.01DJLsx4090060@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200121080828.1310-1-lstipakov@...277...>
References: <20200121080828.1310-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: configure.ac: simplify
 AC_CHECK_FUNCS statements
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

Your patch has been applied to the master branch.

Very lighty tested with FreeBSD and Linux builds with mbedtls/openssl
"it builds and tests" (no idea if it produces the right result for 
the relevant library versions).

commit 91d84530d7eb24718b99478ebac6ba40b0615b28
Author: Lev Stipakov
Date:   Tue Jan 21 10:08:28 2020 +0200

     configure.ac: simplify AC_CHECK_FUNCS statements

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20200121080828.1310-1-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg19333.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


