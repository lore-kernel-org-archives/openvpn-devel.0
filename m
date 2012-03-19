MIME-Version: 1.0
In-Reply-To: <4F6700E1.60201@...1114...>
References: <4F632647.30603@...515...>
	<20120316114747.GV6615@...1330...>
	<CAOazyz2K4s3V3Yq6W8f9Q2us+vk9ArLT1UX3gKCS4Zxr245o+g@...278...>
	<4F633670.1000807@...1114...>
	<CAOazyz0nMAdD5H2MbBR=+ssOPPHgFsdgxr2g-SwWb4BHzDMdcw@...278...>
	<4F633B0C.8080502@...515...>
	<20120316152145.GF1359@...1296...>
	<4F66EE39.5050405@...515...> <4F66F5ED.30006@...1114...>
	<4F66FE98.4030707@...1114...>
	<20120319094235.GM1359@...1296...>
	<4F6700E1.60201@...1114...>
Date: Mon, 19 Mar 2012 17:16:09 +0200
Message-ID: <CAOazyz1aPWoiWWg=T7Ykw0YUL0S_wdAE-T6Gg=djpc=iwF9YXg@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] New generic buildsystem: lzo enabled or
 disabled by default?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: David Sommerseth <openvpn.list@...1114...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On Mon, Mar 19, 2012 at 11:48 AM, David Sommerseth
<openvpn.list@...1114...> wrote:
>
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 19/03/12 10:42, Gert Doering wrote:
> > Hi,
> >
> > On Mon, Mar 19, 2012 at 10:38:32AM +0100, David Sommerseth wrote:
> >> On 19/03/12 10:01, David Sommerseth wrote: [...snip...]
> >>>
> >>> On a related note: --enable-iproute2
> >>>
> >>> Should we also expect this to be available on all *nix platforms?
> >>> =C2=A0iproute2 has been available on most platforms I know of for a
> >>> very long time, and is superior net-tools in very many ways.
> >>
> >> I've been educated by Gert now, and learned that iproute2 is not
> >> common on most Unix based platforms, but is a Linux oriented tool.
> >> So this suggestion makes no longer much sense.
> >
> > Actually, I still agree with you that enabling it by default on Linux
> > is the way forward.
> >
> > (Or hook into the netlink interface directly, but I'm not sure
> > whether this will lead to easier to understand code, and easier to
> > read log files, than what we have now - where you could, for testing,
> > run the commands manually to see which ones cause problems)
>
> I agree, but I consider that a packager responsibility. =C2=A0I don't thi=
nk we
> should have different defaults in our build tools based on which platform
> you build on. =C2=A0That will easily get much more chaotic in the long ru=
n to
> maintain properly, especially if you take into consideration cross
> compilation (like building Windows binaries on Linux).

The only component that is in question is lzo.
I still think this is packager responsibility, not sure why this is an
exception.
But if it will make people happy, I will enable lzo by default.
All the other components are optional by they nature, and again it is
up to packager to decide what good for his configuration.

Alon.

