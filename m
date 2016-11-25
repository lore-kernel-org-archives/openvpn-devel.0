MIME-Version: 1.0
In-Reply-To: <20161125152710.GA81859@...1296...>
References: <CAFHpkQEkvbq1AGSYN-kYqfDjMbUXJhe1gysp4g6s1EOQku6JOQ@...278...>
	<20161116184717.GL28918@...1296...>
	<CAFHpkQHaDiP9Wk49ja3p_Oix=1fAtANzpqmPbT6hLZw6FVqLiw@...278...>
	<CAFHpkQHdgDAELAHwkYysyyGf5_sGFO-bkCuSVY=zwPKz1pLOwQ@...278...>
	<20161121194602.GR28918@...1296...>
	<CAFHpkQEFma=G_K3Y4FN+=vVSEQgyUySrR9HxBa6JejhimQxiNg@...278...>
	<CAFHpkQF7GtEXhaHBm-nRmHzcQ-cpsJt=MZM+h_1N4kORHERKeA@...278...>
	<CAKuzo_iEXGcuf1tt9zQh8dh42C5BX=jNoROXc_=CV-sOsBsW1w@...278...>
	<CAFHpkQFdVasrVF6Km_AnVwZL7QhGy1AAJAEeyiX7yt_Cq7R2Nw@...278...>
	<CAKuzo_h3kza0fftPTOc9vqhy=sSgTuOZXL=qzV3e29yhhpY8mA@...278...>
	<20161125152710.GA81859@...1296...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Fri, 25 Nov 2016 20:35:18 +0500
Message-ID: <CAFHpkQFuFPvQaom1eyqOU_pAAd3=Ys-n6FHkPmkdTmQQd1K-eg@...278...>
Content-Type: multipart/alternative; boundary=001a11466fd698d4b2054221de64
Subject: Re: [Openvpn-devel] launch openvpn-gui at windows startup
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a11466fd698d4b2054221de64
Content-Type: text/plain; charset=UTF-8

2016-11-25 20:27 GMT+05:00 Gert Doering <gert@...1296...>:

> Hi,
>
> On Fri, Nov 25, 2016 at 09:38:31AM -0500, Selva Nair wrote:
> > Even if the GUI cjecks HKLM and HKCU, toggling the option will not work
> as
> > the GUI cannot reset HKLM values. We do not want to be requiring admin
> > rights to run the GUI and that option becomes "readonly" for the user if
> > startup is set in HKLM.
>
> How do other packagages handle "this is the system default, but users
> can change their own setting"?  (So the admin could say "I want this
> started
> by default, for all users" and individual users can uncheck this "leave
> me alone!")
>
> Just thinking aloud, no idea how much effort this is, and whether it's
> a useful consideration in the first place.
>

as a perfect solution, we can add 2 choices to installer

(*) run on startup (current user)
(*) run on startup (all users)

and handle both in openvpn-gui.

but it seems to be complicated.


>
> gert
>
> --
> USENET is *not* the non-clickable part of WWW!
>                                                            //
> www.muc.de/~gert/
> Gert Doering - Munich, Germany
> gert@...1296...
> fax: +49-89-35655025                        gert@...1816...
> muenchen.de
>

--001a11466fd698d4b2054221de64
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2016-11-25 20:27 GMT+05:00 Gert Doering <span dir=3D"ltr">&lt;<a href=
=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1296...</a>&gt;</span=
>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex">Hi,<br>
<span class=3D""><br>
On Fri, Nov 25, 2016 at 09:38:31AM -0500, Selva Nair wrote:<br>
&gt; Even if the GUI cjecks HKLM and HKCU, toggling the option will not wor=
k as<br>
&gt; the GUI cannot reset HKLM values. We do not want to be requiring admin=
<br>
&gt; rights to run the GUI and that option becomes &quot;readonly&quot; for=
 the user if<br>
&gt; startup is set in HKLM.<br>
<br>
</span>How do other packagages handle &quot;this is the system default, but=
 users<br>
can change their own setting&quot;?=C2=A0 (So the admin could say &quot;I w=
ant this started<br>
by default, for all users&quot; and individual users can uncheck this &quot=
;leave<br>
me alone!&quot;)<br>
<br>
Just thinking aloud, no idea how much effort this is, and whether it&#39;s<=
br>
a useful consideration in the first place.<br></blockquote><div><br></div><=
div>as a perfect solution, we can add 2 choices to installer<br><br></div><=
div>(*) run on startup (current user)<br></div><div>(*) run on startup (all=
 users)<br><br></div><div>and handle both in openvpn-gui.<br><br></div><div=
>but it seems to be complicated.<br></div><div>=C2=A0</div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex">
<div class=3D"HOEnZb"><div class=3D"h5"><br>
gert<br>
<br>
--<br>
USENET is *not* the non-clickable part of WWW!<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//<a href=3D"=
http://www.muc.de/~gert/" rel=3D"noreferrer" target=3D"_blank">www.muc.de/~=
gert/</a><br>
Gert Doering - Munich, Germany=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"mailt=
o:gert@...1296...">gert@...1296...</a><br>
fax: +49-89-35655025=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"mailto:gert@...1297...">gert@...2165...=
6...<wbr>muenchen.de</a><br>
</div></div></blockquote></div><br></div></div>

--001a11466fd698d4b2054221de64--

