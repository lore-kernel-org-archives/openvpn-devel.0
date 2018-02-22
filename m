MIME-Version: 1.0
In-Reply-To: <CAKuzo_jcezyJ0OjRGwS0p==b-2gGUMhABsFtCSaa8P61MYvVvA@...278...>
References: <CAFHpkQGwrOTkOy0UDNUkAa3m4YZeUb7ZpKRjFWaj50KaAX47_Q@...278...>
 <CAKuzo_gdOZq1m_fmV6NA2uM7+_5v-R9Pbsgut=C5yELx7bEp+g@...278...>
 <CAFHpkQFP-eenz54yLirF0aYhMD5YonGmGMG+vpo3xmqXtEftbQ@...278...>
 <CAKuzo_jcezyJ0OjRGwS0p==b-2gGUMhABsFtCSaa8P61MYvVvA@...278...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Thu, 22 Feb 2018 11:46:51 +0500
Message-ID: <CAFHpkQGJj9ZdZpc=W1VEk3KXNCy3TamaYe5E58cP2qkzsFn=sw@...278...>
Content-Type: multipart/alternative; boundary="94eb2c1ab264a7e0560565c76885"
Subject: Re: [Openvpn-devel] challenge/response example ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--94eb2c1ab264a7e0560565c76885
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2018-02-22 8:52 GMT+05:00 Selva Nair <selva.nair@...277...>:

> Hi,
>
> On Wed, Feb 21, 2018 at 10:18 PM, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=
=D0=BF=D0=B8=D1=86=D0=B8=D0=BD <chipitsine@...277...>
> wrote:
> >
> >
> > 2018-02-21 22:03 GMT+05:00 Selva Nair <selva.nair@...277...>:
> >>
> >> Hi,
> >>
> >> On Tue, Feb 20, 2018 at 10:10 AM, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=
=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD <chipitsine@...277...>
> >> wrote:
> >> > Hello,
> >> >
> >> > is there any step-by-step example of implementing either static or
> >> > dynamic
> >> > challenge response ?
> >>
> >> Static is easy:
> >> On client: add --static-challenge "Enter OTP" 1 to the client config.
> >> On server, merge my auth-pam plugin patch :)
> >
> >
> >
> > if static challenge is handled via pam, so ... there's only true/false ?
> > I mean, is there a way to tell a user "your password is wrong" or
> "password
> > is good, but response is wrong" ?
>
> The usual practice with PAM is not to indicate that the user input is
> partially correct as that leaks information to an attacker.  Of course
> you can set it up in a less secure way. But avoid it unless you have a
> strong reason.
>
> In case of openvpn, anyway there is no easy way[*] to pass back such
> info from server to client, so auth either succeeds or fails.
>

well, what I can say about it

1) definetly we need some examples on challenge/response

2) for example, windows ldap can response with "password is ok, but account
is locked" or "password is ok, but password is expired". we definetly need
some way for that messaging


>
> Selva
>
> [*] Its possible to send back an AUTH_FAIL reason, but currently only
> supported by --management-client-auth (not by auth scripts or plugins)
> and used only to trigger dynamic challenge.
>

--94eb2c1ab264a7e0560565c76885
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2018-02-22 8:52 GMT+05:00 Selva Nair <span dir=3D"ltr">&lt;<a href=3D"m=
ailto:selva.nair@...277..." target=3D"_blank">selva.nair@...277...</a>&gt;<=
/span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bor=
der-left:1px #ccc solid;padding-left:1ex">Hi,<br>
<span class=3D""><br>
On Wed, Feb 21, 2018 at 10:18 PM, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=
=BF=D0=B8=D1=86=D0=B8=D0=BD &lt;<a href=3D"mailto:chipitsine@...277...">chi=
pitsine@...277...</a>&gt; wrote:<br>
&gt;<br>
&gt;<br>
&gt; 2018-02-21 22:03 GMT+05:00 Selva Nair &lt;<a href=3D"mailto:selva.nair=
@...277...">selva.nair@...277...</a>&gt;:<br>
&gt;&gt;<br>
&gt;&gt; Hi,<br>
&gt;&gt;<br>
&gt;&gt; On Tue, Feb 20, 2018 at 10:10 AM, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=
=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD &lt;<a href=3D"mailto:chipitsine@...1664...=
7...">chipitsine@...277...</a>&gt;<br>
&gt;&gt; wrote:<br>
&gt;&gt; &gt; Hello,<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; is there any step-by-step example of implementing either stat=
ic or<br>
&gt;&gt; &gt; dynamic<br>
&gt;&gt; &gt; challenge response ?<br>
&gt;&gt;<br>
&gt;&gt; Static is easy:<br>
&gt;&gt; On client: add --static-challenge &quot;Enter OTP&quot; 1 to the c=
lient config.<br>
&gt;&gt; On server, merge my auth-pam plugin patch :)<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; if static challenge is handled via pam, so ... there&#39;s only true/f=
alse ?<br>
&gt; I mean, is there a way to tell a user &quot;your password is wrong&quo=
t; or &quot;password<br>
&gt; is good, but response is wrong&quot; ?<br>
<br>
</span>The usual practice with PAM is not to indicate that the user input i=
s<br>
partially correct as that leaks information to an attacker.=C2=A0 Of course=
<br>
you can set it up in a less secure way. But avoid it unless you have a<br>
strong reason.<br>
<br>
In case of openvpn, anyway there is no easy way[*] to pass back such<br>
info from server to client, so auth either succeeds or fails.<br></blockquo=
te><div><br></div><div>well, what I can say about it<br><br></div><div>1) d=
efinetly we need some examples on challenge/response<br><br></div><div>2) f=
or example, windows ldap can response with &quot;password is ok, but accoun=
t is locked&quot; or &quot;password is ok, but password is expired&quot;. w=
e definetly need some way for that messaging<br></div><div>=C2=A0</div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #c=
cc solid;padding-left:1ex">
<br>
Selva<br>
<br>
[*] Its possible to send back an AUTH_FAIL reason, but currently only<br>
supported by --management-client-auth (not by auth scripts or plugins)<br>
and used only to trigger dynamic challenge.<br>
</blockquote></div><br></div></div>

--94eb2c1ab264a7e0560565c76885--

