Date: Tue, 26 Apr 2022 11:57:48 +0200 (CEST)
Message-Id: <202204260957.23Q9vmP4095077@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220422142953.3805364-2-arne@...1227...>
References: <20220422142953.3805364-2-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Refactor tls-auth/tls-crypt
 wrapping into into own function
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

I've done a bit of "extra eyes stare at the code" and things look good
(due to the newly named options, git is not that helpful in confirming
"it's all the same code").  Will test together with 12.

Your patch has been applied to the master branch.

commit 9bbebf100a07f4dca3f088dce19cd87608e82b4c
Author: Arne Schwabe
Date:   Fri Apr 22 16:29:36 2022 +0200

     Refactor tls-auth/tls-crypt wrapping into into own function

     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20220422142953.3805364-2-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24150.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


