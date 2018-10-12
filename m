Date: Fri, 12 Oct 2018 17:30:24 +0200 (CEST)
Message-Id: <201810121530.w9CFUOLh040138@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20181011220639.7316-1-arne@...1227...>
References: <20181011220639.7316-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Use right function to set
 TLS1.3 restrictions in show-tls
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

It now displays the expected result set (and the code change makes sense):

   $ src/openvpn/openvpn --verb 4 --tls-ciphersuites TLS_AES_256_GCM_SHA384 --show-tls --tls-cipher TLS-DHE-RSA-WITH-AES-256-CBC-SHA256
   Available TLS Ciphers, listed in order of preference:

   For TLS 1.3 and newer (--tls-ciphersuites):

   TLS_AES_256_GCM_SHA384

   For TLS 1.2 and older (--tls-cipher):

   TLS-DHE-RSA-WITH-AES-256-CBC-SHA256



Tested with OpenSSL 1.0.2, 1.1.1 and mbedTLS.

Your patch has been applied to the master and release/2.4 branch.

commit 680117529ededd94b1d56867f8d834aa5daa2b95 (master)
commit 33253cf1d0c1175e7391a4eec3b64f1ec0b303dd (release/2.4)
Author: Arne Schwabe
Date:   Fri Oct 12 00:06:39 2018 +0200

     Use right function to set TLS1.3 restrictions in show-tls

     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20181011220639.7316-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg17755.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


