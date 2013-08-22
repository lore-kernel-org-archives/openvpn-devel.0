MIME-Version: 1.0
In-Reply-To: <kv65m0$qbs$1@...1062...>
References: <CANfRfr0zuKi5mf0vAFXPvnRtrsyyFx3EtpGpbzNJsCLBnqZxLA@...278...>
	<kv65m0$qbs$1@...1062...>
Date: Thu, 22 Aug 2013 19:49:42 -0400
Message-ID: <CANfRfr02EyQbPJ52pq4-B02hrKdAShn_cbWOE1NYKbosYrd7Qw@...278...>
From: Jesse Glick <jglick@...1836...>
Subject: Re: [Openvpn-devel] [PATCH 2/2] When using UDP over SOCKS5,
 send the actual remote hostname (FQDN) to the proxy server in the
 first packet.
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

On Thu, Aug 22, 2013 at 7:08 PM, Josh Cepek <josh.cepek@...1085...> wrote:
>> akin to how HTTP reverse proxies commonly delegate to a physical server
>> according to the HTTP 1.1 Host header=E2=80=94so that many hostnames can=
 map
>> to the same IP of the reverse proxy.
>
> There was some issue figuring out what this all means. Do you have an
> example use-case where this is helpful?

To expand on my explanation as quoted above:

For HTTP protocol, if you want to provide a single server with a fixed
IP address which services multiple sites=E2=80=94either directly, or by act=
ing
as a reverse proxy to other servers with variable IPs and ports=E2=80=94it =
is
easy: you just have your server inspect the =E2=80=98Host=E2=80=99 header w=
hich
represents what DNS name the client intended to connect to. HTTP/1.1
clients are obliged to send this, so you can safely have them contact
http://joe.accounts.yourcorp.com/ (where the DNS entry for
*.accounts.yourcorp.com is that of proxy.yourcorp.com) and when you
see =E2=80=98Host: joe.accounts.yourcorp.com=E2=80=99 you know where to for=
ward the
request.

Now what if you want to do the same for a different procotol, such as
OpenVPN? I.e. run hundreds of OpenVPN servers but give clients a
single public contact point? This protocol does not send the original
host name that I know of, and to make a reverse proxy directly working
with the OpenVPN protocol (e.g. inspecting the CN on a client
certificate) you would have to copy a bunch of OpenVPN C code and then
start forwarding a half-completed handshake=E2=80=94a daunting task.

My idea was to take advantage of the fact that OpenVPN has built-in
SOCKS5 support, and use a SOCKS5 =E2=80=9Cproxy=E2=80=9D as a reverse proxy=
. So the
client connects to joe.vpns.yourcorp.com:1194 (UDP), but with a SOCKS5
proxy of vpns.yourcorp.com. Now you just need to write a SOCKS5
server, which is a much easier task since its protocol is very simple
(especially when no authentication is sent, as here). For each
connection made, the server sets up a UDP relay server and blindly
copies all the packets on to the real OpenVPN server, which might have
a floating IP address or even be on a private network.

All that is needed for this to work is for the SOCKS5 server to
receive information about the original hostname
(joe.vpns.yourcorp.com) rather than the singleton IP address it
resolved to, i.e. the equivalent of the Host header. But alas, OpenVPN
today does not send it: it resolves the host locally, then sends only
an IP address to SOCKS5 when creating packets for the UDP relay. My
patch merely tells the client to follow the option in the SOCKS5
protocol to send the hostname rather than IP.

(Beware that I have not yet tried to write such a SOCKS5 UDP reverse
proxy. It is conceivable there would be some subtle problem that
cannot be worked around even if the original hostname is available. I
have only confirmed so far that with the current OpenVPN client it is
*not* possible to write such a proxy, and believe with my patch it
*should* be possible.)

> what's the advantage of doing the DNS lookup remotely?

There is no DNS lookup remotely. The =E2=80=98joe.vpns.yourcorp.com=E2=80=
=99 is merely
a hint to forward packets to a particular delegate (that associated
with Joe=E2=80=99s account).

Again this is analogous to, say, Apache working as an HTTP reverse
proxy. If it gets =E2=80=98Host: joe.accounts.yourcorp.com=E2=80=99, it doe=
s not try
to resolve that hostname, since the result is known in advance. It
just uses this information to match against a rule in its
configuration that tells it how to process that virtual site.

> Since >=3D2.3.0 officially supports IPv6, new features should probably do=
 so as well.

Makes sense, though I doubt I am set up to test IPv6 operation.

