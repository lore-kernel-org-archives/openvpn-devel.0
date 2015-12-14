MIME-Version: 1.0
In-Reply-To: <1449766646-3519-1-git-send-email-wayne@...2099...>
References: <CAHSx_StWk=Es9qg9TSq6yXACPhTLneeeUWNDDaKqp06S0x6R=w@...278...>
	<1449766646-3519-1-git-send-email-wayne@...2099...>
From: Wayne Davison <wayne@...2099...>
Date: Mon, 14 Dec 2015 13:56:31 -0800
Message-ID: <CAHSx_SuDffEw7Ufn6ehXJpjLvh8HPtaTxVnnaMBcKMHA5qRuZA@...278...>
Content-Type: multipart/alternative; boundary=001a113529701863f60526e2c059
Subject: Re: [Openvpn-devel] [PATCH] Improve stdin prompting section,
	fixing CR prompting.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--001a113529701863f60526e2c059
Content-Type: text/plain; charset=UTF-8

On Thu, Dec 10, 2015 at 8:57 AM, Wayne Davison <wayne@...2099...> wrote:

>  src/openvpn/misc.c | 119
> +++++++++++++++++++++++++----------------------------
>  1 file changed, 57 insertions(+), 62 deletions(-)
>

Any questions I can answer about this patch?  This is such a
straight-forward bug with a simple fix that I'd hope that it makes it into
the upcoming release. (The patch is mainly re-indenting, which bloats it a
good bit.)

..wayne..

--001a113529701863f60526e2c059
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Thu, Dec 10, 2015 at 8:57 AM, Wayne Davison <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:wayne@...2099..." target=3D"_blank">wayne@...2099...</a>&gt;</s=
pan> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);border-lef=
t-style:solid;padding-left:1ex">=C2=A0src/openvpn/misc.c | 119 ++++++++++++=
+++++++++++++----------------------------<br>
=C2=A01 file changed, 57 insertions(+), 62 deletions(-)<br></blockquote><di=
v><br></div><div>Any questions I can answer about this patch?=C2=A0 This is=
 such a straight-forward bug with a simple fix that I&#39;d hope that it ma=
kes it into the upcoming release. (The patch is mainly re-indenting, which =
bloats it a good bit.)=C2=A0</div><br clear=3D"all"><div><div class=3D"gmai=
l_signature">..wayne..</div></div><div><br></div></div></div></div>

--001a113529701863f60526e2c059--

