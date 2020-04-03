Date: Fri, 3 Apr 2020 10:12:37 +0200 (CEST)
Message-Id: <202004030812.0338CbQX034518@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1585591527-23734-1-git-send-email-selva.nair@...277...>
References: <1585591527-23734-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Move querying username/password
 from management to a function
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

Your patch has been applied to the master branch.

Stared-at-code, test compiled on linux and MinGW.  Really just moving
code, though "git show --colour-moved=zebra" does not really want to
show it.

I've tried to apply it to release/2.4 (as it's a prerequisite for 
the next patch, which I consider a bugfix) but there are massive
merge conflicts due to #ifdef ENABLE_CLIENT_CR and #ifdef ENABLE_CRYPTO
still present.  So if you could send a backport of both 1v2 + 2v2 to
2.4 (possibly as a joint patch?), as soon as both are merged, that would 
be appreciated.

Acked-by: Gert Doering <gert@...1296...>

commit 8e5d30cf47da63040114c00eab838bbb1c520781 (master)
Author: Selva Nair
Date:   Mon Mar 30 14:05:26 2020 -0400

     Move querying username/password from management to a function

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1585591527-23734-1-git-send-email-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg19656.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


