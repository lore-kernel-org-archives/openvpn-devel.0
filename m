Date: Tue, 11 Aug 2020 10:18:10 +0200 (CEST)
Message-Id: <202008110818.07B8IAMu041447@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200810143707.5834-17-arne@...1227...>
References: <20200810143707.5834-17-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Move parsing IV_PROTO to
 separate function
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

Server-side tested.  "git show -w" shows that half of the
patch is indentation changes - and the other is "move around".

Your patch has been applied to the master branch.

commit 4b4f5fe22f8ac0ffaf32185ac995da08d524dcbd
Author: Arne Schwabe
Date:   Mon Aug 10 16:37:06 2020 +0200

     Move parsing IV_PROTO to separate function

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20200810143707.5834-17-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg20679.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


