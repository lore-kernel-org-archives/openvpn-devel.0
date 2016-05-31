MIME-Version: 1.0
In-Reply-To: <20160531084825.GT53051@...1296...>
References: <1464668569-6480-1-git-send-email-selva.nair@...277...>
	<20160531084825.GT53051@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 31 May 2016 11:54:53 -0400
Message-ID: <CAKuzo_jLpENbvwEOg18dp3CKRCFQbo8O29m3-jZfqQeJ+DB+Kw@...278...>
Content-Type: multipart/alternative; boundary=001a1143e8e0fece300534256577
Subject: Re: [Openvpn-devel] [PATCH] Add an option to filter options
 received from server
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

--001a1143e8e0fece300534256577
Content-Type: text/plain; charset=UTF-8

Hi,

On Tue, May 31, 2016 at 4:48 AM, Gert Doering <gert@...1296...> wrote:

> Hi,
>
> On Tue, May 31, 2016 at 12:22:49AM -0400, Selva Nair wrote:
> > filtering stops as soon as a match is found. Full regex support is
> > not available but partial matching is used to allow some flexibility.
> > Thus
> >
> >   pull-filter accept "ifconfig 10.9.0."
> >   pull-filter reject "ifconfig "
> >   pull-filter accept "route 10."
> >   pull-filter reject "route "
>
> Thinking about this a bit more, without having studied the code - what
> do you think about having a third category
>
>    pull-filter accept "route 10."
>    pull-filter reject "route 195.30."
>    pull-filter ignore "route "
>

> "ignore" would be "if that option shows up, log the fact that we ignored
> it, and go on", while "reject" would be "if this shows up, something bad
> is happening, so complain loudly, abort the connection and try the next
> alternative".
>

Interesting. At the very least it may be worth doing a v2 to make adding
new action types easier.

Suppose we do make "reject" to not just remove the option but reject the
server. What to do if no alternative remotes exist --- just SIGHUP and hope
that next try will succeed or something like management-hold will keep the
connection waiting for user intervention? I would avoid issuing or causing
a SIGTERM.


>
> > A maximum of 64 filters are supported.
>
> We briefly discussed this yesterday - 64 should be plenty for about
> everything, but a dynamic list might be the way to cope for the *one*
> user who then comes up with the 65th rule...
>

I didn't make it a linked-list mainly because of the need of adding to the
tail of the list which means some extra extra book-keeping and if-elses.

For now the 65th filter will trigger an early exit at the config parsing
stage with a message.

Selva

--001a1143e8e0fece300534256577
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,</div><div class=3D"gmail_ex=
tra"><br><div class=3D"gmail_quote">On Tue, May 31, 2016 at 4:48 AM, Gert D=
oering <span dir=3D"ltr">&lt;<a href=3D"mailto:gert@...1296..." target=3D"_=
blank">gert@...1296...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-=
color:rgb(204,204,204);border-left-style:solid;padding-left:1ex"><div>Hi,<b=
r>
<span><br>
On Tue, May 31, 2016 at 12:22:49AM -0400, Selva Nair wrote:<br>
&gt; filtering stops as soon as a match is found. Full regex support is<br>
&gt; not available but partial matching is used to allow some flexibility.<=
br>
&gt; Thus<br>
&gt;<br>
&gt;=C2=A0 =C2=A0pull-filter accept &quot;ifconfig 10.9.0.&quot;<br>
&gt;=C2=A0 =C2=A0pull-filter reject &quot;ifconfig &quot;<br>
&gt;=C2=A0 =C2=A0pull-filter accept &quot;route 10.&quot;<br>
&gt;=C2=A0 =C2=A0pull-filter reject &quot;route &quot;<br>
<br>
</span>Thinking about this a bit more, without having studied the code - wh=
at<br>
do you think about having a third category<br>
<br>
=C2=A0 =C2=A0pull-filter accept &quot;route 10.&quot;<br>
=C2=A0 =C2=A0pull-filter reject &quot;route 195.30.&quot;<br>
=C2=A0 =C2=A0pull-filter ignore &quot;route &quot;</div></blockquote><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-w=
idth:1px;border-left-color:rgb(204,204,204);border-left-style:solid;padding=
-left:1ex"><div>
<br>
&quot;ignore&quot; would be &quot;if that option shows up, log the fact tha=
t we ignored<br>
it, and go on&quot;, while &quot;reject&quot; would be &quot;if this shows =
up, something bad<br>
is happening, so complain loudly, abort the connection and try the next<br>
alternative&quot;.<br></div></blockquote><div><br></div><div>Interesting. A=
t the very least it may be worth doing a v2 to make adding new action types=
 easier.</div><div><br></div><div>Suppose we do make &quot;reject&quot; to =
not just remove the option but reject the server. What to do if no alternat=
ive remotes exist --- just SIGHUP and hope that next try will succeed or so=
mething like management-hold will keep the connection waiting for user inte=
rvention? I would avoid issuing or causing a SIGTERM.</div><div>=C2=A0</div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;=
padding-left:1ex"><div>
<span><br>
&gt; A maximum of 64 filters are supported.<br>
<br>
</span>We briefly discussed this yesterday - 64 should be plenty for about<=
br>
everything, but a dynamic list might be the way to cope for the *one*<br>
user who then comes up with the 65th rule...<div><div></div></div></div></b=
lockquote></div><div class=3D"gmail_extra"><br></div>I didn&#39;t make it a=
 linked-list mainly because of the need of adding to the tail of the list w=
hich means some extra extra book-keeping and if-elses.=C2=A0</div><div clas=
s=3D"gmail_extra"><br></div><div class=3D"gmail_extra">For now the 65th fil=
ter will trigger an early exit at the config parsing stage with a message.<=
/div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Selva<=
/div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra"><br></=
div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra"><br></d=
iv><div class=3D"gmail_extra">=C2=A0<br><br></div></div>

--001a1143e8e0fece300534256577--

