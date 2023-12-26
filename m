Date: Tue, 26 Dec 2023 21:34:51 +0100 (CET)
Message-Id: <202312262034.3BQKYpx1037214@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <tencent_C49D67EAA5678D180C293706A9469EFE8307@...1414...>
References: <tencent_C49D67EAA5678D180C293706A9469EFE8307@...1414...>
Subject: [Openvpn-devel] [PATCH applied] Re: fix(ssl): init peer_id when
 init tls_multi
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
To: yatta <ytzhang01@...2752...>
Cc: openvpn-devel@lists.sourceforge.net

Unfortunately I haven't received a response to my query for a full
name to put into the logs, so "yatta" will have to do.

Thanks to Arne for the detailed insights on what is happening here, and
why this is the correct fix (refactoring for "master" welcome :-) ).

I have not tested this "for real" (on a p2mp server, actually filling
max users) - need to do this.  But it passes all the basic tests, not
surprisingly.

Your patch has been applied to the master and release/2.6 branch (bugfix).

commit 3e30504d86f0fe5556acc0cb8e6975c5b2277661 (master)
commit 6dffbf6a2a0fdacb3509410f665a69dfa3b28cbc (release/2.6)
Author: yatta
Date:   Fri Oct 20 01:12:13 2023 +0800

     fix(ssl): init peer_id when init tls_multi

     Signed-off-by: yatta <ytzhang01@...2752...
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <tencent_C49D67EAA5678D180C293706A9469EFE8307@...1414...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27260.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


