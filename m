MIME-Version: 1.0
From: Jon Chiappetta <root@...2904...>
Date: Sun, 19 Oct 2025 18:16:47 -0400
Message-ID: <CAOh3LPPaxH96ROVS6ktiz+Zv9=Xn5g8CT2CCu-wivM5MpTirSQ@...278...>
Content-Type: multipart/alternative; boundary="00000000000039d25406418a5385"
References: <CAOh3LPPaxH96ROVS6ktiz+Zv9=Xn5g8CT2CCu-wivM5MpTirSQ.ref@...278...>
Subject: [Openvpn-devel] A small downside observation noticed in performing
 mass bulk parallel data transfers
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--00000000000039d25406418a5385
Content-Type: text/plain; charset="UTF-8"

Thanks all for the updates on this project work, I've been fine tuning and
rebasing my proof-of-concept branches on top of the main source code
without too many code conflicts. I've been trying to tune up and work
through the little knots in my home network to maximize performance of this
network-wide, standard-sized MTU, bulk-reading, multi-threaded,
TCP-protocol VPN solution. I think I found an interesting (negative)
observation along the way with using this thing.

It turns out that doing massive bulk reads and parallel data transfers can
impact the performance of poorly written applications (for example, the
Ring app in live view mode). For smarter protocols such as TCP and even
QUIC UDP, they can handle mass reordering of packets as I did not
incorporate any kind of reordering logic on the client/server sides, I was
trying to keep the original code as simple as I could at the time. I found
that the Ring app seems to use some (likely) custom-written, non-standard
UDP API for live video streams and the bulk parallel data transfers were
impacting the quality and performance of the feed view as no packet order
is being guaranteed by this specific set of OpenVPN mode of operations. I'm
guessing that some custom UDP written apps may assume that they will
receive their data packets in the order that their server sends them but
with my implementations, it will likely break that assumption based on
parallel processing speeds.

Instead of trying to put in some sort of packet tracking and ordering into
the code, I decided to use iptables + ip rules/routes to mark a subset of
UDP packets and send them through a separate OVPN instance (bulk mode only,
no multi threaded mode) - the rest of the smarter protocols can still be
sent through the main tunnel (bulk mode + mtio mode). It seems to be
working better now compatibility wise as the network clients are simply on
my WiFi network and they are not individually connected or aware of the VPN
itself (zero config automatic environment).

Anyway, I just wanted to share this observation as I found it interesting
in nature as a potential downside of doing this without more complex logic
placed into the code base itself!

https://fossjon.com/2025/10/19/split-vpn-tunnelling-and-routing-based-on-packet-protocol-and-port-for-improved-network-performance-and-app-compatibility/

Thanks again!
Jon C

--00000000000039d25406418a5385
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks all for the updates on this project work, I&#39;ve =
been fine tuning and rebasing my proof-of-concept branches on top of the ma=
in source code without too many code conflicts. I&#39;ve been trying to tun=
e up and work through the little knots in my home network to maximize perfo=
rmance of this network-wide, standard-sized MTU, bulk-reading, multi-thread=
ed, TCP-protocol VPN solution. I think I found an interesting (negative) ob=
servation along the way with using this thing.=C2=A0<div><br></div><div>It =
turns out that doing massive bulk reads and parallel data transfers can imp=
act the performance of poorly written applications (for example, the Ring a=
pp in live view mode). For smarter protocols such as TCP and even QUIC UDP,=
 they can handle mass reordering of packets as I did not incorporate any ki=
nd of reordering logic on the client/server sides,=C2=A0I was trying to kee=
p the original code as simple as I could at the time. I found that the Ring=
 app seems to use some (likely) custom-written, non-standard UDP API for li=
ve video streams and the bulk parallel data transfers were impacting the qu=
ality and performance of the feed view as no packet order is being=C2=A0gua=
ranteed=C2=A0by this specific set of OpenVPN mode of operations. I&#39;m gu=
essing that some custom UDP written apps may assume that they will receive =
their data packets in the order that their server sends them but with my im=
plementations, it will likely break that assumption based on parallel proce=
ssing speeds.=C2=A0</div><div><br></div><div>Instead of trying to put in so=
me sort of packet tracking and ordering into the code, I decided to use ipt=
ables=C2=A0+ ip rules/routes to mark a subset of UDP packets and send them =
through a separate OVPN instance (bulk mode only, no multi threaded mode) -=
 the rest of the smarter protocols can still be sent through the main tunne=
l (bulk mode + mtio mode). It seems to be working better now compatibility =
wise as the network clients are simply on my WiFi network and they are not =
individually connected or aware of the VPN itself (zero config automatic en=
vironment).=C2=A0</div><div><br></div><div>Anyway, I just wanted to share t=
his observation as I found it interesting in nature as a potential downside=
 of doing this without more complex logic placed into the code base itself!=
</div><div><br></div><div><a href=3D"https://fossjon.com/2025/10/19/split-v=
pn-tunnelling-and-routing-based-on-packet-protocol-and-port-for-improved-ne=
twork-performance-and-app-compatibility/">https://fossjon.com/2025/10/19/sp=
lit-vpn-tunnelling-and-routing-based-on-packet-protocol-and-port-for-improv=
ed-network-performance-and-app-compatibility/</a><br></div><div><br></div><=
div>Thanks again!</div><div>Jon C</div><div><br></div></div>

--00000000000039d25406418a5385--

