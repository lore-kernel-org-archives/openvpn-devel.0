MIME-Version: 1.0
In-Reply-To: <20171203203007.6628-1-simon@...2293...>
References: <20171203202051.7848-1-simon@...2293...>
 <20171203203007.6628-1-simon@...2293...>
From: Selva Nair <selva.nair@...277...>
Date: Sun, 3 Dec 2017 16:25:09 -0500
Message-ID: <CAKuzo_hEgxS0TQyXGQ4pjH8=Cs1okJ4ZfvDNp49OoGKhDUg_hA@...278...>
Content-Type: multipart/alternative; boundary="001a11490138b8fb35055f763d4f"
Subject: Re: [Openvpn-devel] [PATCH v5] openvpnserv: Review MSVC
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

--001a11490138b8fb35055f763d4f
Content-Type: text/plain; charset="UTF-8"

Hi,

This looks good now.

The v1 of this patch and main review comments are in a different thread:
https://sourceforge.net/p/openvpn/mailman/openvpn-devel/
thread/20171010231130.6832-12-simon%40rozman.si/#msg36071613

On Sun, Dec 3, 2017 at 3:30 PM, Simon Rozman <simon@...2293...> wrote:

> Data size arithmetic was reviewed according to 64-bit MSVC complaints.
>
> The warnings were addressed by migrating to size_t, rewriting the code,
> or silencing the warnings by an explicit cast where appropriate.
> ---
>  src/openvpnserv/automatic.c   | 17 ++++++-----------
>  src/openvpnserv/interactive.c | 12 ++++++------
>  2 files changed, 12 insertions(+), 17 deletions(-)
>
> diff --git a/src/openvpnserv/automatic.c b/src/openvpnserv/automatic.c
> index 75c3be2..6f82b4e 100644
> --- a/src/openvpnserv/automatic.c
> +++ b/src/openvpnserv/automatic.c
> @@ -115,25 +115,20 @@ close_if_open(HANDLE h)
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
> +    if (*ext == TEXT('\0'))
>      {
>          return true;

     }
>

Empty extension matching all files is somewhat strange but that's the
original behaviour (unlike I initially thought), and is preserved by the
patch.


>
> -    i = _tcslen(find->cFileName) - _tcslen(ext) - 1;
> -    if (i < 1)
> -    {
> -        return false;
> -    }
> +    /* find the pointer to that last '.' in filename and match ext
> against the rest */
>
> -    return find->cFileName[i] == '.' && !_tcsicmp(find->cFileName + i +
> 1, ext);
> +    const TCHAR *p = _tcsrchr(find->cFileName, TEXT('.'));
> +    return p && p != find->cFileName && _tcsicmp(p + 1, ext) == 0;
>  }
>
>  /*
> @@ -142,14 +137,14 @@ match(const WIN32_FIND_DATA *find, LPCTSTR ext)
>  static bool
>  modext(LPTSTR dest, int size, LPCTSTR src, LPCTSTR newext)
>  {
> -    int i;
> +    size_t i;
>
>      if (size > 0 && (_tcslen(src) + 1) <= size)
>      {
>          _tcscpy(dest, src);
>          dest [size - 1] = TEXT('\0');
>          i = _tcslen(dest);
> -        while (--i >= 0)
> +        while (i-- > 0)
>          {
>              if (dest[i] == TEXT('\\'))
>              {
> diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
> index ed4603e..5d58ceb 100644
> --- a/src/openvpnserv/interactive.c
> +++ b/src/openvpnserv/interactive.c
> @@ -280,7 +280,7 @@ ReturnProcessId(HANDLE pipe, DWORD pid, DWORD count,
> LPHANDLE events)
>      swprintf(buf, _countof(buf), L"0x%08x\n0x%08x\n%s", 0, pid, msg);
>      buf[_countof(buf) - 1] = '\0';
>
> -    WritePipeAsync(pipe, buf, wcslen(buf) * 2, count, events);
> +    WritePipeAsync(pipe, buf, (DWORD)(wcslen(buf) * 2), count, events);
>  }
>
>  static VOID
> @@ -308,7 +308,7 @@ ReturnError(HANDLE pipe, DWORD error, LPCWSTR func,
> DWORD count, LPHANDLE events
>                                  L"0x%1!08x!\n%2!s!\n%3!s!", 0, 0,
>                                  (LPWSTR) &result, 0, (va_list *) args);
>
> -    WritePipeAsync(pipe, result, wcslen(result) * 2, count, events);
> +    WritePipeAsync(pipe, result, (DWORD)(wcslen(result) * 2), count,
> events);
>  #ifdef UNICODE
>      MsgToEventLog(MSG_FLAGS_ERROR, result);
>  #else
> @@ -452,10 +452,10 @@ out:
>  static BOOL
>  GetStartupData(HANDLE pipe, STARTUP_DATA *sud)
>  {
> -    size_t len;
> +    size_t size, len;
>      BOOL ret = FALSE;
>      WCHAR *data = NULL;
> -    DWORD size, bytes, read;
> +    DWORD bytes, read;
>
>      bytes = PeekNamedPipeAsync(pipe, 1, &exit_event);
>      if (bytes == 0)
> @@ -1051,7 +1051,7 @@ netsh_dns_cmd(const wchar_t *action, const wchar_t
> *proto, const wchar_t *if_nam
>      const wchar_t *fmt = L"netsh interface %s %s dns \"%s\" %s";
>
>      /* max cmdline length in wchars -- include room for worst case and
> some */
> -    int ncmdline = wcslen(fmt) + wcslen(if_name) + wcslen(addr) + 32 + 1;
> +    size_t ncmdline = wcslen(fmt) + wcslen(if_name) + wcslen(addr) + 32 +
> 1;
>      wchar_t *cmdline = malloc(ncmdline*sizeof(wchar_t));
>      if (!cmdline)
>      {
> @@ -1571,7 +1571,7 @@ RunOpenvpn(LPVOID p)
>      {
>          DWORD written;
>          WideCharToMultiByte(CP_UTF8, 0, sud.std_input, -1, input,
> input_size, NULL, NULL);
> -        WriteFile(stdin_write, input, strlen(input), &written, NULL);
> +        WriteFile(stdin_write, input, (DWORD)strlen(input), &written,
> NULL);
>          free(input);
>      }
>

Cleaner and shorter code and should silence some pesky MSVC
warnings.

Acked-by: Selva Nair <selva.nair@...277...>

--001a11490138b8fb35055f763d4f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>This looks good now.</div><div><br>=
</div><div>The v1 of this patch and main review comments are in a different=
 thread:<br></div><div><a href=3D"https://sourceforge.net/p/openvpn/mailman=
/openvpn-devel/thread/20171010231130.6832-12-simon%40rozman.si/#msg36071613=
" target=3D"_blank">https://sourceforge.net/p/<wbr>openvpn/mailman/openvpn-=
devel/<wbr>thread/20171010231130.6832-12-<wbr>simon%40rozman.si/#msg3607161=
3</a><br></div><div><br></div><div><div class=3D"gmail_extra"><div class=3D=
"gmail_quote">On Sun, Dec 3, 2017 at 3:30 PM, Simon Rozman <span dir=3D"ltr=
">&lt;<a href=3D"mailto:simon@...2293..." target=3D"_blank">simon@...2359...=
.</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
"><span class=3D"m_6898804296425451684gmail-">Data size arithmetic was revi=
ewed according to 64-bit MSVC complaints.<br>
<br>
The warnings were addressed by migrating to size_t, rewriting the code,<br>
or silencing the warnings by an explicit cast where appropriate.<br>
---<br>
</span>=C2=A0src/openvpnserv/automatic.c=C2=A0 =C2=A0| 17 ++++++-----------=
<br>
=C2=A0src/openvpnserv/interactive.c | 12 ++++++------<br>
=C2=A02 files changed, 12 insertions(+), 17 deletions(-)<br>
<br>
diff --git a/src/openvpnserv/automatic.c b/src/openvpnserv/automatic.c<br>
index 75c3be2..6f82b4e 100644<br>
<span class=3D"m_6898804296425451684gmail-">--- a/src/openvpnserv/automatic=
.c<br>
+++ b/src/openvpnserv/automatic.c<br>
@@ -115,25 +115,20 @@ close_if_open(HANDLE h)<br>
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
</span><span class=3D"m_6898804296425451684gmail-">+=C2=A0 =C2=A0 if (*ext =
=3D=3D TEXT(&#39;\0&#39;))<br>
=C2=A0 =C2=A0 =C2=A0{<br>
</span>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return true;=C2=A0</blockquote><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">
<span class=3D"m_6898804296425451684gmail-">=C2=A0 =C2=A0 =C2=A0}<br></span=
></blockquote><div><br></div><div>Empty extension matching all files is som=
ewhat strange but that&#39;s the</div><div>original behaviour (unlike I ini=
tially thought), and is preserved by the patch.</div><div>=C2=A0</div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex"><span class=3D"m_6898804296425=
451684gmail-">
<br>
-=C2=A0 =C2=A0 i =3D _tcslen(find-&gt;cFileName) - _tcslen(ext) - 1;<br>
-=C2=A0 =C2=A0 if (i &lt; 1)<br>
</span><span class=3D"m_6898804296425451684gmail-">-=C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
-=C2=A0 =C2=A0 }<br>
</span><span class=3D"m_6898804296425451684gmail-">+=C2=A0 =C2=A0 /* find t=
he pointer to that last &#39;.&#39; in filename and match ext against the r=
est */<br>
<br>
-=C2=A0 =C2=A0 return find-&gt;cFileName[i] =3D=3D &#39;.&#39; &amp;&amp; !=
_tcsicmp(find-&gt;cFileName + i + 1, ext);<br>
</span><div><div class=3D"m_6898804296425451684gmail-h5">+=C2=A0 =C2=A0 con=
st TCHAR *p =3D _tcsrchr(find-&gt;cFileName, TEXT(&#39;.&#39;));<br>
+=C2=A0 =C2=A0 return p &amp;&amp; p !=3D find-&gt;cFileName &amp;&amp; _tc=
sicmp(p + 1, ext) =3D=3D 0;<br>
=C2=A0}<br>
<br>
=C2=A0/*<br>
@@ -142,14 +137,14 @@ match(const WIN32_FIND_DATA *find, LPCTSTR ext)<br>
=C2=A0static bool<br>
=C2=A0modext(LPTSTR dest, int size, LPCTSTR src, LPCTSTR newext)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 int i;<br>
+=C2=A0 =C2=A0 size_t i;<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (size &gt; 0 &amp;&amp; (_tcslen(src) + 1) &lt;=3D s=
ize)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0_tcscpy(dest, src);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dest [size - 1] =3D TEXT(&#39;\0&#39;);<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i =3D _tcslen(dest);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 while (--i &gt;=3D 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 while (i-- &gt; 0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (dest[i] =3D=3D TEXT(&#3=
9;\\&#39;))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
diff --git a/src/openvpnserv/interactive.<wbr>c b/src/openvpnserv/interacti=
ve.<wbr>c<br>
index ed4603e..5d58ceb 100644<br>
--- a/src/openvpnserv/interactive.<wbr>c<br>
+++ b/src/openvpnserv/interactive.<wbr>c<br>
@@ -280,7 +280,7 @@ ReturnProcessId(HANDLE pipe, DWORD pid, DWORD count, LP=
HANDLE events)<br>
=C2=A0 =C2=A0 =C2=A0swprintf(buf, _countof(buf), L&quot;0x%08x\n0x%08x\n%s&=
quot;, 0, pid, msg);<br>
=C2=A0 =C2=A0 =C2=A0buf[_countof(buf) - 1] =3D &#39;\0&#39;;<br>
<br>
-=C2=A0 =C2=A0 WritePipeAsync(pipe, buf, wcslen(buf) * 2, count, events);<b=
r>
+=C2=A0 =C2=A0 WritePipeAsync(pipe, buf, (DWORD)(wcslen(buf) * 2), count, e=
vents);<br>
=C2=A0}<br>
<br>
=C2=A0static VOID<br>
@@ -308,7 +308,7 @@ ReturnError(HANDLE pipe, DWORD error, LPCWSTR func, DWO=
RD count, LPHANDLE events<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0L&quot;0x%1!08x!\n%2!s!\n%3!s!=
&quot;, 0, 0,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(LPWSTR) &amp;result, 0, (va_l=
ist *) args);<br>
<br>
-=C2=A0 =C2=A0 WritePipeAsync(pipe, result, wcslen(result) * 2, count, even=
ts);<br>
+=C2=A0 =C2=A0 WritePipeAsync(pipe, result, (DWORD)(wcslen(result) * 2), co=
unt, events);<br>
=C2=A0#ifdef UNICODE<br>
=C2=A0 =C2=A0 =C2=A0MsgToEventLog(MSG_FLAGS_<wbr>ERROR, result);<br>
=C2=A0#else<br>
@@ -452,10 +452,10 @@ out:<br>
=C2=A0static BOOL<br>
=C2=A0GetStartupData(HANDLE pipe, STARTUP_DATA *sud)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 size_t len;<br>
+=C2=A0 =C2=A0 size_t size, len;<br>
=C2=A0 =C2=A0 =C2=A0BOOL ret =3D FALSE;<br>
=C2=A0 =C2=A0 =C2=A0WCHAR *data =3D NULL;<br>
-=C2=A0 =C2=A0 DWORD size, bytes, read;<br>
+=C2=A0 =C2=A0 DWORD bytes, read;<br>
<br>
=C2=A0 =C2=A0 =C2=A0bytes =3D PeekNamedPipeAsync(pipe, 1, &amp;exit_event);=
<br>
=C2=A0 =C2=A0 =C2=A0if (bytes =3D=3D 0)<br>
@@ -1051,7 +1051,7 @@ netsh_dns_cmd(const wchar_t *action, const wchar_t *p=
roto, const wchar_t *if_nam<br>
=C2=A0 =C2=A0 =C2=A0const wchar_t *fmt =3D L&quot;netsh interface %s %s dns=
 \&quot;%s\&quot; %s&quot;;<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* max cmdline length in wchars -- include room for wor=
st case and some */<br>
-=C2=A0 =C2=A0 int ncmdline =3D wcslen(fmt) + wcslen(if_name) + wcslen(addr=
) + 32 + 1;<br>
+=C2=A0 =C2=A0 size_t ncmdline =3D wcslen(fmt) + wcslen(if_name) + wcslen(a=
ddr) + 32 + 1;<br>
=C2=A0 =C2=A0 =C2=A0wchar_t *cmdline =3D malloc(ncmdline*sizeof(wchar_t<wbr=
>));<br>
=C2=A0 =C2=A0 =C2=A0if (!cmdline)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
@@ -1571,7 +1571,7 @@ RunOpenvpn(LPVOID p)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DWORD written;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WideCharToMultiByte(CP_UTF8, 0, sud.std_i=
nput, -1, input, input_size, NULL, NULL);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 WriteFile(stdin_write, input, strlen(input), &=
amp;written, NULL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 WriteFile(stdin_write, input, (DWORD)strlen(in=
put), &amp;written, NULL);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0free(input);<br>
=C2=A0 =C2=A0 =C2=A0}<br></div></div></blockquote><div><br></div><div>Clean=
er and shorter code and should silence some pesky MSVC</div><div>warnings.<=
/div><div><br></div><div>Acked-by: Selva Nair &lt;<a href=3D"mailto:selva.n=
air@...277..." target=3D"_blank">selva.nair@...277...</a>&gt;</div></div></=
div></div></div>

--001a11490138b8fb35055f763d4f--

