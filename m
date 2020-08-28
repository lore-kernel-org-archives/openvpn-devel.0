Date: Fri, 28 Aug 2020 15:25:08 +0200 (CEST)
Message-Id: <202008281325.07SDP8rA045378@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200825041647.26235-1-arne@...1227...>
References: <20200825041647.26235-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix compilation with older mbed
 TLS versions (mbedtls_tls_prf_types undefined)
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Thanks for this.  I have tried to review it without having to understand
all of the EKM/PRF stuff, and it sort of looks reasonable.  The approach
of not having more #ifdefs in the common code is certainly welcome.

I have *tested* it, though, on some of the buildbots that failed before,
and this looks all reasonable (NetBSD 8.1 with mbedtls-2.14.1), plus
Linux with a very recent mbedtls (2.22.0).  All succeeded.

Your patch has been applied to the master branch.

commit 136c5f015c3e7eceecc07a45655d5da5616e9131
Author: Arne Schwabe
Date:   Tue Aug 25 06:16:47 2020 +0200

     Fix compilation with older mbed TLS versions (mbedtls_tls_prf_types undefined)

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20200825041647.26235-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg20812.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


