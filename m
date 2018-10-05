Date: Fri, 5 Oct 2018 14:44:59 +0200 (CEST)
Message-Id: <201810051244.w95CixLW041844@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20181005122330.31431-1-arne@...1227...>
References: <20181005122330.31431-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add OpenSSL compat definition
 for RSA_meth_set_sign
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

Thanks :-)

Your patch has been applied to the master and release/2.4 branch (keep
our compat wrapper aligned).

commit 720c880a8ca73e0f9e9b03e3c9d6031c026bccac (master)
commit c75e937657bf0ae9e9551163f77305d7658c71b3 (release/2.4)
Author: Arne Schwabe
Date:   Fri Oct 5 14:23:30 2018 +0200

     Add OpenSSL compat definition for RSA_meth_set_sign

     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20181005122330.31431-1-arne@...1227...>
     URL: https://www.mail-archive.com/search?l=mid&q=20181005122330.31431-1-arne@...1227...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


