MIME-Version: 1.0
In-Reply-To: <9cb3e4fc-a681-484a-2712-8483835901d5@...2181...>
References: <20180104193710.23778-1-chipitsine@...277...>
 <9cb3e4fc-a681-484a-2712-8483835901d5@...2181...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Fri, 5 Jan 2018 06:42:39 +0500
Message-ID: <CAFHpkQGpU007WMz6GYDGvJ6_WbCjHZ3wxAa8c3eBgFtpHDftzQ@...278...>
Content-Type: multipart/alternative; boundary="94eb2c05bd205b65a20561fd9066"
Subject: Re: [Openvpn-devel] [PATCH v3] travis-ci: add brew cache,
 remove ccache
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

--94eb2c05bd205b65a20561fd9066
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2018-01-05 3:23 GMT+05:00 Antonio Quartulli <a@...2181...>:

>
>
> On 05/01/18 03:37, Ilya Shipitsin wrote:
> > 1-2 minutes speedup osx builds by using brew cache.
> > Also, ccache was removed for a while (builds fail
> > after travis-ci upgraded clang to version 5.0.0)
> > ---
> > v2: this is a "v2" of previously issued "enable ccache for osx and mingw
> builds"
> > patch. I decided not to enable ccache for mingw builds as it does not
> > speedup them
> >
> > v3: removed ccache at all, because it fails on clang-5.0.0
>
> Does this patch make "[PATCH] travis-ci: speedup osx build by enabling
> brew cache=E2=80=8B" obsolete?
>

yes


>
>
> Regards,
>
>
> --
> Antonio Quartulli
>
>

--94eb2c05bd205b65a20561fd9066
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2018-01-05 3:23 GMT+05:00 Antonio Quartulli <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:a@...2181..." target=3D"_blank">a@...2181...</a>&gt;</span>:<b=
r><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex"><span class=3D""><br>
<br>
On 05/01/18 03:37, Ilya Shipitsin wrote:<br>
&gt; 1-2 minutes speedup osx builds by using brew cache.<br>
&gt; Also, ccache was removed for a while (builds fail<br>
&gt; after travis-ci upgraded clang to version 5.0.0)<br>
&gt; ---<br>
&gt; v2: this is a &quot;v2&quot; of previously issued &quot;enable ccache =
for osx and mingw builds&quot;<br>
&gt; patch. I decided not to enable ccache for mingw builds as it does not<=
br>
&gt; speedup them<br>
&gt;<br>
&gt; v3: removed ccache at all, because it fails on clang-5.0.0<br>
<br>
</span>Does this patch make &quot;[PATCH] travis-ci: speedup osx build by e=
nabling<br>
brew cache=E2=80=8B&quot; obsolete?<br></blockquote><div><br></div><div>yes=
<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
<br>
Regards,<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
<br>
--<br>
Antonio Quartulli<br>
<br>
</font></span></blockquote></div><br></div></div>

--94eb2c05bd205b65a20561fd9066--

