Date: Thu, 26 Mar 2026 15:06:25 +0100 (CET)
Message-Id: <202603261406.62QE6P0U044214@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260323121908.730-1-gert@...1296...>
References: <20260323121908.730-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: ssl_verify_openssl: use
 official ASN1_STRING_ API
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
To: Rudi Heitbaum <rudi@...2993...>
Cc: openvpn-devel@lists.sourceforge.net

Thanks for that.  ACKed from Arne, green from BB, all tests fine.

Your patch has been applied to the master and release/2.7 branch
(long-term library compat).

commit dc4a9255f12840eb96a3a150332ccd26c4c41d7f (master)
commit 388800782687793ea968b722e22319b8a13fddbd (release/2.7)
Author: Rudi Heitbaum
Date:   Mon Mar 23 13:19:00 2026 +0100

     ssl_verify_openssl: use official ASN1_STRING_ API

     Signed-off-by: Rudi Heitbaum <rudi@...2993...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1584
     Message-Id: <20260323121908.730-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36254.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


