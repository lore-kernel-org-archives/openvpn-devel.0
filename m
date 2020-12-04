Date: Fri, 4 Dec 2020 11:47:01 +0100 (CET)
Message-Id: <202012041047.0B4Al1jC048417@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20201203154951.29382-2-steffan@...1856...>
References: <20201203154951.29382-2-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH applied] Re: tls-crypt-v2: also preload
 tls-crypt-v2 keys (if --persist-key)
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
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

As for 1/2, I have not really reviewed or tested anything
here.  Trusting you and Arne here.

From a quick view this looks like a nice "code cleanup en passant",
though :-) (and it does pass the client side tests, of course).

Your patch has been applied to the master and release/2.5 branch.

commit 4d307ed431bf18d554f524ebaf111f5e136147fe (master)
commit bac760f84b39bf8f6b97778a15e5fcf863f6d366 (release/2.5)
Author: Steffan Karger
Date:   Thu Dec 3 16:49:51 2020 +0100

     tls-crypt-v2: also preload tls-crypt-v2 keys (if --persist-key)

     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20201203154951.29382-2-steffan@...1856...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21307.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


