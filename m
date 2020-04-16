Date: Thu, 16 Apr 2020 09:47:50 +0200 (CEST)
Message-Id: <202004160747.03G7lova032230@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200313165913.12682-1-lstipakov@...277...>
References: <20200313165913.12682-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix broken async push with NCP
 is used
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

Your patch has been applied to the master and release/2.4 branch (bugfix).

I have read the semi-ACK from Arne, discussed with Lev, and we decided to 
go for "we'll merge this simple change now, so that the bug is fixed, and 
then we can have a longer discussion on how to make this code nicer"
(refactoring).  Did some review on my own, code looks good, explanation
makes sense, so "this is the right fix".

Done some minimal testing on Linux (t_client), just to see we didn't
break something big.  I do not have an async-cc server testbed today,
but it seems I need to add one (note to self!)...

As a side note: the patch does two things, one is "add generation of
data channel keys when async push is triggered", and also a bit of
refactoring, moving the (numerous) "only do channel keys if they have 
not been done already" checks into tls_session_update_crypto_params()
(added a note to that extent to the commit message).

Trac reference to 1259 added to commit message.

commit 3b06b57d9f1d972ec16f0893d06697439c1bb1fe (master)
commit 9bb285e3e63fb6d716923e0353436bb8d8e89313 (release/2.4)
Author: Lev Stipakov
Date:   Fri Mar 13 18:59:13 2020 +0200

     Fix broken async push with NCP is used

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20200313165913.12682-1-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg19553.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


