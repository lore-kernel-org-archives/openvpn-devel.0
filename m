MIME-Version: 1.0
References: <CAOh3LPOnR5qbF-8xRuJFfZhWW25wNXBK3cUwC710cK4kRcSVpA.ref@...278...>
 <CAOh3LPOnR5qbF-8xRuJFfZhWW25wNXBK3cUwC710cK4kRcSVpA@...278...>
 <aR3XmaUlPlK-pDqB@...1296...>
 <CAOh3LPMP0U+AmA0OneDXBre2Q4Ow4v4pyunx41jxWMxxojioBA@...278...>
 <aR3ecLldIl2ObLpS@...1296...>
In-Reply-To: <aR3ecLldIl2ObLpS@...1296...>
From: Jon Chiappetta <root@...2904...>
Date: Wed, 19 Nov 2025 14:28:38 -0500
Message-ID: <CAOh3LPO95O8+iDHRK6TEZZUvKOqsFSh9CcW1UzF86wH7eEnT2g@...278...>
Content-Type: multipart/alternative; boundary="000000000000044d7d0643f79799"
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

--000000000000044d7d0643f79799
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Makes sense, thanks Gert, I've been trying to track, when I can, some of
the work going into the 2.7 release, I understand you folks have priorities
in place already, I don't want to interrupt or delay you all :) I'm not an
expert yet on all the different code paths, esp. when it comes to the push
and pull options and edge cases involved. I didn't know about that client
side full tun restart procedure but if you have any links about it I'd be
interested to try and read through the code - otherwise I can try to search
for it if I can find some relevant keywords to look for :)

Thanks again as always,
Jon C



On Wed, Nov 19, 2025 at 10:12=E2=80=AFAM Gert Doering <gert@...1296...> wro=
te:

> Hi,
>
> On Wed, Nov 19, 2025 at 09:54:30AM -0500, Jon Chiappetta wrote:
> > Yes, that is correct, it does impact the multi-threaded operation,
> however,
> > the older logic has a strcmp between the old IP and the new IP before
> > performing the learn and unlearn logic in the update_vhash function whi=
ch
> > is what SHOULD happen, this is important and correct. Why would you want
> to
> > waste cycles and operations doing that when the IPs haven't even changed
> or
> > differed in value? It doesn't make any logical sense either way even in
> > single threaded operation...
>
> The operational model underlying here is "you send an update when you
> want to change something", so spending brain & code on "verify that there
> is an actual change, and skip the update if not" is not effort well spent
> (also, the client does a full tun restart, which takes much longer than
> the server side - this is what would need optimizing first ;-) ).
>
> The code, as it is now, is nice and compact, easy to read, and does what
> is supposed to do.
>
> We can come back to this in the "after 2.7.0 release" timeframe when
> we open the tree for "refactor and improve code style and details" changes
> again - right now, we need to focus on actual bugfixes.
>
> gert
>
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

--000000000000044d7d0643f79799
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div>Makes sense, thanks Gert, I&#39;ve been trying to=
 track, when I can, some of the work going into the 2.7 release, I understa=
nd you folks have priorities in place already, I don&#39;t want to interrup=
t or delay you all :) I&#39;m not an expert yet on all the different code p=
aths, esp. when it comes to the push and pull options and edge cases involv=
ed. I didn&#39;t know about that client side full tun restart procedure but=
 if you have any links about it I&#39;d be interested to try and read throu=
gh the code - otherwise I can try to search for it if I can find some relev=
ant keywords to look for :)</div><div><br></div><div>Thanks again as always=
,</div><div>Jon C</div><div><br></div><div><br></div></div><br><div class=
=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr=
">On Wed, Nov 19, 2025 at 10:12=E2=80=AFAM Gert Doering &lt;<a href=3D"mail=
to:gert@...1296...">gert@...1296...</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;=
border-left-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex=
">Hi,<br>
<br>
On Wed, Nov 19, 2025 at 09:54:30AM -0500, Jon Chiappetta wrote:<br>
&gt; Yes, that is correct, it does impact the multi-threaded operation, how=
ever,<br>
&gt; the older logic has a strcmp between the old IP and the new IP before<=
br>
&gt; performing the learn and unlearn logic in the update_vhash function wh=
ich<br>
&gt; is what SHOULD happen, this is important and correct. Why would you wa=
nt to<br>
&gt; waste cycles and operations doing that when the IPs haven&#39;t even c=
hanged or<br>
&gt; differed in value? It doesn&#39;t make any logical sense either way ev=
en in<br>
&gt; single threaded operation...<br>
<br>
The operational model underlying here is &quot;you send an update when you<=
br>
want to change something&quot;, so spending brain &amp; code on &quot;verif=
y that there<br>
is an actual change, and skip the update if not&quot; is not effort well sp=
ent<br>
(also, the client does a full tun restart, which takes much longer than<br>
the server side - this is what would need optimizing first ;-) ).<br>
<br>
The code, as it is now, is nice and compact, easy to read, and does what<br>
is supposed to do.<br>
<br>
We can come back to this in the &quot;after 2.7.0 release&quot; timeframe w=
hen<br>
we open the tree for &quot;refactor and improve code style and details&quot=
; changes<br>
again - right now, we need to focus on actual bugfixes.<br>
<br>
gert<br>
<br>
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

--000000000000044d7d0643f79799--

