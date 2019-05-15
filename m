MIME-Version: 1.0
References: <CAGyAFMV=HvOYDRSB7eRpBDp-47wX2vie8JPgp48in1fH+eXn=A@...278...>
In-Reply-To: <CAGyAFMV=HvOYDRSB7eRpBDp-47wX2vie8JPgp48in1fH+eXn=A@...278...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Wed, 15 May 2019 19:49:39 +0500
Message-ID: <CAFHpkQFVpN-+Uoc6QsLmD8hjwEC7Ba1Q2SP4SuS_EMu_PT=3nw@...278...>
Content-Type: multipart/alternative; boundary="000000000000f3c8240588ee428c"
Subject: Re: [Openvpn-devel] Wintun performance results
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: wireguard@...2500..., openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000f3c8240588ee428c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

it will most probably get lost in mailing list.
can we add it to https://openvpn.net website ? something like "performance
testing" with full configs provided ?

=D1=81=D1=80, 15 =D0=BC=D0=B0=D1=8F 2019 =D0=B3. =D0=B2 18:49, Lev Stipakov=
 <lstipakov@...277...>:

> Hi guys,
>
> I made openvpn3 (required changes will be incorporated into main branch at
> some point) work with wintun and did performance testing in AWS.
>
> Client:    c5.xlarge, Windows Server 2016, patched openvpn3 test client
> and OpenVPN Connect 2.7.1.103 (uses tap-windows6, based on openvpn3).
>
> Server:  c5.xlarge, Ubuntu 18.04, openvpn 2.4.4
>
> Client and server instances are in the same VPC and placement group.
>
> iPerf3 running on server:
>
> > iperf3 -s -B 0.0.0.0 -V
>
> iPerf3 running on client:
>
> > iperf3 -c 10.8.0.1 -V (server VPN address)
> > iperf3 -c 10.0.0.18 -V (server VPC address)
>
> Results:
>
> - no vpn
>
> [ ID] Interval           Transfer     Bandwidth
> [  4]   0.00-10.00  sec  8.67 GBytes  7.45
> Gbits/sec                  sender
> [  4]   0.00-10.00  sec  8.67 GBytes  7.45
> Gbits/sec                  receiver
> CPU Utilization: local/sender 61.4% (5.6%u/55.8%s), remote/receiver 33.9%
> (1.7%u/32.2%s)
>
> - tap-windows6
>
> [ ID] Interval           Transfer     Bandwidth
> [  4]   0.00-10.00  sec   404 MBytes   339
> Mbits/sec                  sender
> [  4]   0.00-10.00  sec   404 MBytes   339
> Mbits/sec                  receiver
> CPU Utilization: local/sender 4.6% (0.3%u/4.3%s), remote/receiver 21.4%
> (2.2%u/19.2%s)
>
> - wintun
>
> [ ID] Interval           Transfer     Bandwidth
> [  4]   0.00-10.00  sec   536 MBytes   449
> Mbits/sec                  sender
> [  4]   0.00-10.00  sec   536 MBytes   449
> Mbits/sec                  receiver
> CPU Utilization: local/sender 2.9% (0.1%u/2.8%s), remote/receiver 10.1%
> (0.7%u/9.3%s)
>
> As you see, wintun performs 30% better comparison to tap-windows6 and
> incurs significantly less CPU usage.
>
> --
> -Lev
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--000000000000f3c8240588ee428c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>it will most probably get lost in mailing list.</div>=
<div>can we add it to <a href=3D"https://openvpn.net">https://openvpn.net</=
a> website ? something like &quot;performance testing&quot; with full confi=
gs provided ? <br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">=D1=81=D1=80, 15 =D0=BC=D0=B0=D1=8F 2019 =D0=B3. =
=D0=B2 18:49, Lev Stipakov &lt;<a href=3D"mailto:lstipakov@...277...">lstip=
akov@...277...</a>&gt;:<br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex"><div dir=3D"ltr">Hi guys,<div><br></div><div>I made openvpn3 (requi=
red changes will be incorporated into main branch at some point) work with =
wintun and did performance testing in AWS.</div><div><br></div><div><div>Cl=
ient:=C2=A0 =C2=A0 c5.xlarge, Windows Server 2016, patched openvpn3 test cl=
ient and OpenVPN Connect 2.7.1.103 (uses tap-windows6, based on openvpn3).<=
/div><div><br></div><div>Server:=C2=A0 c5.xlarge, Ubuntu 18.04, openvpn 2.4=
.4</div><div><br></div><div>Client and server instances are in the same VPC=
 and placement group.</div><div><br></div><div>iPerf3 running on server:</d=
iv><div><br></div><div>&gt; iperf3 -s -B 0.0.0.0 -V</div><div><br></div><di=
v>iPerf3 running on client:</div><div><br></div><div>&gt; iperf3 -c 10.8.0.=
1 -V (server VPN address)</div><div>&gt; iperf3 -c 10.0.0.18 -V (server VPC=
 address)=C2=A0=C2=A0<br></div><div><br></div><div>Results:</div><div><br><=
/div><div>- no vpn</div><div><br></div><div>[ ID] Interval=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Transfer=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0Bandwidth</div><div>[=C2=A0=C2=A04]=C2=A0=C2=A0=C2=A00.00-10=
.00=C2=A0=C2=A0sec=C2=A0=C2=A08.67 GBytes=C2=A0=C2=A07.45 Gbits/sec=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0sender</div><div>[=C2=A0=C2=A04]=C2=A0=C2=A0=C2=
=A00.00-10.00=C2=A0=C2=A0sec=C2=A0=C2=A08.67 GBytes=C2=A0=C2=A07.45 Gbits/s=
ec=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0receiver</div><div>CPU Utilization: loc=
al/sender 61.4% (5.6%u/55.8%s), remote/receiver 33.9% (1.7%u/32.2%s)</div><=
div><br></div><div>- tap-windows6</div><div><br></div><div>[ ID] Interval=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Transfer=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Bandwidth</div><div>[=C2=A0=C2=A04]=C2=A0=C2=
=A0=C2=A00.00-10.00=C2=A0=C2=A0sec=C2=A0=C2=A0=C2=A0404 MBytes=C2=A0=C2=A0=
=C2=A0339 Mbits/sec=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sender</div><div>[=C2=
=A0=C2=A04]=C2=A0=C2=A0=C2=A00.00-10.00=C2=A0=C2=A0sec=C2=A0=C2=A0=C2=A0404=
 MBytes=C2=A0=C2=A0=C2=A0339 Mbits/sec=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rec=
eiver</div><div>CPU Utilization: local/sender 4.6% (0.3%u/4.3%s), remote/re=
ceiver 21.4% (2.2%u/19.2%s)</div><div><br></div><div>- wintun</div><div><br=
></div><div>[ ID] Interval=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0Transfer=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Bandwidth</div><div=
>[=C2=A0=C2=A04]=C2=A0=C2=A0=C2=A00.00-10.00=C2=A0=C2=A0sec=C2=A0=C2=A0=C2=
=A0536 MBytes=C2=A0=C2=A0=C2=A0449 Mbits/sec=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0sender</div><div>[=C2=A0=C2=A04]=C2=A0=C2=A0=C2=A00.00-10.00=C2=A0=C2=A0=
sec=C2=A0=C2=A0=C2=A0536 MBytes=C2=A0=C2=A0=C2=A0449 Mbits/sec=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0receiver</div><div>CPU Utilization: local/sender 2.9% =
(0.1%u/2.8%s), remote/receiver 10.1% (0.7%u/9.3%s)</div><div><br></div><div=
>As you see, wintun performs 30% better comparison to tap-windows6 and incu=
rs significantly less CPU usage.</div><div><br></div>-- <br><div dir=3D"ltr=
" class=3D"gmail-m_6674205254209199893gmail_signature">-Lev</div></div></di=
v>
_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=3D"_blank">Op=
envpn-devel@lists.sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/lists/listi=
nfo/openvpn-devel</a><br>
</blockquote></div>

--000000000000f3c8240588ee428c--

