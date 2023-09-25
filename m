Date: Mon, 25 Sep 2023 22:23:20 +0200 (CEST)
Message-Id: <202309252023.38PKNK9v018390@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230922160324.166907-1-frank@...2641...>
References: <20230922160324.166907-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: vcpkg-ports/pkcs11-helper:
 Backport MinGW series from master to release/2.6
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
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

This is one of the patches where "--whitespace=fix" will break the thing...
but I've been here, so, hopefully nothing broken :-)

Tested building on my Ubuntu/MinGW setup, and on the GHA builders, and all
succeed.

Your patch has been applied to the release/2.6 branch.

commit cce957a5b6ed11b0fa35a97e0e638ea00f9921ef
Author: Frank Lichtenheld
Date:   Fri Sep 22 18:03:24 2023 +0200

     vcpkg-ports/pkcs11-helper: Backport MinGW series from master to release/2.6

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Heiko Hund <heiko@...515...>
     Message-Id: <20230922160324.166907-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27083.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


