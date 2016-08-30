MIME-Version: 1.0
In-Reply-To: <20160824131315.GL78279@...1296...>
References: <1451908945-12244-1-git-send-email-lstipakov@...277...>
	<1451911424-12970-1-git-send-email-lstipakov@...277...>
	<20160822191828.GT78279@...1296...>
	<20160823134336.GE78279@...1296...> <57BD5706.2080305@...1147...>
	<20160824131315.GL78279@...1296...>
From: Lev Stipakov <lstipakov@...277...>
Date: Tue, 30 Aug 2016 21:59:52 +0300
Message-ID: <CAGyAFMU+5HM9OhfPB2+3fAhhDOfm-Mr8GLeGnKcbMbZw43aK1Q@...278...>
Content-Type: multipart/alternative; boundary=047d7b670a7bf587cd053b4e9570
Subject: Re: [Openvpn-devel] [PATCH v2] Drop recursively routed packets
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--047d7b670a7bf587cd053b4e9570
Content-Type: text/plain; charset=UTF-8

So, following changes are required for V3:

1) No drop_if_recursive() call for P2P
2) Same for TAP
3) Add an option to disable it

Sounds reasonable?


2016-08-24 16:13 GMT+03:00 Gert Doering <gert@...1296...>:

> Hi,
>
> On Wed, Aug 24, 2016 at 10:12:54AM +0200, Jan Just Keijser wrote:
> > may I suggest to make this configurable,
>
> Well...
>
> > i.e. the user can specify
> > whether rec routed packets should be dropped?  I'm afraid that we might
> > end up with code that drops packets that really should not be dropped -
> > people do weird things with routing: in 99% of the cases in error, but
> > in 1% of the cases because they want to do something funky.
>
> There is no way that this might ever work(*).
>
> If your tunnel gateway is 1.2.3.4, and you send packets to 1.2.3.4 into
> the tunnel, how are these going to arrive?
>
> Packet goes to TUN, is ecapsulated, and sent to 1.2.3.4.
>
> 1.2.3.4 route points to TUN, so packet goes to TUN, gets another layer
> of openvpn, and is sent to 1.2.3.4.
>
> 1.2.3.4 route points to TUN, so packet goes to TUN, gets a *third* layer
> of openvpn, and is sent to 1.2.3.4.
>
> repeat, until the packet hits 1500 byte MTU, and gets fragmented into
> *two* packets that loop forever...
>
> gert
>
>
> (*) it will work if and only if there are multiple routing tables involved,
> that is, packets sent by openvpn itself are not subject to the routing
> tables that would move packets *into* the tunnel - so the Android client
> wouldn't need it (VPN API takes care of this), and with the work on
> Github #13 to suport network name spaces on linux and multiple routing
> tables on *BSD, there are indeed scenarios where this makes sense...
>
> ... so you're right, v3 needs to have an option...
>
> (This started out really small and simple :-) )
> --
> USENET is *not* the non-clickable part of WWW!
>                                                            //
> www.muc.de/~gert/
> Gert Doering - Munich, Germany
> gert@...1296...
> fax: +49-89-35655025                        gert@...1816...
> muenchen.de
>



-- 
-Lev

--047d7b670a7bf587cd053b4e9570
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">So, following changes are required for V3:<div><br></div><=
div>1) No drop_if_recursive() call for P2P</div><div>2) Same for TAP</div><=
div>3) Add an option to disable it</div><div><br></div><div>Sounds reasonab=
le?</div><div><br></div></div><div class=3D"gmail_extra"><br><div class=3D"=
gmail_quote">2016-08-24 16:13 GMT+03:00 Gert Doering <span dir=3D"ltr">&lt;=
<a href=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1296...</a>&gt=
;</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex">Hi,<br>
<span class=3D""><br>
On Wed, Aug 24, 2016 at 10:12:54AM +0200, Jan Just Keijser wrote:<br>
&gt; may I suggest to make this configurable,<br>
<br>
</span>Well...<br>
<span class=3D""><br>
&gt; i.e. the user can specify<br>
&gt; whether rec routed packets should be dropped?=C2=A0 I&#39;m afraid tha=
t we might<br>
&gt; end up with code that drops packets that really should not be dropped =
-<br>
&gt; people do weird things with routing: in 99% of the cases in error, but=
<br>
&gt; in 1% of the cases because they want to do something funky.<br>
<br>
</span>There is no way that this might ever work(*).<br>
<br>
If your tunnel gateway is 1.2.3.4, and you send packets to 1.2.3.4 into<br>
the tunnel, how are these going to arrive?<br>
<br>
Packet goes to TUN, is ecapsulated, and sent to 1.2.3.4.<br>
<br>
1.2.3.4 route points to TUN, so packet goes to TUN, gets another layer<br>
of openvpn, and is sent to 1.2.3.4.<br>
<br>
1.2.3.4 route points to TUN, so packet goes to TUN, gets a *third* layer<br>
of openvpn, and is sent to 1.2.3.4.<br>
<br>
repeat, until the packet hits 1500 byte MTU, and gets fragmented into<br>
*two* packets that loop forever...<br>
<br>
gert<br>
<br>
<br>
(*) it will work if and only if there are multiple routing tables involved,=
<br>
that is, packets sent by openvpn itself are not subject to the routing<br>
tables that would move packets *into* the tunnel - so the Android client<br>
wouldn&#39;t need it (VPN API takes care of this), and with the work on<br>
Github #13 to suport network name spaces on linux and multiple routing<br>
tables on *BSD, there are indeed scenarios where this makes sense...<br>
<br>
... so you&#39;re right, v3 needs to have an option...<br>
<br>
(This started out really small and simple :-) )<br>
<div class=3D"HOEnZb"><div class=3D"h5">--<br>
USENET is *not* the non-clickable part of WWW!<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//<a href=3D"=
http://www.muc.de/~gert/" rel=3D"noreferrer" target=3D"_blank">www.muc.de/~=
gert/</a><br>
Gert Doering - Munich, Germany=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"mailt=
o:gert@...1296...">gert@...1296...</a><br>
fax: <a href=3D"tel:%2B49-89-35655025" value=3D"+498935655025">+49-89-35655=
025</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 <a href=3D"mailto:gert@...1297...">gert@...1816...<wbr>mu=
enchen.de</a><br>
</div></div></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>=
<div class=3D"gmail_signature" data-smartmail=3D"gmail_signature">-Lev</div>
</div>

--047d7b670a7bf587cd053b4e9570--

