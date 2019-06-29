MIME-Version: 1.0
References: <CAKuzo_j6F2+_JxosdVF3iB4kzWsR7Wq2FT8Vgi9Cg3yvT_A1JQ@...278...>
 <20190628210334.GU1097@...1296...>
 <CAKuzo_ji9qNyc1vtQRhuuuYXgmpb6Qey2+L7GRqbhLNqbSwx9A@...278...>
 <20190629095732.GV1097@...1296...>
 <CAGyAFMVxD3+jZ+RR_U-x46Z89DV-feqyXcV599=SaogW-0Qgsw@...278...>
In-Reply-To: <CAGyAFMVxD3+jZ+RR_U-x46Z89DV-feqyXcV599=SaogW-0Qgsw@...278...>
From: Lev Stipakov <lstipakov@...277...>
Date: Sat, 29 Jun 2019 17:50:24 +0300
Message-ID: <CAGyAFMX8247tuQB7eaKFJiOJS+tXOiu3eMv5RJU6ZZmkugjeNg@...278...>
Content-Type: multipart/alternative; boundary="000000000000686f66058c7784af"
Subject: Re: [Openvpn-devel] Using AllowNonAdmin in the advanced options of
 tap adapter
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: Selva Nair <selva.nair@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000686f66058c7784af
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

That --allow-nonadmin functionality was included into commit 3c7f2f553 from
yeah 2005. Here is code from tap-win32/tapdrv.c from the same commit:

+#if ENABLE_NONADMIN
+       /* Read AllowNonAdmin setting from registry */
+       {
+         NDIS_STRING key =3D NDIS_STRING_CONST("AllowNonAdmin");
+         NdisReadConfiguration (&status, &parm, configHandle,
+                                &key, NdisParameterInteger);
+         if (status =3D=3D NDIS_STATUS_SUCCESS)
+           {
+             if (parm->ParameterType =3D=3D NdisParameterInteger)
+               {
+                 if (parm->ParameterData.IntegerData)
+                   {
+                       enable_non_admin =3D TRUE;
+                   }
+               }
+           }
+       }
+#endif

As you see, the current version posted by Selva is missing

  if (parm->ParameterData.IntegerData)

part.

So it seems for me that this feature has been degraded somewhere between
2005 and 2019.


la 29. kes=C3=A4k. 2019 klo 17.34 Lev Stipakov (lstipakov@...277...) kirjoi=
tti:

> Hi,
>
> So Lev's patch proposes to do service calls for wintun *and* tap6, and
>> do so "always"?  Or only if the registry key says so?
>>
>
> Yep, patch always opens wintun and tap6 via service no matter what
> registry key says.
>
> > For some reason that registry key appears to be doing nothing in
>> > current versions of tap-windows6. I know this is confusing...
>>
>> This sounds like a bug...
>>
>
> Indeed that registry key is confusing. If we fix it in tap6, won't we
> break existing setups, which open tap6
> from unprivileged process and do not use --allow-nonadmin?
>
> --
> -Lev
>


--=20
-Lev

--000000000000686f66058c7784af
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">That --allow-nonadmin functionality was included into comm=
it=C2=A03c7f2f553 from yeah 2005. Here is code from tap-win32/tapdrv.c from=
 the same commit:<div><br></div><div>+#if ENABLE_NONADMIN<br>+ =C2=A0 =C2=
=A0 =C2=A0 /* Read AllowNonAdmin setting from registry */<br>+ =C2=A0 =C2=
=A0 =C2=A0 {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 NDIS_STRING key =3D NDIS_STRI=
NG_CONST(&quot;AllowNonAdmin&quot;);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 NdisR=
eadConfiguration (&amp;status, &amp;parm, configHandle,<br>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0&amp;key, NdisParameterInteger);<br>+ =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 if (status =3D=3D NDIS_STATUS_SUCCESS)<br>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (p=
arm-&gt;ParameterType =3D=3D NdisParameterInteger)<br>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 if (parm-&gt;ParameterData.IntegerData)<br>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 enable_n=
on_admin =3D TRUE;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 }<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>=
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>+ =C2=A0 =C2=A0 =C2=A0 }<br>+#end=
if<br></div><div><br></div><div>As you see, the current version posted by S=
elva is missing</div><div><br></div><div>=C2=A0 if (parm-&gt;ParameterData.=
IntegerData)=C2=A0</div><div><br></div><div>part.</div><div><br></div><div>=
So it seems for me that this feature has been degraded somewhere between 20=
05 and 2019.</div><div>=C2=A0<br></div></div><br><div class=3D"gmail_quote"=
><div dir=3D"ltr" class=3D"gmail_attr">la 29. kes=C3=A4k. 2019 klo 17.34 Le=
v Stipakov (<a href=3D"mailto:lstipakov@...277...">lstipakov@...277...</a>)=
 kirjoitti:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div=
 dir=3D"ltr"><div dir=3D"ltr">Hi,</div><div dir=3D"ltr"><br></div><div clas=
s=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">So Lev&=
#39;s patch proposes to do service calls for wintun *and* tap6, and<br>
do so &quot;always&quot;?=C2=A0 Or only if the registry key says so?<br></b=
lockquote><div><br></div><div>Yep, patch always opens wintun and tap6 via s=
ervice no matter=C2=A0what</div><div>registry key says.</div><div><br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">&gt; For some reason tha=
t registry key appears to be doing nothing in<br>
&gt; current versions of tap-windows6. I know this is confusing...<br>
<br>
This sounds like a bug...<br></blockquote><div><br></div><div>Indeed that r=
egistry key is confusing. If we fix it in tap6, won&#39;t we break existing=
 setups, which open tap6</div><div>from unprivileged process and do not use=
 --allow-nonadmin?</div><div><br></div></div>-- <br><div dir=3D"ltr" class=
=3D"gmail-m_2202438022901483863gmail_signature">-Lev</div></div>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">-Lev</div>

--000000000000686f66058c7784af--

