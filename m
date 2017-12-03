MIME-Version: 1.0
In-Reply-To: <CAKuzo_incnQKuZK5SFAVXcqOKbLVDSf6X9k23_Ucnwy6e2x2qw@...278...>
References: <45635479-7296-752e-193c-083d189cc3a7@...277...>
 <CAKuzo_incnQKuZK5SFAVXcqOKbLVDSf6X9k23_Ucnwy6e2x2qw@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Sun, 3 Dec 2017 13:13:55 -0500
Message-ID: <CAKuzo_g+XqUQZHH6L_i2_jrQPOD4kGZJQ_gUPJNrmvP7fGbaPQ@...278...>
Content-Type: multipart/alternative; boundary="94eb2c046b9ed0d16f055f73915e"
Subject: Re: [Openvpn-devel] Suggestion: openvpn-GUI --help style
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: fragmentux <fragmentux@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--94eb2c046b9ed0d16f055f73915e
Content-Type: text/plain; charset="UTF-8"

Hi,

On Thu, Nov 23, 2017 at 6:59 PM, Selva Nair <selva.nair@...277...> wrote:

> Hi
>
> On Thu, Nov 23, 2017 at 1:34 PM, fragmentux <fragmentux@...277...> wrote:
> >
> > Hi,
> >
> > I would like to suggest that, instead of having to run the GUI to
> > retrieve the help, like so:
> >
> > 'C:\Program Files\Openvpn\bin\openvpn-gui --help'
> >
> > the 'help window' can be retrieved via the GUI itself.
> > A menu option or Help button ..
> >
> > Otherwise, because teh GUI is set on install to run by default at user
> > logon it is not possible to run another instance to retrieve the help.
> > Unless you quit the running GUI first.
>
> Yeah, that's bad. But, a help menu option in the GUI may raise
> expectations of a proper documentation that describes how to use
> the GUI, not just a list of a command line options. Until "someone" (not
> me :)
> writes a doc describing the usage, including scripts, script timeouts,
> default config/log/script locations etc., a help menu item would be
> premature.
>
> We could just allow running a second instance with  --help. The gui
> PR #188 implements a more user-friendly handling of a second instance,
> ways to send commands to the running GUI etc, so its easy to add
> such a feature on top of it.
>

 A followup to say that, in fact, PR #188 as is will allow
running openvpn-gui --help even whhen an instance is already running.

This is not to say a help menu is of no interest --- I would very much like
to
have help documentation accessible from the GUI. But it has to show
something
useful to an average user -- not a bunch of command line arguments.

Writing docs is one thing that even non-programmers can contribute to. We
could
link to (or distribute with the GUI) an html page like
https://community.openvpn.net/openvpn/wiki/OpenVPN-GUI if that is brought
in line with the current state of the GUI. Several things like need for
admin rights,
config file locations etc. are totally outdated in there. Also show how to
import
configs which is the first thing a user would would want to do etc...

Any volunteers to bring it up to date or point to something better?

Thanks,

Selva

--94eb2c046b9ed0d16f055f73915e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,</div><div class=3D"gmail_ex=
tra"><br><div class=3D"gmail_quote">On Thu, Nov 23, 2017 at 6:59 PM, Selva =
Nair <span dir=3D"ltr">&lt;<a href=3D"mailto:selva.nair@...277..." target=
=3D"_blank">selva.nair@...277...</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex"><div dir=3D"ltr">Hi<span><br><br>On Thu, N=
ov 23, 2017 at 1:34 PM, <span id=3D"gmail-m_7982512470378607536m_-776933317=
3965098098:4ag.1">fragmentux</span> &lt;<span id=3D"gmail-m_798251247037860=
7536m_-7769333173965098098:4ag.2">fragmentux</span>@<a href=3D"http://gmail=
.com" target=3D"_blank">gmail.com</a>&gt; wrote:<br>&gt;<br>&gt; Hi,<br>&gt=
;<br>&gt; I would like to suggest that, instead of having to run the GUI to=
<br>&gt; retrieve the help, like so:<br>&gt;<br>&gt; &#39;C:\Program Files\=
<span id=3D"gmail-m_7982512470378607536m_-7769333173965098098:4ag.3">Openvp=
n</span>\bin\<span id=3D"gmail-m_7982512470378607536m_-7769333173965098098:=
4ag.4">openvpn</span>-<span id=3D"gmail-m_7982512470378607536m_-77693331739=
65098098:4ag.5">gui</span> --help&#39;<br>&gt;<br>&gt; the &#39;help window=
&#39; can be retrieved via the GUI itself.<br>&gt; A menu option or Help bu=
tton ..<br>&gt;<br>&gt; Otherwise, because <span id=3D"gmail-m_798251247037=
8607536m_-7769333173965098098:4ag.6">teh</span> GUI is set on install to ru=
n by default at user<br>&gt; <span id=3D"gmail-m_7982512470378607536m_-7769=
333173965098098:4ag.7">logon</span> it is not possible to run another insta=
nce to retrieve the help.<br>&gt; Unless you quit the running GUI first.<br=
><br></span>Yeah, that&#39;s bad. But, a help menu option in the GUI may ra=
ise<br>expectations of a proper documentation that describes how to use<br>=
the GUI, not just a list of a command line options. Until &quot;someone&quo=
t; (not me :)<br>writes a doc describing the usage, including scripts, scri=
pt timeouts,<br>default <span id=3D"gmail-m_7982512470378607536m_-776933317=
3965098098:4ag.8">config</span>/log/script locations etc., a help menu item=
 would be<br>premature.<br><br>We could just allow running a second instanc=
e with =C2=A0--help. The <span id=3D"gmail-m_7982512470378607536m_-77693331=
73965098098:4ag.9">gui</span> <br>PR #188 implements a more user-friendly h=
andling of a second instance,<br>ways to send commands to the running GUI e=
tc, so its easy to add<br>such a feature on top of it.</div></blockquote><d=
iv><br></div><div>=C2=A0A followup to say that, in fact, PR #188 as is will=
 allow</div><div>running openvpn-gui --help even whhen an instance is alrea=
dy running.</div><div><br></div><div>This is not to say a help menu is of n=
o interest --- I would very much like to</div><div>have help documentation =
accessible from the GUI. But it has to show something</div><div>useful to a=
n average user -- not a bunch of command line arguments.</div><div><br></di=
v><div>Writing docs is one thing that even non-programmers can contribute t=
o. We could</div><div>link to (or distribute with the GUI) an html page lik=
e</div><div><a href=3D"https://community.openvpn.net/openvpn/wiki/OpenVPN-G=
UI">https://community.openvpn.net/openvpn/wiki/OpenVPN-GUI</a> if that is b=
rought</div><div>in line with the current state of the GUI. Several things =
like need for admin rights,</div><div>config file locations etc. are totall=
y outdated in there. Also show how to import</div><div>configs which is the=
 first thing a user would would want to do etc...</div><div><br></div><div>=
Any volunteers to bring it up to date or point to something better?</div><d=
iv><br></div><div>Thanks,</div><div><br></div><div>Selva</div></div></div><=
/div>

--94eb2c046b9ed0d16f055f73915e--

