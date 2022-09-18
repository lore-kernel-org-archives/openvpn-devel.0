Message-ID: <61a61f4a-a7e7-ad3b-a029-ce351c310a4a@...1227...>
Date: Mon, 19 Sep 2022 01:17:32 +0200
MIME-Version: 1.0
References: <YydCIP5l0WwH5OX+@greenie.muc.de>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <YydCIP5l0WwH5OX+@greenie.muc.de>
Subject: Re: [Openvpn-devel] --explicit-exit-notify and P2P mode (trac #1337)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net


Am 18.09.2022 um 18:06 schrieb Gert Doering:
> Hi,
>
> we have a long standing open ticket, #1337, about --explicit-exit-notify
> together with peer-to-peer mode.
>
> My understanding of --explicit-exit-notify comes from p2mp mode, where
> it notifies the other end "I have been SIGINTR'ed, and will go away now",
> so the other end can stop sending packets (multi-instance is killed on
> the server, and client reconnects / goes to next server).
>
> I have learned much later that --explicit-exit-notify in p2p mode does
> something else - it kills the peer.  So you press ctrl-c on one end
> of the OpenVPN connection, and *both* sides exit.
>
> David tells me "it has always been that way", but I wonder if we should
> keep it (= close #1337, do not change anything), or do something else,
> like "ignore incoming EEN (control-channel EXIT or OCC_EXIT) if not
> in server mode" (*)

 From the implement and the fact that it is a an OCC message (basically 
the rudimentary predecessor to control channel), I think it is older. I 
think this feature fits nicely to the weird inetd + openvpn mode that 
seems to have far to many hacks still left in our code. With inetd, it 
makes sense that the server instance quits if you press C-c on the client.

In our current state where inetd is no longer supported, this behaviour 
to exit makes little sense and we should probably change the behaviour 
to SIGUSR1.

Arne




