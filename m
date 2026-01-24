Date: Sat, 24 Jan 2026 19:17:41 +0100 (CET)
Message-Id: <202601241817.60OIHfKb047964@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260123164746.7333-1-gert@...1296...>
References: <20260123164746.7333-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add support for Mbed TLS 4
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
To: Max Fillinger <maximilian.fillinger@...2918...>
Cc: openvpn-devel@lists.sourceforge.net

This is quite a huge last-minute patch before a 2.7.0 release - but there
are some special considerations.  mbedTLS 3 will run out of support while
we're very likely still in the 2.7.x maintenance phase, so having mbedTLS 4
support in 2.7.x is important for long-term supportability.  Further, the
patch only very lightly touches on "non mbedTLS" areas of the code - so
most users will not be affected.

"git show --color-moved=zebra" shows that all the old code is still there,
just goes to "mbedtls_legacy" - to avoid #ifdef orgys, and at some point
dropping mbedTLS 3 will be easy.

Arne has tested this, and verified interoperability with OpenSSL-OpenVPN,
and the buildbots + GHA have tested that mbedTLS 3 support still works.

Your patch has been applied to the master branch.

commit d0589909b9b6f4400429e010e9c4874b7f496e59
Author: Max Fillinger
Date:   Fri Jan 23 17:47:39 2026 +0100

     Add support for Mbed TLS 4

     Signed-off-by: Max Fillinger <maximilian.fillinger@...2918...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1441
     Message-Id: <20260123164746.7333-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35401.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


