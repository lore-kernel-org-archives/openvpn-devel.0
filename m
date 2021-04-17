Date: Sat, 17 Apr 2021 15:02:48 +0200 (CEST)
Message-Id: <202104171302.13HD2mDk011972@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210415114541.1001644-1-arne@...1227...>
References: <20210415114541.1001644-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove LibreSSL specific
 defines not needed for modern LibreSSL
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

Getting rid of #ifdef is always good :-) - tested on OpenBSD 6.8 ("just
to be sure"), works.

On OpenBSD 6.5, it fails at link time (LibreSSL 2.9.1, RSA_meth_set_pub_enc
and other RSA_meth* functions missing).  So, no more support for that
(already end-of-life) OpenBSD version.

FreeBSD ports now has LibreSSL 3.2.5, so I assume it is not going to 
break anything there (though I have not bothered to test).

Your patch has been applied to the master branch.

commit 2c0ebe0f12c3d7598dd2f604a5a412b68b728ba9
Author: Arne Schwabe
Date:   Thu Apr 15 13:45:41 2021 +0200

     Remove LibreSSL specific defines not needed for modern LibreSSL

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Message-Id: <20210415114541.1001644-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22119.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


