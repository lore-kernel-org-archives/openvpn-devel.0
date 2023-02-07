Date: Tue, 7 Feb 2023 17:22:31 +0100 (CET)
Message-Id: <202302071622.317GMVeP058309@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230203191440.136050-2-frank@...2641...>
References: <20230203191440.136050-2-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: Windows: fix unused function
 setenv_foreign_option
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
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

Tested on plain linux (which needs setenv_foreign_option) and MingW 
(which no longer warns) compile.  Trivial enough.

Your patch has been applied to the master and release/2.6 branch.

commit 8aeec3aa36873489d3e708ae694c57e59b4302ef (master)
commit b9d35055eae676790f3bc214c00a01f756b0cd55 (release/2.6)
Author: Frank Lichtenheld
Date:   Fri Feb 3 20:14:36 2023 +0100

     Windows: fix unused function setenv_foreign_option

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <20230203191440.136050-2-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26145.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


