MIME-Version: 1.0
In-Reply-To: <20170811102147.GT4090@...1281...>
References: <99D61A626FDA8A4B90A270669121BE10806D5BC3@...2294...>
 <20170811102147.GT4090@...1281...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 11 Aug 2017 10:43:53 -0400
Message-ID: <CAKuzo_jPnS5xVmL9LO_V6tL6Tt92jtRzQ62s6W3665pVrZUaYg@...278...>
Content-Type: multipart/alternative; boundary="001a11409566d432a105567b58dc"
Subject: Re: [Openvpn-devel] OVPN Interactive Service for non-admin users
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a11409566d432a105567b58dc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Aug 11, 2017 at 6:21 AM, Pasi K=C3=A4rkk=C3=A4inen <pasik@...124...=
> wrote:

> Hi,
>
> On Wed, Aug 09, 2017 at 02:31:58PM +0000, Simon Rozman via Openvpn-devel
> wrote:
> >    Hi!
> >
> >    I am developing an eduVPN client for Windows. Imagine the eduVPN
> client as
> >    a custom OpenVPN GUI. The client uses openvpn.exe for connecting, the
> >    configuration file is provided by eduVPN server once user
> authenticates
> >    using OAuth. User running the eduVPN client is not an administrator.
> >    Elevation is out of the question.
> >
> >
> >    I would like to use the Interactive Service to start openvpn.exe, but
> I
> >    have some problems:
> >
> >
> >    1.       The configuration file is dynamically downloaded by the
> eduVPN
> >    client and stored somewhere user can write (user's temporary folder
> for
> >    example). But the Interactive Service was specifically programmed to
> allow
> >    configurations from "C:\Program Files\OpenVPN\config" folder only. B=
ut
> >    user running eduVPN client can't write to this folder.
> >
>
>
> Wasn't this changed in the latest version, allowing config files to be
> under user home/profile directory?
>
>
The change you are referring to is that OpenVPN-GUI now looks for configs
in the global location and in user's profile with the latter given priority
in case of duplicates.

However, to use the interactive service, config could be in any directory
only if the user is a member of (i) Administrators group OR (ii) a custom
group (named "OpenVPN Administrators" by default). Otherwise only configs
in the pre-defined global location are allowed[*]. This is done to make
sure that admins has control over who is allowed to manipulate routes etc
using the interactive service. Note that only group membership is needed,
the group need not be enabled in the token which means elevation is not
required.

Selva

[*] This actual requirement is a bit more relaxed than that as some limited
options are allowed in user-editable configs or command line for all users.

--001a11409566d432a105567b58dc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div style=3D"font-size:12.8px">Hi,</div><div class=3D"gma=
il_extra"><br><div class=3D"gmail_quote">On Fri, Aug 11, 2017 at 6:21 AM, P=
asi K=C3=A4rkk=C3=A4inen <span dir=3D"ltr">&lt;<a href=3D"mailto:pasik@...1386...=
24..." target=3D"_blank">pasik@...124...</a>&gt;</span> wrote:<br><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">Hi,<br>
<span class=3D"gmail-"><br>
On Wed, Aug 09, 2017 at 02:31:58PM +0000, Simon Rozman via Openvpn-devel wr=
ote:<br>
&gt;=C2=A0 =C2=A0 Hi!<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 I am developing an eduVPN client for Windows. Imagine the=
 eduVPN client as<br>
&gt;=C2=A0 =C2=A0 a custom OpenVPN GUI. The client uses openvpn.exe for con=
necting, the<br>
&gt;=C2=A0 =C2=A0 configuration file is provided by eduVPN server once user=
 authenticates<br>
&gt;=C2=A0 =C2=A0 using OAuth. User running the eduVPN client is not an adm=
inistrator.<br>
&gt;=C2=A0 =C2=A0 Elevation is out of the question.<br>
&gt;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 I would like to use the Interactive Service to start open=
vpn.exe, but I<br>
&gt;=C2=A0 =C2=A0 have some problems:<br>
&gt;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 1.=C2=A0 =C2=A0 =C2=A0 =C2=A0The configuration file is dy=
namically downloaded by the eduVPN<br>
&gt;=C2=A0 =C2=A0 client and stored somewhere user can write (user&#39;s te=
mporary folder for<br>
&gt;=C2=A0 =C2=A0 example). But the Interactive Service was specifically pr=
ogrammed to allow<br>
&gt;=C2=A0 =C2=A0 configurations from &quot;C:\Program Files\OpenVPN\config=
&quot; folder only. But<br>
&gt;=C2=A0 =C2=A0 user running eduVPN client can&#39;t write to this folder=
.<br>
&gt;<br>
<br>
<br>
</span>Wasn&#39;t this changed in the latest version, allowing config files=
 to be under user home/profile directory?<br><br></blockquote><div><br></di=
v><div><div>The change you are referring to is that OpenVPN-GUI now looks f=
or configs in the global location and in user&#39;s profile with the latter=
 given priority in case of duplicates.</div><div><br></div><div>However, to=
 use the interactive service, config could be in any directory only if the =
user is a member of (i) Administrators group OR (ii) a custom group (named =
&quot;OpenVPN Administrators&quot; by default). Otherwise only configs in t=
he pre-defined global location are allowed[*]. This is done to make sure th=
at admins has control over who is allowed to manipulate routes etc using th=
e interactive service. Note that only group membership is needed, the group=
 need not be enabled in the token which means elevation is not required.</d=
iv><div><br></div><div>Selva</div><div><br></div><div>[*] This actual requi=
rement is a bit more relaxed than that as some limited options are allowed =
in user-editable configs or command line for all users.</div></div></div></=
div></div>

--001a11409566d432a105567b58dc--

