MIME-Version: 1.0
References: <20191009143422.9419-3-a@...2181...>
 <201911062041.xA6KfP8R010468@...2054...>
 <CAGyAFMWBd2GzuZdBfTfGwROPw-hEzqSMUCUY3vrWENeqd1A46w@...278...>
 <20191107122743.GQ40538@...1296...>
 <CAGyAFMU5VAWDPuR7V3dTMKBsDbn2vgH61sgn6O9dtZNi-OTebQ@...278...>
In-Reply-To: <CAGyAFMU5VAWDPuR7V3dTMKBsDbn2vgH61sgn6O9dtZNi-OTebQ@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 7 Nov 2019 10:50:02 -0500
Message-ID: <CAKuzo_j0jGAbpNyfeud+Oco1vWLzgs0vUwvtTV2qztsY0=7A1A@...278...>
Content-Type: multipart/alternative; boundary="0000000000006838490596c39f56"
Subject: Re: [Openvpn-devel] [PATCH applied] Re: VLAN: add basic VLAN
 tagging support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>, Antonio Quartulli <a@...2181...>

--0000000000006838490596c39f56
Content-Type: text/plain; charset="UTF-8"

Hi

On Thu, Nov 7, 2019 at 7:43 AM Lev Stipakov <lstipakov@...277...> wrote:

> Hi,
>
>
>> I'm a bit unhappy with that one, as it changes behaviour for all
>> non-windows
>> builds (including all the openssl build output even if it succeeds).
>>
>
> The only place it changes behavior is this
>
>  install:
>    - if [ ! -z "${CHOST}" ]; then unset CC; fi
> -  - .travis/build-deps.sh > build-deps.log 2>&1 || (cat build-deps.log &&
> exit 1)
> +  - .travis/build-deps.sh
>
> I don't see it as an issue to print output when building dependencies. The
> reason why
> it is done is that travis aborts build if there is no output for more than
> 10 minutes.
>
>
>> Besides this, we need to fix this whole MSVC mess - all other platforms
>> are just done with "add new source file to the Makefile.ac" and done
>> (including mingw builds), and then MSVC is broken again, and this will
>> happen again and again.
>
>
>> Is there no reasonable way to build these project files from Makefile.ac?
>>
>
> I see no reasonable way. Selva, Simon - opinions?
>

Personally, I come from the Unix world, work on Windows only out of
necessity, and either avoid MSVC or leave it to others to figure out as far
as possible. So my opinion may not count for much.

That said, short of moving to a more Windows-friendly build system such as
CMake, I see no good options. But the status quo looks good enough to me --
i.e., just do a patch to fix the project files when you notice a missing
entry.

Selva

--0000000000006838490596c39f56
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi<br></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Thu, Nov 7, 2019 at 7:43 AM Lev Stipakov &=
lt;<a href=3D"mailto:lstipakov@...277...">lstipakov@...277...</a>&gt; wrote=
:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"lt=
r"><div dir=3D"ltr">Hi,</div><div class=3D"gmail_quote"><div>=C2=A0</div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">I&#39;m a bit unhappy with =
that one, as it changes behaviour for all non-windows<br>
builds (including all the openssl build output even if it succeeds).<br></b=
lockquote><div><br></div><div>The only place it changes behavior is this</d=
iv><div><br></div>=C2=A0install:<br>=C2=A0 =C2=A0- if [ ! -z &quot;${CHOST}=
&quot; ]; then unset CC; fi<br>- =C2=A0- .travis/build-deps.sh &gt; build-d=
eps.log 2&gt;&amp;1 || (cat build-deps.log &amp;&amp; exit 1)<br><div>+ =C2=
=A0- .travis/build-deps.sh</div><div><br></div><div>I don&#39;t see it as a=
n issue to print output when building dependencies. The reason why</div><di=
v>it is done is that travis aborts build if there is no output for more tha=
n 10 minutes.=C2=A0</div><div>=C2=A0<br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">
Besides this, we need to fix this whole MSVC mess - all other platforms<br>
are just done with &quot;add new source file to the Makefile.ac&quot; and d=
one<br>
(including mingw builds), and then MSVC is broken again, and this will<br>
happen again and again.=C2=A0 =C2=A0</blockquote><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">
<br>
Is there no reasonable way to build these project files from Makefile.ac?<b=
r></blockquote><div><br></div><div>I see no reasonable way. Selva, Simon - =
opinions?<br></div></div></div></blockquote><div><br></div><div>Personally,=
 I come from the Unix world, work on Windows only out of necessity, and eit=
her avoid MSVC or leave it to others to figure out as far as possible. So m=
y opinion may not count for much.</div><div><br></div><div>That said, short=
 of moving to a more Windows-friendly build system such as CMake, I see no =
good options. But the status quo looks good enough to me -- i.e., just do a=
 patch to fix the project files when you notice a missing entry.</div><div>=
<br></div><div>Selva<br></div><div><br></div><div><br></div></div></div>

--0000000000006838490596c39f56--

