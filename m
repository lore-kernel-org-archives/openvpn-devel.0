MIME-Version: 1.0
References: <CAPM6dUC_L=Q2HseFEKS7bfrff6McwQo9TSuWKramkbC+5k9Phw@...278...>
 <5d43db38-5481-3f67-555d-b2b59b89be63@...1147...>
In-Reply-To: <5d43db38-5481-3f67-555d-b2b59b89be63@...1147...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Wed, 17 Apr 2019 15:24:40 +0500
Message-ID: <CAFHpkQEetMrGST3DziN5gedP32DbN4v7w+NDmViZcccmaZf7Fg@...278...>
Content-Type: multipart/alternative; boundary="000000000000c504bb0586b74b63"
Subject: Re: [Openvpn-devel] openvpn with udp lost event.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Just Keijser <janjust@...1147...>
Cc: wei wang <lnykww@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000c504bb0586b74b63
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=81=D1=80, 17 =D0=B0=D0=BF=D1=80. 2019 =D0=B3. =D0=B2 15:19, Jan Just Ke=
ijser <janjust@...1147...>:

> On 15/04/19 14:29, wei wang wrote:
> > Hi,
> >
> > For function multi_process_io_udp receive many events, but only
> > process one at a time. Doest it cause the event to be lost?
> yes it does
> > In our test, we had create thousands of client. When clients connect
> > to server at a time, for the clients which already connected on this
> > server will not receive packet from tun device.
> that is correct - this is known limitation of  the OpenVPN 2 code base.
> Fixing this limitation is far from trivial, however.
>

that is true.

however you can choose "deffered" auth mode
here's example https://github.com/mozilla-it/openvpn_defer_auth



>
> HTH,
>
> JJK
>
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--000000000000c504bb0586b74b63
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">=D1=81=D1=80, 17 =D0=
=B0=D0=BF=D1=80. 2019 =D0=B3. =D0=B2 15:19, Jan Just Keijser &lt;<a href=3D=
"mailto:janjust@...1147...">janjust@...1147...</a>&gt;:<br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">On 15/04/19 14:29, wei wang wrote:<=
br>
&gt; Hi,<br>
&gt;<br>
&gt; For function multi_process_io_udp receive many events, but only<br>
&gt; process one at a time. Doest it cause the event to be lost?<br>
yes it does<br>
&gt; In our test, we had create thousands of client. When clients connect<b=
r>
&gt; to server at a time, for the clients which already connected on this<b=
r>
&gt; server will not receive packet from tun device.<br>
that is correct - this is known limitation of=C2=A0 the OpenVPN 2 code base=
. <br>
Fixing this limitation is far from trivial, however.<br></blockquote><div><=
br></div><div>that is true.</div><div><br></div><div>however you can choose=
 &quot;deffered&quot; auth mode</div><div>here&#39;s example <a href=3D"htt=
ps://github.com/mozilla-it/openvpn_defer_auth">https://github.com/mozilla-i=
t/openvpn_defer_auth</a><br></div><div><br></div><div>=C2=A0</div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">
<br>
HTH,<br>
<br>
JJK<br>
<br>
<br>
<br>
_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=3D"_blank">Op=
envpn-devel@lists.sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/lists/listi=
nfo/openvpn-devel</a><br>
</blockquote></div></div></div>

--000000000000c504bb0586b74b63--

