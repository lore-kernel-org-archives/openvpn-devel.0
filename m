MIME-Version: 1.0
References: <1585513970-32658-1-git-send-email-selva.nair@...277...>
 <1585513970-32658-2-git-send-email-selva.nair@...277...>
 <CAEsd45RgM7Uh55jKS=Sqz_Wy+0r_j649WvE1w6ki7V4oMjt+UQ@...278...>
 <CAKuzo_hp5ojMrr0KmnHVR335uJ58QTveuqC5C9Brqv-SUq_nTA@...278...>
 <20200330060754.GU1431@...1296...>
In-Reply-To: <20200330060754.GU1431@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 30 Mar 2020 11:12:05 -0400
Message-ID: <CAKuzo_gXnxLCFLpQB7Rsg+2VNP4U0jUTAjKLL_4A5nx9rdkBZw@...278...>
Content-Type: multipart/alternative; boundary="000000000000bccd6e05a213e0f3"
Subject: Re: [Openvpn-devel] [PATCH 2/2] When auth-user-pass file has no
 password, query the management
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: "Jonathan K. Bullard" <jkbullard@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000bccd6e05a213e0f3
Content-Type: text/plain; charset="UTF-8"

Hi,

On Mon, Mar 30, 2020 at 2:07 AM Gert Doering <gert@...1296...> wrote:
>
> Hi,
>
> On Sun, Mar 29, 2020 at 07:58:15PM -0400, Selva Nair wrote:
> > Yes, that's right. However, that logic wont be proper on OS-X, would it?
> > Command line users who use --log can still see password
> > prompt on /dev/tty. We'll be breaking that behaviour.
> >
> > I considered checking for env vars like IV_UI_VER set by the UI
> > client, but that's not readily accessible from auth_user_pass_cr()
> > call. Alternatives like checking whether /dev/tty can be opened and/or
> > systemd is available didn't appeal to me. If at all, that would have
> > to be a separate patch.
>
> Not sure if the case "there is an active management client, and
> --management-query-passwords is set, but we *could* ask on /dev/tty"
> is really worth considering.

I agree, but the problem is that we currently do that when auth-file has
username but no password.

Current behaviour:
   if auth-file is set always read from it
   else query management if management-query-passwords is set etc.
   else ask on /dev/tty or windows console
with a quirk that if auth-file has username but no password, ask on /dev/tty
or console, not the management ever..

(ignoring systemd which just replaces the query on console).

I'm all for changing the latter behaviour to query the management if
possible,
/dev/tty otherwise. But that's a regression and some may complain.

Jonathan K. Bullard <jkbullard@...277...> wrote:
>
> If the OS X command line user was using --management-query-passwords
> (as Tunnelblick does), they wouldn't see the password prompt on
> /dev/tty, would they?

In case of auth-file missing password, they would see it on /dev/tty
on linux, and I would guess on OSX as well, but I've not checked.


Selva

--000000000000bccd6e05a213e0f3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><br>On Mon, Mar 30, 2020 at 2:07 AM Gert Doering &l=
t;<a href=3D"mailto:gert@...1296...">gert@...1296...</a>&gt; wrote:<br>&gt;=
<br>&gt; Hi,<br>&gt;<br>&gt; On Sun, Mar 29, 2020 at 07:58:15PM -0400, Selv=
a Nair wrote:<br>&gt; &gt; Yes, that&#39;s right. However, that logic wont =
be proper on OS-X, would it?<br>&gt; &gt; Command line users who use --log =
can still see password<br>&gt; &gt; prompt on /dev/tty. We&#39;ll be breaki=
ng that behaviour.<br>&gt; &gt;<br>&gt; &gt; I considered checking for env =
vars like IV_UI_VER set by the UI<br>&gt; &gt; client, but that&#39;s not r=
eadily accessible from auth_user_pass_cr()<br>&gt; &gt; call. Alternatives =
like checking whether /dev/tty can be opened and/or<br>&gt; &gt; systemd is=
 available didn&#39;t appeal to me. If at all, that would have<br>&gt; &gt;=
 to be a separate patch.<br>&gt;<br>&gt; Not sure if the case &quot;there i=
s an active management client, and<br>&gt; --management-query-passwords is =
set, but we *could* ask on /dev/tty&quot;<br>&gt; is really worth consideri=
ng.<br><br>I agree, but the problem is that we currently do that when auth-=
file has<div>username but no password.<br><br>Current behaviour:<br>=C2=A0 =
=C2=A0if auth-file is set always read from it<br>=C2=A0 =C2=A0else query ma=
nagement if management-query-passwords is set etc.<br>=C2=A0 =C2=A0else ask=
 on /dev/tty or windows console<br>with a quirk that if auth-file has usern=
ame but no password, ask on /dev/tty<br>or console, not the management ever=
..</div><div><br>(ignoring systemd which just replaces the query on console=
).<br><br>I&#39;m all for changing the latter behaviour to query the manage=
ment if possible,<br>/dev/tty otherwise. But that&#39;s a regression and so=
me may complain.<br><br>Jonathan K. Bullard &lt;<a href=3D"mailto:jkbullard=
@...277...">jkbullard@...277...</a>&gt; wrote:<br>&gt;<br>&gt; If the OS X =
command line user was using --management-query-passwords<br>&gt; (as Tunnel=
blick does), they wouldn&#39;t see the password prompt on<br>&gt; /dev/tty,=
 would they?<br><div><div><br></div><div>In case of auth-file missing passw=
ord, they would see it on /dev/tty</div><div>on linux, and I would guess on=
 OSX as well, but I&#39;ve not checked.</div><div>=C2=A0<br></div><blockquo=
te style=3D"margin:0 0 0 40px;border:none;padding:0px"></blockquote><blockq=
uote style=3D"margin:0 0 0 40px;border:none;padding:0px"></blockquote><bloc=
kquote style=3D"margin:0 0 0 40px;border:none;padding:0px"></blockquote><bl=
ockquote style=3D"margin:0 0 0 40px;border:none;padding:0px"></blockquote><=
blockquote style=3D"margin:0 0 0 40px;border:none;padding:0px"></blockquote=
><blockquote style=3D"margin:0 0 0 40px;border:none;padding:0px"></blockquo=
te>Selva<br></div></div></div>

--000000000000bccd6e05a213e0f3--

