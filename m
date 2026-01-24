Date: Sat, 24 Jan 2026 23:18:01 +0100 (CET)
Message-Id: <202601242218.60OMI1gq051109@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260124181814.30331-1-gert@...1296...>
References: <20260124181814.30331-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: GHA: Update mbedtls to v4
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

Tested via GHA :-) - and lo and behold, it builds mbedtls4 builds, and
those succeed...!  (The mbedtls4 builds replace the "legacy" mbedtls3
builds - we have those in BB)

No actual code change for OpenVPN, just build instructions for GH.

The mbedtls4 builds now do build the test suite as well (our mbedtls3
builds didn't) - not sure if that can be avoided, but it takes quite
a bit of time...

Your patch has been applied to the master branch.

commit c7fbd8a302ac679d2fead0c70dcfff61ce953c47
Author: Frank Lichtenheld
Date:   Sat Jan 24 19:18:07 2026 +0100

     GHA: Update mbedtls to v4

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Yuriy Darnobyt <yura.uddr@...277...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1474
     Message-Id: <20260124181814.30331-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35421.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


