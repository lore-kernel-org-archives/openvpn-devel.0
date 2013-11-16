Message-ID: <52875C1E.5030202@...1847...>
Date: Sat, 16 Nov 2013 12:50:54 +0100
From: Andre Valentin <avalentin@...1847...>
MIME-Version: 1.0
References: <1383163946-24298-1-git-send-email-avalentin@...1847...>
	<CAHqXQkOePgrgcmdJkknRNhCgQxECibRbCSUWUbhrYTf77TQNBw@...278...>
In-Reply-To: <CAHqXQkOePgrgcmdJkknRNhCgQxECibRbCSUWUbhrYTf77TQNBw@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Floating: Add support for floating in
 TLS mode (upd.)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Hi!

On 15.11.2013 16:49, Heikki Hannikainen wrote:
> Nov 15 15:18:01 gw ovpn-udp[9964]: hessu/85.188.36.24.36:58640 MULTI:
> Floated with HMAC authentication to a new client address:
> [AF_INET]85.188.36.24.36:58640
>
> In this case the client's source port changed, because the client is
> behind a NAT device, and the client didn't have traffic within 60
> seconds (the NAT device's UDP session timeout). Without this patch
> --float does not have any effect on the multi-client tls-server setup,
> and after a 60-second break in traffic the session is dead (until
> keepalive ping timeout and reconnection). I'd like to use a large
> keepalive timer, since on mobile devices a 29-second keepalive tends
> to drain the battery.

That's why I'm using 60s ping from device, and 30s from gateway. This
seems to work with most gateways. But I have a big ping-restart to
prevent openvpn to go into expensive "reconnect mode".
>
> I think, however, there might be a problem with the patch: When a
> packet is received from a srcip-srcport which does not belong to any
> current client, it goes and scans through the whole client list,
> calculating a HMAC for the packet contents using the HMAC key of each
> and every client, effectively looking for a match in HMAC keys. An
> attacker could transmit large packets with random source IP addresses
> to a server which has a large number of clients (think 2000 or
> something? how large client loads are people having, anyway?), and
> cause extra CPU load, maybe enough to DOS the server with a smallish
> packet rate.

In April/May another developer also created a patch and made some
performance tests. He got about 700k packets/sec. This seems fast
good and would make an attack quite expensive.

>
> On the other hand, it is commonly quite easy to DOS servers by sheer
> packet/data volume... but we shouldn't make it any easier with new
> developments.

If a normal connection would be pretended by a DOS attack, this is going
to be more a problem because it eats more CPU, I think. [DH i.e.]
>
> The more elegant way would be to have a session ID in each data
> packet, which would used to look up the client, and then a single HMAC
> calculation would tell if the packet is from that client. No need for
> scanning. That session ID could be used even for every packet instead
> of looking at the client IP address+port at all initially (well, for
> sending any following packets you'd use the peer's latest source
> address).
>
> Putting a session ID in the data packet would require changing the
> on-the-wire data packet format, and make the packets a bit larger. The
> ID doesn't have to be very large, though, since it's not secret or
> used for keying, just an integer large enough to index the maximum
> number of VPN clients on a single server. This would require a new
> protocol version, backward compatibility and all that work.

I also thought about this. But if it is not backwards compatible, it
won't be used. Perhaps as a second, more secure implementation would
be a good idea when openvpn is multithreaded and can handle thousands
of connections.

BTW, the patch is not final. I'm just testing a enhanced version. It
seems in this version is a seg fault problem.

Andr=C3=A9

