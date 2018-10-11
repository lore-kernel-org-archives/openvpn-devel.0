Date: Thu, 11 Oct 2018 09:34:04 +0200 (CEST)
Message-Id: <201810110734.w9B7Y4Fr093629@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1539242400-27614-1-git-send-email-steffan.karger@...1435...>
References: <1539242400-27614-1-git-send-email-steffan.karger@...1435...>
Subject: [Openvpn-devel] [PATCH applied] Re: mbedtls: don't print
 unsupported ciphers in insecure cipher list
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
To: Steffan Karger <steffan.karger@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

This removes (checked by "diff") all non-CBC ciphers from "--show-ciphers"
on mbedTLS builds again (like BLOWFISH-CTR, DES-EDE-ECB), and makes
t_lpback.sh succeed again in "make check".  Sorry for not catching this
yesterday already.

Your patch has been applied to the master branch.

commit 4ada4a7d8b3db7ae9722624d745c220fef4c77fd
Author: Steffan Karger
Date:   Thu Oct 11 09:20:00 2018 +0200

     mbedtls: don't print unsupported ciphers in insecure cipher list

     Signed-off-by: Steffan Karger <steffan.karger@...1435...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1539242400-27614-1-git-send-email-steffan.karger@...1435...>
     URL: https://sourceforge.net/p/openvpn/mailman/message/36438012/
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


