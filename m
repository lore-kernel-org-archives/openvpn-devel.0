Date: Sat, 24 Oct 2020 21:57:16 +0200 (CEST)
Message-Id: <202010241957.09OJvG4p090956@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20201023113431.26691-5-arne@...1227...>
References: <20201023113431.26691-5-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove NULL checks before
 calling free
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

I have not verified the OpenSSL and pkcs11 free() functions, but the
changes to our source tree (event_free() etc.) are consistent and make
the code easier to read.

Passed a client side test (for good measure).

Your patch has been applied to the master branch.

commit cb70cf51889ee96446ba77a406bb2ac0f01dc174
Author: Arne Schwabe
Date:   Fri Oct 23 13:34:31 2020 +0200

     Remove NULL checks before calling free

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20201023113431.26691-5-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21216.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


