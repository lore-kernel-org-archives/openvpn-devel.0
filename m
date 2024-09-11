Date: Wed, 11 Sep 2024 16:58:30 +0200 (CEST)
Message-Id: <202409111458.48BEwUOf072690@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240911144231.32553-1-gert@...1296...>
References: <20240911144231.32553-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: GHA: Update dependency
 Mbed-TLS/mbedtls to v3.6.1
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

GHA says "this builds fine", and so we apply it :-)

(And the worries that 3.6.x would break with TLS 1.3 due to missing
key-exporter are alleviated by our mbedtls builds disabling 1.3 anyway,
due to missing key-exporter...)

Your patch has been applied to the master branch.

commit f4d7cec855aea3c453b75fe68a1c151400793661
Author: Frank Lichtenheld
Date:   Wed Sep 11 16:42:31 2024 +0200

     GHA: Update dependency Mbed-TLS/mbedtls to v3.6.1

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Message-Id: <20240911144231.32553-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29208.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


