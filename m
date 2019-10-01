Date: Tue, 1 Oct 2019 13:11:00 +0200 (CEST)
Message-Id: <201910011111.x91BB0r0086995@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20190917121115.13966-1-arne@...1227...>
References: <20190917121115.13966-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Sent indication that a session
 is expired to clients
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
To: Arne Schwabe <arne@...515...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master branch.

This breaks --disable-server (again), but since David sent a patch to
remedy this, I'm merging it nonetheless.  I'll merge David's patch right
away and push both together to avoid needless buildbot fails.

The patch itself looks like a very nice approach to the problem with
"how can we communicate authentication fail reasons to the client?" issue
that had a few (fairly intrusiv) patch sets flying around... someone 
needs to go through the open patches and see what has become obsolete.

commit fba0e8b8964d5a1f24182ff4c48b18923b5d7ba8
Author: Arne Schwabe
Date:   Tue Sep 17 14:11:15 2019 +0200

     Sent indication that a session is expired to clients

     Acked-by: David Sommerseth <davids@...515...>
     Message-Id: <20190917121115.13966-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg18820.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


