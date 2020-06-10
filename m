Date: Wed, 10 Jun 2020 18:01:44 +0200 (CEST)
Message-Id: <202006101601.05AG1i8K031513@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200421154612.14140-1-cschenk@...2502...>
References: <20200421154612.14140-1-cschenk@...2502...>
Subject: [Openvpn-devel] [PATCH applied] Re: Set the correct mtu on windows
 based systems
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
To: Christopher Schenk <cschenk@...2502...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Selva has ACKed the version sent in April 2019, and it should have been
merged then and there - we (I) let it rot, tun.c got changed quite a bit
for wintun support, now we have a new patch.  Thanks!  (And thanks for
the repeated reminders, this is necessary at times)

I have compared both patches.  They differ in context, of course (*),
but the actual changes introduced by this patch are the same - so, I
think I can take the ACK from Selva for the new patch as well.


(*) one of the context differences is the iservice message types - we
have grown "msg_register_ring_buffers" in the meantime.  So to get this
patch into 2.4 would be somewhat complicated, to ensure no iservice
breakage.  But since 2.5 is really close now, I find that acceptable.


I have also reviewed this patch (so, two ACKs, one from Selva and one
from me) - code looks good.

The "SitePrefixLength = 0" call confused me a bit, but this is correct
according to (long URL):
  https://docs.microsoft.com/en-us/windows/win32/api/netioapi/nf-netioapi-setipinterfaceentry

I have tested this on Win10:

 - config with no "tun-mtu" and iservice -> interface MTU = 1500, good
 - config with "tun-mtu 1330" and iservice -> interface MTU = 1330, good
 - config with no "tun-mtu" and priv. gui -> interface MTU = 1500, good
 - config with "tun-mtu 1330" and priv. gui -> interface MTU = 1330, good

because I sometimes test things before I question myself whether this is
a useful thing to test:
 - config with "tun-mtu 1200" and priv. gui -> 
     *succeeds* for IPv4
     *fails* for IPv6
     "TUN: setting IPv6 mtu using service failed: Falscher Parameter.
      [status=87 if_index=8]

   (which is Windows telling me that "the IETF says that the mininum MTU
    for IPv6 is 1280, so go away and complain to them!" - technically
    correct, though slightly confusing)


Just for reference: "ipconfig /all" does not show the MTU, you need to
call "netsh interface ipv4/ipv6 show subinterfaces".


Remarks:

  - if using the iservice, openvpn will log
      "IPv<x> MTU set to 1330 on interface 8 using service"
    if using the gui in privileged mode, it will log
      "Successfully set IPv<x> mtu on interface 8"

    --> I think it would be good to use the same message here, and 
    include the numeric value in both cases, like

      "IPv<x> MTU set to 1330 on interface 8 using SetIpInterfaceEntry()"

    or so.  Can you send a followup patch?  It will be expedited!

  - shall we do "if MTU < 1280, log a notice and do not attempt to set
    IPv6 MTU"?  Or "just log the notice, in case windows will accept
    it nonetheless"?

    if (mtu<1280)
    {
      msg(M_INFO, "NOTE: IPv6 interface MTU < 1280 conflicts with IETF standards and might not work");
    }


Your patch has been applied to the master branch.

Thanks for your patience.


commit 0213f80ed72ad8b6bb43db3bbd72a66ec2e12fcd
Author: Christopher Schenk
Date:   Tue Apr 21 17:46:12 2020 +0200

     Set the correct mtu on windows based systems

     Signed-off-by: Christopher Schenk <cschenk@...2502...>
     Acked-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20200421154612.14140-1-cschenk@...2502...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg19803.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


