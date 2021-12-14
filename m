Date: Tue, 14 Dec 2021 09:42:28 +0100 (CET)
Message-Id: <202112140842.1BE8gSXl013192@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20211207170211.3275837-7-arne@...1227...>
References: <20211207170211.3275837-7-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove post_open_mtu code
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

I follow the reasoning - since we set the MTU now, we do not need to
adjust the frame afterwards.  Logging the MTU might be useful (Windows
is weird, maybe it does not always "stick"...), so let's keep this in 
for the time being.

Spurious comment change in ssl.c removed from the patch.

I like the comment

 /* Some TUN/TAP drivers like to be ioctled for mtu after open */

"like to be ioctled", hah :-) - but why this is there is lost lore from
the long gone past...

I have test compiled this on mingw.


Your patch has been applied to the master branch.

commit c27868bfc2ad6ee21c28f4addb1c2fc003bfa61a
Author: Arne Schwabe
Date:   Tue Dec 7 18:01:56 2021 +0100

     Remove post_open_mtu code

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20211207170211.3275837-7-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23327.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


