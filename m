MIME-Version: 1.0
In-Reply-To: <20160225125008.GD24952@...1296...>
References: <1455398109-28880-1-git-send-email-selva.nair@...277...>
	<20160225125008.GD24952@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 25 Feb 2016 22:31:27 -0500
Message-ID: <CAKuzo_h6+7Mr4_ohviuZMVesaQbQguJpAdUS8-chLM0JZd1rzg@...278...>
Content-Type: multipart/alternative; boundary=001a114771f0540632052ca3f012
Subject: Re: [Openvpn-devel] [PATCH 0/2] Support "block-outside-dns" through
 interactive service
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

--001a114771f0540632052ca3f012
Content-Type: text/plain; charset=UTF-8

Hi,

On Thu, Feb 25, 2016 at 7:50 AM, Gert Doering <gert@...1296...> wrote:

> This looks good to me.  Alas, I also need to ask you for a v2 of the
> (i) patch - I've just merged Valdikss' patch to make the block-outside-dns
> code work on Vista (trac #648), and now the code slab that gets moved
> out of win32.c has been changed.
>

I've sent version 2 for both (i) & (ii). Apart from merging with master,
both have some minor edits (fix a stale comment, print err code in hex and
move a nested function out to play nice with non-mingw folks).

Thanks,

Selva

--001a114771f0540632052ca3f012
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,<br><br></div><div class=3D"=
gmail_extra"><div class=3D"gmail_quote">On Thu, Feb 25, 2016 at 7:50 AM, Ge=
rt Doering <span dir=3D"ltr">&lt;<a href=3D"mailto:gert@...1296..." target=
=3D"_blank">gert@...1296...</a>&gt;</span> wrote:<br><blockquote class=3D"g=
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex"><div id=3D":3sr" class=3D"a3s" style=3D"overflow:hidden">This look=
s good to me.=C2=A0 Alas, I also need to ask you for a v2 of the<br>
(i) patch - I&#39;ve just merged Valdikss&#39; patch to make the block-outs=
ide-dns<br>
code work on Vista (trac #648), and now the code slab that gets moved<br>
out of win32.c has been changed.</div></blockquote></div><br></div><div cla=
ss=3D"gmail_extra">I&#39;ve sent version 2 for both (i) &amp; (ii). Apart f=
rom merging with master, both have some minor edits (fix a stale comment, p=
rint err code in hex and move a nested function out to play nice with non-m=
ingw folks).<br><br></div><div class=3D"gmail_extra">Thanks,<br><br></div><=
div class=3D"gmail_extra">Selva<br></div></div>

--001a114771f0540632052ca3f012--

