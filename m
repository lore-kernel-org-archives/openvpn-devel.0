MIME-Version: 1.0
In-Reply-To: <20171010231130.6832-12-simon@...2293...>
References: <20171010231130.6832-1-simon@...2293...>
 <20171010231130.6832-12-simon@...2293...>
From: Selva <selva.nair@...277...>
Date: Sat, 11 Nov 2017 11:43:11 -0500
Message-ID: <CAKuzo_jzkj2jNMODphaa6GSfyNtB7UiWhg5oEYHtBcCZ3rsBoQ@...278...>
Content-Type: multipart/alternative; boundary="001a114bc42ad4e41e055db7bc34"
Subject: Re: [Openvpn-devel] [PATCH 12/13] Memory size arithmetic reviewed
 according to 64-bit MSVC complaints
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

--001a114bc42ad4e41e055db7bc34
Content-Type: text/plain; charset="UTF-8"

Hi,

Some of these changes are of dubious value as the string lengths
involved are guaranteed to be small and there is no scope
for overflow. And casting only stops the compiler warning, not potential
overflow, if any..

As for the offending mixed int/size_t arithmetic, a better option is
to just to avoid the arithmetic -- code gets clearer and shorter too:

On Tue, Oct 10, 2017 at 7:11 PM, <simon@...2293...> wrote:

> From: Simon Rozman <simon@...2293...>
>
> ---
>  src/openvpnserv/automatic.c   | 14 ++++++++------
>  src/openvpnserv/interactive.c | 12 ++++++------
>  2 files changed, 14 insertions(+), 12 deletions(-)
>
> diff --git a/src/openvpnserv/automatic.c b/src/openvpnserv/automatic.c
> index 6c39aaa..3e8f6ed 100644
> --- a/src/openvpnserv/automatic.c
> +++ b/src/openvpnserv/automatic.c
> @@ -130,24 +130,26 @@ close_if_open(HANDLE h)
>  static bool
>  match(const WIN32_FIND_DATA *find, LPCTSTR ext)
>  {

-    int i;
> +    size_t i, len_filename, len_ext;
>

Instead, we can just get rid of these as below

     if (find->dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY)
>      {
>          return false;
>      }
>

The rest of this function (extension matching) may be made simpler
and hopefully easier to follow as

    if (*ext == TEXT('\0'))
    {
         return false;
    }

    /* find the pointer to that last '.' in filename and match ext against
the rest */

    const char *p = _tcsrchr(find->cFileName, TEXT('.'));
    return p && p != find->cFileName && !_tcsicmp(p+1, ext);
}

No _tcslen() and no offending size variables.


> -    if (!_tcslen(ext))
> +    len_ext = _tcslen(ext);
> +    if (!len_ext)
>      {
>          return true;
>      }
>
> -    i = _tcslen(find->cFileName) - _tcslen(ext) - 1;
> -    if (i < 1)
> +    len_filename = _tcslen(find->cFileName);
> +    if (len_filename < len_ext + 2)
>      {
>          return false;
>      }
>
> +    i = len_filename - len_ext - 1;
>      return find->cFileName[i] == '.' && !_tcsicmp(find->cFileName + i +
> 1, ext);

 }
>

And that convoluted original is then gone.


> @@ -157,14 +159,14 @@ match(const WIN32_FIND_DATA *find, LPCTSTR ext)
>  static bool
>  modext(LPTSTR dest, size_t size, LPCTSTR src, LPCTSTR newext)
>  {
> -    int i;
> +    size_t i;
>

OK

     if (size > 0 && (_tcslen(src) + 1) <= size)
>      {
>          _tcscpy(dest, src);
>          dest [size - 1] = TEXT('\0');
>          i = _tcslen(dest);
> -        while (--i >= 0)
> +        while (i-- > 0)

         {
>              if (dest[i] == TEXT('\\'))
>              {

diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
> index 96e0de0..9a4c01a 100644
> --- a/src/openvpnserv/interactive.c
> +++ b/src/openvpnserv/interactive.c
> @@ -280,7 +280,7 @@ ReturnProcessId(HANDLE pipe, DWORD pid, DWORD count,
> LPHANDLE events)
>      _snwprintf(buf, _countof(buf), L"0x%08x\n0x%08x\n%s", 0, pid, msg);
>      buf[_countof(buf) - 1] = '\0';
>
> -    WritePipeAsync(pipe, buf, wcslen(buf) * 2, count, events);
> +    WritePipeAsync(pipe, buf, (DWORD)(wcslen(buf) * 2), count, events);


Isn't this identical to the original automatic conversion from size_t to
DWORD?
An overly paranoid assert(_countof(buf) < MAXDWORD/2) may catch an extremely
unlikely future coding error, but in what way a cast safer?



 }
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
>

Same here.


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

OK


>
>      bytes = PeekNamedPipeAsync(pipe, 1, &exit_event);
>      if (bytes == 0)
> @@ -1163,7 +1163,7 @@ netsh_dns_cmd(const wchar_t *action, const wchar_t
> *proto, const wchar_t *if_nam
>      const wchar_t *fmt = L"netsh interface %s %s dns \"%s\" %s";
>
>      /* max cmdline length in wchars -- include room for worst case and
> some */
> -    int ncmdline = wcslen(fmt) + wcslen(if_name) + wcslen(addr) + 32 + 1;
> +    size_t ncmdline = wcslen(fmt) + wcslen(if_name) + wcslen(addr) + 32 +
> 1;
>

OK


>      wchar_t *cmdline = malloc(ncmdline*sizeof(wchar_t));
>      if (!cmdline)
>      {
> @@ -1683,7 +1683,7 @@ RunOpenvpn(LPVOID p)
>      {
>          DWORD written;
>          WideCharToMultiByte(CP_UTF8, 0, sud.std_input, -1, input,
> input_size, NULL, NULL);
> -        WriteFile(stdin_write, input, strlen(input), &written, NULL);
> +        WriteFile(stdin_write, input, (DWORD)strlen(input), &written,
> NULL);
>

As above..


>          free(input);
>      }
>
>
Thanks,

Selva

--001a114bc42ad4e41e055db7bc34
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><div class=3D"gmail_extra"><br></div><div class=3D"=
gmail_extra">Some of these changes are of dubious value as the string lengt=
hs</div><div class=3D"gmail_extra">involved are guaranteed to be small and =
there is no scope</div><div class=3D"gmail_extra">for overflow. And casting=
 only stops the compiler warning, not potential</div><div class=3D"gmail_ex=
tra">overflow, if any..</div><div class=3D"gmail_extra"><br></div><div clas=
s=3D"gmail_extra">As for the offending mixed int/size_t arithmetic, a bette=
r option is</div><div class=3D"gmail_extra">to just to avoid the arithmetic=
 -- code gets clearer and shorter too:</div><div class=3D"gmail_extra"><br>=
</div><div class=3D"gmail_extra"><div class=3D"gmail_quote">On Tue, Oct 10,=
 2017 at 7:11 PM,  <span dir=3D"ltr">&lt;<a href=3D"mailto:simon@...2293...=
" target=3D"_blank">simon@...2293...</a>&gt;</span> wrote:<br><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">From: Simon Rozman &lt;<a href=3D"mail=
to:simon@...2293..." target=3D"_blank">simon@...2293...</a>&gt;<br>
<br>
---<br>
=C2=A0src/openvpnserv/automatic.c=C2=A0 =C2=A0| 14 ++++++++------<br>
=C2=A0src/openvpnserv/interactive.c | 12 ++++++------<br>
=C2=A02 files changed, 14 insertions(+), 12 deletions(-)<br>
<br>
diff --git a/src/openvpnserv/automatic.c b/src/openvpnserv/automatic.c<br>
index 6c39aaa..3e8f6ed 100644<br>
--- a/src/openvpnserv/automatic.c<br>
+++ b/src/openvpnserv/automatic.c<br>
@@ -130,24 +130,26 @@ close_if_open(HANDLE h)<br>
=C2=A0static bool<br>
=C2=A0match(const WIN32_FIND_DATA *find, LPCTSTR ext)<br>
=C2=A0{=C2=A0</blockquote><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
-=C2=A0 =C2=A0 int i;<br>
+=C2=A0 =C2=A0 size_t i, len_filename, len_ext;<br></blockquote><div><br></=
div><div>Instead, we can just get rid of these as below</div><div><br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0if (find-&gt;dwFileAttributes &amp; FILE_ATTRIBUTE_DIRE=
CTORY)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
=C2=A0 =C2=A0 =C2=A0}<br></blockquote><div><br></div><div>The rest of this =
function (extension matching) may be made simpler</div><div>and hopefully e=
asier to follow as</div><div><br></div><div>=C2=A0 =C2=A0 if (*ext =3D=3D T=
EXT(&#39;\0&#39;))</div><div>=C2=A0 =C2=A0 {</div><div>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0return false;</div><div>=C2=A0 =C2=A0 }</div><div><br></div><=
div>=C2=A0 =C2=A0 /* find the pointer to that last &#39;.&#39; in filename =
and match ext against the rest */</div><div><br></div><div>=C2=A0 =C2=A0 co=
nst char *p =3D _tcsrchr(find-&gt;cFileName, TEXT(&#39;.&#39;));</div><div>=
=C2=A0 =C2=A0 return p &amp;&amp; p !=3D find-&gt;cFileName &amp;&amp; !_tc=
sicmp(p+1, ext);</div><div>}</div><div><br></div><div>No _tcslen() and no o=
ffending size variables.</div><div><br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">
<br>
-=C2=A0 =C2=A0 if (!_tcslen(ext))<br>
+=C2=A0 =C2=A0 len_ext =3D _tcslen(ext);<br>
+=C2=A0 =C2=A0 if (!len_ext)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return true;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 i =3D _tcslen(find-&gt;cFileName) - _tcslen(ext) - 1;<br>
-=C2=A0 =C2=A0 if (i &lt; 1)<br>
+=C2=A0 =C2=A0 len_filename =3D _tcslen(find-&gt;cFileName);<br>
+=C2=A0 =C2=A0 if (len_filename &lt; len_ext + 2)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
+=C2=A0 =C2=A0 i =3D len_filename - len_ext - 1;<br>
=C2=A0 =C2=A0 =C2=A0return find-&gt;cFileName[i] =3D=3D &#39;.&#39; &amp;&a=
mp; !_tcsicmp(find-&gt;cFileName + i + 1, ext);</blockquote><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">
=C2=A0}<br></blockquote><div><br></div><div>And that convoluted original is=
 then gone.</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex"><br>
@@ -157,14 +159,14 @@ match(const WIN32_FIND_DATA *find, LPCTSTR ext)<br>
=C2=A0static bool<br>
=C2=A0modext(LPTSTR dest, size_t size, LPCTSTR src, LPCTSTR newext)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 int i;<br>
+=C2=A0 =C2=A0 size_t i;<br></blockquote><div><br></div><div>OK</div><div><=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0if (size &gt; 0 &amp;&amp; (_tcslen(src) + 1) &lt;=3D s=
ize)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0_tcscpy(dest, src);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dest [size - 1] =3D TEXT(&#39;\0&#39;);<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i =3D _tcslen(dest);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 while (--i &gt;=3D 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 while (i-- &gt; 0)=C2=A0</blockquote><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (dest[i] =3D=3D TEXT(&#3=
9;\\&#39;))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{</blockquote><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">
diff --git a/src/openvpnserv/interactive.<wbr>c b/src/openvpnserv/interacti=
ve.<wbr>c<br>
index 96e0de0..9a4c01a 100644<br>
--- a/src/openvpnserv/interactive.<wbr>c<br>
+++ b/src/openvpnserv/interactive.<wbr>c<br>
@@ -280,7 +280,7 @@ ReturnProcessId(HANDLE pipe, DWORD pid, DWORD count, LP=
HANDLE events)<br>
=C2=A0 =C2=A0 =C2=A0_snwprintf(buf, _countof(buf), L&quot;0x%08x\n0x%08x\n%=
s&quot;, 0, pid, msg);<br>
=C2=A0 =C2=A0 =C2=A0buf[_countof(buf) - 1] =3D &#39;\0&#39;;<br>
<br>
-=C2=A0 =C2=A0 WritePipeAsync(pipe, buf, wcslen(buf) * 2, count, events);<b=
r>
+=C2=A0 =C2=A0 WritePipeAsync(pipe, buf, (DWORD)(wcslen(buf) * 2), count, e=
vents);</blockquote><div><br></div><div>Isn&#39;t this identical to the ori=
ginal automatic conversion from size_t to DWORD?</div><div>An overly parano=
id assert(_countof(buf) &lt; MAXDWORD/2) may catch an extremely</div><div>u=
nlikely future coding error, but in what way a cast safer?</div><div><br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">=C2=A0</blockquote><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">
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
unt, events);<br></blockquote><div><br></div><div>Same here.</div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0#ifdef UNICODE<br>
=C2=A0 =C2=A0 =C2=A0MsgToEventLog(MSG_FLAGS_ERROR<wbr>, result);<br>
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
+=C2=A0 =C2=A0 DWORD bytes, read;<br></blockquote><div><br></div><div>OK</d=
iv><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
=C2=A0 =C2=A0 =C2=A0bytes =3D PeekNamedPipeAsync(pipe, 1, &amp;exit_event);=
<br>
=C2=A0 =C2=A0 =C2=A0if (bytes =3D=3D 0)<br>
@@ -1163,7 +1163,7 @@ netsh_dns_cmd(const wchar_t *action, const wchar_t *p=
roto, const wchar_t *if_nam<br>
=C2=A0 =C2=A0 =C2=A0const wchar_t *fmt =3D L&quot;netsh interface %s %s dns=
 \&quot;%s\&quot; %s&quot;;<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* max cmdline length in wchars -- include room for wor=
st case and some */<br>
-=C2=A0 =C2=A0 int ncmdline =3D wcslen(fmt) + wcslen(if_name) + wcslen(addr=
) + 32 + 1;<br>
+=C2=A0 =C2=A0 size_t ncmdline =3D wcslen(fmt) + wcslen(if_name) + wcslen(a=
ddr) + 32 + 1;<br></blockquote><div><br></div><div>OK</div><div>=C2=A0</div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0wchar_t *cmdline =3D malloc(ncmdline*sizeof(wchar_t<wbr=
>));<br>
=C2=A0 =C2=A0 =C2=A0if (!cmdline)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
@@ -1683,7 +1683,7 @@ RunOpenvpn(LPVOID p)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DWORD written;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WideCharToMultiByte(CP_UTF8, 0, sud.std_i=
nput, -1, input, input_size, NULL, NULL);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 WriteFile(stdin_write, input, strlen(input), &=
amp;written, NULL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 WriteFile(stdin_write, input, (DWORD)strlen(in=
put), &amp;written, NULL);<br></blockquote><div><br></div><div>As above..</=
div><div>=C2=A0<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0free(input);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<span class=3D"m_2792988390416823077m_5558159874359295240m_8470299133570871=
556m_8856265837151638397m_6434295266320317594m_1582231105454850336gmail-m_-=
6650795910552092661HOEnZb"><font color=3D"#888888"><br></font></span></bloc=
kquote><div><br></div><div>Thanks,</div><div><br></div><div>Selva</div></di=
v></div></div>

--001a114bc42ad4e41e055db7bc34--

