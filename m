MIME-Version: 1.0
In-Reply-To: <45635479-7296-752e-193c-083d189cc3a7@...277...>
References: <45635479-7296-752e-193c-083d189cc3a7@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 23 Nov 2017 18:59:30 -0500
Message-ID: <CAKuzo_incnQKuZK5SFAVXcqOKbLVDSf6X9k23_Ucnwy6e2x2qw@...278...>
Content-Type: multipart/alternative; boundary="001a114ff3264de31e055eaf3b51"
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

--001a114ff3264de31e055eaf3b51
Content-Type: text/plain; charset="UTF-8"

Hi

On Thu, Nov 23, 2017 at 1:34 PM, fragmentux <fragmentux@...277...> wrote:
>
> Hi,
>
> I would like to suggest that, instead of having to run the GUI to
> retrieve the help, like so:
>
> 'C:\Program Files\Openvpn\bin\openvpn-gui --help'
>
> the 'help window' can be retrieved via the GUI itself.
> A menu option or Help button ..
>
> Otherwise, because teh GUI is set on install to run by default at user
> logon it is not possible to run another instance to retrieve the help.
> Unless you quit the running GUI first.

Yeah, that's bad. But, a help menu option in the GUI may raise
expectations of a proper documentation that describes how to use
the GUI, not just a list of a command line options. Until "someone" (not me
:)
writes a doc describing the usage, including scripts, script timeouts,
default config/log/script locations etc., a help menu item would be
premature.

We could just allow running a second instance with  --help. The gui
PR #188 implements a more user-friendly handling of a second instance,
ways to send commands to the running GUI etc, so its easy to add
such a feature on top of it.

Selva

--001a114ff3264de31e055eaf3b51
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi<br><br>On Thu, Nov 23, 2017 at 1:34 PM, <span class=3D"=
" id=3D":4ag.1" tabindex=3D"-1" style=3D"">fragmentux</span> &lt;<span clas=
s=3D"" id=3D":4ag.2" tabindex=3D"-1" style=3D"">fragmentux</span>@<a href=
=3D"http://gmail.com">gmail.com</a>&gt; wrote:<br>&gt;<br>&gt; Hi,<br>&gt;<=
br>&gt; I would like to suggest that, instead of having to run the GUI to<b=
r>&gt; retrieve the help, like so:<br>&gt;<br>&gt; &#39;C:\Program Files\<s=
pan class=3D"" id=3D":4ag.3" tabindex=3D"-1" style=3D"">Openvpn</span>\bin\=
<span class=3D"" id=3D":4ag.4" tabindex=3D"-1" style=3D"">openvpn</span>-<s=
pan class=3D"" id=3D":4ag.5" tabindex=3D"-1" style=3D"">gui</span> --help&#=
39;<br>&gt;<br>&gt; the &#39;help window&#39; can be retrieved via the GUI =
itself.<br>&gt; A menu option or Help button ..<br>&gt;<br>&gt; Otherwise, =
because <span class=3D"" id=3D":4ag.6" tabindex=3D"-1" style=3D"">teh</span=
> GUI is set on install to run by default at user<br>&gt; <span class=3D"" =
id=3D":4ag.7" tabindex=3D"-1" style=3D"">logon</span> it is not possible to=
 run another instance to retrieve the help.<br>&gt; Unless you quit the run=
ning GUI first.<br><br>Yeah, that&#39;s bad. But, a help menu option in the=
 GUI may raise<br>expectations of a proper documentation that describes how=
 to use<br>the GUI, not just a list of a command line options. Until &quot;=
someone&quot; (not me :)<br>writes a doc describing the usage, including sc=
ripts, script timeouts,<br>default <span class=3D"" id=3D":4ag.8" tabindex=
=3D"-1" style=3D"">config</span>/log/script locations etc., a help menu ite=
m would be<br>premature.<br><br>We could just allow running a second instan=
ce with =C2=A0--help. The <span class=3D"" id=3D":4ag.9" tabindex=3D"-1" st=
yle=3D"">gui</span> <br>PR #188 implements a more user-friendly handling of=
 a second instance,<br>ways to send commands to the running GUI etc, so its=
 easy to add<br>such a feature on top of it.<br><br><span class=3D"" id=3D"=
:4ag.10" tabindex=3D"-1" style=3D"">Selva</span><br></div>

--001a114ff3264de31e055eaf3b51--

