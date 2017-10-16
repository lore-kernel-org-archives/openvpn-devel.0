MIME-Version: 1.0
In-Reply-To: <cc1449bf-ae57-f598-51af-2d3a59c2da1d@...515...>
References: <20171012072440.8704-1-simon@...2293...>
 <CAKuzo_jUnvMkHwHXZ=cAre-=z7WACU0b2qKV27FyymfBTncX=g@...278...>
 <99D61A626FDA8A4B90A270669121BE108580F7E3@...2294...>
 <CAKuzo_jPU1rubUTtbq61PB0YgJyjaw7DREEwVeRV9XwQPMykEA@...278...>
 <cc1449bf-ae57-f598-51af-2d3a59c2da1d@...515...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Mon, 16 Oct 2017 13:22:47 +0500
Message-ID: <CAFHpkQEgjmdRgMaOC-1-6vRqjYTUoC6fODtcx2yZt0DJUPGcsw@...278...>
Content-Type: multipart/alternative; boundary="001a114aa6d637f8b5055ba5b636"
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
To: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: Selva <selva.nair@...277...>, Simon Rozman <simon@...2293...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a114aa6d637f8b5055ba5b636
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2017-10-16 13:05 GMT+05:00 Samuli Sepp=C3=A4nen <samuli@...515...>:

> On 13/10/2017 20:48, Selva wrote:
> > Hi,
> >
> > On Fri, Oct 13, 2017 at 12:55 AM, Simon Rozman <simon@...2293...
> > <mailto:simon@...2293...>> wrote:
> > ...
> >
> >
> >     > As said above, I would have replaced all _snwprintf and snwprintf
> by
> >     > swprintf
> >     > and avoided the #define. That has the added advantage that mingw
> builds
> >     > also will no longer depend on the non-standard snwprintf.
> >
> >     Are you sure MinGW supports swprintf() in an ISO C conformant way?
> >     People all
> >     over the web complain about MinGW's non-ISO C conformant swprintf()
> >     declaration being a legacy of VC 6.0 runtime library used:
> >     https://stackoverflow.com/questions/35072373/swprintf-
> declaration-mismatch
> >     <https://stackoverflow.com/questions/35072373/swprintf-
> declaration-mismatch>
> >     As said before, I am not familiar with MinGW. I read OpenVPN has a
> >     patched
> >     version of it. Perhaps you moved to a more recent VC runtime library
> >     meanwhile.
> >
> >
> >     If we change _snwprintf/snwprintf() to swprintf() as you suggested,
> I am
> >     afraid OpenVPN would not compile on MinGW anymore without #define
> >     tweaks. But,
> >     this time MinGW will need them, not MSVC*2017*.
> >
> >
> > There are two issues here: sprintf signature in Windows runtime and
> > mingw-w64's  support for the standard conforming variant.
> >
> > @samuli: Which versions of mingw-w64 should we test against to ensure
> > release and snapshot builds would succeed?
>
> Right now _we_ use Ubuntu 16.04 for building:
>
>   mingw-w64 4.0.4
>   gcc-mingw-w64 5.3.1
>   g++-mingw-w64 5.3.1
>
> That said, I'm pretty sure many people still build with Ubuntu 14.04. So
> keeping support for it would make sense if it is not horribly painful.
> This is what Ubuntu 14.04 comes with:
>
>   mingw-w64 3.1.0
>   gcc-mingw-w64 4.8.2
>   g++-mingw-w64 4.8.2
>

I'm afraid, it's not possible to build openvpn with mingw-gcc-4.8.X due to
lack of firewall manipulation api
(that's why we use xenial repo during travis-ci build)


Samuli, can you please try to build on ubuntu 14.04 ? am I wrong ?


>
> Samuli
>
> >
> > Windows runtime used to have an swprintf that does not take the buffer
> > size. But to get that non-conformant behaviour you will need some
> > preprocessor define like ....NON_CONFORMING_SWPRINTF... so hopefully
> > modern VS installations does pick the right function.
> >
> > As for mingw, note that I use mingw-w64, not the older one
> > from mingw.org <http://mingw.org>.
> > In the former, my understanding is that an implementation based on
> > _vsnwprintf is used unless the above NON_CONFORMING.. define is active.
> >
> > Probably there are some old mingw releases where this was broken ---
> > I'll test your latest patch. That said, I would not depend on any of
> these
> > for nul-termination, we should continue to append an explicit L'\0'.
> >
> > Selva
>
> ------------------------------------------------------------
> ------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--001a114aa6d637f8b5055ba5b636
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2017-10-16 13:05 GMT+05:00 Samuli Sepp=C3=A4nen <span dir=3D"ltr">&lt;<=
a href=3D"mailto:samuli@...515..." target=3D"_blank">samuli@...515...</a>&g=
t;</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex"><span class=3D"">On 13/10/2017=
 20:48, Selva wrote:<br>
&gt; Hi,<br>
&gt;<br>
&gt; On Fri, Oct 13, 2017 at 12:55 AM, Simon Rozman &lt;<a href=3D"mailto:s=
imon@...2293...">simon@...2293...</a><br>
</span><div><div class=3D"h5">&gt; &lt;mailto:<a href=3D"mailto:simon@...2313...=
93...">simon@...2293...</a>&gt;&gt; wrote:<br>
&gt; ...<br>
&gt;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; As said above, I would have replaced all _snwp=
rintf and snwprintf by<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; swprintf<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; and avoided the #define. That has the added ad=
vantage that mingw builds<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; also will no longer depend on the non-standard=
 snwprintf.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Are you sure MinGW supports swprintf() in an ISO C =
conformant way?<br>
&gt;=C2=A0 =C2=A0 =C2=A0People all<br>
&gt;=C2=A0 =C2=A0 =C2=A0over the web complain about MinGW&#39;s non-ISO C c=
onformant swprintf()<br>
&gt;=C2=A0 =C2=A0 =C2=A0declaration being a legacy of VC 6.0 runtime librar=
y used:<br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"https://stackoverflow.com/questions/3507=
2373/swprintf-declaration-mismatch" rel=3D"noreferrer" target=3D"_blank">ht=
tps://stackoverflow.com/<wbr>questions/35072373/swprintf-<wbr>declaration-m=
ismatch</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"https://stackoverflow.com/questions/=
35072373/swprintf-declaration-mismatch" rel=3D"noreferrer" target=3D"_blank=
">https://stackoverflow.com/<wbr>questions/35072373/swprintf-<wbr>declarati=
on-mismatch</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0As said before, I am not familiar with MinGW. I rea=
d OpenVPN has a<br>
&gt;=C2=A0 =C2=A0 =C2=A0patched<br>
&gt;=C2=A0 =C2=A0 =C2=A0version of it. Perhaps you moved to a more recent V=
C runtime library<br>
&gt;=C2=A0 =C2=A0 =C2=A0meanwhile.=C2=A0<br>
&gt;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0If we change _snwprintf/snwprintf() to swprintf() a=
s you suggested, I am<br>
&gt;=C2=A0 =C2=A0 =C2=A0afraid OpenVPN would not compile on MinGW anymore w=
ithout #define<br>
&gt;=C2=A0 =C2=A0 =C2=A0tweaks. But,<br>
&gt;=C2=A0 =C2=A0 =C2=A0this time MinGW will need them, not MSVC*2017*.<br>
&gt;<br>
&gt;<br>
&gt; There are two issues here: sprintf signature in Windows runtime and<br>
&gt; mingw-w64&#39;s =C2=A0support for the standard conforming variant.<br>
&gt;<br>
&gt; @samuli: Which versions of mingw-w64 should we test against to ensure<=
br>
&gt; release and snapshot builds would succeed?<br>
<br>
</div></div>Right now _we_ use Ubuntu 16.04 for building:<br>
<br>
=C2=A0 mingw-w64 4.0.4<br>
=C2=A0 gcc-mingw-w64 5.3.1<br>
=C2=A0 g++-mingw-w64 5.3.1<br>
<br>
That said, I&#39;m pretty sure many people still build with Ubuntu 14.04. S=
o<br>
keeping support for it would make sense if it is not horribly painful.<br>
This is what Ubuntu 14.04 comes with:<br>
<br>
=C2=A0 mingw-w64 3.1.0<br>
=C2=A0 gcc-mingw-w64 4.8.2<br>
=C2=A0 g++-mingw-w64 4.8.2<br></blockquote><div><br></div><div>I&#39;m afra=
id, it&#39;s not possible to build openvpn with mingw-gcc-4.8.X due to lack=
 of firewall manipulation api<br></div><div>(that&#39;s why we use xenial r=
epo during travis-ci build)<br><br><br></div><div>Samuli, can you please tr=
y to build on ubuntu 14.04 ? am I wrong ?<br></div><div>=C2=A0</div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex">
<br>
Samuli<br>
<span class=3D""><br>
&gt;<br>
&gt; Windows runtime used to have an swprintf that does not take the buffer=
=C2=A0<br>
&gt; size. But to get that non-conformant behaviour you will need some<br>
&gt; preprocessor define like ....NON_CONFORMING_SWPRINTF... so hopefully<b=
r>
&gt; modern VS installations does pick the right function.=C2=A0<br>
&gt;<br>
&gt; As for mingw, note that I use mingw-w64, not the older one<br>
</span>&gt; from=C2=A0<a href=3D"http://mingw.org" rel=3D"noreferrer" targe=
t=3D"_blank">mingw.org</a> &lt;<a href=3D"http://mingw.org" rel=3D"noreferr=
er" target=3D"_blank">http://mingw.org</a>&gt;.<br>
<span class=3D"">&gt; In the former, my understanding is that an implementa=
tion based on=C2=A0<br>
&gt; _vsnwprintf is used unless the above NON_CONFORMING.. define is active=
.<br>
&gt;<br>
&gt; Probably there are some old mingw releases where this was broken ---=
=C2=A0<br>
&gt; I&#39;ll test your latest patch. That said, I would not depend on any =
of these<br>
&gt; for nul-termination, we should continue to append an explicit L&#39;\0=
&#39;.<br>
&gt;<br>
&gt; Selva<br>
<br>
</span>------------------------------<wbr>------------------------------<wb=
r>------------------<br>
Check out the vibrant tech community on one of the world&#39;s most<br>
engaging tech sites, Slashdot.org! <a href=3D"http://sdm.link/slashdot" rel=
=3D"noreferrer" target=3D"_blank">http://sdm.link/slashdot</a><br>
______________________________<wbr>_________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...2155...=
9...<wbr>sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/<wbr>lists/=
listinfo/openvpn-devel</a><br>
</blockquote></div><br></div></div>

--001a114aa6d637f8b5055ba5b636--

