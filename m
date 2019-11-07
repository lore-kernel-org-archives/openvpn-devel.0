Date: Thu, 7 Nov 2019 21:00:22 +0100 (CET)
Message-Id: <201911072000.xA7K0MfR035151@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20191009143422.9419-5-a@...2181...>
References: <20191009143422.9419-5-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: VLAN: filter multicast and
 client-to-client unicast traffic
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

Your patch has been applied to the master branch.

Stared at the code, did quite a bit of testing, found interesting effects.

What this patch does is "client-to-client isolation according to pvid"
(so if you have clients with "vlan-pvid 200" in their ccd/ file, and
other clients with "vlan-pvid 207", only those with the same ID can 
talk to each other).  This is as desired.

What it also does is completely break TAP-to-client communication if
"--vlan-tagging" is enabled - broadcasts ("...incoming_tun()") are
broadcasted everywhere, but unicast packets are never delivered as
they are looked up with a dst PVID of "0" while the "...incoming_link()"
part has learned then with the correct per-client pvid (defaulting 
to "@1").  The necessary adjustments for this are coming in a later
patch in the series, but it makes testing individual bits a bit
more complex (I hacked multi.c to use a non-0 server pvid and that
made tap<->client work again, so the basics are sound).

If --vlan-tagging is disabled, all tests pass.  So this is not breaking
existing functionality, just not adding all required new bits yet.

(And it's not touching any non-TAP code paths anyway)


commit 1c57ea76a256330314d53999bce3e09644b420f9
Author: Antonio Quartulli
Date:   Wed Oct 9 16:34:17 2019 +0200

     VLAN: filter multicast and client-to-client unicast traffic

     Signed-off-by: Fabian Knittel <fabian.knittel@...1547...>
     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20191009143422.9419-5-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg18922.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


