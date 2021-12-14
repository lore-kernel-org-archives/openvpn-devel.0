Date: Tue, 14 Dec 2021 08:19:49 +0100 (CET)
Message-Id: <202112140719.1BE7Jnat010668@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20211207170211.3275837-4-arne@...1227...>
References: <20211207170211.3275837-4-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove align_adjust frame code
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

Followed the twisty maze through the code, and I agree with the
observation - align_adjust is effectively not used for "normal" data
paths (not cipher none), so align_adjust + align_flags can go.

Lightly tested on client side.  Including "cipher none" :-)

Your patch has been applied to the master branch.

commit 053de4db59a2d99eed8a07877ea321be4065ba26
Author: Arne Schwabe
Date:   Tue Dec 7 18:01:53 2021 +0100

     Remove align_adjust frame code

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20211207170211.3275837-4-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23331.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


