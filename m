Date: Wed, 16 Feb 2022 14:09:04 +0100 (CET)
Message-Id: <202202161309.21GD94nF071240@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220216125653.4080943-1-arne@...1227...>
References: <20220216125653.4080943-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix mbed TLS compile if OpenSSL
 headers are not available
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

"Because it makes sense" :-) - ignoring the "core_dispatnch.h" typo.

Your patch has been applied to the master branch.

commit e8a2794824ded011a1ed58aeb95321332b1ae684
Author: Arne Schwabe
Date:   Wed Feb 16 13:56:53 2022 +0100

     Fix mbed TLS compile if OpenSSL headers are not available

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220216125653.4080943-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23804.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


