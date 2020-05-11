Date: Mon, 11 May 2020 14:38:29 +0200 (CEST)
Message-Id: <202005111238.04BCcTVY036337@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200508212356.18522-1-a@...2181...>
References: <20200508212356.18522-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: get rid of TAG_FILE_INLINE
 constant
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

Your patch has been applied to the master branch.  I have dutifully 
fixed the "INLINE_FILE_TAG" confusion in the commit message :-)

Lightly compile-tested.  Buildbot can do more testing (but this is one
of the patches that would break compilation anywhere, so "trivially
correct).

commit 27ad978fd6721f05f0c484a1bdbf775b0ab36ab2
Author: Antonio Quartulli
Date:   Fri May 8 23:23:56 2020 +0200

     get rid of INLINE_FILE_TAG constant

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: David Sommerseth <davids@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20200508212356.18522-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg19863.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


