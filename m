MIME-Version: 1.0
In-Reply-To: <CAKuzo_gBhwmAkc8EpaE62NpEhQcGPHkASesiurnF9pcghuv2tA@...278...>
References: <CAKuzo_gBhwmAkc8EpaE62NpEhQcGPHkASesiurnF9pcghuv2tA@...278...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Tue, 16 Jan 2018 13:16:05 +0500
Message-ID: <CAFHpkQG9Y4NYnv0ACSj72dNwVpjRggBXvBHMoOwUMnhdVBnL+w@...278...>
Content-Type: multipart/alternative; boundary="001a11445200a3ac180562e05774"
Subject: Re: [Openvpn-devel] travis builds
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--001a11445200a3ac180562e05774
Content-Type: text/plain; charset="UTF-8"

it started to happen after travis-ci image was updated to clang-5.0,
somehow it does not work well with ccache (that's why we removed ccache
recently)

2018-01-15 22:28 GMT+05:00 Selva Nair <selva.nair@...277...>:

> Hi,
>
> Out of the 12 or so jobs we have in the travis build matrix a few
> sometime fail with "write error" (happened a number of times for some
> local feature branches). On restarting only the failed jobs, one by
> one, they succeed indicating possible resource starvation?
>
> Is there anything one can do to avoid this?
>
> Thanks,
>
> Selva
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

--001a11445200a3ac180562e05774
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">it started to happen after travis-ci image was updated to =
clang-5.0, somehow it does not work well with ccache (that&#39;s why we rem=
oved ccache recently)<br><div><div class=3D"gmail_extra"><br><div class=3D"=
gmail_quote">2018-01-15 22:28 GMT+05:00 Selva Nair <span dir=3D"ltr">&lt;<a=
 href=3D"mailto:selva.nair@...277..." target=3D"_blank">selva.nair@...1663...=
.</a>&gt;</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi,<br>
<br>
Out of the 12 or so jobs we have in the travis build matrix a few<br>
sometime fail with &quot;write error&quot; (happened a number of times for =
some<br>
local feature branches). On restarting only the failed jobs, one by<br>
one, they succeed indicating possible resource starvation?<br>
<br>
Is there anything one can do to avoid this?<br>
<br>
Thanks,<br>
<br>
Selva<br>
<br>
------------------------------<wbr>------------------------------<wbr>-----=
-------------<br>
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
</blockquote></div><br></div></div></div>

--001a11445200a3ac180562e05774--

