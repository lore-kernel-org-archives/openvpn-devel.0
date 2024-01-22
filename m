Date: Mon, 22 Jan 2024 14:15:53 +0100 (CET)
Message-Id: <202401221315.40MDFrTe003874@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240122130909.10706-1-gert@...1296...>
References: <20240122130909.10706-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix ssl unit tests on OpenSSL
 1.0.2
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

Good catch, "obviously correct" :-)

Your patch has been applied to the master branch.

Not applied to 2.6 since these new tests are not in release/2.6 - so, but
not present.

commit dc4fde8052639ffbc29ccc87130a0ce25f6dcd6c
Author: Arne Schwabe
Date:   Mon Jan 22 14:09:09 2024 +0100

     Fix ssl unit tests on OpenSSL 1.0.2

     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20240122130909.10706-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28112.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


