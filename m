MIME-Version: 1.0
In-Reply-To: <20170508141939.31224-1-davids@...515...>
References: <20170508141939.31224-1-davids@...515...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 8 May 2017 10:38:56 -0400
Message-ID: <CAKuzo_jU+ufz5vkLKdzbf5637hF8bPRNrV3q4Ttq+5YQBqWGtA@...278...>
Content-Type: multipart/alternative; boundary=94eb2c050a9222ca7a054f043407
Subject: Re: [Openvpn-devel] [PATCH] plugin: Fix documentation typo for
	type_mask
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <davids@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--94eb2c050a9222ca7a054f043407
Content-Type: text/plain; charset=UTF-8

Hi,

On Mon, May 8, 2017 at 10:19 AM, David Sommerseth <davids@...515...>
wrote:

>   *
>   * STRUCT MEMBERS
>   *
> - * *type_mask : The plug-in should set this value to the logical OR of
> all script
> + * type_mask  : The plug-in should set this value to the logical OR of
> all script
>   *              types which the plug-in wants to intercept.  For example,
> if the
>   *              script wants to intercept the client-connect and
> client-disconnect
>   *              script types:
>   *
> - *              *type_mask = OPENVPN_PLUGIN_MASK(OPENVPN_PL
> UGIN_CLIENT_CONNECT)
> + *              type_mask = OPENVPN_PLUGIN_MASK(OPENVPN_PL
> UGIN_CLIENT_CONNECT)
>   *                         | OPENVPN_PLUGIN_MASK(OPENVPN_PL
> UGIN_CLIENT_DISCONNECT)
>   *
>   * *handle :    Pointer to a global plug-in context, created by the
> plug-in.  This pointer
>


Asking to set *handle to context_ptr is wrong too. One can't dereference
handle. So it will have to be interpreted as set handle to pointer to
pointer to the context but that is wrong.

But as discussed in the other thread I think we should also change the
definition of handle in this struct.

Reference to *handle in line 390 needs correction too (comment only --
struct is fine).

Thanks,

Selva

--94eb2c050a9222ca7a054f043407
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,<br><br></div><div class=3D"=
gmail_extra"><div class=3D"gmail_quote">On Mon, May 8, 2017 at 10:19 AM, Da=
vid Sommerseth <span dir=3D"ltr">&lt;<a href=3D"mailto:davids@...515..." ta=
rget=3D"_blank">davids@...515...</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex"><div id=3D"m_6492574060144710172:4ij" class=3D"m_649257406014=
4710172a3s m_6492574060144710172aXjCH m_6492574060144710172m15be86fdb64e5c1=
9">=C2=A0 *<br>
=C2=A0 * STRUCT MEMBERS<br>
=C2=A0 *<br>
- * *type_mask : The plug-in should set this value to the logical OR of all=
 script<br>
+ * type_mask=C2=A0 : The plug-in should set this value to the logical OR o=
f all script<br>
=C2=A0 *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 types which the pl=
ug-in wants to intercept.=C2=A0 For example, if the<br>
=C2=A0 *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 script wants to in=
tercept the client-connect and client-disconnect<br>
=C2=A0 *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 script types:<br>
=C2=A0 *<br>
- *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *type_mask =3D OPENVPN_=
PLUGIN_MASK(OPENVPN_PL<wbr>UGIN_CLIENT_CONNECT)<br>
+ *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 type_mask =3D OPENVPN_P=
LUGIN_MASK(OPENVPN_PL<wbr>UGIN_CLIENT_CONNECT)<br>
=C2=A0 *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0| OPENVPN_PLUGIN_MASK(OPENVPN_PL<wbr>UGIN_CLIENT_DI=
SCONNECT)<br>
=C2=A0 *<br>
=C2=A0 * *handle :=C2=A0 =C2=A0 Pointer to a global plug-in context, create=
d by the plug-in.=C2=A0 This pointer</div></blockquote></div><br><br></div>=
<div class=3D"gmail_extra">Asking to set *handle to context_ptr is wrong to=
o. One can&#39;t dereference handle. So it will have to be interpreted as s=
et handle to pointer to pointer to the context but that is wrong.<br><br></=
div><div class=3D"gmail_extra">But as discussed in the other thread I think=
 we should also change the definition of handle in this struct.<br><br></di=
v><div class=3D"gmail_extra">Reference to *handle in line 390 needs correct=
ion too (comment only -- struct is fine).<br><br></div><div class=3D"gmail_=
extra">Thanks,<br><br></div><div class=3D"gmail_extra">Selva<br></div></div>

--94eb2c050a9222ca7a054f043407--

