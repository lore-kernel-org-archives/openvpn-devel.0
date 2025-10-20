MIME-Version: 1.0
From: Jon Chiappetta <root@...2904...>
Date: Mon, 20 Oct 2025 16:15:22 -0400
Message-ID: <CAOh3LPOK2-L8VCS5VcvpDvDyGQp9o00y9v069OChyK9o9-884Q@...278...>
Content-Type: multipart/alternative; boundary="000000000000dd44bf06419cbe89"
References: <CAOh3LPOK2-L8VCS5VcvpDvDyGQp9o00y9v069OChyK9o9-884Q.ref@...278...>
Subject: [Openvpn-devel] Quick question for the OpenVPN developers on the
 source code functionality [problem solving]
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--000000000000dd44bf06419cbe89
Content-Type: text/plain; charset="UTF-8"

Hi all,

I was wondering if any part of the OpenVPN source code parses the IPv4
packet header for source/destination address already in place? I was
thinking that I could possibly solve my multi-threaded packet-reordering
problem instead by associating a udp/tcp connection "stream" with a given
thread in a connection state table for a certain amount of time (similar to
how conntrack works for iptables). Once I redirected UDP port 443 to my
bulk-mode OpenVPN instances it worked much faster compared to my
multi-threaded mode OVPN instances so if I could do that same kind of
static routing based on something unique for the clients connection that
would be kinda cool and I think it would be much easier than implementing
true strict packet ordering on both the client and server threads...

Thanks again for your work and time all,
Jon C

--000000000000dd44bf06419cbe89
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi all,<div><br></div><div>I was wondering if any part of =
the OpenVPN source code parses the IPv4 packet header for source/destinatio=
n=C2=A0address already in place? I was thinking that I could possibly solve=
 my multi-threaded packet-reordering problem instead by associating a udp/t=
cp connection &quot;stream&quot; with a given thread in a connection state =
table for a certain amount of time (similar to how conntrack works for ipta=
bles). Once I redirected UDP port 443 to my bulk-mode OpenVPN instances it =
worked much faster compared to my multi-threaded mode OVPN instances so if =
I could do that same kind of static routing based on something unique for t=
he clients connection that would be kinda cool and I think it would be much=
 easier than implementing true strict packet ordering on both the client an=
d server threads...</div><div><br></div><div>Thanks again for your work and=
 time all,</div><div>Jon C</div><div><br></div></div>

--000000000000dd44bf06419cbe89--

