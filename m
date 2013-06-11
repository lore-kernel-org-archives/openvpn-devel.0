MIME-Version: 1.0
In-Reply-To: <51B75346.9020702@...1114...>
References: <CAEYCsr6idT0VPyR=g5s9dC-AQ3xAbcgeaq7otDa5JTpXaa=Thw@...278...>
	<51B75346.9020702@...1114...>
Date: Tue, 11 Jun 2013 18:44:41 +0200
Message-ID: <CAEYCsr6w2St4NxcV65w8+O3CYje8Aczy61qfbM4smf4emZc3jw@...278...>
From: wen lui <esolvepolito@...277...>
Content-Type: multipart/alternative; boundary=001a11c3b9a21f418104dee39d0c
Subject: Re: [Openvpn-devel] delivering a packet through tun file descriptor
 leads to different results
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--001a11c3b9a21f418104dee39d0c
Content-Type: text/plain; charset=ISO-8859-1

thanks

you meant when you run my program, you got a ICMP reply?


2013/6/11 David Sommerseth <openvpn.list@...1114...>

> On 11/06/13 18:00, wen lui wrote:
> > Hi, all:
> >
> >     I encountered a strange problem, my problem is detailed in this link
> >
> >
> http://stackoverflow.com/questions/16915322/delivering-a-packet-through-tun-file-descriptor-leads-to-different-results
> >
> > can anyone help me with this problem?
> >
> > thanks!
>
> The OpenVPN project didn't write the tun/tap driver for Linux (or BSD
> and Solaris).  So I would recommend you to check this out with the Linux
> kernel networking team, as they most likely have a broader understanding
> on how this driver works.
>
> You do use openvpn to create the tun device, but you could just as well
> used tunctl for the same operation.
>
> Having all that said ... your program partly works for me - but not
> reliably.  I did one code change, I had to use 10.99.0.1/24 as my IP
> address to avoid address conflicts.  So I used this line:
>
>     packet = create_icmp_pkt(100, "10.99.0.2", "10.99.0.1", 500, 5);
>
> And I had to run your program as root (to gain access to the tun
> device).  In addition, I ensured that my firewall was not adding any
> obstacles by adding this iptables rule:
>
>     iptables -I INPUT -i tun2 -j ACCEPT
>
> When running your program via strace, it works reliably though.  Which
> is surprising.
>
> So I still recommend you to discuss this with the Linux Kernel
> networking group.
>
> <http://kernelnewbies.org/ML#head-007c59cc4d4ffcd7aacd7fabb6234d9b5a52c61a
> >
>
>
>
> --
> kind regards,
>
> David Sommerseth
>
>

--001a11c3b9a21f418104dee39d0c
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">thanks<br><div class=3D"gmail_extra"><br></div><div class=
=3D"gmail_extra">you meant when you run my program, you got a ICMP reply? <=
br><br></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">2013=
/6/11 David Sommerseth <span dir=3D"ltr">&lt;<a href=3D"mailto:openvpn.list=
@...1114..." target=3D"_blank">openvpn.list@...1114...</a>&gt;</span><br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><div class=3D"h5">On 1=
1/06/13 18:00, wen lui wrote:<br>
&gt; Hi, all:<br>
&gt;<br>
&gt; =A0 =A0 I encountered a strange problem, my problem is detailed in thi=
s link<br>
&gt;<br>
&gt; <a href=3D"http://stackoverflow.com/questions/16915322/delivering-a-pa=
cket-through-tun-file-descriptor-leads-to-different-results" target=3D"_bla=
nk">http://stackoverflow.com/questions/16915322/delivering-a-packet-through=
-tun-file-descriptor-leads-to-different-results</a><br>

&gt;<br>
&gt; can anyone help me with this problem?<br>
&gt;<br>
&gt; thanks!<br>
<br>
</div></div>The OpenVPN project didn&#39;t write the tun/tap driver for Lin=
ux (or BSD<br>
and Solaris). =A0So I would recommend you to check this out with the Linux<=
br>
kernel networking team, as they most likely have a broader understanding<br>
on how this driver works.<br>
<br>
You do use openvpn to create the tun device, but you could just as well<br>
used tunctl for the same operation.<br>
<br>
Having all that said ... your program partly works for me - but not<br>
reliably. =A0I did one code change, I had to use <a href=3D"http://10.99.0.=
1/24" target=3D"_blank">10.99.0.1/24</a> as my IP<br>
address to avoid address conflicts. =A0So I used this line:<br>
<br>
=A0 =A0 packet =3D create_icmp_pkt(100, &quot;10.99.0.2&quot;, &quot;10.99.=
0.1&quot;, 500, 5);<br>
<br>
And I had to run your program as root (to gain access to the tun<br>
device). =A0In addition, I ensured that my firewall was not adding any<br>
obstacles by adding this iptables rule:<br>
<br>
=A0 =A0 iptables -I INPUT -i tun2 -j ACCEPT<br>
<br>
When running your program via strace, it works reliably though. =A0Which<br>
is surprising.<br>
<br>
So I still recommend you to discuss this with the Linux Kernel<br>
networking group.<br>
<br>
&lt;<a href=3D"http://kernelnewbies.org/ML#head-007c59cc4d4ffcd7aacd7fabb62=
34d9b5a52c61a" target=3D"_blank">http://kernelnewbies.org/ML#head-007c59cc4=
d4ffcd7aacd7fabb6234d9b5a52c61a</a>&gt;<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
<br>
<br>
--<br>
kind regards,<br>
<br>
David Sommerseth<br>
<br>
</font></span></blockquote></div><br></div></div>

--001a11c3b9a21f418104dee39d0c--

