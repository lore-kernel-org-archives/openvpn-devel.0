MIME-Version: 1.0
In-Reply-To: <cc1449bf-ae57-f598-51af-2d3a59c2da1d@...515...>
References: <20171012072440.8704-1-simon@...2293...>
 <CAKuzo_jUnvMkHwHXZ=cAre-=z7WACU0b2qKV27FyymfBTncX=g@...278...>
 <99D61A626FDA8A4B90A270669121BE108580F7E3@...2294...>
 <CAKuzo_jPU1rubUTtbq61PB0YgJyjaw7DREEwVeRV9XwQPMykEA@...278...>
 <cc1449bf-ae57-f598-51af-2d3a59c2da1d@...515...>
From: Selva <selva.nair@...277...>
Date: Mon, 16 Oct 2017 11:18:42 -0400
Message-ID: <CAKuzo_hDhQmqdB7fk_59b6QBScLp6jbOWUevDL9PvyX3Ty6mDA@...278...>
Content-Type: multipart/alternative; boundary="001a114f59a4d1f37b055bab86c7"
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
Cc: Simon Rozman <simon@...2293...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a114f59a4d1f37b055bab86c7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Oct 16, 2017 at 4:05 AM, Samuli Sepp=C3=A4nen <samuli@...515...> wr=
ote:

> On 13/10/2017 20:48, Selva wrote:
>
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

Thanks.

For the purpose of the present discussion (i.e., behaviour of fwprintf),
14.04 is ok.

Selva

--001a114f59a4d1f37b055bab86c7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,</div><div class=3D"gmail_ex=
tra"><br><div class=3D"gmail_quote">On Mon, Oct 16, 2017 at 4:05 AM, Samuli=
 Sepp=C3=A4nen <span dir=3D"ltr">&lt;<a href=3D"mailto:samuli@...515..." ta=
rget=3D"_blank">samuli@...515...</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex"><span>On 13/10/2017 20:48, Selva wrote:<br></span><div><div c=
lass=3D"m_3700458728655591434h5"><br>
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
=C2=A0 g++-mingw-w64 4.8.2<br></blockquote><div><br></div><div>Thanks.</div=
><div><br></div><div>For the purpose of the present discussion (i.e., behav=
iour of fwprintf), 14.04 is ok.</div><div><br></div><div>Selva</div></div><=
/div></div>

--001a114f59a4d1f37b055bab86c7--

