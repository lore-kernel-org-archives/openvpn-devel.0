Date: Sat, 7 Jan 2023 18:53:20 +0100 (CET)
Message-Id: <202301071753.307HrK2M069718@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230103202330.1835-2-a@...2181...>
References: <20230103202330.1835-2-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco: bail out when no
 peer-specific message is delivered
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

I've done a bit of commit message grammar ("chacking that the peed_is")
and actually tested this one.  Without the check, my DCO test server
has quite a lot of these...

Jan  7 07:24:06 ubuntu2004 tun-udp-p2mp-topology-subnet[2441339]: Received packet for peer-id unknown to OpenVPN: -1, type 0, reason 2
Jan  7 07:24:06 ubuntu2004 tun-tcp-p2mp[2441317]: Received packet for peer-id unknown to OpenVPN: -1, type 0, reason 1

with the patch these are gone.  Very welcome de-noisification of my logs :-)


We do still have a bit of "logging redundancy" here... for every client
connect to instance A, p2p instance B logs 3 lines (on D_DCO_DEBUG)

Jan  7 18:35:35 ubuntu2004 tun-udp-p2p-tls-sha256[2463894]: dco_do_read
Jan  7 18:35:35 ubuntu2004 tun-udp-p2p-tls-sha256[2463894]: ovpn-dco: ignoring message (type=3) for foreign ifindex 34074
Jan  7 18:35:35 ubuntu2004 tun-udp-p2p-tls-sha256[2463894]: process_incoming_dco: received message of type 0 - ignoring

.. this is coming from forward.c::process_incoming_dco(), which I assume
is only called in the p2p case, and the first message is coming from
ovpn_handle_msg() (which is not using the __func__ paradigm... why?) - so
if we can assert that "there is no message, there is nothing to see
(and nothing to log!)" in the multi_process_incoming_dco() case - maybe
we can apply this (unwritten) function contract here as well...


Stare-at-code also agrees that if the function contract says
"if (peer_id < 0) there is no valid packet, ever", early exit is a
good way out - see my note about un-initializing the dco-> fields at 
the *end* of the function for 1/3, though - in this case, no un-init...
and also Arne's comment about "is this documented anywhere?")


Your patch has been applied to the master and release/2.6 branch.

commit 388e032019ec3674b8294c856039b96fe35e5f32 (master)
commit b0dee39c353ae9479fd19e66ae07cb336d57eef8 (release/2.6)
Author: Antonio Quartulli
Date:   Tue Jan 3 21:23:29 2023 +0100

     dco: bail out when no peer-specific message is delivered

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20230103202330.1835-2-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25882.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


