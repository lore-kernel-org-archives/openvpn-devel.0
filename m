MIME-Version: 1.0
In-Reply-To: <20171113094952.33364-1-simon@...2293...>
References: <99D61A626FDA8A4B90A270669121BE108588B957@...2294...>
 <20171113094952.33364-1-simon@...2293...>
From: Selva <selva.nair@...277...>
Date: Mon, 13 Nov 2017 11:26:17 -0500
Message-ID: <CAKuzo_gscnr4Bfbtc15Wq2D2v7dk2GAqF1T_R-gikRqhbDgkbA@...278...>
Content-Type: multipart/alternative; boundary="94eb2c0381340de2ad055ddfbcb9"
Subject: Re: [Openvpn-devel] [PATCH v2] openvpnserv: Review MSVC
 down-casting warnings
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

--94eb2c0381340de2ad055ddfbcb9
Content-Type: text/plain; charset="UTF-8"

Hi,

Thanks for the v2

On Mon, Nov 13, 2017 at 4:49 AM, Simon Rozman <simon@...2293...> wrote:

> Data size arithmetic was reviewed according to 64-bit MSVC complaints.
>
> The warnings were addressed by migrating to size_t, rewriting the code,
> or silencing the warnings by an explicit cast where appropriate.
> ---
>  src/openvpnserv/automatic.c   | 20 ++++----------------
>  src/openvpnserv/interactive.c | 12 ++++++------
>  2 files changed, 10 insertions(+), 22 deletions(-)
>
> diff --git a/src/openvpnserv/automatic.c b/src/openvpnserv/automatic.c
> index 75c3be2..4d5501b 100644
> --- a/src/openvpnserv/automatic.c
> +++ b/src/openvpnserv/automatic.c
> @@ -115,25 +115,13 @@ close_if_open(HANDLE h)
>  static bool
>  match(const WIN32_FIND_DATA *find, LPCTSTR ext)
>  {
> -    int i;
> -
>      if (find->dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY)
>      {
>          return false;
>      }
>
> -    if (!_tcslen(ext))
> -    {
> -        return true;
> -    }
> -
> -    i = _tcslen(find->cFileName) - _tcslen(ext) - 1;
> -    if (i < 1)
> -    {
> -        return false;
> -    }
> -
> -    return find->cFileName[i] == '.' && !_tcsicmp(find->cFileName + i +
> 1, ext);
> +    const TCHAR *p = _tcsrchr(find->cFileName, TEXT('.'));
> +    return p && p != find->cFileName && _tcsicmp(p + 1, ext) == 0;


FWIW, ensuring the extension string is not empty seems to be required to
avoid a regression (see my reply to v1). A check for ext[0] != TEXT('\0')
should do the trick.

The rest looks good.

Selva

--94eb2c0381340de2ad055ddfbcb9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>Thanks for the v2<br><div class=3D"=
gmail_extra"><br><div class=3D"gmail_quote">On Mon, Nov 13, 2017 at 4:49 AM=
, Simon Rozman <span dir=3D"ltr">&lt;<a href=3D"mailto:simon@...2293..." ta=
rget=3D"_blank">simon@...2293...</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">Data size arithmetic was reviewed according to 64-bit MSVC co=
mplaints.<br>
<br>
The warnings were addressed by migrating to size_t, rewriting the code,<br>
or silencing the warnings by an explicit cast where appropriate.<br>
---<br>
=C2=A0src/openvpnserv/automatic.c=C2=A0 =C2=A0| 20 ++++----------------<br>
=C2=A0src/openvpnserv/interactive.c | 12 ++++++------<br>
=C2=A02 files changed, 10 insertions(+), 22 deletions(-)<br>
<br>
diff --git a/src/openvpnserv/automatic.c b/src/openvpnserv/automatic.c<br>
index 75c3be2..4d5501b 100644<br>
--- a/src/openvpnserv/automatic.c<br>
+++ b/src/openvpnserv/automatic.c<br>
@@ -115,25 +115,13 @@ close_if_open(HANDLE h)<br>
=C2=A0static bool<br>
=C2=A0match(const WIN32_FIND_DATA *find, LPCTSTR ext)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 int i;<br>
-<br>
=C2=A0 =C2=A0 =C2=A0if (find-&gt;dwFileAttributes &amp; FILE_ATTRIBUTE_DIRE=
CTORY)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 if (!_tcslen(ext))<br>
-=C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 i =3D _tcslen(find-&gt;cFileName) - _tcslen(ext) - 1;<br>
-=C2=A0 =C2=A0 if (i &lt; 1)<br>
-=C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 return find-&gt;cFileName[i] =3D=3D &#39;.&#39; &amp;&amp; !=
_tcsicmp(find-&gt;cFileName + i + 1, ext);<br>
+=C2=A0 =C2=A0 const TCHAR *p =3D _tcsrchr(find-&gt;cFileName, TEXT(&#39;.&=
#39;));<br>
+=C2=A0 =C2=A0 return p &amp;&amp; p !=3D find-&gt;cFileName &amp;&amp; _tc=
sicmp(p + 1, ext) =3D=3D 0;</blockquote><div><br></div><div>FWIW, ensuring =
the extension string is not empty seems to be required to</div><div>avoid a=
 regression (see my reply to v1). A check for ext[0] !=3D TEXT(&#39;\0&#39;=
)</div><div>should do the trick.</div><div><br></div><div>The rest looks go=
od.</div><div><br></div><div>Selva</div></div></div></div></div>

--94eb2c0381340de2ad055ddfbcb9--

