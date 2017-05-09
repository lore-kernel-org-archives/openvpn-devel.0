MIME-Version: 1.0
In-Reply-To: <55a3770f-be19-4f37-bd29-c8d9f7f47088@...2080...>
References: <20170508141939.31224-1-davids@...515...>
	<CAKuzo_jU+ufz5vkLKdzbf5637hF8bPRNrV3q4Ttq+5YQBqWGtA@...278...>
	<55a3770f-be19-4f37-bd29-c8d9f7f47088@...2080...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 8 May 2017 22:40:27 -0400
Message-ID: <CAKuzo_jktqSrKfGvQ0=uMr=3jHVaNjSgVbAwayxSMbeE+Jey4w@...278...>
Content-Type: multipart/alternative; boundary=94eb2c059dfe874907054f0e4899
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
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--94eb2c059dfe874907054f0e4899
Content-Type: text/plain; charset=UTF-8

Hi,

On Mon, May 8, 2017 at 10:57 AM, David Sommerseth <
openvpn@...2080...> wrote:

> On 08/05/17 16:38, Selva Nair wrote:
> > Hi,
> >
>
On Mon, May 8, 2017 at 10:19 AM, David Sommerseth <davids@...515...>
>>  wrote:
>>   *
>>   * STRUCT MEMBERS
>>   *
>> - * *type_mask : The plug-in should set this value to the logical OR of
>> all script
>> + * type_mask  : The plug-in should set this value to the logical OR of
>> all script
>>   *              types which the plug-in wants to intercept.  For
>> example, if the
>>   *              script wants to intercept the client-connect and
>> client-disconnect
>>   *              script types:
>>   *
>> - *              *type_mask = OPENVPN_PLUGIN_MASK(OPENVPN_PL
>> UGIN_CLIENT_CONNECT)
>> + *              type_mask = OPENVPN_PLUGIN_MASK(OPENVPN_PL
>> UGIN_CLIENT_CONNECT)
>>   *                         | OPENVPN_PLUGIN_MASK(OPENVPN_PL
>> UGIN_CLIENT_DISCONNECT)
>>   *
>>   * *handle :    Pointer to a global plug-in context, created by the
>> plug-in.  This pointer
>
>

>
> >
> > Asking to set *handle to context_ptr is wrong too. One can't
> > dereference handle. So it will have to be interpreted as set handle
> > to pointer to pointer to the context but that is wrong.
> >
> > But as discussed in the other thread I think we should also change
> > the definition of handle in this struct.
> >
> > Reference to *handle in line 390 needs correction too (comment only
> > -- struct is fine).
>
> Yes, I saw that, but thought we should fix that when we know what is
> the right solution for the *handle vs handle.   Just to keep things
> separate.


OK, that makes sense.  Then this is good to go.

ACK.

Selva

--94eb2c059dfe874907054f0e4899
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,</div><div class=3D"gmail_ex=
tra"><br><div class=3D"gmail_quote">On Mon, May 8, 2017 at 10:57 AM, David =
Sommerseth <span dir=3D"ltr">&lt;<a href=3D"mailto:openvpn@...2080..." targ=
et=3D"_blank">openvpn@...2080...</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex"><span class=3D"gmail-">On 08/05/17 16:38, =
Selva Nair wrote:<br>
&gt; Hi,<br>
&gt;<br>
</span></blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex"><span style=3D"color:rgb(80,0,=
80);font-size:12.8px">On Mon, May 8, 2017 at 10:19 AM, David Sommerseth=C2=
=A0</span><span dir=3D"ltr" style=3D"color:rgb(80,0,80);font-size:12.8px">&=
lt;<a href=3D"mailto:davids@...515..." target=3D"_blank">davids@...515...</=
a>&gt;</span><span style=3D"color:rgb(80,0,80);font-size:12.8px">=C2=A0wrot=
e:<br></span>=C2=A0 *<br>=C2=A0 * STRUCT MEMBERS<br>=C2=A0 *<br>- * *type_m=
ask : The plug-in should set this value to the logical OR of all script<br>=
+ * type_mask=C2=A0 : The plug-in should set this value to the logical OR o=
f all script<br>=C2=A0 *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ty=
pes which the plug-in wants to intercept.=C2=A0 For example, if the<br>=C2=
=A0 *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 script wants to inter=
cept the client-connect and client-disconnect<br>=C2=A0 *=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 script types:<br>=C2=A0 *<br>- *=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *type_mask =3D OPENVPN_PLUGIN_MASK(O=
PENVPN_PL<wbr>UGIN_CLIENT_CONNECT)<br>+ *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 type_mask =3D OPENVPN_PLUGIN_MASK(OPENVPN_PL<wbr>UGIN_CLIENT=
_CONNECT)<br>=C2=A0 *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| OPENVPN_PLUGIN_MASK(OPENVPN_PL<wbr>=
UGIN_CLIENT_DISCONNECT)<br>=C2=A0 *<br><span style=3D"color:rgb(80,0,80);fo=
nt-size:12.8px">=C2=A0 * *handle :=C2=A0 =C2=A0 Pointer to a global plug-in=
 context, created by the plug-in.=C2=A0 This pointer</span>=C2=A0</blockquo=
te>=C2=A0</blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><sp=
an class=3D"gmail-">
&gt;<br>
&gt;<br>
&gt; Asking to set *handle to context_ptr is wrong too. One can&#39;t<br>
&gt; dereference handle. So it will have to be interpreted as set handle<br>
&gt; to pointer to pointer to the context but that is wrong.<br>
&gt;<br>
&gt; But as discussed in the other thread I think we should also change<br>
&gt; the definition of handle in this struct.<br>
&gt;<br>
&gt; Reference to *handle in line 390 needs correction too (comment only<br>
&gt; -- struct is fine).<br>
<br>
</span>Yes, I saw that, but thought we should fix that when we know what is=
<br>
the right solution for the *handle vs handle.=C2=A0 =C2=A0Just to keep thin=
gs<br>
separate.</blockquote></div><div class=3D"gmail_extra"><br></div>OK, that m=
akes sense.=C2=A0 Then this is good to go.</div><div class=3D"gmail_extra">=
<br></div><div class=3D"gmail_extra">ACK.<br><br></div><div class=3D"gmail_=
extra">Selva</div></div>

--94eb2c059dfe874907054f0e4899--

