Date: Fri, 16 Dec 2022 12:43:46 +0100 (CET)
Message-Id: <202212161143.2BGBhkcZ070485@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20221215190143.2107896-4-arne@...1227...>
References: <20221215190143.2107896-4-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Ensure that argument to
 parse_line has always space for final sentinel
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

Straightforward enough :-) - still, run through the test mill.  I have
no ASAN environment around right now, so couldn't verify the actual
overflow "before" - but stare-at-code confirms the problem and the fix.

Your patch has been applied to the master, release/2.6, release/2.5
and release/2.4 branch (and has been t_client tested on 2.4+2.5)

commit 749beb6d0cb9f8628997bb656ba2f64e31cac377 (master)
commit d75462fc70a2b0b26fb10063b15b6bfc5c8161db (release/2.6)
commit 01bed788b0ec4007591b81398b56b5f9632ca33c (release/2.5)
commit a12adfa01b2486bff32c9bb3aedf81716ad14c58 (release/2.4)
Author: Arne Schwabe
Date:   Thu Dec 15 20:01:38 2022 +0100

     Ensure that argument to parse_line has always space for final sentinel

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20221215190143.2107896-4-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25734.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


