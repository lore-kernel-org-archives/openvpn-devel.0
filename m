MIME-Version: 1.0
In-Reply-To: <20180418065816.GY69387@...1296...>
References: <c113c9a5-198e-775b-c183-f319c35bdb28@...515...>
 <3ed13a6a-07fd-3f0c-100c-148099bc8971@...277...>
 <CAKuzo_haG86HMg8+Wet0=m6O9tzU_c92TQSBgJy7NncPv+3=GQ@...278...>
 <20180418065816.GY69387@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 18 Apr 2018 12:52:23 -0400
Message-ID: <CAKuzo_g01G5BL8Tr4EBU8wv_xa=vOhAuVxHFGqDh2h+mYxParA@...278...>
Content-Type: multipart/alternative; boundary="000000000000ae3eac056a2248c7"
Subject: Re: [Openvpn-devel] New tap-windows6 driver (9.21.3) available for
 testing
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

--000000000000ae3eac056a2248c7
Content-Type: text/plain; charset="UTF-8"

Hi,

On Wed, Apr 18, 2018 at 2:58 AM, Gert Doering <gert@...1296...> wrote:

> On Tue, Apr 17, 2018 at 09:45:24PM -0400, Selva Nair wrote:
> > (ii) The driver version shows up as 9.0.0.21 -- this is apparently taken
> > from the inf file. Why is it not 9.21.3? The file version is 9.21.3 9/21
> as
> > expected.
>
> I have no idea how the various values in version.m4 should work.  There
> are many numbers...
>
> What I have (after bumping all "21" to "22", and ".2/.3" to ".1") is:
>
> define([PRODUCT_NAME], [TAP-Windows])
> define([PRODUCT_PUBLISHER], [OpenVPN Technologies, Inc.])
> define([PRODUCT_VERSION], [9.22.1])
> define([PRODUCT_VERSION_RESOURCE], [9,0,0,22])
> define([PRODUCT_TAP_WIN_COMPONENT_ID], [tap0901])
> define([PRODUCT_TAP_WIN_MAJOR], [9])
> define([PRODUCT_TAP_WIN_MINOR], [22])
> define([PRODUCT_TAP_WIN_REVISION], [1])
> define([PRODUCT_TAP_WIN_BUILD], [601])
>
> So, no idea what PRODUCT_VERSION_RESOURCE does and why it is not "9,22,1,0"
> (or the like).
>

These are custom defines, so it depends on how those variables are used in
the resource file and the inf file.

The relevant defines in resource.rc are

VER_PRODUCTVERSION = major,0,0,minor --> 9,0,0,22
VER_PRODUCTVERSION_STR = "PRODUCTVERSION" "major/minor" --> "9.22.1 9/22"
(no idea why that 9/22 is added or build is not included).

The driver inf (OemVista.inf.in) file defines the driver version as
major,0,0,minor which matches the product version above.

Currently PRODUCT_VERSION_RESOURCE as such and revision, build numbers are
unused.

I have no idea whether there are any implications of changing the version
in two places (resource and inf) consistently  to major,minor,release,build.

Selva

--000000000000ae3eac056a2248c7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><div><div class=3D"gmail_extra"><br><div class=3D"g=
mail_quote">On Wed, Apr 18, 2018 at 2:58 AM, Gert Doering <span dir=3D"ltr"=
>&lt;<a href=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1296...</=
a>&gt;</span> wrote:<span class=3D"m_5400161129330922259gmail-m_43922131154=
00598637gmail-"></span><br><span class=3D"m_5400161129330922259gmail-m_4392=
213115400598637gmail-"></span><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex"><span class=3D"m_5400161129330922259gmail-m_4392213115400598637gmail-">
On Tue, Apr 17, 2018 at 09:45:24PM -0400, Selva Nair wrote:<br>
&gt; (ii) The driver version shows up as 9.0.0.21 -- this is apparently tak=
en<br>
&gt; from the inf file. Why is it not 9.21.3? The file version is 9.21.3 9/=
21 as<br>
&gt; expected.<br>
<br>
</span>I have no idea how the various values in version.m4 should work.=C2=
=A0 There<br>
are many numbers...<br>
<br>
What I have (after bumping all &quot;21&quot; to &quot;22&quot;, and &quot;=
.2/.3&quot; to &quot;.1&quot;) is:<br>
<br>
define([PRODUCT_NAME], [TAP-Windows])<br>
define([PRODUCT_PUBLISHER], [OpenVPN Technologies, Inc.])<br>
define([PRODUCT_VERSION], [9.22.1])<br>
define([PRODUCT_VERSION_RESOUR<wbr>CE], [9,0,0,22])<br>
define([PRODUCT_TAP_WIN_COMPON<wbr>ENT_ID], [tap0901])<br>
define([PRODUCT_TAP_WIN_MAJOR]<wbr>, [9])<br>
define([PRODUCT_TAP_WIN_MINOR]<wbr>, [22])<br>
define([PRODUCT_TAP_WIN_REVISI<wbr>ON], [1])<br>
define([PRODUCT_TAP_WIN_BUILD]<wbr>, [601])<br>
<br>
So, no idea what PRODUCT_VERSION_RESOURCE does and why it is not &quot;9,22=
,1,0&quot;<br>
(or the like).<br></blockquote><div><br></div><div>These are custom defines=
, so it depends on how those variables are used in the resource file and th=
e inf file.<br><br>The relevant defines in resource.rc are<br><br></div><di=
v>VER_PRODUCTVERSION =3D major,0,0,minor --&gt; 9,0,0,22<br></div><div>VER_=
PRODUCTVERSION_STR =3D &quot;PRODUCTVERSION&quot; &quot;major/minor&quot; -=
-&gt; &quot;9.22.1 9/22&quot; (no idea why that 9/22 is added or build is n=
ot included).<br><br></div><div>The driver inf (<a href=3D"http://OemVista.=
inf.in">OemVista.inf.in</a>) file defines the driver version as major,0,0,m=
inor which matches the product version above.<br><br></div><div>Currently P=
RODUCT_VERSION_RESOUR<wbr>CE as such and revision, build numbers are unused=
.<br><br></div><div>I have no idea whether there are any implications of ch=
anging the version in two places (resource and inf) consistently=C2=A0 to m=
ajor,minor,release,build.<br></div><div><br></div><div>Selva<br></div></div=
></div></div></div>

--000000000000ae3eac056a2248c7--

