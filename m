MIME-Version: 1.0
References: <1524752664-27946-1-git-send-email-selva.nair@...277...>
 <201810051051.w95ApC2t040828@...2054...>
In-Reply-To: <201810051051.w95ApC2t040828@...2054...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 5 Oct 2018 20:05:55 -0400
Message-ID: <CAKuzo_j=WSnExJDOK=mnNqmC+DF=9DmKo_uNicjcCkfD+wMG5A@...278...>
Content-Type: multipart/alternative; boundary="000000000000e1e5910577842728"
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Pass the hash without the
 DigestInfo header to NCryptSignHash()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000e1e5910577842728
Content-Type: text/plain; charset="UTF-8"

Hi

On Fri, Oct 5, 2018 at 6:51 AM Gert Doering <gert@...1296...> wrote:

> Your patch has been applied to the master branch.  Steffan says "it is
> a bugfix so it should go to 2.4", but the underlying infrastructure
> does not seem to be there yet (git cherry-pick tries to bring in lots
> of extra stuff).  So we can do that, but I need to be told which master
> commits I need to bring to 2.4 first.
>

cherry-picking this needs some manual conflict resolution but no pulling in
anything extra from master (one function got refactored and renamed in
master
and hence the conflict).

A patch for 2.4 follows -- same as for master except for the context of one
hunk.

Thanks,

Selva

--000000000000e1e5910577842728
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br><div><br><div class=3D"gmail_quote"=
><div dir=3D"ltr">On Fri, Oct 5, 2018 at 6:51 AM Gert Doering &lt;<a href=
=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1296...</a>&gt; wrote=
:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Your patch has=
 been applied to the master branch.=C2=A0 Steffan says &quot;it is<br>
a bugfix so it should go to 2.4&quot;, but the underlying infrastructure <b=
r>
does not seem to be there yet (git cherry-pick tries to bring in lots<br>
of extra stuff).=C2=A0 So we can do that, but I need to be told which maste=
r<br>
commits I need to bring to 2.4 first.<br></blockquote><div><br></div><div>c=
herry-picking this needs some manual conflict resolution but no pulling in<=
br></div><div>anything extra from master (one function got refactored and r=
enamed in master</div><div>and hence the conflict).</div><div><br></div><di=
v>A patch for 2.4 follows -- same as for master except for the context of o=
ne hunk.<br><br></div><div>Thanks,<br><br></div><div>Selva<br></div></div><=
/div></div></div>

--000000000000e1e5910577842728--

