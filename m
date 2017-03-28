MIME-Version: 1.0
Sender: emmanueldeloget53@...277...
In-Reply-To: <20170327183502.GJ93896@...1296...>
References: <ec21d010-67a3-0ff1-3c2a-d5db08039e45@...277...>
	<20170327183502.GJ93896@...1296...>
From: Emmanuel Deloget <logout@...260...>
Date: Tue, 28 Mar 2017 10:33:48 +0200
Message-ID: <CAKh=nwE-U4C6CVw+XpdBE1RXjG_VOYoT=UuJDAPs2AOFOoP+jw@...278...>
Content-Type: multipart/alternative; boundary=94eb2c0929c8a067d6054bc651e1
Subject: Re: [Openvpn-devel] building HEAD + openssl 1.1 api fails @
 "crypto.c:823:32: error: invalid application of ???sizeof??? to incomplete
 type ???cipher_ctx_t"
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net, PGNet Dev <pgnet.dev@...277...>

--94eb2c0929c8a067d6054bc651e1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,


On Mon, Mar 27, 2017 at 8:35 PM, Gert Doering <gert@...1296...> wrote:

> Hi,
>
> On Mon, Mar 27, 2017 at 11:25:50AM -0700, PGNet Dev wrote:
> > noting
> >
> >       openvpn fails to build with openssl 1.1
> >               https://community.openvpn.net/openvpn/ticket/759
>
> Guess why that ticket is still open?
>
> >       [Openvpn-devel] [RFC PATCH v1 00/15] Add support for OpenSSL 1.1.x
> >               https://www.mail-archive.com/openvpn-devel@...1199...
> sourceforge.net/msg14075.html
>
> ... because that is a patch *series*, and only half of it has been
> merged yet.
>
> So it is perfectly known that it will not build with 1.1 yet.
>


=E2=80=8BI should be able to push a new version of the remaining patches in=
 the
foreseeable future (let's say today or tomorrow, because I will be
unavailable at the end of this week).

I found a solution to overcome the big X509_check_purpose() issue, so now
I'm able to propose a solution that does not change the behavior of OpenVPN.

BR,

-- Emmanuel Deloget

--94eb2c0929c8a067d6054bc651e1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:&quot;co=
urier new&quot;,monospace">Hi,=C2=A0</div><div class=3D"gmail_default" styl=
e=3D"font-family:&quot;courier new&quot;,monospace"><br></div><div class=3D=
"gmail_extra"><br><div class=3D"gmail_quote">On Mon, Mar 27, 2017 at 8:35 P=
M, Gert Doering <span dir=3D"ltr">&lt;<a href=3D"mailto:gert@...1296..." ta=
rget=3D"_blank">gert@...1296...</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">Hi,<br>
<br>
On Mon, Mar 27, 2017 at 11:25:50AM -0700, PGNet Dev wrote:<br>
&gt; noting<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0openvpn fails to build with openssl 1.1<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"https=
://community.openvpn.net/openvpn/ticket/759" rel=3D"noreferrer" target=3D"_=
blank">https://community.openvpn.net/<wbr>openvpn/ticket/759</a><br>
<br>
Guess why that ticket is still open?<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0[Openvpn-devel] [RFC PATCH v1 00/15] Add sup=
port for OpenSSL 1.1.x<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"https=
://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg14075.html" =
rel=3D"noreferrer" target=3D"_blank">https://www.mail-archive.com/<wbr>open=
vpn-devel@...1199...<wbr>sourceforge.net/msg14075.html</a><br>
<br>
... because that is a patch *series*, and only half of it has been<br>
merged yet.<br>
<br>
So it is perfectly known that it will not build with 1.1 yet.<br></blockquo=
te><div><br></div><div><br></div><div><div class=3D"gmail_default" style=3D=
"font-family:&quot;courier new&quot;,monospace">=E2=80=8BI should be able t=
o push a new version of the remaining patches in the foreseeable future (le=
t&#39;s say today or tomorrow, because I will be unavailable at the end of =
this week).</div><div class=3D"gmail_default" style=3D"font-family:&quot;co=
urier new&quot;,monospace"><br></div><div class=3D"gmail_default" style=3D"=
font-family:&quot;courier new&quot;,monospace">I found a solution to overco=
me the big X509_check_purpose() issue, so now I&#39;m able to propose a sol=
ution that does not change the behavior of OpenVPN.</div><div class=3D"gmai=
l_default" style=3D"font-family:&quot;courier new&quot;,monospace"><br></di=
v><div class=3D"gmail_default" style=3D"font-family:&quot;courier new&quot;=
,monospace">BR,=C2=A0</div><div class=3D"gmail_default" style=3D"font-famil=
y:&quot;courier new&quot;,monospace"><br></div><div class=3D"gmail_default"=
 style=3D"font-family:&quot;courier new&quot;,monospace">-- Emmanuel Deloge=
t</div></div></div><br></div></div>

--94eb2c0929c8a067d6054bc651e1--

