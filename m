Date: Thu, 21 Oct 2021 16:11:40 +0200 (CEST)
Message-Id: <202110211411.19LEBekg052628@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20211019183127.614175-5-arne@...1227...>
References: <20211019183127.614175-5-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove DES check with OpenSSL
 3.0
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

Taking MaxF review into account, moving the comment as suggested, and
changing "risk ... is ... weak" to "low".

Your patch has been applied to the master branch.

commit d67658feeab4742b9b6f57806ba8e93c8eec75b8
Author: Arne Schwabe
Date:   Tue Oct 19 20:31:10 2021 +0200

     Remove DES check with OpenSSL 3.0

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20211019183127.614175-5-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23004.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


