Date: Mon, 8 May 2023 14:20:12 +0200 (CEST)
Message-Id: <202305081220.348CKC2K005006@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230417134046.81761-1-arne@...1227...>
References: <20230417134046.81761-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix compile error on
 TARGET_ANDROID
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

"Obviously correct".  Wonder who ACKed and/or merged the offending code...

Interesting enough, Uncrustify does not complain here.

Your patch has been applied to the master and release/2.6 branch.

commit 8d38ed4817f4c1fe1676409c4e5138aaa4a69dfc (master)
commit a32f914051909cc5e7692964af169fc3224270e5 (release/2.6)
Author: Arne Schwabe
Date:   Mon Apr 17 15:40:46 2023 +0200

     Fix compile error on TARGET_ANDROID

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20230417134046.81761-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26593.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


