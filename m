MIME-Version: 1.0
References: <1585513970-32658-1-git-send-email-selva.nair@...277...>
 <1585513970-32658-2-git-send-email-selva.nair@...277...>
 <CAEsd45RgM7Uh55jKS=Sqz_Wy+0r_j649WvE1w6ki7V4oMjt+UQ@...278...>
 <CAKuzo_hp5ojMrr0KmnHVR335uJ58QTveuqC5C9Brqv-SUq_nTA@...278...>
 <20200330060754.GU1431@...1296...>
 <CAKuzo_gXnxLCFLpQB7Rsg+2VNP4U0jUTAjKLL_4A5nx9rdkBZw@...278...>
 <CAEsd45R3571EMBik_KauVWyfwyjS2oMKkxnbX5hj5UkniS4n3Q@...278...>
In-Reply-To: <CAEsd45R3571EMBik_KauVWyfwyjS2oMKkxnbX5hj5UkniS4n3Q@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 30 Mar 2020 12:29:44 -0400
Message-ID: <CAKuzo_jeYoYVMp+BkJWfdEeQ8gsm2W3RenV5UcszYxt-26p_Hg@...278...>
Content-Type: multipart/alternative; boundary="0000000000006c76fe05a214f65b"
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
To: "Jonathan K. Bullard" <jkbullard@...277...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0000000000006c76fe05a214f65b
Content-Type: text/plain; charset="UTF-8"

Hi,

On Mon, Mar 30, 2020 at 12:11 PM Jonathan K. Bullard <jkbullard@...277...>
wrote:

> Hi,
>
> On Mon, Mar 30, 2020 at 11:12 AM Selva Nair <selva.nair@...277...> wrote:
> > Jonathan K. Bullard <jkbullard@...277...> wrote:
> > >
> > > If the OS X command line user was using --management-query-passwords
> > > (as Tunnelblick does), they wouldn't see the password prompt on
> > > /dev/tty, would they?
> >
> > In case of auth-file missing password, they would see it on /dev/tty
> > on linux, and I would guess on OSX as well, but I've not checked.
>
> The password prompt appears on /dev/tty on OS X only if --daemon is not
> used.
>
> If --daemon and --management-query-passwords are used but --askpass is
> not (whether or not --auth-nocache is also used), which is typical for
> a Tunnelblick configuration on OS X, the following appears in the log:
>
>      neither stdin nor stderr are a tty device and you have neither a
>           controlling tty nor systemd - can't ask for 'Enter Auth
> Password:'.
>           If you used --daemon, you need to use --askpass to make
>           passphrase-protected keys work, and you can not use
>           --auth-nocache.
>      Exiting due to fatal error
>
> if --daemon, --management-query-passwords, and --askpass are all used
> (whether or not --auth-nocache is used), you get:
>
>      Need password(s) from management interface, waiting...
>
> If Windows GUI uses --daemon, that could be an additional requirement
> that would work for Tunnelblick and OS X, which would mean one less
> incompatibility between Windows and OS X.
>

--daemon is a unix/linux option (not supported on Windows) and after
deamonizing there is no controlling tty leading to the behaviour you mention
above. I think that's documented.


> Or it could test for Windows || (OS X && --daemon).
>

Personally I would prefer to enable this code for all platforms although
its a minor regression.

That is, if management-query-passwords is enabled and auth file is
missing password, query the management, not on console irrespective
of other options and OS. If that's acceptable, I'll submit a v2.

Selva



> Best regards,
>
> Jon Bullard
>

--0000000000006c76fe05a214f65b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><br><div class=3D"gmail_quote"><div dir=3D"l=
tr" class=3D"gmail_attr">On Mon, Mar 30, 2020 at 12:11 PM Jonathan K. Bulla=
rd &lt;<a href=3D"mailto:jkbullard@...277...">jkbullard@...277...</a>&gt; w=
rote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
<br>
On Mon, Mar 30, 2020 at 11:12 AM Selva Nair &lt;<a href=3D"mailto:selva.nai=
r@...277..." target=3D"_blank">selva.nair@...277...</a>&gt; wrote:<br>
&gt; Jonathan K. Bullard &lt;<a href=3D"mailto:jkbullard@...277..." target=
=3D"_blank">jkbullard@...277...</a>&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt; If the OS X command line user was using --management-query-passwo=
rds<br>
&gt; &gt; (as Tunnelblick does), they wouldn&#39;t see the password prompt =
on<br>
&gt; &gt; /dev/tty, would they?<br>
&gt;<br>
&gt; In case of auth-file missing password, they would see it on /dev/tty<b=
r>
&gt; on linux, and I would guess on OSX as well, but I&#39;ve not checked.<=
br>
<br>
The password prompt appears on /dev/tty on OS X only if --daemon is not use=
d.<br>
<br>
If --daemon and --management-query-passwords are used but --askpass is<br>
not (whether or not --auth-nocache is also used), which is typical for<br>
a Tunnelblick configuration on OS X, the following appears in the log:<br>
<br>
=C2=A0 =C2=A0 =C2=A0neither stdin nor stderr are a tty device and you have =
neither a<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 controlling tty nor systemd - can&#39;t =
ask for &#39;Enter Auth Password:&#39;.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 If you used --daemon, you need to use --=
askpass to make<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 passphrase-protected keys work, and you =
can not use<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 --auth-nocache.<br>
=C2=A0 =C2=A0 =C2=A0Exiting due to fatal error<br>
<br>
if --daemon, --management-query-passwords, and --askpass are all used<br>
(whether or not --auth-nocache is used), you get:<br>
<br>
=C2=A0 =C2=A0 =C2=A0Need password(s) from management interface, waiting...<=
br>
<br>
If Windows GUI uses --daemon, that could be an additional requirement<br>
that would work for Tunnelblick and OS X, which would mean one less<br>
incompatibility between Windows and OS X.<br></blockquote><div><br></div><d=
iv>--daemon is a unix/linux option (not supported on Windows) and after</di=
v><div>deamonizing there is no controlling tty leading to the behaviour you=
 mention</div><div>above. I think that&#39;s documented.</div><div><br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Or it could test for Windows || (OS X &amp;&amp; --daemon).<br></blockquote=
><div><br></div><div>Personally I would prefer to enable this code for all =
platforms although</div><div>its a minor regression.</div><div><br></div><d=
iv>That is, if management-query-passwords is enabled and auth file is</div>=
<div>missing password, query the management, not on console irrespective</d=
iv><div>of other options and OS. If that&#39;s acceptable, I&#39;ll submit =
a v2.</div><div><br></div><div>Selva</div><div><br></div><div><br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Best regards,<br>
<br>
Jon Bullard<br>
</blockquote></div></div>

--0000000000006c76fe05a214f65b--

