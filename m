Date: Mon, 1 Dec 2025 15:16:21 +0100 (CET)
Message-Id: <202512011416.5B1EGLgr082803@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251201133956.29880-1-gert@...1296...>
References: <20251201133956.29880-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Drop Mbed TLS 2.X compatibility
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

BB workers have either been updated to mbedtls3 (built from source, or 
upgraded to new OS versions that bundle mbedtls).  GHA builds are also
fine again.

I have adjusted the 2.7.0 Changes.rst entry regarding mbedTLS - it used
to say "Support for mbedTLS older than 2.18.0 has been removed" and now
says "mbedTLS 2.x support has been removed" (same style as for the
OpenSSL 1.0.2 removal in the paragraph before it).

Your patch has been applied to the master branch.

commit da51cc458716605d0d19be9486b8ee08fc6a9e06
Author: Max Fillinger
Date:   Mon Dec 1 14:39:50 2025 +0100

     Drop Mbed TLS 2.X compatibility

     Signed-off-by: Max Fillinger <maximilian.fillinger@...2918...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1412
     Message-Id: <20251201133956.29880-1-gert@...1296...>
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


