MIME-Version: 1.0
In-Reply-To: <99D61A626FDA8A4B90A270669121BE108580F7E3@...2294...>
References: <20171012072440.8704-1-simon@...2293...>
 <CAKuzo_jUnvMkHwHXZ=cAre-=z7WACU0b2qKV27FyymfBTncX=g@...278...>
 <99D61A626FDA8A4B90A270669121BE108580F7E3@...2294...>
From: Selva <selva.nair@...277...>
Date: Fri, 13 Oct 2017 13:48:45 -0400
Message-ID: <CAKuzo_jPU1rubUTtbq61PB0YgJyjaw7DREEwVeRV9XwQPMykEA@...278...>
Content-Type: multipart/alternative; boundary="94eb2c030f36e4c34d055b714539"
Subject: Re: [Openvpn-devel] [PATCH] Uniform snwprintf() across MinGW and
 MSVC compilers
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Simon Rozman <simon@...2293...>, =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--94eb2c030f36e4c34d055b714539
Content-Type: text/plain; charset="UTF-8"

Hi,

On Fri, Oct 13, 2017 at 12:55 AM, Simon Rozman <simon@...2293...> wrote:
...

>
> > As said above, I would have replaced all _snwprintf and snwprintf by
> > swprintf
> > and avoided the #define. That has the added advantage that mingw builds
> > also will no longer depend on the non-standard snwprintf.
>
> Are you sure MinGW supports swprintf() in an ISO C conformant way? People
> all
> over the web complain about MinGW's non-ISO C conformant swprintf()
> declaration being a legacy of VC 6.0 runtime library used:
> https://stackoverflow.com/questions/35072373/swprintf-declaration-mismatch
> As said before, I am not familiar with MinGW. I read OpenVPN has a patched
> version of it. Perhaps you moved to a more recent VC runtime library
> meanwhile.


> If we change _snwprintf/snwprintf() to swprintf() as you suggested, I am
> afraid OpenVPN would not compile on MinGW anymore without #define tweaks.
> But,
> this time MinGW will need them, not MSVC*2017*.


There are two issues here: sprintf signature in Windows runtime and
mingw-w64's  support for the standard conforming variant.

@samuli: Which versions of mingw-w64 should we test against to ensure
release and snapshot builds would succeed?

Windows runtime used to have an swprintf that does not take the buffer
size. But to get that non-conformant behaviour you will need some
preprocessor define like ....NON_CONFORMING_SWPRINTF... so hopefully
modern VS installations does pick the right function.

As for mingw, note that I use mingw-w64, not the older one from mingw.org.
In the former, my understanding is that an implementation based on
_vsnwprintf is used unless the above NON_CONFORMING.. define is active.

Probably there are some old mingw releases where this was broken ---
I'll test your latest patch. That said, I would not depend on any of these
for nul-termination, we should continue to append an explicit L'\0'.

Selva

--94eb2c030f36e4c34d055b714539
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><div class=3D"gmail_extra"><br></div><div class=3D"=
gmail_extra"><div class=3D"gmail_quote">On Fri, Oct 13, 2017 at 12:55 AM, S=
imon Rozman <span dir=3D"ltr">&lt;<a href=3D"mailto:simon@...2293..." targe=
t=3D"_blank">simon@...2293...</a>&gt;</span> wrote:</div><div class=3D"gmai=
l_quote">...</div><div class=3D"gmail_quote"><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">
<span><br>
&gt; As said above, I would have replaced all _snwprintf and snwprintf by<b=
r>
&gt; swprintf<br>
&gt; and avoided the #define. That has the added advantage that mingw build=
s<br>
&gt; also will no longer depend on the non-standard snwprintf.<br>
<br>
</span>Are you sure MinGW supports swprintf() in an ISO C conformant way? P=
eople all<br>
over the web complain about MinGW&#39;s non-ISO C conformant swprintf()<br>
declaration being a legacy of VC 6.0 runtime library used:<br>
<a href=3D"https://stackoverflow.com/questions/35072373/swprintf-declaratio=
n-mismatch" rel=3D"noreferrer" target=3D"_blank">https://stackoverflow.com/=
ques<wbr>tions/35072373/swprintf-declar<wbr>ation-mismatch</a><br>
As said before, I am not familiar with MinGW. I read OpenVPN has a patched<=
br>
version of it. Perhaps you moved to a more recent VC runtime library<br>
meanwhile.=C2=A0</blockquote><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">
<br>
If we change _snwprintf/snwprintf() to swprintf() as you suggested, I am<br>
afraid OpenVPN would not compile on MinGW anymore without #define tweaks. B=
ut,<br>
this time MinGW will need them, not MSVC*2017*.</blockquote><div><br></div>=
<div>There are two issues here: sprintf signature in Windows runtime and</d=
iv><div>mingw-w64&#39;s =C2=A0support for the standard conforming variant.<=
/div><div><br></div><div><div><div>@samuli: Which versions of mingw-w64 sho=
uld we test against to ensure</div><div>release and snapshot builds would s=
ucceed?</div></div></div><div><br></div><div>Windows runtime used to have a=
n swprintf that does not take the buffer=C2=A0</div><div>size. But to get t=
hat non-conformant behaviour you will need some</div><div>preprocessor defi=
ne like ....NON_CONFORMING_SWPRINTF... so hopefully</div><div>modern VS ins=
tallations does pick the right function.=C2=A0</div><div><br></div><div>As =
for mingw, note that I use mingw-w64, not the older one from=C2=A0<a href=
=3D"http://mingw.org" target=3D"_blank">mingw.org</a>.</div><div>In the for=
mer, my understanding is that an implementation based on=C2=A0</div><div>_v=
snwprintf is used unless the above NON_CONFORMING.. define is active.</div>=
<div><br></div><div>Probably there are some old mingw releases where this w=
as broken ---=C2=A0</div><div>I&#39;ll test your latest patch. That said, I=
 would not depend on any of these</div><div>for nul-termination, we should =
continue to append an explicit L&#39;\0&#39;.</div><div><br></div><div>Selv=
a</div></div></div></div>

--94eb2c030f36e4c34d055b714539--

