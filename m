MIME-Version: 1.0
References: <CAOh3LPOK2-L8VCS5VcvpDvDyGQp9o00y9v069OChyK9o9-884Q.ref@...278...>
 <CAOh3LPOK2-L8VCS5VcvpDvDyGQp9o00y9v069OChyK9o9-884Q@...278...>
 <aPcq1N1o2-mZJH1G@...1296...>
In-Reply-To: <aPcq1N1o2-mZJH1G@...1296...>
From: Jon Chiappetta <root@...2904...>
Date: Wed, 22 Oct 2025 17:29:57 -0400
Message-ID: <CAOh3LPM2Tc_=LTNmu4ntnXCjkVVChcxeF2KuCE7-0Lm78WKUxA@...278...>
Content-Type: multipart/alternative; boundary="00000000000046ee9e0641c605e0"
Subject: Re: [Openvpn-devel] Quick question for the OpenVPN developers on
 the source code functionality [problem solving]
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

--00000000000046ee9e0641c605e0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Gert! :) I did find a nice built-in method in the OVPN source code
to extract both the source and destination ipv4 addresses
(mroute_extract_addr_ip) which I was able to use and build on top of to
help solve this multi-threaded "issue" of mine. It has helped greatly in
terms of performance now as I am able to simply associate an IPv4
connection state to an available thread which will result in ordered packet
processing of data from the TUN device (read/write). This has helped
greatly to prevent or reduce the amount of processing and reordering that
TCP and QUIC-UDP have to perform and things are loading "snappier" now it
seems. The other available threads can also work on their own connection
states at the same time allowing them to work in parallel but also
separately if you will. Thanks again for your work on this project and
inputs on this proof-of-concept experiment I'm running. I wouldn't have
been able to do any of this with WireGuard!

Blog post:
https://fossjon.com/2025/10/22/solving-a-final-remaining-performance-impact=
-with-mutli-threaded-operation-by-using-connection-state-mapping-in-the-hig=
hly-modified-openvpn-source-code-implementation/



On Tue, Oct 21, 2025 at 2:40=E2=80=AFAM Gert Doering <gert@...1296...> wrot=
e:

> Hi,
>
> On Mon, Oct 20, 2025 at 04:15:22PM -0400, Jon Chiappetta via Openvpn-devel
> wrote:
> > I was wondering if any part of the OpenVPN source code parses the IPv4
> > packet header for source/destination address already in place?
>
> With tun/tap and ipv4/ipv6, this is a bit of nastiness...
>
> You might want to have a look at drop_if_recursive_routing() in master,
> as that one has to find destination address & port and will log source
> address & port.
>
> Not sure we have something more convenient.  Grepping for openvpn_iphdr
> might turn up something, though :-) (like somewhere in the NAT code).
>
> gert
> --
> "If was one thing all people took for granted, was conviction that if you
>  feed honest figures into a computer, honest figures come out. Never
> doubted
>  it myself till I met a computer with a sense of humor."
>                              Robert A. Heinlein, The Moon is a Harsh
> Mistress
>
> Gert Doering - Munich, Germany
> gert@...1296...
>

--00000000000046ee9e0641c605e0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div>Thanks Gert! :) I did find a nice built-in method=
 in the OVPN source code to extract both the source and destination ipv4 ad=
dresses (mroute_extract_addr_ip) which I was able to use and build on top o=
f to help solve this multi-threaded &quot;issue&quot; of mine. It has helpe=
d greatly in terms of performance=C2=A0now as I am able to simply associate=
 an IPv4 connection state to an available thread which will result in order=
ed packet processing of data from the TUN device (read/write). This has hel=
ped greatly to prevent or reduce the amount of processing and reordering th=
at TCP and QUIC-UDP have to perform and things are loading &quot;snappier&q=
uot; now it seems. The other available threads can also work on their own c=
onnection states at the same time allowing them to work in parallel but als=
o separately if you will. Thanks again for your work<span class=3D"gmail-Ap=
ple-converted-space">=C2=A0</span>on this project and inputs on this proof-=
of-concept experiment I&#39;m running. I wouldn&#39;t have been able to do =
any of this with WireGuard!</div><div><br></div><div>Blog post:=C2=A0<a hre=
f=3D"https://fossjon.com/2025/10/22/solving-a-final-remaining-performance-i=
mpact-with-mutli-threaded-operation-by-using-connection-state-mapping-in-th=
e-highly-modified-openvpn-source-code-implementation/">https://fossjon.com/=
2025/10/22/solving-a-final-remaining-performance-impact-with-mutli-threaded=
-operation-by-using-connection-state-mapping-in-the-highly-modified-openvpn=
-source-code-implementation/</a></div><div><br></div><div><br></div></div><=
br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=
=3D"gmail_attr">On Tue, Oct 21, 2025 at 2:40=E2=80=AFAM Gert Doering &lt;<a=
 href=3D"mailto:gert@...1296...">gert@...1296...</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft-width:1px;border-left-style:solid;border-left-color:rgb(204,204,204);pad=
ding-left:1ex">Hi,<br>
<br>
On Mon, Oct 20, 2025 at 04:15:22PM -0400, Jon Chiappetta via Openvpn-devel =
wrote:<br>
&gt; I was wondering if any part of the OpenVPN source code parses the IPv4=
<br>
&gt; packet header for source/destination address already in place?<br>
<br>
With tun/tap and ipv4/ipv6, this is a bit of nastiness...<br>
<br>
You might want to have a look at drop_if_recursive_routing() in master,<br>
as that one has to find destination address &amp; port and will log source<=
br>
address &amp; port.<br>
<br>
Not sure we have something more convenient.=C2=A0 Grepping for openvpn_iphd=
r<br>
might turn up something, though :-) (like somewhere in the NAT code).<br>
<br>
gert<br>
-- <br>
&quot;If was one thing all people took for granted, was conviction that if =
you <br>
=C2=A0feed honest figures into a computer, honest figures come out. Never d=
oubted <br>
=C2=A0it myself till I met a computer with a sense of humor.&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Robert A. Heinlein, The Moon is a Harsh Mist=
ress<br>
<br>
Gert Doering - Munich, Germany=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"mailt=
o:gert@...1296..." target=3D"_blank">gert@...1296...</a><br>
</blockquote></div>

--00000000000046ee9e0641c605e0--

