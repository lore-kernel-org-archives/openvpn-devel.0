Date: Tue, 2 Sep 2025 20:28:37 +0200 (CEST)
Message-Id: <202509021828.582ISbdf074463@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250826184148.21534-1-gert@...1296...>
References: <20250826184148.21534-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: ssl_openssl: Fix type of
 sslopts argument to SSL_CTX_set_options
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

This is actually an interesting one - in OpenSSL 1.1.x, the "sslopt"
argument to SSL_CTX_set_options() is a "long", so back then, our code
had the correct data type.  With 3.0, this is now an "uint64_t", and
for master/2.7, this is the right thing to do - even if it will cause
some warnings on FreeBSD 13, for example, which still ships 1.1.1w

Your patch has been applied to the master branch.

commit 80c5cdef00fdef89738df1c17441f0bb987ccc97
Author: Frank Lichtenheld
Date:   Tue Aug 26 20:41:38 2025 +0200

     ssl_openssl: Fix type of sslopts argument to SSL_CTX_set_options

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Message-Id: <20250826184148.21534-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32690.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


