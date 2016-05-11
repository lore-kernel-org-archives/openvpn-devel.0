MIME-Version: 1.0
In-Reply-To: <CAAM7bARYZSecZZb2aU7dTaRc1a6rP8dz4hsHR=tDUbTmSTpgFg@...278...>
References: <CAAM7bARYZSecZZb2aU7dTaRc1a6rP8dz4hsHR=tDUbTmSTpgFg@...278...>
Date: Thu, 12 May 2016 00:35:38 +0500
Message-ID: <CAFHpkQH--CiX4XguNMsoCNSKJ3GEFShPpae+=AVon-h6bT4c5Q@...278...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Content-Type: multipart/alternative; boundary=001a114e35b079954a0532962582
Subject: Re: [Openvpn-devel] Need help for adding feature: Selecting remote
 servers by best latency
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Paul Garnier <paul.garnier3@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--001a114e35b079954a0532962582
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

how are you going to resolve

a) host.example.com resolves in multiple "A" records
b) host.example.com resolves in both "AAAA" and "A" records

?

2016-05-11 20:41 GMT+05:00 Paul Garnier <paul.garnier3@...277...>:

> Hello,
>
>
> I=E2=80=99m actually trying to add an option in openvpn which will allow =
the
> client to connect to the server with the lowest latency in his remote lis=
t.
> For now there are only two options to choose between servers : =E2=80=9C
> *--remote-random*=E2=80=9D  which randomize the order of the address list=
, the
> default one which will try the hosts in the order of the config file, and=
 I
> want to add  a 3rd one. To start I want to do it for udp and unix servers
> and clients.
>
>
> I=E2=80=99m a beginner in things like this so I started  very simply : I =
wrote a
> little program in C to ping a host:port using udp but I can=E2=80=99t get=
 an answer
> from an openvpn server. The only way I found to get an answer was to make
> the packet I send look like the start of a TLS transaction, but because of
> the TLS processing I can only get the first ping right, after it takes way
> too long to come back to be accurate.
>
>
> So I started digging  in the source code to find where my packet is
> thrown away and why I don=E2=80=99t get any answer (even an error message=
 would be
> enough). I=E2=80=99ve found how a =E2=80=9Cnormal=E2=80=9D packet is sent=
 but what I want is the
> latency with the server, not in the tunnel.  I don=E2=80=99t want to esta=
blish a
> connection to test my link with each server and, how I understand it, if I
> want use function like *encrypt_sign*() so my packet is recognized I need
> to have a tunnel set. I can=E2=80=99t replicate how the existing *ping *a=
nd *occ *packets
> are sent.
>
>
> What I would like to know is :
>
>
> - where my packet is processed and rejected ?
>
> - why I don't get any answer at all nor an error message on my server ?
>
> - is there a major issue making what I want to do impossible ?
>
> Kind regards,
>
>
> Paul Garnier
>
>
> -------------------------------------------------------------------------=
-----
> Mobile security can be enabling, not merely restricting. Employees who
> bring their own devices (BYOD) to work are irked by the imposition of MDM
> restrictions. Mobile Device Manager Plus allows you to control only the
> apps on BYO-devices by containerizing them, leaving personal data
> untouched!
> https://ad.doubleclick.net/ddm/clk/304595813;131938128;j
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>
>

--001a114e35b079954a0532962582
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>how are you going to resolve<br><br></div>a) <a =
href=3D"http://host.example.com">host.example.com</a> resolves in multiple =
&quot;A&quot; records<br></div>b) <a href=3D"http://host.example.com">host.=
example.com</a> resolves in both &quot;AAAA&quot; and &quot;A&quot; records=
<br><br>?<br></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote=
">2016-05-11 20:41 GMT+05:00 Paul Garnier <span dir=3D"ltr">&lt;<a href=3D"=
mailto:paul.garnier3@...277..." target=3D"_blank">paul.garnier3@...277...</=
a>&gt;</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr">

<p class=3D"MsoNormal">Hello,</p><p class=3D"MsoNormal"><br></p>

<p class=3D"MsoNormal">I=E2=80=99m actually trying to add an option in open=
vpn which will
allow the client to connect to the server with the lowest latency in his re=
mote
list. For now there are only two options to choose between servers : =E2=80=
=9C<b>--remote-random</b><span>=E2=80=9D<span>=C2=A0
</span>which randomize the order of the address list, the default one which
will try the hosts in the order of the config file, and I want to add<span>=
=C2=A0 </span>a 3<sup>rd</sup> one. To start I want to do
it for udp and unix servers and clients.</span></p><p class=3D"MsoNormal"><=
span><br></span></p>

<p class=3D"MsoNormal"><span>I=E2=80=99m a beginner in things
like this so I started<span>=C2=A0 </span>very simply : I
wrote a little program in C to ping a host:port using udp but I can=E2=80=
=99t get an
answer from an openvpn server. The only way I found to get an answer was to
make the packet I send look like the start of a TLS transaction, but becaus=
e of
the TLS processing I can only get the first ping right, after it takes way =
too
long to come back to be accurate. <br></span></p><p class=3D"MsoNormal"><sp=
an><br></span></p>

<p class=3D"MsoNormal"><span>So I started
digging<span>=C2=A0 </span>in the source code to find where
my packet is thrown away and why I don=E2=80=99t get any answer (even an er=
ror message
would be enough). I=E2=80=99ve found how a =E2=80=9Cnormal=E2=80=9D packet =
is sent but what I want is
the latency with the server, not in the tunnel. <span>=C2=A0</span>I don=E2=
=80=99t want to establish a connection to test
my link with each server and, how I understand it, if I want use function l=
ike <b>encrypt_sign</b>()
so my packet is recognized<b> </b>I need to have a tunnel <span></span>set.=
 I can=E2=80=99t replicate how the existing <b>ping
</b>and <b>occ </b>packets are sent.</span></p><p class=3D"MsoNormal"><span=
><br></span></p>

<p class=3D"MsoNormal"><span>What I would like to
know is :<span>=C2=A0 <br></span></span></p><p class=3D"MsoNormal"><br><spa=
n><span></span></span></p><p class=3D"MsoNormal"><span><span>- where my pac=
ket is processed and rejected ?</span></span></p><p class=3D"MsoNormal"><sp=
an><span>- why I don&#39;t get any answer at all nor an error message on my=
 server ?</span></span></p><p class=3D"MsoNormal"><span><span>- is there a =
major issue making what I want to do impossible ?</span></span><span style=
=3D"font-size:11pt;line-height:115%;font-family:&quot;Calibri&quot;,&quot;s=
ans-serif&quot;"><br></span></p><br><p class=3D"MsoNormal"><span style=3D"f=
ont-family:Symbol"><span><span style=3D"font:7pt &quot;Times New Roman&quot=
;"></span></span></span><span></span>Kind regards,</p><span></span><p class=
=3D"MsoNormal"><span><br></span></p>

<p class=3D"MsoNormal"><span>Paul Garnier</span></p>

</div>
<br>-----------------------------------------------------------------------=
-------<br>
Mobile security can be enabling, not merely restricting. Employees who<br>
bring their own devices (BYOD) to work are irked by the imposition of MDM<b=
r>
restrictions. Mobile Device Manager Plus allows you to control only the<br>
apps on BYO-devices by containerizing them, leaving personal data untouched=
!<br>
<a href=3D"https://ad.doubleclick.net/ddm/clk/304595813;131938128;j" rel=3D=
"noreferrer" target=3D"_blank">https://ad.doubleclick.net/ddm/clk/304595813=
;131938128;j</a><br>_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...1199...=
sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/lists/listi=
nfo/openvpn-devel</a><br>
<br></blockquote></div><br></div>

--001a114e35b079954a0532962582--

