MIME-Version: 1.0
References: <1550368541-10402-1-git-send-email-selva.nair@...277...>
 <20190218142426.GC962@...1296...>
In-Reply-To: <20190218142426.GC962@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 18 Feb 2019 12:32:06 -0500
Message-ID: <CAKuzo_hfb-MUkMpXnj0dtWe4Lk5C+HoGZuDfOrcR7mboXrxn6g@...278...>
Content-Type: multipart/alternative; boundary="000000000000ec5ce805822e81a2"
Subject: Re: [Openvpn-devel] [PATCH] Better error message when script fails
 due to script-security setting
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000ec5ce805822e81a2
Content-Type: text/plain; charset="UTF-8"

Hi

On Mon, Feb 18, 2019 at 9:24 AM Gert Doering <gert@...1296...> wrote:

> Hi,
>
> On Sat, Feb 16, 2019 at 08:55:41PM -0500, selva.nair@...277... wrote:
> > From: Selva Nair <selva.nair@...277...>
> >
> > - Add a new return value (-2) for openvpn_execve() when external
> > program execution is not allowed due to a low script-security
> > setting.
> >
> > - Add a corresponding error message
>
> I find this a useful way forward (because it will not introduce new FATALs
> where we had none before, just make the errors more clear).
>
> Since David had reservations on the other patch, I want to have explicit
> agreement from him before going on - and will poke on IRC to make sure I
> get attention.
>

Just to be explicit:

Since David pointed out the "regressive" nature of the earlier patch, I too
have
reservations about it, and prefer this approach.

Nevertheless, as we agreed to tag 2.4.7 *today* to make the release tomorrow
> and meet the Debian deadline, I will not include this in 2.4.7.


The planned script-security over-ride feature in the GUI is pretty
intrusive. Taking
time to give it more thought, and preferably get some user feedback, is not
a bad thing.

Selva

--000000000000ec5ce805822e81a2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div>Hi</div><br><div cl=
ass=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Feb 18, 2=
019 at 9:24 AM Gert Doering &lt;<a href=3D"mailto:gert@...1296..." target=
=3D"_blank">gert@...1296...</a>&gt; wrote:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">Hi,<br>
<br>
On Sat, Feb 16, 2019 at 08:55:41PM -0500, <a href=3D"mailto:selva.nair@...1665...=
77..." target=3D"_blank">selva.nair@...277...</a> wrote:<br>
&gt; From: Selva Nair &lt;<a href=3D"mailto:selva.nair@...277..." target=3D=
"_blank">selva.nair@...277...</a>&gt;<br>
&gt; <br>
&gt; - Add a new return value (-2) for openvpn_execve() when external<br>
&gt; program execution is not allowed due to a low script-security<br>
&gt; setting.<br>
&gt; <br>
&gt; - Add a corresponding error message<br>
<br>
I find this a useful way forward (because it will not introduce new FATALs<=
br>
where we had none before, just make the errors more clear).=C2=A0 <br>
<br>
Since David had reservations on the other patch, I want to have explicit<br>
agreement from him before going on - and will poke on IRC to make sure I<br>
get attention.<br></blockquote><div><br></div><div>Just to be explicit:</di=
v><div><br></div><div>Since David pointed out the &quot;regressive&quot; na=
ture of the earlier patch, I too have</div><div>reservations about it, and =
prefer this approach.</div><div><br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">Nevertheless, as we agreed to tag 2.4.7 *today* to make th=
e release tomorrow<br>and meet the Debian deadline, I will not include this=
 in 2.4.7.</blockquote><div><br></div><div>The planned script-security over=
-ride feature in the GUI is pretty intrusive. Taking</div><div>time to give=
 it more thought, and preferably get some user feedback, is not a bad thing=
.</div><div><br></div><div>Selva</div></div></div></div></div>

--000000000000ec5ce805822e81a2--

