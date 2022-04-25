Date: Mon, 25 Apr 2022 14:19:24 +0200 (CEST)
Message-Id: <202204251219.23PCJOQl063330@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220422142953.3805364-10-arne@...1227...>
References: <20220422142953.3805364-10-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Make buf_write_u8/16/32 take
 the type they pretend to take
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

Indeed :-) - code looks good, test compiled on Linux and FreeBSD
("does it bring any surprise warnings?")

Your patch has been applied to the master branch.

commit dc6e00e2e75eae58bf94bcf384ae2ba68c5c6bd3
Author: Arne Schwabe
Date:   Fri Apr 22 16:29:44 2022 +0200

     Make buf_write_u8/16/32 take the type they pretend to take

     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20220422142953.3805364-10-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24165.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


