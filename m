Date: Sat, 9 Nov 2019 10:29:13 +0100 (CET)
Message-Id: <201911090929.xA99TDwU077636@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20191009143422.9419-7-a@...2181...>
References: <20191009143422.9419-7-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: VLAN: implement support for
 forwarding only pre-tagged VLAN packets
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

Stared at the code.  Ran a full set of t_client/t_server tests with
disabled VLAN tagging (no change, no brokenness).

With enabled VLAN tagging and using "untagged mode" it now correctly
sorts out packets tap <-> client and client1 <-> client2 according
to PVID - if PVIDs match, devices can talk and broadcasts are seen,
and if they do not match, no communication happens.  Great.

One bug for the upcoming documentation: if there is *no* "vlan-pvid"
setting in a ccd/ file, it will not use "1" but the "global vlan-pvid"
setting.  Which, as we just agreed on, makes sense, just needs to be
documented.


If enabling "tagging only" ("vlan-accept tagged") half the openvpn server
config stops having a meaning - like "ifconfig" or "ifconfig-pool" - so
you really want tap devices that are setup outside of OpenVPN or
by means of a --up script (setting up dot1q subinterfaces, ifconfig,
set up routes, etc.).  Just pointing this out for the sake of the 
archives.

For reference: this is what you'd do on Linux to set up VLAN subinterfaces
(vlan 200 on tap9)

  # modprobe 8021q
  # ip link add link tap9 name tap9.200 type vlan id 200
  # ip addr add 10.204.4.1/24 dev tap9.200
  # ip addr add fd00:abcd:204:4::1/64 dev tap9.200
  # ip link set up dev tap9.200


(openvpn running on "--dev tap9")


That said, tagged mode works nicely - client packets are sent to tap0
with "vlan 207" visible in tcpdump, and linux "tap9.207" picks them
up correctly and clients can talk.  Clients in a different VLAN show
up with a different vlan tag, etc. - as one would expect.  If you want
"clients in vlan 200" to talk to "clients in vlan 207", it needs to be
done with linux routing between "tap9.200" and "tap9.207" - which I did
test, and it also works as expected.

Full set of t_server test passed with enabled vlan tagging (rearranging
tap clients into different vlans and adding IP forwarding etc)


Your patch has been applied to the master branch.

commit e375a5ce555a66c8b6b2ac2869977e723a65982f
Author: Antonio Quartulli
Date:   Wed Oct 9 16:34:19 2019 +0200

     VLAN: implement support for forwarding only pre-tagged VLAN packets

     Signed-off-by: Fabian Knittel <fabian.knittel@...1547...>
     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20191009143422.9419-7-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg18918.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


