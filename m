MIME-Version: 1.0
References: <CAOh3LPOnR5qbF-8xRuJFfZhWW25wNXBK3cUwC710cK4kRcSVpA.ref@...278...>
 <CAOh3LPOnR5qbF-8xRuJFfZhWW25wNXBK3cUwC710cK4kRcSVpA@...278...>
 <aR3XmaUlPlK-pDqB@...1296...>
In-Reply-To: <aR3XmaUlPlK-pDqB@...1296...>
From: Jon Chiappetta <root@...2904...>
Date: Wed, 19 Nov 2025 09:54:30 -0500
Message-ID: <CAOh3LPMP0U+AmA0OneDXBre2Q4Ow4v4pyunx41jxWMxxojioBA@...278...>
Content-Type: multipart/alternative; boundary="0000000000009b1cde0643f3c254"
Subject: Re: [Openvpn-devel] Old/New IP - Logic Redo
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

--0000000000009b1cde0643f3c254
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Gert,

Yes, that is correct, it does impact the multi-threaded operation, however,
the older logic has a strcmp between the old IP and the new IP before
performing the learn and unlearn logic in the update_vhash function which
is what SHOULD happen, this is important and correct. Why would you want to
waste cycles and operations doing that when the IPs haven't even changed or
differed in value? It doesn't make any logical sense either way even in
single threaded operation...

Thanks,
Jon C


On Wed, Nov 19, 2025 at 9:43=E2=80=AFAM Gert Doering <gert@...1296...> wrot=
e:

> Hi,
>
> On Wed, Nov 19, 2025 at 09:19:35AM -0500, Jon Chiappetta via Openvpn-devel
> wrote:
> > This is something I noticed recently with potential connection
> > interruptions which could occur which the original older code checked
> for!
> >
> > https://github.com/OpenVPN/openvpn/pull/910
>
> Yeah, but, no.
>
> Since our code is single-threaded, there is no time frame between
> "unlearn" and "relearn" where a packet could come in and be dropped, due
> to "address not known".
>
> So yes, on a PUSH_UPDATE with "the same ifconfig again", we do more work
> than we would have to do, but it has no adverse effects - and if you are
> worried about that, then do not send PUSH_UPDATE with unchanged configs
> (given that the client would do a full tun restart on receiving
> PUSH_UPDATE,
> this has way more impact than on the server).
>
>
> > There was an update pushed earlier this year which undid some important
> > logic in terms of learning/unlearning the ifconfig IP address. The older
> > original code would check that the new/old IPs don't match first before
> > performing that logic. I believe this was important and correct because
> it
> > could cause connection interruptions during the learn/unlearn process if
> > the IP address has stayed the same!
>
> The older code did not do proper unlearning at all, so was obviously not
> correct.
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

--0000000000009b1cde0643f3c254
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Gert,<div><br></div><div>Yes, that is correct, it does =
impact the multi-threaded operation, however, the older logic has a strcmp =
between the old IP and the new IP before performing the learn and unlearn l=
ogic in the update_vhash function which is what SHOULD happen, this is impo=
rtant and correct. Why would you want to waste cycles and operations doing =
that when the IPs haven&#39;t even changed or differed in value? It doesn&#=
39;t make any logical sense either way even in single threaded operation...=
</div><div><br></div><div>Thanks,</div><div>Jon C</div><div><br></div></div=
><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" clas=
s=3D"gmail_attr">On Wed, Nov 19, 2025 at 9:43=E2=80=AFAM Gert Doering &lt;<=
a href=3D"mailto:gert@...1296...">gert@...1296...</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft-width:1px;border-left-style:solid;border-left-color:rgb(204,204,204);pa=
dding-left:1ex">Hi,<br>
<br>
On Wed, Nov 19, 2025 at 09:19:35AM -0500, Jon Chiappetta via Openvpn-devel =
wrote:<br>
&gt; This is something I noticed recently with potential connection<br>
&gt; interruptions which could occur which the original older code checked =
for!<br>
&gt; <br>
&gt; <a href=3D"https://github.com/OpenVPN/openvpn/pull/910" rel=3D"norefer=
rer" target=3D"_blank">https://github.com/OpenVPN/openvpn/pull/910</a><br>
<br>
Yeah, but, no.<br>
<br>
Since our code is single-threaded, there is no time frame between<br>
&quot;unlearn&quot; and &quot;relearn&quot; where a packet could come in an=
d be dropped, due<br>
to &quot;address not known&quot;.<br>
<br>
So yes, on a PUSH_UPDATE with &quot;the same ifconfig again&quot;, we do mo=
re work<br>
than we would have to do, but it has no adverse effects - and if you are<br>
worried about that, then do not send PUSH_UPDATE with unchanged configs<br>
(given that the client would do a full tun restart on receiving PUSH_UPDATE=
,<br>
this has way more impact than on the server).<br>
<br>
<br>
&gt; There was an update pushed earlier this year which undid some importan=
t<br>
&gt; logic in terms of learning/unlearning the ifconfig IP address. The old=
er<br>
&gt; original code would check that the new/old IPs don&#39;t match first b=
efore<br>
&gt; performing that logic. I believe this was important and correct becaus=
e it<br>
&gt; could cause connection interruptions during the learn/unlearn process =
if<br>
&gt; the IP address has stayed the same!<br>
<br>
The older code did not do proper unlearning at all, so was obviously not<br>
correct.<br>
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

--0000000000009b1cde0643f3c254--

