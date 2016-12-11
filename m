MIME-Version: 1.0
In-Reply-To: <08d5f483-cc64-b708-a54c-29cfb2c7880e@...277...>
References: <CAKuzo_hFT3vXnNn46ubhQiV0zwjg_0uyyMyVtNq2OZeYsq3TuQ@...278...>
	<08d5f483-cc64-b708-a54c-29cfb2c7880e@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Sun, 11 Dec 2016 10:21:07 -0500
Message-ID: <CAKuzo_jFHw1k0M0WfU8WsiTaZDYNE9+K=2=41g_oHqLikydo1w@...278...>
Content-Type: multipart/alternative; boundary=94eb2c084cac7ea4eb0543638a55
Subject: Re: [Openvpn-devel] On saving passwords
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: debbie10t <debbie10t@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--94eb2c084cac7ea4eb0543638a55
Content-Type: text/plain; charset=UTF-8

Hi,

On Sun, Dec 11, 2016 at 9:06 AM, debbie10t <debbie10t@...277...> wrote:

> I think it is down to individual server admins to make this call ..
> If they have a policy which demands that passwords not be saved and
> openvpn does not have a robust method to do so, what will they do ?
>

Agreed, GUI should somehow allow an admin to disable  the save password
feature.


> Is it possible to have --push "auth-nocache-override" which enables
> client --auth-nocache and cannot be filtered out ?
>

This is not required: the code already has restrictions in place so that a
limited user running an arbitrary config through interactive service is not
possible unless the admin permits them to do so. So keeping the config file
readonly for users is enough to protect --auth-nocache.

If we also make the GUI not to save passwords when --auth-nocache is
present in the config, that should be robust enough.

Selva

--94eb2c084cac7ea4eb0543638a55
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,<br><br></div><div class=3D"=
gmail_extra"><div class=3D"gmail_quote">On Sun, Dec 11, 2016 at 9:06 AM, de=
bbie10t <span dir=3D"ltr">&lt;<a href=3D"mailto:debbie10t@...277..." target=
=3D"_blank">debbie10t@...277...</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex"><div id=3D"m_2039390955243096597m_-6316953053816320643:3eq" c=
lass=3D"m_2039390955243096597m_-6316953053816320643a3s m_203939095524309659=
7m_-6316953053816320643aXjCH m_2039390955243096597m_-6316953053816320643m15=
8ee3765a789af8">I think it is down to individual server admins to make this=
 call ..<br>
If they have a policy which demands that passwords not be saved and<br>
openvpn does not have a robust method to do so, what will they do ?<br></di=
v></blockquote><div><br></div><div>Agreed, GUI should somehow allow an admi=
n to disable=C2=A0 the save password feature.<br><br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex"><div id=3D"m_2039390955243096597m_-6316953053816320643:3eq" =
class=3D"m_2039390955243096597m_-6316953053816320643a3s m_20393909552430965=
97m_-6316953053816320643aXjCH m_2039390955243096597m_-6316953053816320643m1=
58ee3765a789af8">
<br>
Is it possible to have --push &quot;auth-nocache-override&quot; which enabl=
es<br>
client --auth-nocache and cannot be filtered out ?<br>
</div></blockquote></div><br></div><div class=3D"gmail_extra">This is not r=
equired: the code already has restrictions in place so that a limited user =
running an arbitrary config through interactive service is not possible unl=
ess the admin permits them to do so. So keeping the config file readonly fo=
r users is enough to protect --auth-nocache.<br><br></div><div class=3D"gma=
il_extra">If we also make the GUI not to save passwords when --auth-nocache=
 is present in the config, that should be robust enough.<br><br></div><div =
class=3D"gmail_extra">Selva<br></div></div>

--94eb2c084cac7ea4eb0543638a55--

