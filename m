MIME-Version: 1.0
Sender: heikki.hannikainen@...277...
In-Reply-To: <1383163946-24298-1-git-send-email-avalentin@...1847...>
References: <1383163946-24298-1-git-send-email-avalentin@...1847...>
Date: Fri, 15 Nov 2013 17:49:05 +0200
Message-ID: <CAHqXQkOePgrgcmdJkknRNhCgQxECibRbCSUWUbhrYTf77TQNBw@...278...>
From: Heikki Hannikainen <hessu@...1822...>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

On Wed, Oct 30, 2013 at 10:12 PM, Andr=C3=A9 Valentin <avalentin@...1847...=
> wrote:
> Add support for floating in tls mode using the HMAC of a packet. It costs
> a roundtrip through the clients. Its security comes from a secret key, bo=
th
> peers have. This key and the data form the signature used, which is then
> checked againts existing peer connections. Therefore a good auth algo is
> recommended.
>
> URL: https://community.openvpn.net/openvpn/ticket/49

I took a look at this patch, since I am frustrated by the same
problem, so +1 for the conceptual issue. It seems to work:

Nov 15 15:18:01 gw ovpn-udp[9964]: hessu/85.188.36.24.36:58639 MULTI:
Detected floating by hmac test, new client address:
[AF_INET]85.188.36.24.36:58640
Nov 15 15:18:01 gw ovpn-udp[9964]: hessu/85.188.36.24.36:58640 MULTI:
Floated with HMAC authentication to a new client address:
[AF_INET]85.188.36.24.36:58640

In this case the client's source port changed, because the client is
behind a NAT device, and the client didn't have traffic within 60
seconds (the NAT device's UDP session timeout). Without this patch
--float does not have any effect on the multi-client tls-server setup,
and after a 60-second break in traffic the session is dead (until
keepalive ping timeout and reconnection). I'd like to use a large
keepalive timer, since on mobile devices a 29-second keepalive tends
to drain the battery.

I think, however, there might be a problem with the patch: When a
packet is received from a srcip-srcport which does not belong to any
current client, it goes and scans through the whole client list,
calculating a HMAC for the packet contents using the HMAC key of each
and every client, effectively looking for a match in HMAC keys. An
attacker could transmit large packets with random source IP addresses
to a server which has a large number of clients (think 2000 or
something? how large client loads are people having, anyway?), and
cause extra CPU load, maybe enough to DOS the server with a smallish
packet rate.

On the other hand, it is commonly quite easy to DOS servers by sheer
packet/data volume... but we shouldn't make it any easier with new
developments.

The more elegant way would be to have a session ID in each data
packet, which would used to look up the client, and then a single HMAC
calculation would tell if the packet is from that client. No need for
scanning. That session ID could be used even for every packet instead
of looking at the client IP address+port at all initially (well, for
sending any following packets you'd use the peer's latest source
address).

Putting a session ID in the data packet would require changing the
on-the-wire data packet format, and make the packets a bit larger. The
ID doesn't have to be very large, though, since it's not secret or
used for keying, just an integer large enough to index the maximum
number of VPN clients on a single server. This would require a new
protocol version, backward compatibility and all that work.

- Hessu

