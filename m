MIME-Version: 1.0
Date: Wed, 11 May 2016 17:41:19 +0200
Message-ID: <CAAM7bARYZSecZZb2aU7dTaRc1a6rP8dz4hsHR=tDUbTmSTpgFg@...278...>
From: Paul Garnier <paul.garnier3@...277...>
Content-Type: multipart/alternative; boundary=001a11393e907dde95053292dff5
Subject: [Openvpn-devel] Need help for adding feature: Selecting remote
	servers by best latency
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--001a11393e907dde95053292dff5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,


I=E2=80=99m actually trying to add an option in openvpn which will allow th=
e client
to connect to the server with the lowest latency in his remote list. For
now there are only two options to choose between servers : =E2=80=9C
*--remote-random*=E2=80=9D  which randomize the order of the address list, =
the
default one which will try the hosts in the order of the config file, and I
want to add  a 3rd one. To start I want to do it for udp and unix servers
and clients.


I=E2=80=99m a beginner in things like this so I started  very simply : I wr=
ote a
little program in C to ping a host:port using udp but I can=E2=80=99t get a=
n answer
from an openvpn server. The only way I found to get an answer was to make
the packet I send look like the start of a TLS transaction, but because of
the TLS processing I can only get the first ping right, after it takes way
too long to come back to be accurate.


So I started digging  in the source code to find where my packet is thrown
away and why I don=E2=80=99t get any answer (even an error message would be
enough). I=E2=80=99ve found how a =E2=80=9Cnormal=E2=80=9D packet is sent b=
ut what I want is the
latency with the server, not in the tunnel.  I don=E2=80=99t want to establ=
ish a
connection to test my link with each server and, how I understand it, if I
want use function like *encrypt_sign*() so my packet is recognized I need
to have a tunnel set. I can=E2=80=99t replicate how the existing *ping *and
*occ *packets
are sent.


What I would like to know is :


- where my packet is processed and rejected ?

- why I don't get any answer at all nor an error message on my server ?

- is there a major issue making what I want to do impossible ?

Kind regards,


Paul Garnier

--001a11393e907dde95053292dff5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">

<p class=3D"MsoNormal">Hello,</p><p class=3D"MsoNormal"><br></p>

<p class=3D"MsoNormal">I=E2=80=99m actually trying to add an option in open=
vpn which will
allow the client to connect to the server with the lowest latency in his re=
mote
list. For now there are only two options to choose between servers : =E2=80=
=9C<b>--remote-random</b><span style=3D"mso-bidi-font-weight:bold">=E2=80=
=9D<span style=3D"mso-spacerun:yes">=C2=A0
</span>which randomize the order of the address list, the default one which
will try the hosts in the order of the config file, and I want to add<span =
style=3D"mso-spacerun:yes">=C2=A0 </span>a 3<sup>rd</sup> one. To start I w=
ant to do
it for udp and unix servers and clients.</span></p><p class=3D"MsoNormal"><=
span style=3D"mso-bidi-font-weight:bold"><br></span></p>

<p class=3D"MsoNormal"><span style=3D"mso-bidi-font-weight:bold">I=E2=80=99=
m a beginner in things
like this so I started<span style=3D"mso-spacerun:yes">=C2=A0 </span>very s=
imply : I
wrote a little program in C to ping a host:port using udp but I can=E2=80=
=99t get an
answer from an openvpn server. The only way I found to get an answer was to
make the packet I send look like the start of a TLS transaction, but becaus=
e of
the TLS processing I can only get the first ping right, after it takes way =
too
long to come back to be accurate. <br></span></p><p class=3D"MsoNormal"><sp=
an style=3D"mso-bidi-font-weight:bold"><br></span></p>

<p class=3D"MsoNormal"><span style=3D"mso-bidi-font-weight:bold">So I start=
ed
digging<span style=3D"mso-spacerun:yes">=C2=A0 </span>in the source code to=
 find where
my packet is thrown away and why I don=E2=80=99t get any answer (even an er=
ror message
would be enough). I=E2=80=99ve found how a =E2=80=9Cnormal=E2=80=9D packet =
is sent but what I want is
the latency with the server, not in the tunnel. <span style=3D"mso-spacerun=
:yes">=C2=A0</span>I don=E2=80=99t want to establish a connection to test
my link with each server and, how I understand it, if I want use function l=
ike <b>encrypt_sign</b>()
so my packet is recognized<b> </b>I need to have a tunnel <span style=3D"ms=
o-spacerun:yes"></span>set. I can=E2=80=99t replicate how the existing <b>p=
ing
</b>and <b>occ </b>packets are sent.</span></p><p class=3D"MsoNormal"><span=
 style=3D"mso-bidi-font-weight:bold"><br></span></p>

<p class=3D"MsoNormal"><span style=3D"mso-bidi-font-weight:bold">What I wou=
ld like to
know is :<span style=3D"mso-spacerun:yes">=C2=A0 <br></span></span></p><p c=
lass=3D"MsoNormal"><br><span style=3D"mso-bidi-font-weight:bold"><span styl=
e=3D"mso-spacerun:yes"></span></span></p><p class=3D"MsoNormal"><span style=
=3D"mso-bidi-font-weight:bold"><span style=3D"mso-spacerun:yes">- where my =
packet is processed and rejected ?</span></span></p><p class=3D"MsoNormal">=
<span style=3D"mso-bidi-font-weight:bold"><span style=3D"mso-spacerun:yes">=
- why I don&#39;t get any answer at all nor an error message on my server ?=
</span></span></p><p class=3D"MsoNormal"><span style=3D"mso-bidi-font-weigh=
t:bold"><span style=3D"mso-spacerun:yes">- is there a major issue making wh=
at I want to do impossible ?</span></span><span style=3D"font-size:11pt;lin=
e-height:115%;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;"><br><=
/span></p><br><p class=3D"MsoNormal"><span style=3D"font-family:Symbol"><sp=
an style=3D"mso-list:Ignore"><span style=3D"font:7pt &quot;Times New Roman&=
quot;"></span></span></span><span style=3D"mso-bidi-font-weight:bold"></spa=
n>Kind regards,</p><span style=3D"mso-bidi-font-weight:bold"></span><p clas=
s=3D"MsoNormal"><span style=3D"mso-bidi-font-weight:bold"><br></span></p>

<p class=3D"MsoNormal"><span style=3D"mso-bidi-font-weight:bold">Paul Garni=
er</span></p>

</div>

--001a11393e907dde95053292dff5--

