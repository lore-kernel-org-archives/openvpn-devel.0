Date: Sat, 23 Jan 2021 14:37:30 +0100 (CET)
Message-Id: <202101231337.10NDbUb6048218@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210121172536.32500-1-gert@...1296...>
References: <20210121172536.32500-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: clean up / rewrite
 sample-plugins/defer/simple.c
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Patch has been applied to the master, release/2.5 and release/2.4 branch.

I have fixed the whitespace issue pointed out by Arne, and a few others
that uncrustify wanted fixed (a few TABs have escaped, and one bracked
was misaligned).

commit 452e016cba977cb1c109e74977029b9c0de33de2 (master)
commit 436a4cdd06ecdbab5ef73556431af776a984ad66 (release/2.5)
commit 8007a8a347336fded2f71d84945bbf3e60e58a78 (release/2.4)
Author: Gert Doering
Date:   Thu Jan 21 18:25:36 2021 +0100

     clean up / rewrite sample-plugins/defer/simple.c

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20210121172536.32500-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21466.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


