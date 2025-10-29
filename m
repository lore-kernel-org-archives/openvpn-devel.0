Date: Wed, 29 Oct 2025 08:53:06 +0100 (CET)
Message-Id: <202510290753.59T7r679050029@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251029070701.11457-1-gert@...1296...>
References: <20251029070701.11457-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Install host routes for
 out-of-subnet ifconfig-push addresses when DCO is enabled
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

Thanks for the midnight fix, just in time for 2.7_rc1 ;-)

So this has been a bit of a journey with the patch running up to v14...
getting bits and pieces right across the 3 potentially affected platforms
(Linux and FreeBSD need this, Windows has DCO but must not have this)
and IPv4/IPv6 is quite a few small snippets all over the place.

I have tested this on FreeBSD with DCO, with a client-connect script that
can setup ifconfig-push/ifconfig-ipv6-push/iroute/iroute-ipv6 controlled
from the client ("setenv UV_WANT_IP ...") and t_client.rc instances that
request IPv4/IPv6 addresses "outside the server subnet", verify that they
receive what they asked for, and then run pings to see if traffic actually
comes back.  This worked already in v11.

v11->v13->v14 was basically ensuring that we only install these routes
when we really need them (v11 installed the route "always!" for IPv6 due
to checking the wrong variable, v13 always tried to *delete* the route
for IPv4 due to missing htonl() in one of the calls).  In v14 we now
have exactly what we want - routes get only installed when needed, and
are only deleted when installed.


There might be dragons lurking here with clients reconnecting and 
learn/unlearn-address getting confused.  I ran my tests with EEN on the
client side to ensure the server always has a well-defined state.


I have also reworded the commit message a bit :-)


Your patch has been applied to the master branch.

commit f938d991a8222bb3304865f2cd7b368d7f8a9224
Author: Arne Schwabe
Date:   Wed Oct 29 08:06:56 2025 +0100

     Install host routes for out-of-subnet ifconfig-push addresses when DCO is enabled

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1192
     Message-Id: <20251029070701.11457-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33991.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


