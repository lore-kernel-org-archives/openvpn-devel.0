MIME-Version: 1.0
From: Derek Zimmer <derek@...2095...>
Date: Fri, 4 May 2018 09:41:56 -0500
Message-ID: <CAJY0qZKNO_aamQfi56BG_XK2vrOCyPAQf-My1N56qqV7TsUG7A@...278...>
Content-Type: multipart/alternative; boundary="0000000000006ae739056b6252b3"
Subject: [Openvpn-devel] Does the OpenVPN protocol itself handle windowing?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--0000000000006ae739056b6252b3
Content-Type: text/plain; charset="UTF-8"

Hello everyone,

Derek from OSTIF here. I've been working with OpenVPN for a few years and
there's a few curious performance anomalies that i've ran into that add up
to a possible performance opportunity. My experience lies closer to
networking protocols and cryptography rather than programming, so i'd need
some help confirming my suspicions to see if this is an opportunity for us.

I've been having some discussions with Mattock related to performance,
specifically the way that OpenVPN performance scales on fast networks.

The interesting symptoms:
-OpenVPN performance appears to decrease linearly with increases in latency.
-OpenVPN performance seems consistent regardless of the OS of the
client/server.
-OpenVPN performance seems to adjust/scale with the speed of the
client/server, but always seems limited to roughly 25% of the line speed of
the fastest device when you scale up to fiber speeds. The interesting part
is that 1Gb servers will top out around 220-275Mbit, and 10Gb servers will
top out around 2.5Gbit.
-OpenVPN performance increases when you manually increase the size of the
packets to oversized (MTU 9000+).
-Performance is similar between TCP/UDP barring confounding issues like
packet loss.

What conclusions can we draw from this?

My network experience points to something going awry with windowing with
TCP, but UDP does not apply any sort of windowing (no ACKs = no windowing)
but the OpenVPN protocol itself does have an ACK system, which suggests
that OpenVPN may apply its own windowing.

From my network brain: These 4 factors all point to the same problem with
regular TCP networks, not enough packets are "allowed" to be in flight by
the protocol. This is why performance scales linearly with
distance/latency. The maximum number of packets in flight gets reached, and
the client/server then waits to send more or throttles back the rate to hit
the target number of packets per second based on the latency (how this is
done depends on how windowing is implemented). This is also why making the
packets larger increases performance. The OpenVPN protocol allows more
packets to be in flight indirectly, because a 9000 bit packet is broken
down into 1500 bit packets by the network protocol outside of OpenVPN, so
it sees fewer "packets in flight" at the OpenVPN level.

I'm also hesitant to blame issues like task-switching as the primary cause
of the issue because of the behavior being OS agnostic, and 10Gb
connections being able to move 2.5Gbit/sec.

This problem only seems to surface with high latency connections, or
particularly fast networks (over 1Gb),

Let me know if i'm drawing the wrong conclusions from the evidence here. I
think we may have a performance opportunity if we hack away at this issue
and come to a greater understanding of why OpenVPN behaves this way in
these cases. I'm also willing to do some Wireshark work to see how OpenVPN
behaves in these edge cases if we think it would be valuable.

Increasing performance for long-distance VPNs, and being able to
accommodate users in a fiber-to-the-home world would be a huge benefit for
all OpenVPN users.

Thanks for taking the time to read and respond!

Derek Zimmer
Chief Executive Officer
Open Source Technology Improvement Fund

--0000000000006ae739056b6252b3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>Hello everyone,<br><br></div>Derek from OSTIF he=
re. I&#39;ve been working with OpenVPN for a few years and there&#39;s a fe=
w curious performance anomalies that i&#39;ve ran into that add up to a pos=
sible performance opportunity. My experience lies closer to networking prot=
ocols and cryptography rather than programming, so i&#39;d need some help c=
onfirming my suspicions to see if this is an opportunity for us.<br><br></d=
iv>I&#39;ve been having some discussions with Mattock related to performanc=
e, specifically the way that OpenVPN performance scales on fast networks.<b=
r><br><div><div><div>The interesting symptoms:<br></div><div>-OpenVPN perfo=
rmance appears to decrease linearly with increases in latency.<br></div><di=
v>-OpenVPN performance seems consistent regardless of the OS of the client/=
server.<br></div><div>-OpenVPN performance seems to adjust/scale with the s=
peed of the client/server, but always seems limited to roughly 25% of the l=
ine speed of the fastest device when you scale up to fiber speeds. The inte=
resting part is that 1Gb servers will top out around 220-275Mbit, and 10Gb =
servers will top out around 2.5Gbit.<br></div><div>-OpenVPN performance inc=
reases when you manually increase the size of the packets to oversized (MTU=
 9000+).<br></div><div>-Performance is similar between TCP/UDP barring conf=
ounding issues like packet loss.<br></div><div><br></div><div>What conclusi=
ons can we draw from this?<br></div><div><br></div><div>My network experien=
ce points to something going awry with windowing with TCP, but UDP does not=
 apply any sort of windowing (no ACKs =3D no windowing) but the OpenVPN pro=
tocol itself does have an ACK system, which suggests that OpenVPN may apply=
 its own windowing.<br></div><div><br><div>From my network brain: These 4 f=
actors all point to the same problem with=20
regular TCP networks, not enough packets are &quot;allowed&quot; to be in f=
light=20
by the protocol. This is why performance scales linearly with=20
distance/latency. The maximum number of packets in flight gets reached,=20
and the client/server then waits to send more or throttles back the rate
 to hit the target number of packets per second based on the latency (how t=
his is done depends on how windowing is implemented). This is also why maki=
ng the packets larger increases performance. The OpenVPN protocol allows mo=
re packets to be in flight indirectly, because a 9000 bit packet is broken =
down into 1500 bit packets by the network protocol outside of OpenVPN, so i=
t sees fewer &quot;packets in flight&quot; at the OpenVPN level.<br><br></d=
iv><div>I&#39;m also hesitant to blame issues like task-switching as the pr=
imary cause of the issue because of the behavior being OS agnostic, and 10G=
b connections being able to move 2.5Gbit/sec.<br></div><div><br></div><div>=
This problem only seems to surface with high latency connections, or partic=
ularly fast networks (over 1Gb),<br></div><br></div><div>Let me know if i&#=
39;m drawing the wrong conclusions from the evidence here. I think we may h=
ave a performance opportunity if we hack away at this issue and come to a g=
reater understanding of why OpenVPN behaves this way in these cases. I&#39;=
m also willing to do some Wireshark work to see how OpenVPN behaves in thes=
e edge cases if we think it would be valuable.<br><br></div><div>Increasing=
 performance for long-distance VPNs, and being able to accommodate users in=
 a fiber-to-the-home world would be a huge benefit for all OpenVPN users.<b=
r><br></div><div>Thanks for taking the time to read and respond!<br></div><=
div><br clear=3D"all"><div><div class=3D"gmail_signature" data-smartmail=3D=
"gmail_signature">Derek Zimmer<br>Chief Executive Officer<br>Open Source Te=
chnology Improvement Fund</div></div>
</div></div></div></div>

--0000000000006ae739056b6252b3--

