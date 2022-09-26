Date: Mon, 26 Sep 2022 11:24:28 +0200 (CEST)
Message-Id: <202209260924.28Q9OS52080817@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220926064310.688-1-lstipakov@...277...>
References: <20220926064310.688-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: msvc: add branch name and
 commit hash to version output
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

Acked-by: Gert Doering <gert@...1296...>

This is a useful feature, and after some polishing, I think this is 
about as good as it will get now :-) - thanks.

I have not tested this at all, as I have no MSVC build environment and
it will not manifest on MinGW builds.  From my understanding it looks
reasonable.

Your patch has been applied to the master branch.

commit b9d91c38843076a03b6b5fc123a386ef3c2bc564
Author: Lev Stipakov
Date:   Mon Sep 26 09:43:10 2022 +0300

     msvc: add branch name and commit hash to version output

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220926064310.688-1-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25311.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


