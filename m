Date: Sun, 6 Dec 2020 14:51:24 +0100
From: Michael Kress <lists@...1660...>
Message-ID: <20201206145124.77fc2db6@...1661...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Update client config over control channel
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi list,

Problem: OpenVPN Clients have to be reconfigured from time to
time because e.g.
- CA certificate changed
- client certificates/keys should get updated
- client destination address to server should be changed

For these and others eighter
a) a human must take action and execute commands, store files etc. 
b) some external mechanism uses the existing data channel and triggers
    services outside of OpenVPN. This means, that on client side
    another process has to be started, which comes with complications
    like addressing, privileges and so on.

Could you imagine a mechanism in OpenVPN, where the control channel
could be used for generic messages between server and client? This
control channel would acts like a websocket, is encrypted and secure.

A huge advantage to b) would be, that no external service has to exist
on the client side and the addressing works via common name.

Looking at check_incoming_control_channel_dowork() makes me think, if
there could exist another PUSH_command that could be very generic and
address code in a loaded plugin? Such a plugin could rewrite the local
configuration file of the client.

On server side one could fire up the management interface and initiate
this PUSH command - similar to "kill cn", that causes the server to
tell the client that it should disconnect.

There is an architectural implication though: Secrets (like
certificates) are transfered over the same transportation channel. Is
this a huge DON'T in the art of crypto?

This won't be a 100% solution for everybody, e.g.
- there is no config file, OpenVPN gets started via network manager
- write privileges for config or key material is not granted
- plugin is not there because the user installed a standard OpenVPN
  packet

This could help admins, that have to maintain a bigger VPN installation.

What do you think? Is this a completely stupid idea?

-- 
Servus
  Michael

