MIME-Version: 1.0
In-Reply-To: <3e2e63ed-99fb-e880-11dc-b0748f501567@...2080...>
References: <1484772172-19758-1-git-send-email-selva.nair@...277...>
	<3e2e63ed-99fb-e880-11dc-b0748f501567@...2080...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 19 Jan 2017 10:32:53 -0500
Message-ID: <CAKuzo_g+PPAfxUZMAmE0L4JKk7Wwp6Y58VfdAJGQA5Ys6j52OQ@...278...>
Content-Type: multipart/alternative; boundary=001a113e7bf664fccb05467440b0
Subject: Re: [Openvpn-devel] [PATCH] Add a check for -Wl,
	--wrap support in linker
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a113e7bf664fccb05467440b0
Content-Type: text/plain; charset=UTF-8

Hi,

Thanks for the comments.

On Thu, Jan 19, 2017 at 9:41 AM, David Sommerseth <
openvpn@...2080...> wrote:

> Any reason to have this AC_DEFINE?  That puts HAVE_LD_WRAP_SUPPORT into
> config.h, which I don't think makes much sense.  If we don't have --wrap
> support, would we have #ifdef HAVE_LD_WRAP_SUPPORT in the C code at all?
>

Repeating from related discussion on the PR page: AC_DEFINE is indeed meant
to add a  preprocessor define (available to sources through config.h). We
do not have a use for it right now but we could --- say one could provide
an alternative to __wrap_xxx() in source, not sure how though.

So currently its just a preprocessor define that provides a solution
waiting for a problem. If the consensus is not to define it, fine with me.

Selva

--001a113e7bf664fccb05467440b0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,</div><div class=3D"gmail_ex=
tra"><br></div><div class=3D"gmail_extra">Thanks for the comments.</div><di=
v class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Thu, Jan 19, 2017=
 at 9:41 AM, David Sommerseth <span dir=3D"ltr">&lt;<a href=3D"mailto:openv=
pn@...2080..." target=3D"_blank">openvpn@...2080...</a>&gt;</span> wrote:<b=
r><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex"><div id=3D":1au" class=3D"a3s aXjCH m159b7=
2ca336e02e1">Any reason to have this AC_DEFINE?=C2=A0 That puts HAVE_LD_WRA=
P_SUPPORT into<br>
config.h, which I don&#39;t think makes much sense.=C2=A0 If we don&#39;t h=
ave --wrap<br>
support, would we have #ifdef HAVE_LD_WRAP_SUPPORT in the C code at all?</d=
iv></blockquote></div><br>Repeating from related discussion on the PR page:=
 AC_DEFINE is indeed meant to add a =C2=A0preprocessor define (available to=
 sources through config.h). We do not have a use for it right now but we co=
uld --- say one could provide an alternative to __wrap_xxx() in source, not=
 sure how though.</div><div class=3D"gmail_extra"><br></div><div class=3D"g=
mail_extra">So currently its just a preprocessor define that provides a sol=
ution waiting for a problem. If the consensus is not to define it, fine wit=
h me.</div><div class=3D"gmail_extra">=C2=A0</div><div class=3D"gmail_extra=
">Selva</div></div>

--001a113e7bf664fccb05467440b0--

