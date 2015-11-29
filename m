MIME-Version: 1.0
In-Reply-To: <565B50C5.7020704@...1227...>
References: <CAEsd45QjsjNDWFkoHG2O0ycO2pNGxj115TH+SLiUD__jf=WWpQ@...278...>
	<1448823144-1497-1-git-send-email-arne@...1227...>
	<CAKuzo_gG40h6JOyp4fAw39u1uK+6Zs68XSVHAABihtYEtfGrEw@...278...>
	<565B50C5.7020704@...1227...>
From: Selva Nair <selva.nair@...277...>
Date: Sun, 29 Nov 2015 14:29:44 -0500
Message-ID: <CAKuzo_hLnaNknOXXZCTSGs8b0Y_cwEz-tYLk-Ts-BtrZBdqhXg@...278...>
Content-Type: multipart/alternative; boundary=089e011766238a11960525b2f3a7
Subject: Re: [Openvpn-devel] [PATCH] Reflect enable-password-save change in
	documentation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--089e011766238a11960525b2f3a7
Content-Type: text/plain; charset=UTF-8

Hi,

On Sun, Nov 29, 2015 at 2:23 PM, Arne Schwabe <arne@...1227...> wrote:

>
> Hm but the paragraph of --askpass is not related to
> --enable-password-save, or do I miss something?


please see starting line 4886 of openvpn.8 quoted below:

If
.B file
is specified, read the password from the first line of
.B file.
Keep in mind that storing your password in a file
to a certain extent invalidates the extra security provided by
using an encrypted key (Note: OpenVPN
will only read passwords from a file if it has been built
with the \-\-enable\-password\-save configure option, or on Windows
by defining ENABLE_PASSWORD_SAVE in win/settings.in).

Selva

--089e011766238a11960525b2f3a7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,<br><br></div><div class=3D"=
gmail_extra"><div class=3D"gmail_quote">On Sun, Nov 29, 2015 at 2:23 PM, Ar=
ne Schwabe <span dir=3D"ltr">&lt;<a href=3D"mailto:arne@...1227..." target=
=3D"_blank">arne@...1227...</a>&gt;</span> wrote:<br><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex"><span class=3D""><br>
</span>Hm but the paragraph of --askpass is not related to<br>
--enable-password-save, or do I miss something?</blockquote></div><br></div=
><div class=3D"gmail_extra">please see starting line 4886 of openvpn.8 quot=
ed below:<br></div><div class=3D"gmail_extra"><br></div><div class=3D"gmail=
_extra">If<br>.B file<br>is specified, read the password from the first lin=
e of<br>.B file.<br>Keep in mind that storing your password in a file<br>to=
 a certain extent invalidates the extra security provided by<br>using an en=
crypted key (Note: OpenVPN<br>will only read passwords from a file if it ha=
s been built<br>with the \-\-enable\-password\-save configure option, or on=
 Windows<br>by defining ENABLE_PASSWORD_SAVE in win/<a href=3D"http://setti=
ngs.in">settings.in</a>).<br></div><div class=3D"gmail_extra"><br></div><di=
v class=3D"gmail_extra">Selva<br></div></div>

--089e011766238a11960525b2f3a7--

