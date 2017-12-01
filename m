MIME-Version: 1.0
In-Reply-To: <CAEsd45T7i0CLzEFmLE5xhe451YZRZHMBn1dEWEtF=xtND=ejGQ@...278...>
References: <CAKuzo_jPThhvXTJAtzhqVUVOLPW1VGu6h2jQhVsHicY8P2WRqA@...278...>
 <CAEsd45T7i0CLzEFmLE5xhe451YZRZHMBn1dEWEtF=xtND=ejGQ@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 30 Nov 2017 22:26:42 -0500
Message-ID: <CAKuzo_ig29-NKbxYJvCxEHk5m8pniz3yrrhJ0gdO000zcwHr6w@...278...>
Content-Type: multipart/alternative; boundary="94eb2c046b9e33f83d055f3ef1b4"
Subject: Re: [Openvpn-devel] Follow up on sending messages to the GUI
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "Jonathan K. Bullard" <jkbullard@...277...>
Cc: "openvpn-users@lists.sourceforge.net" <openvpn-users@lists.sourceforge.net>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--94eb2c046b9e33f83d055f3ef1b4
Content-Type: text/plain; charset="UTF-8"

Hi Jon,

On Thu, Nov 30, 2017 at 8:41 PM, Jonathan K. Bullard <jkbullard@...277...>
wrote:

> Thanks, Selva,
>
> On Wed, Nov 29, 2017 at 9:03 PM, Selva Nair <selva.nair@...277...> wrote:
> >
> > I have made a draft implementation of this feature that was discussed in
> a previous thread. A test executable (GUI only) is in this pre-release:
> >
> > https://github.com/selvanair/openvpn-gui/releases/tag/v11-echo-msg
> <SNIP>
> >
> > Also see some technical notes included in the above link.
>
> The technical notes say
>
>      In case of "echo msg text" the previous text, if any, is appended
> with a new line. An empty text in this case will just add a new line.
>
>
That was a poor way of saying that "echo msg text" will display a single
line of text, not two lines as would be expected if an '\n' is automatically
appended.


> Is that the same as
>
>      In case of "echo msg text" the previous text, if any, is appended
> with text and then a new line. An empty text in this case will just
> add a new line.
>
>
Yes, that would be a less confusing way to word it provided an
additional remark is added: that the last newline so added is ignored during
display (see below).


> ? (That is, the new line comes after the text, not after the previous
> text.)
>

Well, here is what I thought should happen:

echo msg Text
echo msg-window title

should display "Text" as a single line (ignoring any "soft" linebreaks
added by the UI for display purposes). For this to happen no '\n' should
get appended to "Text".

echo msg Text1
echo msg Text2
echo msg-window title

leads to "Text1\nText2"  displayed in 2 lines

Alternatively the one could say "msg Text" implicitly appends a newline
character(s) to "Text" except that the last implicit newline does not cause
an
empty line to be displayed.

Isn't that the expected behaviour?

Selva

P.S: In reality I add about a line of blank space at the top and bottom
before display
for aesthetic reasons, but that is beside the point.

--94eb2c046b9e33f83d055f3ef1b4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Jon,<br><div class=3D"gmail_extra"><br><div class=3D"gm=
ail_quote">On Thu, Nov 30, 2017 at 8:41 PM, Jonathan K. Bullard <span dir=
=3D"ltr">&lt;<a href=3D"mailto:jkbullard@...277..." target=3D"_blank">jkbul=
lard@...277...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">Thanks, Selva,<br>
<span class=3D"m_9153128886306226461m_428956954955622674m_-7617401627936496=
762gmail-"><br>
On Wed, Nov 29, 2017 at 9:03 PM, Selva Nair &lt;<a href=3D"mailto:selva.nai=
r@...277..." target=3D"_blank">selva.nair@...277...</a>&gt; wrote:<br>
&gt;<br>
&gt; I have made a draft implementation of this feature that was discussed =
in a previous thread. A test executable (GUI only) is in this pre-release:<=
br>
&gt;<br>
&gt; <a href=3D"https://github.com/selvanair/openvpn-gui/releases/tag/v11-e=
cho-msg" rel=3D"noreferrer" target=3D"_blank">https://github.com/selvanair/=
o<wbr>penvpn-gui/releases/tag/v11-ec<wbr>ho-msg</a><br>
</span>&lt;SNIP&gt;<br>
<span class=3D"m_9153128886306226461m_428956954955622674m_-7617401627936496=
762gmail-">&gt;<br>
&gt; Also see some technical notes included in the above link.<br>
<br>
</span>The technical notes say<br>
<br>
=C2=A0 =C2=A0 =C2=A0In case of &quot;echo msg text&quot; the previous text,=
 if any, is appended<br>
with a new line. An empty text in this case will just add a new line.<br>
<br></blockquote><div><br></div><div>That was a poor way of saying that &qu=
ot;echo msg text&quot; will display a single</div><div>line of text, not tw=
o lines as would be expected if an &#39;\n&#39; is automatically</div><div>=
appended.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">
Is that the same as<br>
<br>
=C2=A0 =C2=A0 =C2=A0In case of &quot;echo msg text&quot; the previous text,=
 if any, is appended<br>
with text and then a new line. An empty text in this case will just<br>
add a new line.<br>
<br></blockquote><div><br></div><div>Yes, that would be a less confusing wa=
y to word it provided an</div><div>additional remark is added: that the las=
t newline so added is ignored during</div><div>display (see below).</div><d=
iv>=C2=A0=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
? (That is, the new line comes after the text, not after the previous text.=
)<br></blockquote><div><br></div><div>Well, here is what I thought should h=
appen:</div><div><br></div><div>echo msg Text</div><div>echo msg-window tit=
le</div><div><br></div><div>should display &quot;Text&quot; as a single lin=
e (ignoring any &quot;soft&quot; linebreaks=C2=A0</div><div>added by the UI=
 for display purposes). For this to happen no &#39;\n&#39; should</div><div=
>get appended to &quot;Text&quot;.</div><div>=C2=A0</div><div>echo msg Text=
1</div><div>echo msg Text2</div><div>echo msg-window title</div><div><br></=
div><div>leads to &quot;Text1\nText2&quot; =C2=A0displayed in 2 lines</div>=
<div><br></div><div>Alternatively the one could say &quot;msg Text&quot; im=
plicitly appends a newline</div><div>character(s) to &quot;Text&quot; excep=
t that the last implicit newline does not cause an</div><div>empty line to =
be displayed.</div><div><br></div><div>Isn&#39;t that the expected behaviou=
r?</div><div><br></div><div>Selva</div><div><br></div><div>P.S: In reality =
I add about a line of blank space at the top and bottom before display</div=
><div>for aesthetic reasons, but that is beside the point.</div></div></div=
></div>

--94eb2c046b9e33f83d055f3ef1b4--

