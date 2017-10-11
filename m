MIME-Version: 1.0
In-Reply-To: <20171010231130.6832-4-simon@...2293...>
References: <20171010231130.6832-1-simon@...2293...>
 <20171010231130.6832-4-simon@...2293...>
From: Selva <selva.nair@...277...>
Date: Wed, 11 Oct 2017 11:50:22 -0400
Message-ID: <CAKuzo_iEKPgAgWkGq+c2FqbjDgOPviP0-LV7W6A+1jiRonag-A@...278...>
Content-Type: multipart/alternative; boundary="001a11406242dfbed6055b4762bd"
Subject: Re: [Openvpn-devel] [PATCH 04/13] Local functions are not supported
 in MSVC. Bummer.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Simon Rozman <simon@...2293...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a11406242dfbed6055b4762bd
Content-Type: text/plain; charset="UTF-8"

Hi,

On Tue, Oct 10, 2017 at 7:11 PM, <simon@...2293...> wrote:

> From: Simon Rozman <simon@...2293...>
>
> ---
>  src/openvpnserv/interactive.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
> index 2019d38..7ff45b1 100644
> --- a/src/openvpnserv/interactive.c
> +++ b/src/openvpnserv/interactive.c
> @@ -1891,6 +1891,11 @@ FreeWaitHandles(LPHANDLE h)
>      free(h);
>  }
>
> +static BOOL
> +CmpHandle(LPVOID item, LPVOID hnd)
> +{
> +    return item == hnd;
> +}
>
>  VOID WINAPI
>  ServiceStartInteractive(DWORD dwArgc, LPTSTR *lpszArgv)
> @@ -1901,11 +1906,6 @@ ServiceStartInteractive(DWORD dwArgc, LPTSTR
> *lpszArgv)
>      list_item_t *threads = NULL;
>      PHANDLE handles = NULL;
>      DWORD handle_count;
> -    BOOL
> -    CmpHandle(LPVOID item, LPVOID hnd)
> -    {
> -        return item == hnd;
> -    }
>
>      service = RegisterServiceCtrlHandlerEx(interactive_service.name,
> ServiceCtrlInteractive, &status);
>      if (!service)
>


Well, nested function is a GNU extension so we can't blame MSVC here..
We had more of these and removed by a previous patch but it keeps coming
back -- this one from me (commit 600dd9a16fc)

ACK.

--001a11406242dfbed6055b4762bd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,</div><div class=3D"gmail_ex=
tra"><br><div class=3D"gmail_quote">On Tue, Oct 10, 2017 at 7:11 PM,  <span=
 dir=3D"ltr">&lt;<a href=3D"mailto:simon@...2293..." target=3D"_blank">simo=
n@...2293...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">From: Simon Rozman &lt;<a href=3D"mailto:simon@...2293..." tar=
get=3D"_blank">simon@...2293...</a>&gt;<br>
<br>
---<br>
=C2=A0src/openvpnserv/interactive.c | 10 +++++-----<br>
=C2=A01 file changed, 5 insertions(+), 5 deletions(-)<br>
<br>
diff --git a/src/openvpnserv/interactive.<wbr>c b/src/openvpnserv/interacti=
ve.<wbr>c<br>
index 2019d38..7ff45b1 100644<br>
--- a/src/openvpnserv/interactive.<wbr>c<br>
+++ b/src/openvpnserv/interactive.<wbr>c<br>
@@ -1891,6 +1891,11 @@ FreeWaitHandles(LPHANDLE h)<br>
=C2=A0 =C2=A0 =C2=A0free(h);<br>
=C2=A0}<br>
<br>
+static BOOL<br>
+CmpHandle(LPVOID item, LPVOID hnd)<br>
+{<br>
+=C2=A0 =C2=A0 return item =3D=3D hnd;<br>
+}<br>
<br>
=C2=A0VOID WINAPI<br>
=C2=A0ServiceStartInteractive(DWORD dwArgc, LPTSTR *lpszArgv)<br>
@@ -1901,11 +1906,6 @@ ServiceStartInteractive(DWORD dwArgc, LPTSTR *lpszAr=
gv)<br>
=C2=A0 =C2=A0 =C2=A0list_item_t *threads =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0PHANDLE handles =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0DWORD handle_count;<br>
-=C2=A0 =C2=A0 BOOL<br>
-=C2=A0 =C2=A0 CmpHandle(LPVOID item, LPVOID hnd)<br>
-=C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return item =3D=3D hnd;<br>
-=C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0service =3D RegisterServiceCtrlHandlerEx(<a href=3D"htt=
p://interactive_service.name" rel=3D"noreferrer" target=3D"_blank">i<wbr>nt=
eractive_service.name</a>, ServiceCtrlInteractive, &amp;status);<br>
=C2=A0 =C2=A0 =C2=A0if (!service)<br></blockquote><div><br></div><div><br><=
/div><div>Well, nested function is a GNU extension so we can&#39;t blame MS=
VC here..=C2=A0</div><div>We had more of these and removed by a previous pa=
tch but it keeps coming back -- this one from me (commit=C2=A0600dd9a16fc)<=
br></div><div><br></div><div>ACK.</div></div></div></div>

--001a11406242dfbed6055b4762bd--

