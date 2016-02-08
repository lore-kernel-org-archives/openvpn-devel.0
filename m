MIME-Version: 1.0
In-Reply-To: <CAFHpkQEzCUDpHgRZhxYqTBUkvSe7ra5-CiS06Auzke+6vB=dkg@...278...>
References: <CAKuzo_gX4qwZg01UR2k=_g1yEY93z3wc1LiyqTXn=WBm3aZvwQ@...278...>
	<20160207215605.GC24952@...1296...>
	<CAFHpkQEzCUDpHgRZhxYqTBUkvSe7ra5-CiS06Auzke+6vB=dkg@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 8 Feb 2016 00:05:42 -0500
Message-ID: <CAKuzo_hOLJh88w8294MpHgafmO_rT5Dv_ONamaze1v_p+J8Yhg@...278...>
Content-Type: multipart/alternative; boundary=047d7b4179214244cf052b3b280c
Subject: Re: [Openvpn-devel] GUI repo
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--047d7b4179214244cf052b3b280c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Feb 7, 2016 at 10:35 PM, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=
=BF=D0=B8=D1=86=D0=B8=D0=BD <chipitsine@...277...> wrote:

> what about that PR. there might be cases when
>
> 1) interactive service installed
> 2) user is administrator
>

It will just work in all cases that worked before (as Gert said, 1, 2 and
1&&2). The pull request only does three things:

1. Attempt iService if the process is not elevated, else directly start
openvpn
2. Use HKCU to store GUI-specific registry keys
3. Save logs in %UserProfile%\OpenVPN\log

'highestPrivilege' in the manifest is not removed -- not yet.


> how many openvpn processes will be running ? how many of them will attempt
> to bind to 1194 ?
>

Though tempting, this has nothing to do with the PR so I'll pass.

Selva

--047d7b4179214244cf052b3b280c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,<br><br></div><div class=3D"=
gmail_extra"><div class=3D"gmail_quote">On Sun, Feb 7, 2016 at 10:35 PM, =
=D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD <span d=
ir=3D"ltr">&lt;<a href=3D"mailto:chipitsine@...277..." target=3D"_blank">ch=
ipitsine@...277...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex"><div dir=3D"ltr"><div><div><div>what about that PR. ther=
e might be cases when <br><br></div>1) interactive service installed<br></d=
iv>2) user is administrator<br></div></div></blockquote><div><br></div><div=
>It will just work in all cases that worked before (as Gert said, 1, 2 and =
1&amp;&amp;2). The pull request only does three things:<br><br><div class=
=3D"gmail_extra">1. Attempt iService if the process is not elevated, else d=
irectly start openvpn<br></div><div class=3D"gmail_extra">2. Use HKCU to st=
ore GUI-specific registry keys <br></div>3. Save logs in %UserProfile%\Open=
VPN\log<br><br></div><div>&#39;highestPrivilege&#39; in the manifest is not=
 removed -- not yet.<br>=C2=A0<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex"><div dir=3D"ltr">how many openvpn processes will be running =
? how many of them will attempt to bind to 1194 ?<br></div></blockquote><di=
v class=3D"gmail_extra"><br>Though tempting, this has nothing to do with th=
e PR so I&#39;ll pass.<br><br></div><div class=3D"gmail_extra">Selva<br></d=
iv></div></div></div>

--047d7b4179214244cf052b3b280c--

