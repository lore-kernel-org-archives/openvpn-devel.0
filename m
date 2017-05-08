MIME-Version: 1.0
In-Reply-To: <20170505214624.11675-1-davids@...515...>
References: <20170505214624.11675-1-davids@...515...>
From: Selva Nair <selva.nair@...277...>
Date: Sun, 7 May 2017 23:28:49 -0400
Message-ID: <CAKuzo_hOntpCXhSUJFZk3QbKiVMLn87_t+2YAYcirLcX0z17SQ@...278...>
Content-Type: multipart/alternative; boundary=001a113fe0faa42289054efad704
Subject: Re: [Openvpn-devel] [PATCH 1/2] plugin: Export base64 encode and
 decode functions
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

--001a113fe0faa42289054efad704
Content-Type: text/plain; charset=UTF-8

Hi,

Thanks for the patch exporting base64_encode/decode

A quick question/comment though: quoting from your sample base64.c

On Fri, May 5, 2017 at 5:46 PM, David Sommerseth <davids@...515...> wrote:

> +    /*  Which callbacks to intercept.  */
> +    ret->type_mask =
> +        OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_TLS_VERIFY)
> +        |OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_CLIENT_CONNECT_V2);
> +
> +    /* we don't need a plug-in context in this example, but OpenVPN
> expects "something" */
> +    ret->handle = calloc(1, 1);
>

While this looks right[*], in openvpn-plugin.h (lines 344-370) the handle
in the _return struct
is defined as openvpn_plugin_handle_t * where that type itself is void *,
making handle void **.
Also the comment accompanying  "struct openvpn_plugin_args_open_return"
indicates
*handle should be set to the pointer to the context but that cant be right.

The compiler will not warn about void * and void ** mismatches, so ignoring
the definition and
saving the context pointer in ret->handle works,  but the declaration of
handle in the return struct
should be simply openvpn_plugin_handle_t without the *. The same comment
also refers to
*type_mask instead of type_mask.which is not right either.
.
Am I missing something?

Selva

[*] By the way, this being an example, it may be best to show the correct
type by casting the
return value of calloc to (openvpn_plugin_handle_t)

--001a113fe0faa42289054efad704
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,</div><div class=3D"gmail_ex=
tra"><br></div><div class=3D"gmail_extra">Thanks for the patch exporting ba=
se64_encode/decode</div><div class=3D"gmail_extra"><br></div><div class=3D"=
gmail_extra">A quick question/comment though: quoting from your sample base=
64.c</div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Fri,=
 May 5, 2017 at 5:46 PM, David Sommerseth <span dir=3D"ltr">&lt;<a href=3D"=
mailto:davids@...515..." target=3D"_blank">davids@...515...</a>&gt;</span> =
wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div id=3D"gmai=
l-:1je" class=3D"gmail-a3s gmail-aXjCH gmail-m15bda95fa5f31677">+=C2=A0 =C2=
=A0 /*=C2=A0 Which callbacks to intercept.=C2=A0 */<br>
+=C2=A0 =C2=A0 ret-&gt;type_mask =3D<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 OPENVPN_PLUGIN_MASK(OPENVPN_<wbr>PLUGIN_TLS_VE=
RIFY)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 |OPENVPN_PLUGIN_MASK(OPENVPN_<wbr>PLUGIN_CLIEN=
T_CONNECT_V2);<br>
+<br>
+=C2=A0 =C2=A0 /* we don&#39;t need a plug-in context in this example, but =
OpenVPN expects &quot;something&quot; */<br>
+=C2=A0 =C2=A0 ret-&gt;handle =3D calloc(1, 1);</div></blockquote></div><br=
>While this looks right[*], in openvpn-plugin.h (lines 344-370) the handle =
in the _return struct</div><div class=3D"gmail_extra">is defined as openvpn=
_plugin_handle_t * where that type itself is void *, making handle void **.=
=C2=A0</div><div class=3D"gmail_extra">Also the comment accompanying =C2=A0=
&quot;struct openvpn_plugin_args_open_return&quot; indicates=C2=A0</div><di=
v class=3D"gmail_extra">*handle should be set to the pointer to the context=
 but that cant be right.</div><div class=3D"gmail_extra"><br></div><div cla=
ss=3D"gmail_extra">The compiler will not warn about void * and void ** mism=
atches, so ignoring the definition and</div><div class=3D"gmail_extra">savi=
ng the context pointer in ret-&gt;handle works, =C2=A0but the declaration o=
f handle in the return struct</div><div class=3D"gmail_extra">should be sim=
ply openvpn_plugin_handle_t without the *. The same comment also refers to<=
/div><div class=3D"gmail_extra">*type_mask instead of type_mask.which is no=
t right either.</div><div class=3D"gmail_extra">.</div><div class=3D"gmail_=
extra">Am I missing something?</div><div class=3D"gmail_extra"><br></div><d=
iv class=3D"gmail_extra">Selva</div><div class=3D"gmail_extra"><br></div><d=
iv class=3D"gmail_extra">[*] By the way, this being an example, it may be b=
est to show the correct type by casting the</div><div class=3D"gmail_extra"=
>return value of calloc to (openvpn_plugin_handle_t)</div></div>

--001a113fe0faa42289054efad704--

