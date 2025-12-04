Date: Thu, 4 Dec 2025 14:23:42 +0100 (CET)
Message-Id: <202512041323.5B4DNg4e025400@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251203125741.29239-1-gert@...1296...>
References: <20251203125741.29239-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Clarify some code in epoch with
 better comments
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

Improved documentation is always welcome :-)

I have taken Antonio's last-minute complaint into account and adjusted
the end-of-comment '*/' bits to live on their own line.  I did not touch
other comments in these files, just those that were touched in Arne's
patch.

Since this is just comments, I've only done a sanity check compile to
ensure I didn't fat-finger one of my changes.

Your patch has been applied to the master branch.

commit c282b62f9072b513c0fa8eef49fd8fc7c47afd15
Author: Arne Schwabe
Date:   Wed Dec 3 13:57:34 2025 +0100

     Clarify some code in epoch with better comments

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1190
     Message-Id: <20251203125741.29239-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34829.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


