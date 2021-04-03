Date: Sat, 3 Apr 2021 11:49:55 +0200 (CEST)
Message-Id: <202104030949.1339ntpL084152@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210401123751.31756-1-arne@...1227...>
References: <20210401123751.31756-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove deprecated option
 '--keysize'
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

I had conflicts in init.c and options.c due to the previously-merged
"TLS libraries without BF-CBC" patch, but that was trivially resolved
(3 calls to "init_key_type()", remove the keysize option from all of
them).  To be sure I didn't break anything, client-side tested with
mbedtls and OpenSSL.

commit 961db602592cf9021b116fd555a8b09577d04683
Author: Arne Schwabe
Date:   Thu Apr 1 14:37:51 2021 +0200

     Remove deprecated option '--keysize'

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Message-Id: <20210401123751.31756-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21943.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


