MIME-Version: 1.0
In-Reply-To: <DM5PR08MB36429068FCBF60610B6E85CFB94F0@...2422...>
References: <DM5PR08MB36429068FCBF60610B6E85CFB94F0@...2422...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 28 Jun 2018 00:22:40 -0400
Message-ID: <CAKuzo_i+FAq7ZLnCtY471K8KVG62HVSftOdt1X9-FquuyP56eA@...278...>
Content-Type: multipart/alternative; boundary="0000000000002cf58e056fac16f4"
Subject: Re: [Openvpn-devel] OpenVPN GUI, and routes
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "Morris, Russell" <rmorris@...1315...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--0000000000002cf58e056fac16f4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Russel,

Long time !

On Wed, Jun 27, 2018 at 8:54 PM, Morris, Russell <rmorris@...1315...>
wrote:

> Hi,
>
>
> This may be by design =E2=80=93 if so just say that and I=E2=80=99ll go a=
way =E2=80=A6 =F0=9F=98=89. But
> that said =E2=80=93 it seems I have to run the OpenVPN GUI (manually) as =
an
> administrator, for routes to be set / added as directed by the server. Is
> this expected? Unfortunately it won=E2=80=99t even allow the client to co=
nnect if
> this step fails.
>

The GUI in 2.4.x release is meant to be started without admin privileges
and should just work including setting of routes.

It relies on the interactive service so the service should be running ---
 but that's the default. And, when the GUI is started as a limited user it
will warn if the service is stopped. So not sure, why its not working for
you. Client logs may hold some clues.

Cheers,

Selva

--0000000000002cf58e056fac16f4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Russel,<div><br></div><div>Long time !<br><div class=3D=
"gmail_extra"><br><div class=3D"gmail_quote">On Wed, Jun 27, 2018 at 8:54 P=
M, Morris, Russell <span dir=3D"ltr">&lt;<a href=3D"mailto:rmorris@...2424...=
.." target=3D"_blank">rmorris@...1315...</a>&gt;</span> wrote:<br><blockquo=
te class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc so=
lid;padding-left:1ex">





<div lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"m_3083935626055542899WordSection1">
<p class=3D"MsoNormal">Hi,<u></u><u></u></p>
<p class=3D"MsoNormal"><br>
This may be by design =E2=80=93 if so just say that and I=E2=80=99ll go awa=
y =E2=80=A6 <span style=3D"font-family:&quot;Segoe UI Emoji&quot;,sans-seri=
f">
=F0=9F=98=89</span>. But that said =E2=80=93 it seems I have to run the Ope=
nVPN GUI (manually) as an administrator, for routes to be set / added as di=
rected by the server. Is this expected? Unfortunately it won=E2=80=99t even=
 allow the client to connect if this step fails.</p></div></div></blockquot=
e><div><br></div><div>The GUI in 2.4.x release is meant to be started witho=
ut admin privileges and should just work including setting of routes.</div>=
<div><br></div><div>It relies on the interactive service so the service sho=
uld be running --- =C2=A0but that&#39;s the default. And, when the GUI is s=
tarted as a limited user it will warn if the service is stopped. So not sur=
e, why its not working for you. Client logs may hold some clues.</div><div>=
<br></div><div>Cheers,</div><div><br></div><div>Selva</div></div></div></di=
v></div>

--0000000000002cf58e056fac16f4--

