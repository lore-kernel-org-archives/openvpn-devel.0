Date: Sun, 23 Nov 2025 14:21:43 +0100 (CET)
Message-Id: <202511231321.5ANDLhQA083478@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251123113747.17739-1-gert@...1296...>
References: <20251123113747.17739-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: iservice: make sure buffer size
 is not zero
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
To: Heiko Hund <heiko@...2662...>
Cc: openvpn-devel@lists.sourceforge.net

Trivial enough.

While this cannot happen today (the single caller passes in 
*size = sizeof(data[0].domains)), who knows what the next refactoring
might bring...

Not tested beyond "does BB confirm it compiles" - it does.  The failed
checks in BB look more like "something in one part of the build infra
is eating UDP fragments again" (some workers consistently fail t_client,
while all others are fine).

Your patch has been applied to the master branch.

commit c20a960a338a2e6e7436260cdae4d6eef298cfb0
Author: Heiko Hund
Date:   Sun Nov 23 12:37:42 2025 +0100

     iservice: make sure buffer size is not zero

     Signed-off-by: Heiko Hund <heiko@...2662...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1389
     Message-Id: <20251123113747.17739-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34606.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


