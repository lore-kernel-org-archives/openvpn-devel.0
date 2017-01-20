MIME-Version: 1.0
In-Reply-To: <20170120214018.GT78624@...1296...>
References: <1484772172-19758-1-git-send-email-selva.nair@...277...>
	<20170120181647.10199-1-davids@...515...>
	<CAKuzo_iuwKbWwTsRP4PV+-5NRFOkjyY6LtCKEbzT7ETEjysZ+g@...278...>
	<20170120214018.GT78624@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 20 Jan 2017 17:04:27 -0500
Message-ID: <CAKuzo_j+zHO43BE=ez++Mx0Bmz+kH=7a1Pz3RiV22ZNwCUFXuw@...278...>
Content-Type: multipart/alternative; boundary=001a113a2bec98a6ab05468dd6d4
Subject: Re: [Openvpn-devel] [PATCH applied] Add a check for -Wl,
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

--001a113a2bec98a6ab05468dd6d4
Content-Type: text/plain; charset=UTF-8

Hi,

On Fri, Jan 20, 2017 at 4:40 PM, Gert Doering <gert@...1296...> wrote:

> On Fri, Jan 20, 2017 at 03:38:46PM -0500, Selva Nair wrote:
> > I am curious to know whether the opensolaris buildbot (there is one isn't
> > it?) run and pass all tests?
>
> There is one, but it uses gcc and GNU ld, so --wrap never was a problem
> there...
>
> gert@...2236...:/home/gert$ ld --version
> GNU ld version 2.15
> Copyright 2002 Free Software Foundation, Inc.


I see... Recently I've used opensolaris only as in Illumo's omnios
and gcc -v shows

Target: i386-pc-solaris2.11
Configured with: ./configure --host i386-pc-solaris2.11 [...snip...]
--without-gnu-ld --with-ld=/bin/ld --with-as=/usr/bin/gas --with-gnu-as
 etc..

And /bin/ld gives
usage: ld [-3:6:abc:d:e:f:h:il:mo:p:rstu:z:B:CD:F:GI:L:M:N:P:Q:R:S:VW:Y:?]
file(s)

It does support --wrap though.

Selva

--001a113a2bec98a6ab05468dd6d4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
Hi,</div><div class=3D"gmail_quote"><br></div><div class=3D"gmail_quote">On=
 Fri, Jan 20, 2017 at 4:40 PM, Gert Doering <span dir=3D"ltr">&lt;<a href=
=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1296...</a>&gt;</span=
> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);border-left-s=
tyle:solid;padding-left:1ex"><span>On Fri, Jan 20, 2017 at 03:38:46PM -0500=
, Selva Nair wrote:<br>
&gt; I am curious to know whether the opensolaris buildbot (there is one is=
n&#39;t<br>
&gt; it?) run and pass all tests?<br>
<br>
</span>There is one, but it uses gcc and GNU ld, so --wrap never was a prob=
lem<br>
there...<br>
<br>
gert@...2236...:/home/gert$ ld --version<br>
GNU ld version 2.15<br>
Copyright 2002 Free Software Foundation, Inc.</blockquote></div><div class=
=3D"gmail_extra"><br></div><div class=3D"gmail_extra">I see... Recently I&#=
39;ve used opensolaris only as in Illumo&#39;s omnios</div></div><div class=
=3D"gmail_extra">and gcc -v shows</div><div class=3D"gmail_extra"><br></div=
><div class=3D"gmail_extra">Target: i386-pc-solaris2.11</div><div class=3D"=
gmail_extra">Configured with: ./configure --host i386-pc-solaris2.11 [...sn=
ip...] --without-gnu-ld --with-ld=3D/bin/ld --with-as=3D/usr/bin/gas --with=
-gnu-as =C2=A0etc..</div><div class=3D"gmail_extra"><br></div><div class=3D=
"gmail_extra">And /bin/ld gives</div><div class=3D"gmail_extra">usage: ld [=
-3:6:abc:d:e:f:h:il:mo:p:rstu:z:B:CD:F:GI:L:M:N:P:Q:R:S:VW:Y:?] file(s)<br>=
</div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">It do=
es support --wrap though.</div><div class=3D"gmail_extra"><br></div><div cl=
ass=3D"gmail_extra">Selva</div><div class=3D"gmail_extra"><br></div></div>

--001a113a2bec98a6ab05468dd6d4--

