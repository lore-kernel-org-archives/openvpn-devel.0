Date: Mon, 22 Mar 2021 11:15:35 +0100 (CET)
Message-Id: <202103221015.12MAFZmN005852@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210322091414.7533-1-arne@...1227...>
References: <20210322091414.7533-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Support fingerprint
 authentication without CA certificate
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
To: "Jason A. Donenfeld" <Jason@...2390...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master branch (in the reworked v3
version from Arne, but since the original idea and v1 patch are from
you, we record you as the author).

I have not tested the actual functionality yet, only verified that
it didn't break openssl/mbedtls builds and "regular certificate checks"
(Antonio verified functionality).

commit 423ced962db3129b4ed551c489624faba4340652
Author: Jason A. Donenfeld
Date:   Mon Mar 22 10:14:14 2021 +0100

     Support fingerprint authentication without CA certificate

     Signed-off-by: Jason A. Donenfeld <Jason@...2390...>
     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Message-Id: <20210322091414.7533-1-arne@...1227...>
     URL: https://www.mail-archive.com/search?l=mid&q=20210322091414.7533-1-arne@...1227...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


