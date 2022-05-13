Date: Fri, 13 May 2022 09:23:35 +0200 (CEST)
Message-Id: <202205130723.24D7NZcX093636@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220512121429.2096164-6-arne@...1227...>
References: <20220512121429.2096164-6-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add --with-openssl-engine
 autoconf option (auto|yes|no)
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

This repairs the first part of "make check" for ossl 3.0 builds (... by 
skipping the failing engine test).  The cipher loopback still fails.

Moved the Changes.rst hunk to the 2.5.7 section I introduced with 2/7 :-)

Your patch has been applied to the release/2.5 branch.

commit c5d61b345e21860b2357206848535a8452754ad8
Author: Arne Schwabe
Date:   Thu May 12 14:14:27 2022 +0200

     Add --with-openssl-engine autoconf option (auto|yes|no)

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220512121429.2096164-6-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24332.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


