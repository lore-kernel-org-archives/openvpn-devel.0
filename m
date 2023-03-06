MIME-Version: 1.0
References: <20230306053346.796992-1-selva.nair@...277...>
 <20230306053346.796992-2-selva.nair@...277...>
 <ZAWjO1dXEnBRsltG@...1296...>
In-Reply-To: <ZAWjO1dXEnBRsltG@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 6 Mar 2023 07:11:27 -0500
Message-ID: <CAKuzo_ixHXYnZxfkJzBpMtHZ2E8f5u0GJVSWzXkx=_yZHToTBQ@...278...>
Content-Type: multipart/alternative; boundary="000000000000baa98505f63a3222"
Subject: Re: [Openvpn-devel] [PATCH 2/2] Include supplementary groups when
 checking management-client-group
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

--000000000000baa98505f63a3222
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 6, 2023 at 3:24=E2=80=AFAM Gert Doering <gert@...1296...> wrote:

> Hi,
>
> On Mon, Mar 06, 2023 at 12:33:46AM -0500, selva.nair@...277... wrote:
> > From: Selva Nair <selva.nair@...277...>
> >
> > - When management-client-group is in use, allow access if any of
> >   the supplementary groups of the user matches the specified group.
> >
> >   Currently only the effective gid of the peer socket is checked
> >   which is normally the primary group of user. As unprivileged users
> >   have no easy way of changing the effective gid of a process,
> >   group based access control is of very limited use without this change.
>
> I'm not really convinced this is a good way forward - it's yet another
> extra function for a very niche use case, as in "the code has been like
> this for 100 years, and nobody has ever used it".
>
> What you do is also not exactly "the user connecting has this gid at the
> time of connection" but "the uid reported by getpeerid() has this group
> listed in /etc/groups", which will be the same in many cases, but is
> still checking something different.
>

I was of the same opinion when I first saw issue #264, but I think the
original
intent of "--management-client-group has to be what I've implemented or
something similar.

Docs refer to it as group (not effective gid of the socket), and
restricting based on
gid reported by getpeerid is kind of useless. Why use "group" if it can't
be used
to restrict access to a set of users using a supplementary group...

I would propose to extend the documentation with "this only checks the
> primary gid at time of connection, if this does not work for your use
> case, put the socket into a directory with the right gid and mode 750
> and do not use that openvpn option" - as you wrote in the github ticket.
>

It's impossible to save that option by documenting. In that case, let's
just
make it a no-op and document that this option has no effect. And suggest
the above for how to achieve group-based access control..


> > - Also accept if uid =3D 0 irrespective of the group.
>
> This part is fine for me, as it follows the traditional unix way of
> "root may pass".
>

I'm not keen on touching some code and ignore that a closely related
code stays crippled (IMO). Unless we can make --management-client-group
a no-op as mentioned above.

As you say this is an obscure option -- we can leave it "as is".

Selva

--000000000000baa98505f63a3222
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi,</div><br><div class=3D"gmail_quote"><=
div dir=3D"ltr" class=3D"gmail_attr">On Mon, Mar 6, 2023 at 3:24=E2=80=AFAM=
 Gert Doering &lt;<a href=3D"mailto:gert@...1296...">gert@...1296...</a>&gt=
; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
<br>
On Mon, Mar 06, 2023 at 12:33:46AM -0500, <a href=3D"mailto:selva.nair@...1665...=
77..." target=3D"_blank">selva.nair@...277...</a> wrote:<br>
&gt; From: Selva Nair &lt;<a href=3D"mailto:selva.nair@...277..." target=3D=
"_blank">selva.nair@...277...</a>&gt;<br>
&gt; <br>
&gt; - When management-client-group is in use, allow access if any of<br>
&gt;=C2=A0 =C2=A0the supplementary groups of the user matches the specified=
 group.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0Currently only the effective gid of the peer socket is che=
cked<br>
&gt;=C2=A0 =C2=A0which is normally the primary group of user. As unprivileg=
ed users<br>
&gt;=C2=A0 =C2=A0have no easy way of changing the effective gid of a proces=
s,<br>
&gt;=C2=A0 =C2=A0group based access control is of very limited use without =
this change.<br>
<br>
I&#39;m not really convinced this is a good way forward - it&#39;s yet anot=
her<br>
extra function for a very niche use case, as in &quot;the code has been lik=
e<br>
this for 100 years, and nobody has ever used it&quot;.<br>
<br>
What you do is also not exactly &quot;the user connecting has this gid at t=
he<br>
time of connection&quot; but &quot;the uid reported by getpeerid() has this=
 group<br>
listed in /etc/groups&quot;, which will be the same in many cases, but is<b=
r>
still checking something different.<br></blockquote><div><br></div><div>I w=
as of the same opinion when I first saw issue #264, but I think the origina=
l</div><div>intent of &quot;--management-client-group has to be what I&#39;=
ve implemented or</div><div>something similar.</div><div><br></div><div>Doc=
s refer to it as group (not effective gid of the socket), and restricting b=
ased on</div><div>gid=C2=A0reported by getpeerid is kind of useless. Why us=
e &quot;group&quot; if it can&#39;t be used</div><div>to restrict access to=
 a set of users using a supplementary group...</div><div><br></div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">
I would propose to extend the documentation with &quot;this only checks the=
<br>
primary gid at time of connection, if this does not work for your use<br>
case, put the socket into a directory with the right gid and mode 750<br>
and do not use that openvpn option&quot; - as you wrote in the github ticke=
t.<br></blockquote><div><br></div><div>It&#39;s impossible to save that opt=
ion by documenting. In that case, let&#39;s just=C2=A0</div><div>make it a =
no-op and document=C2=A0that this option has no effect. And suggest</div><d=
iv>the above for how to achieve group-based access control..</div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; - Also accept if uid =3D 0 irrespective of the group.<br>
<br>
This part is fine for me, as it follows the traditional unix way of<br>
&quot;root may pass&quot;.<br></blockquote><div><br></div><div>I&#39;m not =
keen on touching some code and ignore that a closely related</div><div>code=
=C2=A0stays crippled (IMO). Unless we can make --management-client-group</d=
iv><div>a no-op as mentioned above.</div><div><br></div><div>As you say thi=
s is an obscure=C2=A0option -- we can leave it &quot;as is&quot;.</div><div=
><br></div><div>Selva</div></div></div>

--000000000000baa98505f63a3222--

