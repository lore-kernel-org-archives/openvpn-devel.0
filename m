MIME-Version: 1.0
References: <CAKuzo_g3qfaAB62SVxGPhjqan0+QPCNz6D1+EjRS6OL17Z2x=g@...278...>
 <Y73e+p668JhsXANA@...1296...>
In-Reply-To: <Y73e+p668JhsXANA@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 10 Jan 2023 18:27:56 -0500
Message-ID: <CAKuzo_jsJOMaAAv95mY6Uvu-sN8n_DNKbhU4-L-pOB+Pw5c=QA@...278...>
Content-Type: multipart/alternative; boundary="000000000000c2197605f1f13cae"
Subject: Re: [Openvpn-devel] Conditions under which a connection entry could
 be disabled
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000c2197605f1f13cae
Content-Type: text/plain; charset="UTF-8"

On Tue, Jan 10, 2023 at 4:56 PM Gert Doering <gert@...1296...> wrote:

> Hi,
>
> On Tue, Jan 10, 2023 at 04:42:50PM -0500, Selva Nair wrote:
> > I'm trying to get this info into the GUI for handling
> > "--management-query-remote".  Selecting a disabled entry from the UI
> would
> > lead to erratic behaviour. Ideally this info (CE_DISABLED state) should
> be
> > included in the response to  "remote-entry-get" command, but too late for
> > that to happen in 2.6. It didn't occur to me when that command was
> > implemented.
>
> If you are REALLY fast we can bring it in _rc2 (planned for Thursday).
>
> This should not be a very intrusive change and the only consumer of
> the output today is the Windows GUI, so "compatibility" is not a
> problem here (right?).
>

There is no compat issue as this is a new management command in 2.6.
The change is simple but testing takes time. Let me see if I can pull-it-off
tonight.

Selva



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

--000000000000c2197605f1f13cae
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jan 10, 2023 at 4:56 PM Gert =
Doering &lt;<a href=3D"mailto:gert@...1296...">gert@...1296...</a>&gt; wrot=
e:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
<br>
On Tue, Jan 10, 2023 at 04:42:50PM -0500, Selva Nair wrote:<br>
&gt; I&#39;m trying to get this info into the GUI for handling<br>
&gt; &quot;--management-query-remote&quot;.=C2=A0 Selecting a disabled entr=
y from the UI would<br>
&gt; lead to erratic behaviour. Ideally this info (CE_DISABLED state) shoul=
d be<br>
&gt; included in the response to=C2=A0 &quot;remote-entry-get&quot; command=
, but too late for<br>
&gt; that to happen in 2.6. It didn&#39;t occur to me when that command was=
<br>
&gt; implemented.<br>
<br>
If you are REALLY fast we can bring it in _rc2 (planned for Thursday).<br>
<br>
This should not be a very intrusive change and the only consumer of<br>
the output today is the Windows GUI, so &quot;compatibility&quot; is not a =
<br>
problem here (right?).<br></blockquote><div><br></div><div>There is no comp=
at issue as this is a new management command in 2.6.</div><div>The change i=
s simple but testing takes time. Let me see if I can pull-it-off</div><div>=
tonight.</div><div><br></div><div>Selva</div><div><br></div><div>=C2=A0</di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">
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
</blockquote></div></div>

--000000000000c2197605f1f13cae--

