MIME-Version: 1.0
References: <20221129180534.657529-1-selva.nair@...277...>
 <20221129183756.657793-1-selva.nair@...277...>
 <Y4ZzzbGgy/pUHDN6@...1296...>
In-Reply-To: <Y4ZzzbGgy/pUHDN6@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 29 Nov 2022 16:52:45 -0500
Message-ID: <CAKuzo_jLs928Ef+OJBnYTt0pzSH+3S9_-U-+e8owA64FQ95a8Q@...278...>
Content-Type: multipart/alternative; boundary="000000000000b95f4105eea30554"
Subject: Re: [Openvpn-devel] [PATCH v2] pull-filter: ignore leading "spaces"
 in option names
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

--000000000000b95f4105eea30554
Content-Type: text/plain; charset="UTF-8"

Hi,

On Tue, Nov 29, 2022 at 4:04 PM Gert Doering <gert@...1296...> wrote:

> Hi,
>
> On Tue, Nov 29, 2022 at 01:37:56PM -0500, selva.nair@...277... wrote:
> > From: Selva Nair <selva.nair@...277...>
> >
> > It seems sometimes comma-separated pulled options have
> > an offending leading space. Not sure whether that is an error,
> > but the change here matches the behaviour of option parsing.
> >
> > v2: fix typo in commit message.
>
> I have seen this, but I'd really prefer to fix the pushing side.
>
> Which options have you seen this with?  I only observed with with
> "auth-token", which grows an extra leading space when being sent
> unsolicited.
>

That's the only one I have seen too --  I made this on noticing that option
parser
is happy with the leading space. While fixing this at the server side would
be great, it's
arguable that this one too is needed to bring it line with option parsing.
I'm fine either
way.

Selva

--000000000000b95f4105eea30554
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi,</div><br><div class=3D"gmail_quote"><=
div dir=3D"ltr" class=3D"gmail_attr">On Tue, Nov 29, 2022 at 4:04 PM Gert D=
oering &lt;<a href=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1826...=
6...</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">Hi,<br>
<br>
On Tue, Nov 29, 2022 at 01:37:56PM -0500, <a href=3D"mailto:selva.nair@...1665...=
77..." target=3D"_blank">selva.nair@...277...</a> wrote:<br>
&gt; From: Selva Nair &lt;<a href=3D"mailto:selva.nair@...277..." target=3D=
"_blank">selva.nair@...277...</a>&gt;<br>
&gt; <br>
&gt; It seems sometimes comma-separated pulled options have<br>
&gt; an offending leading space. Not sure whether that is an error,<br>
&gt; but the change here matches the behaviour of option parsing.<br>
&gt; <br>
&gt; v2: fix typo in commit message.<br>
<br>
I have seen this, but I&#39;d really prefer to fix the pushing side.<br>
<br>
Which options have you seen this with?=C2=A0 I only observed with with<br>
&quot;auth-token&quot;, which grows an extra leading space when being sent<=
br>
unsolicited.<br></blockquote><div><br></div><div>That&#39;s the only one I =
have seen too --=C2=A0 I made this on noticing that option parser</div><div=
>is happy with the leading space. While fixing this at the server side woul=
d be great, it&#39;s=C2=A0</div><div>arguable that this one too is needed t=
o bring it line with option parsing. I&#39;m fine either</div><div>way.</di=
v><div><br></div><div>Selva</div></div></div>

--000000000000b95f4105eea30554--

