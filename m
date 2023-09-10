Date: Sun, 10 Sep 2023 17:05:26 +0200 (CEST)
Message-Id: <202309101505.38AF5QRc057775@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230909134956.5902-1-orbea@...2744...>
References: <20230909134956.5902-1-orbea@...2744...>
Subject: [Openvpn-devel] [PATCH applied] Re: configure: disable engines if
 OPENSSL_NO_ENGINE is defined
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
To: orbea <orbea@...2744...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Compile-tested on our GH Actions farm (OpenSSL 1.1 and 3.0, on various
OSes).  Not tested against LibreSSL.

Your patch has been applied to the master and release/2.6 branch (compat).

commit 34bf473e19118eecf525e7401ef37b1cbf661e67 (master)
commit a22f017ac249df1170a9480b5d7a1f9cc81201e5 (release/2.6)
Author: orbea
Date:   Sat Sep 9 06:49:56 2023 -0700

     configure: disable engines if OPENSSL_NO_ENGINE is defined

     Signed-off-by: orbea <orbea@...2744...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20230909134956.5902-1-orbea@...2744...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26994.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


