MIME-Version: 1.0
References: <CAOrkh=Vw_5rLO=Ny4RKMUfjVAhoAD36SyeZj0EjZfwnqHaL2QQ@...278...>
 <a1c7e516.AXIAAFJAwlcAAAAAAAAAAajn0CoAAYCsnhYAAAAAABXTlQBm-n8I@...2677...>
In-Reply-To: <a1c7e516.AXIAAFJAwlcAAAAAAAAAAajn0CoAAYCsnhYAAAAAABXTlQBm-n8I@...2677...>
From: Petr Portnov <mrjarviscraft@...277...>
Date: Mon, 30 Sep 2024 17:16:29 +0300
Message-ID: <CAOrkh=W8su+XxShw5pGd-UCb2dbXO4HSUA+Pv-rm85_rCR29hQ@...278...>
Content-Type: multipart/alternative; boundary="000000000000837da4062356da03"
Subject: Re: [Openvpn-devel] [PATCH] Configurable installation directories
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <dazo+openvpn@...2108...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000837da4062356da03
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Glad to hear it, thanks for your response!
As for the release: is there any planned date for v24? Or, as an
alternative, could the previous asio-related patch
(75abb7dc9366ba85fb1a144d88f02a1e8a62f538) and this one be cherry-picked on
top of v23 tag and be release as something like v23.1 so that there is no
need to wait for v24 to have this specific changes?

PS: accidentally sent it to personal mail only without sending it to the
mailing list, thus resending it.

=D0=BF=D0=BD, 30 =D1=81=D0=B5=D0=BD=D1=82. 2024=E2=80=AF=D0=B3. =D0=B2 13:3=
5, David Sommerseth <dazo+openvpn@...2108...>:

> On 24/09/2024 15:26, Petr Portnov wrote:
> > Hi there!
> > Continuing the packaging of the latest OpenVPN-linux for NixOS, I would
> > like to propose the following addition to the build system.
> >
> > What it does is it allows you to customize the installation paths for
> > DBus and systemd services and adds the option to disable the generation
> > of `openvpn3_statedir / 'configs'` directory (which is not always
> > desired, e.g. when the OS takes this responsibility).
>
> That's again, Petr!
>
> I'm going to pull this into the coming v24 release.  I'll keep you
> posted on the progress here.
>
> Your changes makes sense, so I don't expect any issues here.  Going to
> test it a bit first, though.
>
>
> --
> kind regards,
>
> David Sommerseth
> OpenVPN Inc
>
>
>

--000000000000837da4062356da03
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div id=3D"gmail-:1d7" class=3D"gmail-a3s gmail-aiL"><div =
dir=3D"ltr"><div>Glad to hear it, thanks for your response!</div><div>As fo=
r the release: is there any planned date for v24? Or, as an alternative, co=
uld the previous asio-related patch (75abb7dc9366ba85fb1a144d88f02a1e8a62f5=
38)
 and this one be cherry-picked on top of v23 tag and be release as=20
something like v23.1 so that there is no need to wait for v24 to have=20
this specific changes?</div><div><br></div><div>PS: accidentally sent it to=
 personal mail only without sending it to the mailing list, thus resending =
it.<br></div></div></div></div><br><div class=3D"gmail_quote"><div dir=3D"l=
tr" class=3D"gmail_attr">=D0=BF=D0=BD, 30 =D1=81=D0=B5=D0=BD=D1=82. 2024=E2=
=80=AF=D0=B3. =D0=B2 13:35, David Sommerseth &lt;<a href=3D"mailto:dazo%2Bo=
penvpn@...2108...">dazo+openvpn@...2108...</a>&gt;:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">On 24/09/2024 15:26, Petr Portnov wrote=
:<br>
&gt; Hi there!<br>
&gt; Continuing the packaging of the latest OpenVPN-linux for NixOS, I woul=
d <br>
&gt; like to propose the following addition to the build system.<br>
&gt; <br>
&gt; What it does is it allows you to customize the installation paths for =
<br>
&gt; DBus and systemd services and adds the option to disable the generatio=
n <br>
&gt; of `openvpn3_statedir / &#39;configs&#39;` directory (which is not alw=
ays <br>
&gt; desired, e.g. when the OS takes this responsibility).<br>
<br>
That&#39;s again, Petr!<br>
<br>
I&#39;m going to pull this into the coming v24 release.=C2=A0 I&#39;ll keep=
 you <br>
posted on the progress here.<br>
<br>
Your changes makes sense, so I don&#39;t expect any issues here.=C2=A0 Goin=
g to <br>
test it a bit first, though.<br>
<br>
<br>
-- <br>
kind regards,<br>
<br>
David Sommerseth<br>
OpenVPN Inc<br>
<br>
<br>
</blockquote></div>

--000000000000837da4062356da03--

