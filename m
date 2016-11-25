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
From: Selva Nair <selva.nair@...277...>
Date: Fri, 25 Nov 2016 14:55:45 -0500
Message-ID: <CAKuzo_jz9CWZ0oOgDB3niO3sfSXAAYNzF6UZ7d9SFJy8Av+iNQ@...278...>
Content-Type: multipart/alternative; boundary=001a11408cb639ce78054225835b
Subject: Re: [Openvpn-devel] launch openvpn-gui at windows startup
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a11408cb639ce78054225835b
Content-Type: text/plain; charset=UTF-8

On Fri, Nov 25, 2016 at 10:27 AM, Gert Doering <gert@...1296...> wrote:

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
>
I have posted a PR (https://github.com/OpenVPN/openvpn-build/pull/55) using
an active-setup registry entry to do this. It will automatically add the
required HKCU entry when the user logs-in. As this happens early in the
login process (before startup registry key is evaluated) the GUI will
startup even on the first login.

Should works also for new users, and the user can change override it using
the option in GUI settings menu. Changes to the nsis file is minor too.

Selva

--001a11408cb639ce78054225835b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Fri, Nov 25, 2016 at 10:27 AM, Gert Doering <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1296...</a>&gt;</spa=
n> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);border-left-=
style:solid;padding-left:1ex">Hi,<br>
<span><br>
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
a useful consideration in the first place.<br>
<div class=3D"gmail-m_7237335575349074592HOEnZb"><div class=3D"gmail-m_7237=
335575349074592h5"><br></div></div></blockquote><div><br></div><div>I have =
posted a PR (<a href=3D"https://github.com/OpenVPN/openvpn-build/pull/55">h=
ttps://github.com/OpenVPN/openvpn-build/pull/55</a>)=C2=A0using an active-s=
etup registry entry to do this. It will automatically add the required HKCU=
 entry when the user logs-in. As this happens early in the login process (b=
efore startup registry key is evaluated) the GUI will startup even on the f=
irst login.</div><div><br></div><div>Should works also for new users, and t=
he user can change override it using the option in GUI settings menu. Chang=
es to the nsis file is minor too.</div><div><br></div><div>Selva</div></div=
></div></div>

--001a11408cb639ce78054225835b--

