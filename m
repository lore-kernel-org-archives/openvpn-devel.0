Date: Sat, 10 Feb 2024 10:12:44 +0100 (CET)
Message-Id: <202402100912.41A9Ci0Y066253@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240209110629.15364-1-frank@...2641...>
References: <20240209110629.15364-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: Implement generating TLS 1.0
 PRF using new OpenSSL 3.0 APIs
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

Tested locally (FreeBSD / OpenSSL 3.0, OpenBSD / LibreSSL) and via GHA,
and things still work.

Your patch has been applied to the master branch.

commit 7435114d9a979611dfe5ab751c213900cc1773e8
Author: Arne Schwabe
Date:   Fri Feb 9 12:06:29 2024 +0100

     Implement generating TLS 1.0 PRF using new OpenSSL 3.0 APIs

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20240209110629.15364-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28203.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


