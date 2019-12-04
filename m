Date: Wed, 4 Dec 2019 16:36:22 +0100 (CET)
Message-Id: <201912041536.xB4FaM8c038616@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20191122143315.8564-1-arne@...1227...>
References: <20191122143315.8564-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Make tls_version_max return the
 actual maximum version
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

Your patch has been applied to the master branch.

Thanks for the confirmation about that commit message change - it seemed
to make sense, but to hear from the author is better :-) - changed on
the fly, as requested.

Lightly tested with OpenSSL 1.0.2o, OpenSSL 1.0.1l, OpenSSL 1.1.1d.

*Not* tested with "compiled with 1.1.0, dynlinked to 1.1.1, does TLS 1.3" 
because too lazy right now to set up things to properly verify that.

commit 6328aef94a748bd9859ae5cd264b7e50fbb8a325
Author: Arne Schwabe
Date:   Fri Nov 22 15:33:14 2019 +0100

     Make tls_version_max return the actual maximum version

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Selva Nair <selva.nair@...277...>
     Message-Id: <20191122143315.8564-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg19186.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


