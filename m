MIME-Version: 1.0
References: <20230124142316.441-1-lstipakov@...277...>
In-Reply-To: <20230124142316.441-1-lstipakov@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 24 Jan 2023 13:11:20 -0500
Message-ID: <CAKuzo_ieXKQyB68qp3HtwHFTDkrhN1mKfNsoPW8seYcNrDCKZA@...278...>
Content-Type: multipart/alternative; boundary="00000000000048579005f30672e3"
Subject: Re: [Openvpn-devel] [PATCH] openvpnmsica: fix adapters discovery
 logic for DCO
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net, Lev Stipakov <lev@...515...>

--00000000000048579005f30672e3
Content-Type: text/plain; charset="UTF-8"

Hi,

On Tue, Jan 24, 2023 at 9:25 AM Lev Stipakov <lstipakov@...277...> wrote:

> From: Lev Stipakov <lev@...515...>
>
> Custom action "FindSystemInfo" finds adapters with certain hwid and
> assigns found adapters' guids to a certain property. Later another custom
> action "EvaluateTUNTAPAdapters" schedules adapter creation if the
> abovementioned property is not set - which means no adapters exist
> with given hwid.
>
> I think this logic is needed to prevent duplicate adapter creation
> if adapter was renamed and then new version is installed.
>

Is the driver still always updated (i.e., when update required) even if the
adapter is not created because of existing ones found?

Can we add an adapter creation to iservice so that openvp.exe can create
adapters on the fly? An alternative is for the GUI to catch the "no
adapters" error and offer to create one. But that would work only for users
who can elevate and is less opaque to the user.

As we support multiple connections and default to DCO, auto-creating at
least DCO adapters will be an improvement.

If we just fix a typo, OpenVPN-GUI won't create a adapter on step 2 and
> after Connect removal on step 3 there won't be DCO adapters anymore
> for OpenVPN-GUI to use.
>

Can the "Connect team" be convinced to use a different hwid for the
adapter? Using a name to distinguish between adapters installed by
different packages doesn't look very robust.

That said, the quick-fix looks good to me.. I did not test it though.

+        /* exclude adapters created by OpenVPN Connect, since they're
> removed on Connect uninstallation */
> +        if (_tcsstr(pAdapter->szName, OPENVPN_CONNECT_ADAPTER_SUBSTR))

+        {
> +            msg(M_WARN, "%s: skip OpenVPN Connect adapter '%ls'",
> __FUNCTION__, pAdapter->szName);
>

M_INFO may be enough here?


> +            continue;
> +        }
> +
>          /* Convert adapter GUID to UTF-16 string. (LPOLESTR defaults to
> LPWSTR) */
>          LPOLESTR szAdapterId = NULL;
>          StringFromIID((REFIID)&pAdapter->guid, &szAdapterId);
> @@ -316,7 +325,7 @@ FindSystemInfo(_In_ MSIHANDLE hInstall)
>      find_adapters(
>          hInstall,
>          TEXT("ovpn-dco") TEXT("\0"),
> -        TEXT("OVPNDCOAPTERS"),
> +        TEXT("OVPNDCOADAPTERS"),
>          TEXT("ACTIVEOVPNDCOADAPTERS"));


>      if (bIsCoInitialized)


Acked-by Selva Nair <selva.nair@...277...>

Selva

--00000000000048579005f30672e3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><br><div class=3D"gmail_quote"><div dir=3D"l=
tr" class=3D"gmail_attr">On Tue, Jan 24, 2023 at 9:25 AM Lev Stipakov &lt;<=
a href=3D"mailto:lstipakov@...277..." target=3D"_blank">lstipakov@...277...=
</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
From: Lev Stipakov &lt;<a href=3D"mailto:lev@...515..." target=3D"_blank">l=
ev@...515...</a>&gt;<br>
<br>
Custom action &quot;FindSystemInfo&quot; finds adapters with certain hwid a=
nd<br>
assigns found adapters&#39; guids to a certain property. Later another cust=
om<br>
action &quot;EvaluateTUNTAPAdapters&quot; schedules adapter creation if the=
<br>
abovementioned property is not set - which means no adapters exist<br>
with given hwid.<br>
<br>
I think this logic is needed to prevent duplicate adapter creation<br>
if adapter was renamed and then new version is installed.<br></blockquote><=
div><br></div><div>Is the driver still always updated (i.e., when update re=
quired) even if the adapter is not created because of existing=C2=A0ones fo=
und?</div><div><br></div><div>Can we add an adapter creation to iservice so=
 that openvp.exe can create adapters on the fly? An alternative is for the =
GUI to catch the &quot;no adapters&quot; error and offer to create one. But=
 that would work only for users who can elevate and is less opaque to the u=
ser.=C2=A0</div><div><br></div><div>As we support multiple connections and =
default to DCO, auto-creating at least DCO adapters will be an improvement.=
</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">If w=
e just fix a typo, OpenVPN-GUI won&#39;t create a adapter on step 2 and<br>
after Connect removal on step 3 there won&#39;t be DCO adapters anymore<br>
for OpenVPN-GUI to use.<br></blockquote><div><br></div><div>Can the &quot;C=
onnect team&quot; be convinced to use a different hwid for the adapter? Usi=
ng a name to distinguish between adapters installed by different packages d=
oesn&#39;t look very robust.</div><div><br></div><div>That said, the quick-=
fix looks good to me.. I did not test it though.</div><div><br></div></div>=
<div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* exclude adapters created by OpenVPN Conne=
ct, since they&#39;re removed on Connect uninstallation */<br>+=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 if (_tcsstr(pAdapter-&gt;szName, OPENVPN_CONNECT_ADAPTER_=
SUBSTR))=C2=A0</blockquote><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 msg(M_WARN, &quot;%s: skip OpenVPN Connect adapter &#39;%ls&#39;&quot;,=
 __FUNCTION__, pAdapter-&gt;szName);<br></blockquote><div><br></div><div>M_=
INFO=C2=A0may be enough here?</div><div>=C2=A0</div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 conti=
nue;<br>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>+<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0/* Convert adapter GUID to UTF-16 string. (LPOLESTR defaults to LPWST=
R) */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0LPOLESTR szAdapterId =3D NULL;<b=
r>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0StringFromIID((REFIID)&amp;pAdapter-&gt=
;guid, &amp;szAdapterId);<br>@@ -316,7 +325,7 @@ FindSystemInfo(_In_ MSIHAN=
DLE hInstall)<br>=C2=A0 =C2=A0 =C2=A0find_adapters(<br>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0hInstall,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TEXT(&quot;ovp=
n-dco&quot;) TEXT(&quot;\0&quot;),<br>-=C2=A0 =C2=A0 =C2=A0 =C2=A0 TEXT(&qu=
ot;OVPNDCOAPTERS&quot;),<br>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 TEXT(&quot;OVPNDCO=
ADAPTERS&quot;),<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TEXT(&quot;ACTIVEOVPN=
DCOADAPTERS&quot;));</blockquote><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex"><br>=C2=A0 =C2=A0 =C2=A0if (bIsCoInitialized)</blockquote><div><br>=
</div><div>Acked-by Selva Nair &lt;<a href=3D"mailto:selva.nair@...277..." =
target=3D"_blank">selva.nair@...277...</a>&gt;</div><div><br></div><div>Sel=
va</div></div></div>

--00000000000048579005f30672e3--

