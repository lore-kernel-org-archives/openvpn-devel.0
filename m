Date: Fri, 19 Aug 2022 15:14:43 +0200 (CEST)
Message-Id: <202208191314.27JDEhMk091491@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220704025840.2558-1-selva.nair@...277...>
References: <20220704025840.2558-1-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix auth-token usage with
 management-def-auth
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Sorry for leaving this ACKed-but-unmerged since July.  It got heaped-over
by DCO patches...

Anyway.  I have no current test rig where I could recreate and test this,
but if Arne as resident management interface expert is happy with this,
this is fine for me.  (The comment / message updates are easy to review
and make sense).

I have test compiled it :-) - and lightly tested, knowing that the
interesting code path is not excercised.  Just to be sure.

Cherrypicking to 2.5 caused a funny conflict, as the variable is called
"in_renog_time" there, and got renamed to "in_renegotiation_time" somewhere
later...  but solved easily enough.

Your patch has been applied to the master and release/2.5 branch.

commit ddbe6a6fc26586d09f5a9105f13124c479b4d993 (master)
commit 5b178f591c882a6600414104a77a9240f7a29331 (release/2.5)
Author: Selva Nair
Date:   Sun Jul 3 22:58:40 2022 -0400

     Fix auth-token usage with management-def-auth

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20220704025840.2558-1-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24627.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


