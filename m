MIME-Version: 1.0
References: <CAAUX2SVQRn4zuDC947HE9M38nDNK1oNqyUv0GKeAw2dasHo62Q@...278...>
 <ad7e8624-6f87-2874-9786-d5de521bc6a2@...2181...>
 <f10fc09e-5d7b-c678-02f8-04f80f004b24@...2181...>
 <CAAUX2SU9u8sdsN08ynDTVD15q+qP0yOF-RxMzF5hMRg-pFCWFg@...278...>
 <CAAUX2SXiT1=-5HtKzQRay-R1zreT0_7QpEvjc40H3-0U2nqcAA@...278...>
 <d967fd98-6dd9-fe05-cac8-83fb022e4ea4@...2181...>
 <CAAUX2SVLseVOawC=m-Cs38jEjAtNcHzvHcUeDLpjTK6oYi1nvQ@...278...>
In-Reply-To: <CAAUX2SVLseVOawC=m-Cs38jEjAtNcHzvHcUeDLpjTK6oYi1nvQ@...278...>
From: Tony He <huangya90@...277...>
Date: Thu, 1 Apr 2021 15:03:16 +0800
Message-ID: <CAAUX2SXD_Ffmp7ESyxMF=CUdeWHOjG=1OpR7RcqdGG7LT8KYJg@...278...>
Content-Type: multipart/alternative; boundary="000000000000084bb805bee3d4e8"
Subject: Re: [Openvpn-devel] [ovpn-dco] sudden network disconnection
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, Arne Schwabe <arne@...1227...>

--000000000000084bb805bee3d4e8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

sorry, update transport interface.
 % ifconfig enx00e04c680a44
enx00e04c680a44: flags=3D4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.1.10  netmask 255.255.255.0  broadcast 192.168.1.255
        inet6 fe80::ec9b:2258:82ec:3cdb  prefixlen 64  scopeid 0x20<link>
        ether 00:e0:4c:68:0a:44  txqueuelen 1000  (Ethernet)
        RX packets 10365932  bytes 6963820421 (6.9 GB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 11883693  bytes 11887431595 (11.8 GB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

Tony He <huangya90@...277...> =E4=BA=8E2021=E5=B9=B44=E6=9C=881=E6=97=A5=E5=
=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=883:01=E5=86=99=E9=81=93=EF=BC=9A

>
>
> Antonio Quartulli <a@...2181...> =E4=BA=8E2021=E5=B9=B44=E6=9C=881=E6=97=
=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=882:35=E5=86=99=E9=81=93=EF=BC=9A
>
>> Hi Tony,
>>
>> On 01/04/2021 04:38, Tony He wrote:
>> > Hi Antonio, Arne,
>> >
>> > According to the dump, this issue is caused by fragment. If I set
>> > link-mtu to 1472 in the condition of encryption "none", it's gone.
>> > I also can reproduce the fragment in my Linux x86-64 PC and Linux VM .
>> > They use kernel 5.4. Fragment affects the performance
>> > in the low-end devices. It also consumes more CPU resource in low-end
>> > and high-end devices.  If I'm not mistaken, we don't need
>> > to set link-mtu without dco. Is this a bug? Can you reproduce? Do I
>> > still need to upload my dump? If so, maybe I need to provide a link.
>>
>> You told us what you did to fix, but you haven't fully explained what
>> the "broken setup" is. We don't have your configs, so we can't say what
>> is creating the issue in your scenario.
>>
> server config:
> root@...2607...:/tmp# cat openvpn-sample_server-fragment.conf
> data-ciphers none
> auth none
> topology subnet
> persist-key
> persist-tun
> ca /etc/luci-uploads/cbid.openvpn.sample_server.ca
> cert /etc/luci-uploads/cbid.openvpn.sample_server.cert
> dev tun
> dh /etc/luci-uploads/cbid.openvpn.sample_server.dh
> ifconfig-pool-persist /tmp/ipp.txt
> keepalive 10 120
> key /etc/luci-uploads/cbid.openvpn.sample_server.key
> port 1194
> proto udp
> server 10.8.0.0 255.255.255.0
> status /tmp/openvpn-status.log
> verb 3
>
> client config:
>  % cat  client-framgment.conf
> auth none
> client
> dev tun
> proto udp
> remote 192.168.1.1 1194
> resolv-retry infinite
> nobind
> persist-key
> persist-tun
> ca ca.crt
> cert client.crt
> key client.key
> data-ciphers none
> verb 2
> writepid /var/run/openvpn.pid
>
>
>> What is the MTU on the DCO and on the transport interfaces when the
>> problem shows us?
>>
> % ifconfig ovpn-dco0
> ovpn-dco0: flags=3D81<UP,POINTOPOINT,RUNNING>  mtu 1500
>         inet 10.8.0.2  netmask 255.255.255.0  destination 10.8.0.2
>         inet6 fe80::3559:b6c1:3fc3:b8cb  prefixlen 64  scopeid 0x20<link>
>         unspec 00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00  txqueuelen
> 1000  (UNSPEC)
>         RX packets 0  bytes 0 (0.0 B)
>         RX errors 0  dropped 0  overruns 0  frame 0
>         TX packets 1  bytes 134 (134.0 B)
>         TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
>  % ifconfig ovpn-dco0
> ovpn-dco0: flags=3D81<UP,POINTOPOINT,RUNNING>  mtu 1500
>         inet 10.8.0.2  netmask 255.255.255.0  destination 10.8.0.2
>         inet6 fe80::3559:b6c1:3fc3:b8cb  prefixlen 64  scopeid 0x20<link>
>         unspec 00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00  txqueuelen
> 1000  (UNSPEC)
>         RX packets 0  bytes 0 (0.0 B)
>         RX errors 0  dropped 0  overruns 0  frame 0
>         TX packets 1  bytes 134 (134.0 B)
>         TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
> log from openvpn client:
> 2021-04-01 14:57:31 net_iface_mtu_set: mtu 1500 for ovpn-dco0
>

--000000000000084bb805bee3d4e8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">sorry, update transport interface.<div>=C2=A0% ifconfig en=
x00e04c680a44<br>enx00e04c680a44: flags=3D4163&lt;UP,BROADCAST,RUNNING,MULT=
ICAST&gt; =C2=A0mtu 1500<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 inet 192.168.1.10 =
=C2=A0netmask 255.255.255.0 =C2=A0broadcast 192.168.1.255<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 inet6 fe80::ec9b:2258:82ec:3cdb =C2=A0prefixlen 64 =C2=A0scop=
eid 0x20&lt;link&gt;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 ether 00:e0:4c:68:0a:44=
 =C2=A0txqueuelen 1000 =C2=A0(Ethernet)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 RX p=
ackets 10365932 =C2=A0bytes 6963820421 (6.9 GB)<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 RX errors 0 =C2=A0dropped 0 =C2=A0overruns 0 =C2=A0frame 0<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 TX packets 11883693 =C2=A0bytes 11887431595 (11.8 GB)<=
br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 TX errors 0 =C2=A0dropped 0 overruns 0 =C2=
=A0carrier 0 =C2=A0collisions 0<br></div></div><br><div class=3D"gmail_quot=
e"><div dir=3D"ltr" class=3D"gmail_attr">Tony He &lt;<a href=3D"mailto:huan=
gya90@...277...">huangya90@...277...</a>&gt; =E4=BA=8E2021=E5=B9=B44=E6=9C=
=881=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=883:01=E5=86=99=E9=81=93=EF=
=BC=9A<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=
=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">Antonio Quartulli &lt;a@...2181...&gt; =E4=BA=
=8E2021=E5=B9=B44=E6=9C=881=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=882:=
35=E5=86=99=E9=81=93=EF=BC=9A<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">Hi Tony,<br>
<br>
On 01/04/2021 04:38, Tony He wrote:<br>
&gt; Hi Antonio, Arne,<br>
&gt; <br>
&gt; According to the dump, this issue is caused by fragment. If I set<br>
&gt; link-mtu to 1472 in the condition of encryption &quot;none&quot;, it&#=
39;s gone.<br>
&gt; I also can reproduce the fragment in my Linux x86-64 PC and Linux VM .=
<br>
&gt; They use kernel 5.4. Fragment affects the performance<br>
&gt; in the low-end devices. It also consumes more CPU resource in low-end<=
br>
&gt; and high-end devices.=C2=A0 If I&#39;m not mistaken, we don&#39;t need=
<br>
&gt; to set link-mtu without dco. Is this a bug? Can you reproduce? Do I<br>
&gt; still need to upload my dump? If so, maybe I need to provide a link.<b=
r>
<br>
You told us what you did to fix, but you haven&#39;t fully explained what<b=
r>
the &quot;broken setup&quot; is. We don&#39;t have your configs, so we can&=
#39;t say what<br>
is creating the issue in your scenario.<br></blockquote><div>server config:=
</div>root@...2607...:/tmp# cat openvpn-sample_server-fragment.conf <br>dat=
a-ciphers none<br>auth none<br>topology subnet<br>persist-key<br>persist-tu=
n<br>ca /etc/luci-uploads/<a href=3D"http://cbid.openvpn.sample_server.ca" =
target=3D"_blank">cbid.openvpn.sample_server.ca</a><br>cert /etc/luci-uploa=
ds/cbid.openvpn.sample_server.cert<br>dev tun<br>dh /etc/luci-uploads/cbid.=
openvpn.sample_server.dh<br>ifconfig-pool-persist /tmp/ipp.txt<br>keepalive=
 10 120<br>key /etc/luci-uploads/cbid.openvpn.sample_server.key<br>port 119=
4<br>proto udp<br>server 10.8.0.0 255.255.255.0<br>status /tmp/openvpn-stat=
us.log<br>verb 3<br><div><br></div><div>client config:</div>=C2=A0% cat =C2=
=A0client-framgment.conf<br>auth none<br>client<br>dev tun<br>proto udp<br>=
remote 192.168.1.1 1194<br>resolv-retry infinite<br>nobind<br>persist-key<b=
r>persist-tun<br>ca ca.crt<br>cert client.crt<br>key client.key<br>data-cip=
hers none<br>verb 2<br>writepid /var/run/openvpn.pid<br><div>=C2=A0</div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">
What is the MTU on the DCO and on the transport interfaces when the<br>
problem shows us?<br></blockquote>% ifconfig ovpn-dco0<br>ovpn-dco0: flags=
=3D81&lt;UP,POINTOPOINT,RUNNING&gt; =C2=A0mtu 1500<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 inet 10.8.0.2 =C2=A0netmask 255.255.255.0 =C2=A0destination 10.8.0.2=
<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 inet6 fe80::3559:b6c1:3fc3:b8cb =C2=A0prefi=
xlen 64 =C2=A0scopeid 0x20&lt;link&gt;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 unspe=
c 00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00 =C2=A0txqueuelen 1000 =C2=
=A0(UNSPEC)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 RX packets 0 =C2=A0bytes 0 (0.0 =
B)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 RX errors 0 =C2=A0dropped 0 =C2=A0overrun=
s 0 =C2=A0frame 0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 TX packets 1 =C2=A0bytes 1=
34 (134.0 B)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 TX errors 0 =C2=A0dropped 0 ove=
rruns 0 =C2=A0carrier 0 =C2=A0collisions 0<br><div>=C2=A0% ifconfig ovpn-dc=
o0</div>ovpn-dco0: flags=3D81&lt;UP,POINTOPOINT,RUNNING&gt; =C2=A0mtu 1500<=
br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 inet 10.8.0.2 =C2=A0netmask 255.255.255.0 =
=C2=A0destination 10.8.0.2<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 inet6 fe80::3559:=
b6c1:3fc3:b8cb =C2=A0prefixlen 64 =C2=A0scopeid 0x20&lt;link&gt;<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 unspec 00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00=
 =C2=A0txqueuelen 1000 =C2=A0(UNSPEC)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 RX pac=
kets 0 =C2=A0bytes 0 (0.0 B)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 RX errors 0 =C2=
=A0dropped 0 =C2=A0overruns 0 =C2=A0frame 0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
TX packets 1 =C2=A0bytes 134 (134.0 B)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 TX er=
rors 0 =C2=A0dropped 0 overruns 0 =C2=A0carrier 0 =C2=A0collisions 0</div><=
div class=3D"gmail_quote">log from openvpn client:</div><div class=3D"gmail=
_quote">2021-04-01 14:57:31 net_iface_mtu_set: mtu 1500 for ovpn-dco0<br></=
div></div>
</blockquote></div>

--000000000000084bb805bee3d4e8--

