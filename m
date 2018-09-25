Date: Tue, 25 Sep 2018 16:28:43 +0200 (CEST)
Message-Id: <201809251428.w8PEShkI021328@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20180912110701.31609-1-arne@...1227...>
References: <20180912110701.31609-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Properly free tuntap struct on
 android when emulating persist-tun
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

"It does what it says on the lid" - do_init_tun() will allocate a new
struct tuntap, so if we have one beforehand, it needs free()ing.  

I have not actively *tested* it, as I have no test rig for building 
Android binaries - OTOH, if the one who gets all the blame for Android 
says it's ok, I'm going to believe it (no other platform affected).

Your patch has been applied to the master and release/2.4 branch
(2.4 mostly due to "it's a bugfix, it's a single platform, and 
to keep the code similar for future changes").

commit da3f583f30a4b2be9cc5501874373fc4f627158d (master)
commit 21a307dd7252a066f204dee52a4cf569a4a48a1d (release/2.4)
Author: Arne Schwabe
Date:   Wed Sep 12 13:07:01 2018 +0200

     Properly free tuntap struct on android when emulating persist-tun

     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20180912110701.31609-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg17460.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


