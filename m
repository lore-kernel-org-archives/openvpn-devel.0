Date: Mon, 19 Dec 2022 17:46:36 +0100 (CET)
Message-Id: <202212191646.2BJGka6E093080@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20221219155638.497-1-lstipakov@...277...>
References: <20221219155638.497-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: git-version.py: proper support
 for tags
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
To: Lev Stipakov <lev@...515...>
Cc: openvpn-devel@lists.sourceforge.net

I haven't tested this, but I'm not the one who gets more grey hair
if this doesn't work - Frank is, and he's ACKed it, so all fine with me.

I have changed the Github reference to

 Github: Fixes OpenVPN/openvpn#199 

(we always prefix them with "Github:", and this notation is known to
make GH understand the reference - not sure if the "Fixes" part also
works, we'll see)

Your patch has been applied to the master, release/2.6 and release/2.5
branch (as instructed by Lev).

commit 91ab3d022e2652a46e6d6f25ab62f7c903e583c1 (master)
commit 0bcbfea85dd737b7b68937697fd13e96439a756f (release/2.6)
commit 4a165e1ea58eb395865a9975cefcfbfe7b41c356 (release/2.5)
Author: Lev Stipakov
Date:   Mon Dec 19 17:56:38 2022 +0200

     git-version.py: proper support for tags

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20221219155638.497-1-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25773.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


