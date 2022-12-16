Date: Fri, 16 Dec 2022 18:40:14 +0100 (CET)
Message-Id: <202212161740.2BGHeEHc018606@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20221215190143.2107896-8-arne@...1227...>
References: <20221215190143.2107896-8-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix corner case that might lead
 to leaked file descriptor
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

Acked-by: Gert Doering <gert@...1296...>

stare-at-code confirms that this is a simple-enough fix.

One could argue for moving the fclose(fp) up before the tangled if/else/...
construct, but this one will do and is easy enough to review "it will
not change anything except in case of error".

Your patch has been applied to the master, release/2.6 and release/2.5 branch.

commit a034dc8153522713c3cfda90b2cda114cea70e2d (master)
commit 03f990b4df00bfb2cb9aa93155420efa935011b5 (release/2.6)
commit 1ec71f4568e13f2876e6ec15f1efda530693d2e9 (release/2.5)
Author: Arne Schwabe
Date:   Thu Dec 15 20:01:42 2022 +0100

     Fix corner case that might lead to leaked file descriptor

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20221215190143.2107896-8-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25730.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


