Date: Mon, 9 Jan 2023 13:17:05 +0100 (CET)
Message-Id: <202301091217.309CH5AT018457@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230106150412.1667492-1-selva.nair@...277...>
References: <20230106150412.1667492-1-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Distinguish route addition
 errors from route already exists
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Lev has also ACKed, but since I did some previous digging into the code,
I gave it an extra-hard stare and can confirm that it looks very reasonable.

That said, I have a dislike for magic "0", "1" and "2" constants appearing
with no explanation - can we have a followup patch that documents the
expected behaviour (maybe in route.h?) and also introduces some helpful
constants?  Like, we have ISC_ERROR, maybe RTA_ERROR, RTA_SUCCESS, 
RTA_EEXISTS or so?  I do not care much about the actual naming, but 
I'm sure that I'll wonder in a year "why '2'?  what is '2' here?".

I also notice that there is quite a bit of imbalance between IPv4 and
IPv6 route addition on Windows - for IPv6, add_route_ipv6() will not
print any messages (so, no diff here), while IPv4 has all that...
maybe something to clean up in 2.7.

We *also* might want to get rid of that obscure 

  /* failed, try increasing the metric to work around Vista issue */

code bit, which looks extremely scary ("increasing metric with +1 in
a tight loop until we reach 2048") and Vista is out of support anyway...


Last not least, a 'status ? "succeeded"...' msg() escaped your
attention, in do_route_ipv6_service()...


I have compile-tested this for Windows, and client-side tested on 
Linux (netlink).  Unsurprisingly nothing really interesting happened,
as there is no real new code, my test rig has no "EEXIST" yet, and
nothing uses the new status values yet.


Your patch has been applied to the master and release/2.6 branch.

commit 9c6d72c783f4212f965e1e855b4fdb0ea34b595b (master)
commit 93da80eaa1548197b173537bb74bf6db7e10912e (release/2.6)
Author: Selva Nair
Date:   Fri Jan 6 10:04:12 2023 -0500

     Distinguish route addition errors from route already exists

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20230106150412.1667492-1-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25903.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


