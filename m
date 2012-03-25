MIME-Version: 1.0
In-Reply-To: <CAP+U6tKTRJ8ybhd9xgyZrj0vDXPFAk+=r=Ai46sUjDsio3bsgw@...278...>
References: <1332616557-15727-1-git-send-email-alon.barlev@...277...>
	<CAOazyz3p-pZ=Sbmomnr2b9431hFxsxjte_P7ucSCAA4gJBpC_Q@...278...>
	<CAP+U6tKTRJ8ybhd9xgyZrj0vDXPFAk+=r=Ai46sUjDsio3bsgw@...278...>
Date: Sun, 25 Mar 2012 13:10:45 +0200
Message-ID: <CAOazyz1odoeRyG5UxvsNehdwWdUpJ+kJmuiaoiLD8T-Ht7nTcw@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] build: rename bool->obool
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Fabian Knittel <fabian.knittel@...1547...>
Cc: Openvpn-devel@lists.sourceforge.net

On Sun, Mar 25, 2012 at 12:51 PM, Fabian Knittel
<fabian.knittel@...1547...> wrote:
>
> Hi Alon,
>
> 2012/3/24 Alon Bar-Lev <alon.barlev@...277...>:
> > On Sat, Mar 24, 2012 at 9:15 PM, Alon Bar-Lev <alon.barlev@...277...>
> > wrote:
> >> PPC architectures and conflict with stdbool.h.
> >>
> >> basic.h defines a type 'bool' that conflicts with the altivec
> >> keyword bool which has to be fixed upstream, see bugs[1][2].
> >>
> >> [1] https://bugs.gentoo.org/show_bug.cgi?id=293840
> >> [2] https://bugs.gentoo.org/show_bug.cgi?id=297854
>
> The approach attempted in [2], using stdbool.h, looks far less
> intrusive than renaming "bool" to "obool" everywhere, so why did you
> choose the latter approach? Jan Scholz's comment #6 [3] sounds like
> the right approach to me ...
>
> Cheers
> Fabian
>
> 3: https://bugs.gentoo.org/show_bug.cgi?id=297854#c6

Hello,

This is a good question.

My formal answer is that although stdbool contains the "standard"
implication it is far from being standard right now.

First, there is a problem with constant definition of sizeof(bool),
and second there is a problem with integration of C and C++ code one
using C++ and the other using stdbool constants.

Most platforms, such as Microsoft platform and Sun still missing that
functionality anyway.

What I recommend in order to avoid conflicts and resolve this easily
is simply not to use the "bool" keywords. This is what I am doing in
all of my C projects.

If we want to invest some more time, we can make sure that openvpn
does not depend of sizeof(bool) and create emulation for bool for
platforms that do not provide it.

However the flags modifications from [1] should be merged anyway, I
will submit a patch.

What do you think?

Thanks,
Alon.

[1] https://297854.bugs.gentoo.org/attachment.cgi?id=214304

