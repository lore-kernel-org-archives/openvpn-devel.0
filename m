Date: Tue, 17 Sep 2024 12:40:28 +0200 (CEST)
Message-Id: <202409171040.48HAeS7s040193@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240221111814.942965-1-frank@...2641...>
References: <20240221111814.942965-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: Route: remove incorrect routes
 on exit
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
To: Gianmarco De Gregori <gianmarco@...2726...>
Cc: openvpn-devel@lists.sourceforge.net

This is a good find, and a somewhat stupid oversight - even if not easy
to trigger.  What you need so this has an effect is a pre-existing host
route to the VPN server and then a "route add" fail (easy to trigger on
the BSDs, EEXIST because "only 1 route can exist") - and because we do not
remember, we try "route delete" later on and delete the *other* route,
messing up our routing table.  Which is something t_client even checks
for ("is 'route print' the same as before?") but you need a host route
to begin with - added t_client tests, breaks without the patch, works
with the patch.  Thanks :-)

I've changed the commit message slightly ("Trac: #1457" is the standard
format).

Your patch has been applied to the master and release/2.6 branch (bugfix).

commit 14d2db6cd41fb6414992869caf109972d7a8275e (master)
commit 4ad3aa5a2b6838650ca98fd92994eab7108c1e8b (release/2.6)
Author: Gianmarco De Gregori
Date:   Wed Feb 21 12:18:14 2024 +0100

     Route: remove incorrect routes on exit

     Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20240221111814.942965-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28290.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


