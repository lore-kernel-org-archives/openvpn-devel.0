MIME-Version: 1.0
In-Reply-To: <20120626133532.GK22125@...1296...>
References: <1340715726-14670-1-git-send-email-alon.barlev@...277...>
	<20120626133532.GK22125@...1296...>
Date: Tue, 26 Jun 2012 16:41:49 +0300
Message-ID: <CAOazyz1A5mo9hKXi-KXUsoAUeNp1ELtA784xgYOzGT+e7BFu=Q@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] build: plugins: set default to no in
	Windows
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

This is exactly the reason why *ALL* plugins should be disabled by default.
We are left with only Linux enabled... and distro maintainer can take
care of that anyway.
But again... my opinion is not matter, right... sending a new patch.

On Tue, Jun 26, 2012 at 4:35 PM, Gert Doering <gert@...1296...> wrote:
> Hi,
>
> On Tue, Jun 26, 2012 at 04:02:06PM +0300, Alon Bar-Lev wrote:
>> Both plugins cannot be compiled on Windows anyway.
>
> Can you auto-disable plugin-auth-pam for OpenBSD as well, please?
>
> We ran into this on the OpenBSD buildslave today - OpenBSD has no PAM
> whatsoever, so it would be nice to not have to care.
>
> (Leaving the ACK on the windows patch to Samuli - looks good to me, but
> I can't test right now)
>
> thanks.
>
> gert
> --
> USENET is *not* the non-clickable part of WWW!
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 //www.muc.de/~gert/
> Gert Doering - Munich, Germany =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gert@...1296...
> fax: +49-89-35655025 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gert@...1297...

