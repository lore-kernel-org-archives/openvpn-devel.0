Date: Sat, 3 Jun 2023 10:03:30 +0200 (CEST)
Message-Id: <202306030803.35383URg046763@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230601095721.4065834-1-arne@...1227...>
References: <20230601095721.4065834-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix use-after-free with
 EVP_CIPHER_free
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

I have not tested this beyond a simple "does it compile" (it does) - and
the fix is quite "obviously correct" - good find.

I have also removed the spurious extra blank line on merge.

Your patch has been applied to the master and release/2.6 branch
(relevant code is not part of 2.5).

commit 13f5e615310ea64ab69f521e622a10f2d0ad3f4e (master)
commit 205c66bd0ed2661c47b9fe7317089fbb09cc7aa4 (release/2.6)
Author: Arne Schwabe
Date:   Thu Jun 1 11:57:21 2023 +0200

     Fix use-after-free with EVP_CIPHER_free

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Antonio Quartulli <a@...2181...>
     Message-Id: <20230601095721.4065834-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26735.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


