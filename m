Date: Thu, 18 Aug 2022 08:28:44 +0200 (CEST)
Message-Id: <202208180628.27I6SitM055924@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220817210857.1558-1-timo@...2669...>
References: <20220817210857.1558-1-timo@...2669...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco: turn platform config
 checks into separate function
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
To: Timo Rothenpieler <timo@...2669...>
Cc: openvpn-devel@lists.sourceforge.net

Tested this on the Linux / DCO server test rig that found the issue
yesterday - the "no root" server now does no longer reject clients
on connect, so that problem is fixed.  Thanks :-)

To verify that the startup function is actually used, I triggered
it with
 
  - openvpn --mktun --dev tun99
  - openvpn --dev tun99 ...
    (pre-existing tun device -> disable DCO)

    2022-08-18 07:57:30 net_iface_type: type of tun99: tun
    2022-08-18 07:57:30 Interface tun99 exists and is non-DCO. Disabling data channel offload

  - openvpn --user nobody ...
    (started as non-root user - failed, of course, but told me "you no DCO!"
    first :-) )

    2022-08-18 07:56:27 --user specified but lacking CAP_SETPCAP. Cannot retain CAP_NET_ADMIN. Disabling data channel offload


Your patch has been applied to the master branch.

commit 897728ff7141c367c5ea1e02918c8487ccafef16
Author: Timo Rothenpieler
Date:   Wed Aug 17 23:08:57 2022 +0200

     dco: turn platform config checks into separate function

     Acked-by: Antonio Quartulli <a@...2181...>
     Message-Id: <20220817210857.1558-1-timo@...2669...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24969.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


