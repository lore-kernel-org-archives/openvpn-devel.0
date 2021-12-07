Date: Tue, 7 Dec 2021 18:16:18 +0100 (CET)
Message-Id: <202112071716.1B7HGIQX066141@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20211207165035.3274728-1-arne@...1227...>
References: <20211207165035.3274728-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove ENABLE_CRYPTO_OPENSSL
 ifdef inside ENABLE_CRYPTO_OPENSSL ifdef
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

"Now that was an easy one" :-)  (and going back and finding out why
it ended being there in the first place was an interesting journey
via 9b33b5a4b and bf707bd2b)

Your patch has been applied to the master branch.

commit 2aef01df6ca54ca6e04923aa988b22c5df9f48f8
Author: Arne Schwabe
Date:   Tue Dec 7 17:50:35 2021 +0100

     Remove ENABLE_CRYPTO_OPENSSL ifdef inside ENABLE_CRYPTO_OPENSSL ifdef

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20211207165035.3274728-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23326.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


