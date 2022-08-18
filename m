Date: Thu, 18 Aug 2022 09:35:22 +0200 (CEST)
Message-Id: <202208180735.27I7ZMY2057080@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220814085117.7128-1-a@...2181...>
References: <20220814085117.7128-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco-win: ensure the DCO API is
 not used when running on Windows
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
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

Taking the ACK from Lev on 102, applying to 103 - which mostly has
"better wording".  I have tested this on the DCO test rig, and it's
fine with the change.

I wouldn't be surprised to see more work in this area for "we need to
be able to send packets to not-yet-authenticated remotes in p2p mode",
though... :-)

Your patch has been applied to the master branch.

commit d4f2209cdb4dfda32f36fa750d97b7e1ba751a4d
Author: Antonio Quartulli
Date:   Sun Aug 14 10:51:17 2022 +0200

     dco-win: ensure the DCO API is not used when running on Windows

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <20220814085117.7128-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24929.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


