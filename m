Date: Sun, 8 Sep 2024 14:24:32 +0200 (CEST)
Message-Id: <202409081224.488COWo6056646@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240906160510.76387-1-frank@...2641...>
References: <20240906160510.76387-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: configure: Try to use
 pkg-config to detect mbedTLS
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

Lightly tested on a FreeBSD (no .pc) and a Gentoo system (.pc), both
find mbedtls & build fine.

Discovered "<psa/crypto.h>" while at it... in case someone else
wonders what that is, it's part of mbedTLS but is not installed in
the normal mbedtls include path, because, why should it... (*roll eyes*).

Your patch has been applied to the master branch.

commit c829f57096cb6951aa4698eff388aeebf9310334
Author: Frank Lichtenheld
Date:   Fri Sep 6 18:05:10 2024 +0200

     configure: Try to use pkg-config to detect mbedTLS

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Yuriy Darnobyt <yura.uddr@...277...>
     Message-Id: <20240906160510.76387-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29090.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


