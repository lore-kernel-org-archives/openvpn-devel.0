MIME-Version: 1.0
In-Reply-To: <4489a66e-428f-493d-6dc9-1dde62c2c731@...2080...>
References: <4489a66e-428f-493d-6dc9-1dde62c2c731@...2080...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 11 Aug 2016 16:44:59 -0400
Message-ID: <CAKuzo_jhiRWMucS+Xm6jnJDY6U6Kfk2AKxDqzrsc_mH1d=YLdg@...278...>
Content-Type: multipart/alternative; boundary=94eb2c05602e0fd8850539d1d8a3
Subject: Re: [Openvpn-devel] autoconf/automake warnings
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--94eb2c05602e0fd8850539d1d8a3
Content-Type: text/plain; charset=UTF-8

Hi,

You are right, it was me who introduced reference to sources in subdir to
avoid duplication when block-dns support was added to the interactive
service.

On Thu, Aug 11, 2016 at 2:50 PM, David Sommerseth <
openvpn@...2080...> wrote:

> Hi,
>
> I noticed a few errors today when building OpenVPN on Fedora 23.  The
> attached patch resolves this.  But it breaks 'make' when it reaches
> ./src/openvpnserv:
>
> Makefile:505: ../../src/openvpn/.deps/openvpnserv-block_dns.Po: No
> such file or directory
>

Looks like a bug that was reported in automake 1.15 and fixed later. Does
this
happen on later version of automake as well?


>
> Except of that, the patch removes the warnings on Fedora 23 [1] and
> causes no other issues on Scientific Linux 7.2 [2] or CentOS 5.11 [3].
>
>
> And some comments to the patch.
>
> * The subdir-objects option was needed to avoid a warning with
>   automake-1.15.
>

> * AM_PROG_CC_C_O is needed with automake-1.9.6 when the subdir-objects
>   option is enabled.
>

I thought AM_PROG_CC_C_O was deprecated a long time ago. When did it make a
come back?

All my systems have automake older than 1.15 --- I will boot up a docker
container and test this.

Selva

--94eb2c05602e0fd8850539d1d8a3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,</div><div class=3D"gmail_ex=
tra"><br></div><div class=3D"gmail_extra">You are right, it was me who intr=
oduced reference to sources in subdir to avoid duplication when block-dns s=
upport was added to the interactive service.</div><div class=3D"gmail_extra=
"><br><div class=3D"gmail_quote">On Thu, Aug 11, 2016 at 2:50 PM, David Som=
merseth <span dir=3D"ltr">&lt;<a href=3D"mailto:openvpn@...2080..." target=
=3D"_blank">openvpn@...2080...</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex"><div id=3D":ccm" class=3D"a3s aXjCH m1567af0f22e35d90">Hi,<br>
<br>
I noticed a few errors today when building OpenVPN on Fedora 23.=C2=A0 The<=
br>
attached patch resolves this.=C2=A0 But it breaks &#39;make&#39; when it re=
aches<br>
./src/openvpnserv:<br>
<br>
Makefile:505: ../../src/openvpn/.deps/<wbr>openvpnserv-block_dns.Po: No<br>
such file or directory<br></div></blockquote><div><br></div><div>Looks like=
 a bug that was reported in automake 1.15 and fixed later. Does this=C2=A0<=
/div><div>happen on later version of automake as well?</div><div>=C2=A0</di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex"><div id=3D":ccm" class=3D"a3s aXjCH m1567a=
f0f22e35d90">
<br>
Except of that, the patch removes the warnings on Fedora 23 [1] and<br>
causes no other issues on Scientific Linux 7.2 [2] or CentOS 5.11 [3].<br>
<br>
<br>
And some comments to the patch.<br>
<br>
* The subdir-objects option was needed to avoid a warning with<br>
=C2=A0 automake-1.15.</div></blockquote><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div=
 id=3D":ccm" class=3D"a3s aXjCH m1567af0f22e35d90">
<br>
* AM_PROG_CC_C_O is needed with automake-1.9.6 when the subdir-objects<br>
=C2=A0 option is enabled.<br></div></blockquote><div><br></div><div>I thoug=
ht AM_PROG_CC_C_O was deprecated a long time ago. When did it make a come b=
ack?</div></div><div class=3D"gmail_extra"><br></div>All my systems have au=
tomake older than 1.15 --- I will boot up a docker container and test this.=
</div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Selva=
<br><br></div></div>

--94eb2c05602e0fd8850539d1d8a3--

