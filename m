Date: Fri, 29 Jun 2018 14:23:28 +0200 (CEST)
Message-Id: <201806291223.w5TCNSE2009408@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20171126150401.28565-1-steffan@...1856...>
References: <20171126150401.28565-1-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH applied] Re: openssl: don't use deprecated
 SSLEAY/SSLeay symbols
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
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

"because it makes sense".  

Tested on FreeBSD/1.0.1u, Linux/1.0.2o, FreeBSD/1.1.0h.
("testing" = "it compiles, and openvpn --version prints the right 
version", so it's not worse than before :-) - a test compilation with 
-DOPENSSL_API_COMPAT=0x10100000L still explodes because 2/2 is missing)

Your patch has been applied to the master branch.

commit 17a476fd5c8cc49f1d103a50199e87ede76b1b67
Author: Steffan Karger
Date:   Sun Nov 26 16:04:00 2017 +0100

     openssl: don't use deprecated SSLEAY/SSLeay symbols

     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20171126150401.28565-1-steffan@...1856...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg15934.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


