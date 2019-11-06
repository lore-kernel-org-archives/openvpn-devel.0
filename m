Date: Wed, 6 Nov 2019 22:11:58 +0100 (CET)
Message-Id: <201911062111.xA6LBwGQ010924@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20191009143422.9419-4-a@...2181...>
References: <20191009143422.9419-4-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: maddr: export VLAN ID from
 client context to maddr object
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
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Stared at the code, ran client side tests, full set of server side tests,
and compiled (+client tested) on FreeBSD 7.4 to give the "anonymous union 
explosion" bits a good checking :-) (it does not explode anymore, thanks 
for fixing that).

Similar to 2/9, this patch does not actually change behaviour yet - it 
adds the 2-byte vid to the hashed ethernet address for per-client learning,
but as all callers set it to "0", there is no "vlan separation" effect
yet (I know it's coming in a future patch, just pointing out why this 
patch does not change visible behaviour yet).

It shows up in the "MULTI: Learn" lines already, though

Nov  6 22:04:51 gentoo tap-udp-p2mp[11510]: freebsd-11-amd64/2001:608:0:814::f000:16 MULTI: Learn: 00:bd:b5:63:b5:04@...150... -> freebsd-11-amd64/2001:608:0:814::f000:16

.. the "@0" bit after the MAC address is the PVID.


As a side note: it seems that whoever did the IPv6 payload patches was
a bit sloppy (it was me, so I am allowed to say that).  MAC learning is 
only done on IPv4 and ARP packets, but not on IPv6 packets - so I expect 
"ipv6 only mode on tap" to be a bit wacky...  this needs re-testing
before we can declare "ipv6-only works reliably".


Your patch has been applied to the master branch.

commit a2b7230712dbc8cfab85d5bd59605f58fc5fe5f8
Author: Antonio Quartulli
Date:   Wed Oct 9 16:34:16 2019 +0200

     maddr: export VLAN ID from client context to maddr object

     Signed-off-by: Fabian Knittel <fabian.knittel@...1547...>
     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20191009143422.9419-4-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg18917.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


