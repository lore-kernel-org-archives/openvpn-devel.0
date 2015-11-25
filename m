MIME-Version: 1.0
In-Reply-To: <20151124201135.GM24952@...1296...>
References: <564BA6DB.4070703@...2070...>
	<564DE8B3.9030803@...2070...>
	<20151124083944.GY24952@...1296...>
	<5654A314.3080607@...2070...>
	<20151124201135.GM24952@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 24 Nov 2015 19:13:17 -0500
Message-ID: <CAKuzo_jdcOjunyVmpT8er3HqWG7yh6pr+i8Tn8kD3omj=G_Pqw@...278...>
Content-Type: multipart/alternative; boundary=001a1144424e61d97d052552540a
Subject: Re: [Openvpn-devel] [PATCH v4-master] Add Windows DNS Leak fix
 using WFP ('block-outside-dns')
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--001a1144424e61d97d052552540a
Content-Type: text/plain; charset=UTF-8

Hi,

On Tue, Nov 24, 2015 at 3:11 PM, Gert Doering <gert@...1296...> wrote:

> > I still need help with 2.3 build system. If somebody willing to help me,
> please use the attached version.
>
> Well, the 2.3 version would need all the #ifdefs around the code if not
> running at VISTA level, and *no* changes to the build system part (so,
> 2.3 out of the box would simply not "see" this code at all).
>
> Samuli would then have to change part of his build system to enable VISTA
> API level and add these extra libraries - but that would have to be an
> out-of-tree patch applied only to the Vista-and-up installers.


Not sure I understand this.  The patch I had tested all along had ifdef
_WINNT_WIN32 >= 0x0600 around everything. So the code nicely silences
itself when built for XP (I did not try this though). I built only 64 bit
version for vista+.

And this was against the master. Now the new sets of patches have different
ifdefs: _WINNT_WIN32 >= 0x600 for 2.3, and if defined(WIN32) for master.
This appears unnecessary. Two patches are still needed as some context
lines have changed between 2.3 and master, but the code could be the same,
and, in particular, the ifdefs could be just _WINNT_WIN32 >= 0x600.

May be you mean the same?

Selva

--001a1144424e61d97d052552540a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,</div><div class=3D"gmail_ex=
tra"><br><div class=3D"gmail_quote">On Tue, Nov 24, 2015 at 3:11 PM, Gert D=
oering <span dir=3D"ltr">&lt;<a href=3D"mailto:gert@...1296..." target=3D"_=
blank">gert@...1296...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-=
color:rgb(204,204,204);border-left-style:solid;padding-left:1ex"><span>&gt;=
 I still need help with 2.3 build system. If somebody willing to help me, p=
lease use the attached version.<br>
<br>
</span>Well, the 2.3 version would need all the #ifdefs around the code if =
not<br>
running at VISTA level, and *no* changes to the build system part (so,<br>
2.3 out of the box would simply not &quot;see&quot; this code at all).<br>
<br>
Samuli would then have to change part of his build system to enable VISTA<b=
r>
API level and add these extra libraries - but that would have to be an<br>
out-of-tree patch applied only to the Vista-and-up installers.</blockquote>=
</div><br>Not sure I understand this.=C2=A0 The patch I had tested all alon=
g had ifdef _WINNT_WIN32 &gt;=3D 0x0600 around everything. So the code nice=
ly silences itself when built for XP (I did not try this though). I built o=
nly 64 bit version for vista+.=C2=A0</div><div class=3D"gmail_extra"><br></=
div><div class=3D"gmail_extra">And this was against the master. Now the new=
 sets of patches have different ifdefs: _WINNT_WIN32 &gt;=3D 0x600 for 2.3,=
 and if defined(WIN32) for master. This appears unnecessary. Two patches ar=
e still needed as some context lines have changed between 2.3 and master, b=
ut the code could be the same, and, in particular, the ifdefs could be just=
=C2=A0_WINNT_WIN32 &gt;=3D 0x600.</div><div class=3D"gmail_extra"><br></div=
><div class=3D"gmail_extra">May be you mean the same?</div><div class=3D"gm=
ail_extra">=C2=A0</div><div class=3D"gmail_extra">Selva</div><div class=3D"=
gmail_extra">=C2=A0</div></div>

--001a1144424e61d97d052552540a--

