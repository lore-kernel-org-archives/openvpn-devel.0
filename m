Date: Tue, 14 Apr 2026 18:43:14 +0200 (CEST)
Message-Id: <202604141643.63EGhELj032865@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260414055927.17252-1-gert@...1296...>
References: <20260414055927.17252-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: ssl_mbedtls: Fix format string
 in get_ssl_library_version
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

Good find.  With the expected version numbers in mbedTLS, we're unlikely
to hit an actual sign/unsign overflow ("3.5.128" maybe?), so I don't think
this needs to go to 2.7.

Your patch has been applied to the master branch.

commit 9a6e3646610afb13c794f284b25222dac19f095a
Author: Frank Lichtenheld
Date:   Tue Apr 14 07:59:21 2026 +0200

     ssl_mbedtls: Fix format string in get_ssl_library_version

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1626
     Message-Id: <20260414055927.17252-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36607.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


