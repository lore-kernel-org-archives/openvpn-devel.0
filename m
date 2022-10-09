Date: Sun, 9 Oct 2022 15:51:36 +0200 (CEST)
Message-Id: <202210091351.299Dpam7025642@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20221009130805.1556517-1-arne@...1227...>
References: <20221009130805.1556517-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix OpenVPN querying
 user/password if auth-token with user expires
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

Verified that this is just a rebase of v3, to accomodate for the
auth_user_pass_setup() changes that have happened in the meantime.

Recording David's and Heiko's ACK, they have done the stare-at-code
and actual testing (I have run t_client tests, but they do not excercise
this problem with my current test servers - need to add more variants).

I have reworded the commit message along the lines David suggested.

This is a bugfix, so it goes into release/2.5 as well - needed a bit
of manual massaging (auth_user_pass_setup() change)

Your patch has been applied to the master and release/2.5 branch.

commit 7d291e10bccd1d6b9e584307fb5fe3ebfb114ec9 (master)
commit af546d798213587285b225cd0031944a81e8e26c (release/2.5)
Author: Arne Schwabe
Date:   Sun Oct 9 15:08:05 2022 +0200

     Fix OpenVPN querying user/password if auth-token with user expires

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: David Sommerseth <davids@...515...>
     Acked-by: Heiko Hund <heiko@...2662...>
     Message-Id: <20221009130805.1556517-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25367.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


