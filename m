Date: Sun, 15 Mar 2020 22:16:28 +0100 (CET)
Message-Id: <202003152116.02FLGSo4037377@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200314052906.28095-1-lstipakov@...277...>
References: <20200314052906.28095-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix building with
 --enable-async-push in FreeBSD
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
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Your patch has been applied to the master branch.  

Tested on FreeBSD 11.3 with libinotify installed and 12.0 without (fails
if called with "--enable-async-patch", works nicely otherwise).  From
"staring at patch" I assume no changes for other platforms, so I did not
test there.

Re-sending with a new commit ID - I noticed, after sending out the mail,
that the "Trac: ###" got lost from v4.  So I re-added, and this is the
right commit ID now.

commit e1eb630df1b3ef5df88afd51003fbec40e5d6d67
Author: Lev Stipakov
Date:   Sat Mar 14 07:29:06 2020 +0200

     Fix building with --enable-async-push in FreeBSD

     Signed-off-by: Lev Stipakov <lstipakov@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20200314052906.28095-1-lstipakov@...277...>
     URL: https://www.mail-archive.com/search?l=mid&q=20200314052906.28095-1-lstipakov@...277...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


