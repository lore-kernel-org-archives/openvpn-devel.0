MIME-Version: 1.0
References: <20191110133525.6069-1-a@...2181...>
 <20191110133525.6069-3-a@...2181...>
 <CAKuzo_ha8xxM+bw=Lrq01dnCNhNDqzS1EQGaptjUrdDq5pqcLg@...278...>
 <20191110170338.GP40538@...1296...>
In-Reply-To: <20191110170338.GP40538@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Sun, 10 Nov 2019 17:03:26 -0500
Message-ID: <CAKuzo_h+qTFQvUeiCM1TewW1b1XC7OvOESbEo+CtJWmMAUgvqA@...278...>
Content-Type: multipart/alternative; boundary="000000000000337790059705307e"
Subject: Re: [Openvpn-devel] [PATCH 3/3] travis: compile with -Werror on
 Linux
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: Antonio Quartulli <a@...2181...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000337790059705307e
Content-Type: text/plain; charset="UTF-8"

Forgot to hit send on this, and probably this is only partially relevant
now, but here goes.

Hi

On Sun, Nov 10, 2019 at 12:03 PM Gert Doering <gert@...1296...> wrote:

> Hi,
>
> On Sun, Nov 10, 2019 at 11:48:16AM -0500, Selva Nair wrote:
> > But it seems it may also affect mingw builds on travis. I would resist
> the
> > temptation to add -Werror in general and to Windows cross-build in
> > particular.
>
> Yeah, we're not intending to.
>

But the patch does affect cross-compilation for Windows on linux.

Unless restricted to a very small cross-section (say gcc x.y + linux) this
is going to cause a lot of grief. Note that every check run by configure
that succeeds with warnings will become mysterious error at build time.
There may be other unexpected failures too. -Werror is never fit for
production in my view. There is a reason why warnings are warnings.

Just my 2c.

Selva

--000000000000337790059705307e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Forgot to hit send on this, and probably this is only=
 partially relevant now, but here goes.</div><div><br></div><div>Hi</div><d=
iv><br></div><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_att=
r">On Sun, Nov 10, 2019 at 12:03 PM Gert Doering &lt;<a href=3D"mailto:gert=
@...1296..." target=3D"_blank">gert@...1296...</a>&gt; wrote:<br></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
<br>
On Sun, Nov 10, 2019 at 11:48:16AM -0500, Selva Nair wrote:<br>
&gt; But it seems it may also affect mingw builds on travis. I would resist=
 the<br>
&gt; temptation to add -Werror in general and to Windows cross-build in<br>
&gt; particular.<br>
<br>
Yeah, we&#39;re not intending to.<br></blockquote><div><br></div><div>But t=
he patch does affect cross-compilation for Windows on linux.</div><div><br>=
</div><div>Unless restricted to a very small cross-section (say gcc x.y + l=
inux) this is going to cause a lot of grief. Note that every check run by c=
onfigure that succeeds with warnings will become mysterious error at build =
time. There may be other unexpected failures too. -Werror is never fit for =
production in my view. There is a reason why warnings are warnings.</div><d=
iv><br></div><div>Just my 2c.</div><div><br></div><div>Selva</div></div></d=
iv>

--000000000000337790059705307e--

