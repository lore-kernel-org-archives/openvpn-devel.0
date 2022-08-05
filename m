Date: Fri, 5 Aug 2022 16:55:12 +0200 (CEST)
Message-Id: <202208051455.275EtC8Q060596@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220805064555.13385-1-a@...2181...>
References: <20220805064555.13385-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco: implement dco support for
 p2mp/server code path
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

v2 has an ACK from Heiko, so recording that.  OTOH v3 is substantially
different (the dco.c hunk was missing from v1+v2 - hidden in 13/25 v1 - 
and the multi.c tls_keys stuff is quite different), so I gave this my own
stare-at-code, and of course the full test set.

The findings are lengthy, the followup work is non-trivial, but we have
come a long way.

- stare-at-code

   - the new additions to dco.c all make sense - the iroute thing, we discussed
     a lot beforehand, and the variants (sockaddr/inaddr) in local/remote
     address are due to "kernel wants them ready-to-use in target format".

     Not sure if we want to consider the "!ENABLE_IP_PKTINFO" case here, 
     ever, though...  DCO requires a recent Linux (or FreeBSD) system,
     and those have them.  Followup patch, though.

     *Naming* some of these bits "remoteaddr" and "remote_addr*" is a bit
     unlucky, though...  I do understand that "remoteaddr" is the remote
     end of the (UDP) socket, and "remote_addr*" is the inside ifconfig
     IP for the tunnel peer - but I think this could be made more clear.

     The code bits

	+        int netbits = 128;
	+        if (addr->type & MR_WITH_NETBITS)
	+        {
	+            netbits = addr->netbits;
	+        }

     are ugly, and take too much code space.  I think we need to fix this,
     as in, ensure that addr->netbits is always set, and for "host route
     things", MR_WITH_NETBITS would just control whether ".../bits" is 
     used on printing, not for lookup.  Maybe the code already does that,
     but we don't know.  Another followup patch...
 
     I noticed that we don't do error handling on the iroute installation
     - but that is traditional OpenVPN behaviour, for all sorts of route
     additions.  We log, but we never fail...


   - in mtcp.c, there is a new "mi->socket_set_called = false" call,
     which seems to be unrelated to DCO, just cleaning up references
     (but it looks reasonable).

   - there is some nesting cleanup (-> show -w) around mtcp.c line 625

   - there is more nesting cleanup in multi.c / multi_learn_in_addr_t()
     (but that code is changed anyway, so it makes sense)

     The actual changes here are needed for "real route" iroute handling,
     and have been discussed and agreed-on months ago already.

   - as agreed on IRC, I changed the comment

        /* We do not want to install IP -> IP dev ovpn-dco0 */

     to

        /* "primary" is the VPN ifconfig address of the peer and already 
         * known to DCO, so only install "extra" iroutes (primary = false)
         */

   - I need to test connecting from a 2.3 client to a DCO-enabled
     server, to excercise the "Client does not support DATA_V2..." path
     (but it looks good).

   - I also need to test if "on a DCO enabled server, a ccd/ script 
     produces something which is not allowed for DCO" (like, cipher BF-CBC
     etc.) gets handled correctly.  The code is there now (multi.c, around
     line 2710).

   - multi_close_instance_on_signal() and multi_signal_instance() just
     move around (--color-moved=zebra) [#ifdef ENABLE_MANAGEMENT]


- FreeBSD client test (no DCO whatsoever yet)
  (everything passes, unsurprisingly)

- Linux client test, --enable-dco, no kernel DCO
  (everything passes, unsurprisingly, not hitting these new code paths)

- Linux server test, no --enable-dco
  (everything passes, and this is good - so the new code paths in multi.c
  do not break existing functionality and "known corner cases")

- Linux client test, --enable-dco, kernel DCO
  (everything except 2c, 2d, 2f passes - known kernel issue, unchanged
  from before)

- Linux server test, --enable-dco, kernel DCO

  - many of my server test instances had DCO incompatible options in there
    (like, comp-lzo, or just being TAP instances)

	Note: cipher 'BF-CBC' in --data-ciphers is not supported by ovpn-dco, disabling data channel offload.
	Note: dev-type not tun, disabling data channel offload.
	Note: NOT using '--topology subnet' disables data channel offload.
	Note: --fragment disables data channel offload.
	Note: Using compression disables data channel offload.
	Note: dev-type not tun, disabling data channel offload.


    NOTE: the wording should be made more similar (disabling/disables), 
    I'd say.

  - clients connecting will produce this very confusing sequence of
    messages...:

	Aug  5 16:27:33 ubuntu2004 tun-udp-p2mp[1834587]: freebsd-74-amd64/194.97.140.3:65038 OPTIONS IMPORT: reading client specific options from: ccd/freebsd-74-amd64
	Aug  5 16:27:33 ubuntu2004 tun-udp-p2mp[1834587]: freebsd-74-amd64/194.97.140.3:65038 OPTIONS IMPORT: Server did not request DATA_V2 packet format required for data channel offload
	Aug  5 16:27:33 ubuntu2004 tun-udp-p2mp[1834587]: freebsd-74-amd64/194.97.140.3:65038 OPTIONS ERROR: pushed options are incompatible with data channel offload. Use --disable-dco to connect to this server

    (we are the server, so what did "the Server" do wrong, and we are not
    trying to connect to "this server" either???)

    ... but proceeds!

	Aug  5 16:27:33 ubuntu2004 tun-udp-p2mp[1834587]: freebsd-74-amd64/194.97.140.3:65038 MULTI: Learn: 10.220.2.8 -> freebsd-74-amd64/194.97.140.3:65038
	...
	Aug  5 16:27:33 ubuntu2004 tun-udp-p2mp[1834587]: freebsd-74-amd64/194.97.140.3:65038 Data Channel: using negotiated cipher 'AES-256-GCM'
	...
	Aug  5 16:27:36 ubuntu2004 tun-udp-p2mp[1834587]: freebsd-74-amd64/194.97.140.3:65038 SENT CONTROL [freebsd-74-amd64]: 'PUSH_REPLY,route 10.220.0.0 255.255.0.0,route-ipv6 fd00:abcd:220::/48,tun-ipv6,route-gateway 10.220.2.1,topology subnet,ping 10,ping-restart 30,compress stub-v2,ifconfig-ipv6 fd00:abcd:220:2::1006/64 fd00:abcd:220:2::1,ifconfig 10.220.2.8 255.255.255.0,peer-id 0,cipher AES-256-GCM' (status=1)

    ... and pinging 10.220.2.8 works just fine.

    The mentioning of ccd/ here is a red herring, if I move away the
    ccd/ file, I get the same complaints about DATA_V2.

    Seems we shuffled around the option checking code a bit too often
    (this is the no-longer _part2() bits, dco_check_pull_options(),
     I'm afraid, so, yeah, blame me).


  - the udp p2p instance wants to send something "from userland" right after
    starting (before a peer is connected, no --remote) - this used to trigger
    an ASSERT(), now it just logs  this:

    ubuntu2004 tun-udp-p2p[1834288]: Attempting to send data packet while data channel offload is in use. Dropping packet

  - connecting and disconnecting in rapid sequence (t_client tests on the
    other end) triggers these messages

	Aug  5 16:38:31 ubuntu2004 tun-tcp-p2mp[1834574]: Received packet for peer-id unknown to OpenVPN: 1
	Aug  5 16:38:31 ubuntu2004 tun-udp-p2p-tls-sha256[1834670]: ovpn-dco: received message type 3 with mismatched ifindex 8966
	Aug  5 16:38:31 ubuntu2004 tun-udp-p2mp[1834587]: ovpn-dco: received message type 3 with mismatched ifindex 8966

    which is interesting, because I am only connecting to one of them at
    a time - so if there are multiple DCO interfaces active, messages 
    seems to bleed over.

  - for connections "UDP over IPv6", we bump into the same issue that
    we've seen on the p2p DCO test - that is, double-fragmented packets
    trigger "packet is drop and extended socket error"

	Aug  5 16:42:53 ubuntu2004 tun-udp-p2mp[1834587]: read UDPv6 [EMSGSIZE Path-MTU=1500]: Message too long (fd=7,code=90)


  - these issues aside, a good number of tests worked :-) - some that
    still fail are stuff like "cipher none" that need adjustment of the
    testbed.

	Test sets succeeded: 1 1a 1b 1c 1d 1e 1x 2a 2b 2d 2e 2w 2z1 2z2 3 4 4a 4b 5 5a 5b 5c 5d 5v1 5v2 5v3 5w1 5w2 5w3 5w4 5x1 5x2 5x3 5x4 6 9 9a 10 10a 10u 10v 10w 10x 10z.
	Test sets failed: 2 2c 2g 2f 2x 2y.

    I'll followup with "why is each of them failing, and is this a problem
    of (Linux) DCO or not?".


Your patch has been applied to the master branch.

commit a5b4bad46978a01162fb820ea25594d6333aa9db
Author: Antonio Quartulli
Date:   Fri Aug 5 08:45:55 2022 +0200

     dco: implement dco support for p2mp/server code path

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Heiko Hund <heiko@...2662...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220805064555.13385-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24811.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


