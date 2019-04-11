MIME-Version: 1.0
References: <CAM1xzG1X-iERU2ZXFS_m_VqCKOwjt_gD8oi0F8J5h38Xx+FQ9A@...278...>
 <CAKuzo_gXgqWSLhpvMhjTS+VfbWmQ8JXnHEiOVEPyPSOMCbPKcQ@...278...>
 <3f0208be-60e9-118d-b148-fe05e3da031b@...2080...>
In-Reply-To: <3f0208be-60e9-118d-b148-fe05e3da031b@...2080...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 10 Apr 2019 21:58:24 -0400
Message-ID: <CAKuzo_ivfR68SAUTBvAiGg2yTcf85U=Sh3w4EBcSwcGZEH=gfg@...278...>
Content-Type: multipart/alternative; boundary="00000000000075f72e058637867c"
Subject: Re: [Openvpn-devel] Issue with smartcard authentication for openvpn
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn@...2080...>
Cc: Francois Gelis <francois.gelis@...277...>, antiac@...277..., openvpn-devel <openvpn-devel@lists.sourceforge.net>

--00000000000075f72e058637867c
Content-Type: text/plain; charset="UTF-8"

Hi,


On Wed, Apr 10, 2019 at 6:00 PM David Sommerseth <
openvpn@...2080...> wrote:

> On 10/04/2019 17:58, Selva Nair wrote:
> >
> > As I replied to the openssl-users list[*], pkcs11-helper only supports
> PKCS1
> > signatures, not raw signature needed in this case.
> >
> > We have to either patch pkcs11-helper or switch to something else.
>
> It would be wonderful to switch it for something else.  Unfortunately, it
> does
> a lot of gluing between the lower-level operations (similarly available via
> p11-kit) and the interfaces implemented in OpenVPN is fairly high-level.
> So
> this "glue code" which pkcs11-helper is, is not that trivial and last time
> I
> checked the alternatives were scarce :(
>
> Is this a Windows only issue?  Or is it present on other platforms as well?
> If it's Windows only, I think we can get around it by patching it and
> ensuring
> upstream is aware of this.  But if it is more platforms, patching
> pkcs11-helper gets nasty quickly.
>

This has nothing to do with Windows. This is a limitation of pkcs11-helper
no matter what OS its used in. In fact on Windows we have an alternative
option to use hardware tokens through cryptoapicert, but on other OSes we
are dependent on pkcs11-helper.

So this has everything non-Windows written on it.

Selva

--00000000000075f72e058637867c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi,<div><br></div></div><br><div class=3D=
"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Apr 10, 2019 at=
 6:00 PM David Sommerseth &lt;<a href=3D"mailto:openvpn@...2080...">openvpn=
@...2080...</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">On 10/04/2019 17:58, Selva Nair wrote:<br>
&gt; <br>
&gt; As I replied to the openssl-users list[*], pkcs11-helper only supports=
 PKCS1<br>
&gt; signatures, not raw signature needed in this case.<br>
&gt; <br>
&gt; We have to either patch pkcs11-helper or switch to something else.<br>
<br>
It would be wonderful to switch it for something else.=C2=A0 Unfortunately,=
 it does<br>
a lot of gluing between the lower-level operations (similarly available via=
<br>
p11-kit) and the interfaces implemented in OpenVPN is fairly high-level.=C2=
=A0 So<br>
this &quot;glue code&quot; which pkcs11-helper is, is not that trivial and =
last time I<br>
checked the alternatives were scarce :(<br>
<br>
Is this a Windows only issue?=C2=A0 Or is it present on other platforms as =
well?<br>
If it&#39;s Windows only, I think we can get around it by patching it and e=
nsuring<br>
upstream is aware of this.=C2=A0 But if it is more platforms, patching<br>
pkcs11-helper gets nasty quickly.<br></blockquote><div><br></div><div>This =
has nothing to do with Windows. This is a limitation of pkcs11-helper no ma=
tter what OS its used in. In fact on Windows we have an alternative option =
to use hardware tokens through cryptoapicert, but on other OSes we are depe=
ndent on pkcs11-helper.</div><div><br></div><div>So this has everything non=
-Windows written on it.</div><div><br></div><div>Selva</div></div></div>

--00000000000075f72e058637867c--

