Date: Sat, 9 Nov 2019 12:24:42 +0100 (CET)
Message-Id: <201911091124.xA9BOgY3079110@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20191009143422.9419-8-a@...2181...>
References: <20191009143422.9419-8-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: VLAN: allow forwarding tagged
 and untagged packets on the server TAP device
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

Stared at code, ran full t_client/t_server tests.

In my test I had a "vlan 200" which was the native/untagged VLAN on the
tap interface now (so ipv4/v6 config goes to "tap9") and a "vlan 207"
which was tagged (-> tap9.207), and clients in "pvid 200" could nicely
talk to clients in "pvid 207" by means of linux routing between tap9 
and tap9.207.  Shutting down tap9.207 stopped communication (= proof 
that it really went out of openvpn and in again).

Your patch has been applied to the master branch.

commit d626fa179b215a12398051ffca25b43ecfc0ad60
Author: Antonio Quartulli
Date:   Wed Oct 9 16:34:20 2019 +0200

     VLAN: allow forwarding tagged and untagged packets on the server TAP device

     Signed-off-by: Fabian Knittel <fabian.knittel@...1547...>
     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20191009143422.9419-8-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg18919.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


