Date: Wed, 16 Jul 2025 18:26:02 +0200 (CEST)
Message-Id: <202507161626.56GGQ2qI035230@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250716151857.385959-1-frank@...2641...>
References: <20250716151857.385959-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: configure.ac: Remove use of
 PKCS11_HELPER_LIBS in mbedTLS checks
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

Nice and simple alternative to #1085... and the buildbots like it as well :-)

Your patch has been applied to the master branch.

commit ed690d1d58792f70b86b75b00c09df2ad96babca
Author: Frank Lichtenheld
Date:   Wed Jul 16 17:18:57 2025 +0200

     configure.ac: Remove use of PKCS11_HELPER_LIBS in mbedTLS checks

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Message-Id: <20250716151857.385959-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32187.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


