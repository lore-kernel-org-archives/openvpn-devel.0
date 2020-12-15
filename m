MIME-Version: 1.0
References: <20201215171600.25534-1-domagoj@...2540...>
 <20201215173558.GN976@...1296...>
In-Reply-To: <20201215173558.GN976@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 15 Dec 2020 13:00:23 -0500
Message-ID: <CAKuzo_hjr3BLyBvDyd8OQN1e8SUgoZYBK920uLUgzuODdGAdnw@...278...>
Content-Type: multipart/alternative; boundary="0000000000005cf30f05b684890f"
Subject: Re: [Openvpn-devel] [PATCH] Fix too early argv freeing when
 registering DNS
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: Domagoj Pensa <domagoj@...2540...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0000000000005cf30f05b684890f
Content-Type: text/plain; charset="UTF-8"

Hi

On Tue, Dec 15, 2020 at 12:37 PM Gert Doering <gert@...1296...> wrote:

> Hi,
>
> On Tue, Dec 15, 2020 at 06:16:00PM +0100, Domagoj Pensa wrote:
> > When registering DNS on Windows, argv is freed after being used in first
> > ipconfig command (/flushdns).
> >
> > Then same argv is used uninitialized in next ipconfig command
> (/registerdns)
> > causing heap exception and subprocess crash.
> >
> > As a consequence second command is never executed and locked netcmd
> > semaphore is not cleanly released.
> >
> > Removing argv freeing between ipconfig calls solves the problem.
>
> Oh!  Yes, now with your patch, this is very obvious - there is a trac
> ticket (so when I merge this, I'll add the trac ticket number to the
> commit message) but it sort of puzzled Selva and me, because the
> code "looked sane".
>

Indeed, I went looking at wrong places.

Thanks,

Selva

--0000000000005cf30f05b684890f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi</div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Tue, Dec 15, 2020 at 12:37 PM Gert Doering &lt;<=
a href=3D"mailto:gert@...1296...">gert@...1296...</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
<br>
On Tue, Dec 15, 2020 at 06:16:00PM +0100, Domagoj Pensa wrote:<br>
&gt; When registering DNS on Windows, argv is freed after being used in fir=
st<br>
&gt; ipconfig command (/flushdns).<br>
&gt; <br>
&gt; Then same argv is used uninitialized in next ipconfig command (/regist=
erdns)<br>
&gt; causing heap exception and subprocess crash.<br>
&gt; <br>
&gt; As a consequence second command is never executed and locked netcmd<br>
&gt; semaphore is not cleanly released.<br>
&gt; <br>
&gt; Removing argv freeing between ipconfig calls solves the problem.<br>
<br>
Oh!=C2=A0 Yes, now with your patch, this is very obvious - there is a trac<=
br>
ticket (so when I merge this, I&#39;ll add the trac ticket number to the<br>
commit message) but it sort of puzzled Selva and me, because the<br>
code &quot;looked sane&quot;.<br></blockquote><div><br></div><div>Indeed, I=
 went looking at wrong places.</div><div><br></div><div>Thanks,</div><div><=
br></div><div>Selva</div><div>=C2=A0</div></div></div>

--0000000000005cf30f05b684890f--

