Date: Tue, 9 Mar 2021 20:21:55 +0100 (CET)
Message-Id: <202103091921.129JLtBT056457@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210303123818.16012-1-arne@...1227...>
References: <20210303123818.16012-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Implement server side of
 AUTH_PENDING with extending timeout
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

I won't claim to understand what this stuff is doing in the grand scheme
of things (as far as I can see, all it does is "it introduces a timeout 
variable all over the place, which then gets sent to the client") but
the changes look safe enough :-)

I have subjected this to client-side and server side torturing - which,
admittedly, does not excercise the mangement interface at all, and does
not have a test for "delayed auth" either.  So it's not testing the new
code at all, just "nothing else breaks".  And this, I can confirm
(mbedTLS 2.25 client crashes :-) ).

Your patch has been applied to the master branch.

commit 53229047a259b2edb9034802a33fe27636675ff9
Author: Arne Schwabe
Date:   Wed Mar 3 13:38:18 2021 +0100

     Implement server side of AUTH_PENDING with extending timeout

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <20210303123818.16012-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21596.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


