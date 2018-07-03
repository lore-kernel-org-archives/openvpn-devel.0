MIME-Version: 1.0
In-Reply-To: <20180703070902.GV989@...1296...>
References: <1530581086-7825-1-git-send-email-selva.nair@...277...>
 <CAEsd45SC3aXgJYX33gFyF53A3njcbokK8ho_G7-6VDVG84zNfA@...278...>
 <20180703070902.GV989@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 3 Jul 2018 10:31:52 -0400
Message-ID: <CAKuzo_gkZ_Fz_-KVNBDr+k3LVRC7vokp-SsNYKoyhmS1=KX2pg@...278...>
Content-Type: multipart/alternative; boundary="000000000000124b440570192eb3"
Subject: Re: [Openvpn-devel] [PATCH] Make up/down script errors not FATAL
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

--000000000000124b440570192eb3
Content-Type: text/plain; charset="UTF-8"

Hi,

On Tue, Jul 3, 2018 at 3:09 AM, Gert Doering <gert@...1296...> wrote:

> Hi,
>
> On Mon, Jul 02, 2018 at 11:13:01PM -0400, Jonathan K. Bullard wrote:
> > My initial reaction is that I'd rather a problem in the up/down
> > scripts generates a fatal error, so if there's a problem in the
> > Tunnelblick scripts somebody will report it. In my experience, almost
> > nobody pays attention to warnings, and mostly, those who do are
> > worried about warning that don't matter.
>
> From how I read Selva's mail, an error in the script will still create
> a fatal error.
>
> The difference is that today, if you have --script-security 1 and a --up
> config, that combination will cause an error, while after the change, this
> will only cause a warning.
>
> Selva, did I read that correctly?
>

Unfortunately no. This patch will trigger only a warning for both a script
error
and inability execute the script due to script-security setting.

If actual errors in up/down scripts should trigger M_FATAL, we can change
the
patch to just bypass the script execution if script security is < 2. It
would be a
bit ugly like this:

-        openvpn_run_script(&argv, es, 0, "--up/--down");
+       openvpn_run_script(&argv, es, (script_security >= SSEC_SCRIPTS)?
S_FATAL : 0, "--up/--down");


For some reason the code path involved is somewhat convoluted:

First we log a warning that external scripts require script_security >= 2.
But fully knowing its going to fail we still call openvpn_run_script(). The
flag
that say error out or warn is set in this call and script permission is
checked just before executing:

openvpn_run_script() --> openvpn_execve_check() --> openvpn_execve_allowed()

When the latter returns an error due to script-security,
openvpn_execve_check()
fails with a slightly misleading message.

Selva

--000000000000124b440570192eb3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><div class=3D"gmail_extra"><br><div class=3D"gmail_=
quote">On Tue, Jul 3, 2018 at 3:09 AM, Gert Doering <span dir=3D"ltr">&lt;<=
a href=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1296...</a>&gt;=
</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
<span class=3D"m_4065982707826998152gmail-"><br>
On Mon, Jul 02, 2018 at 11:13:01PM -0400, Jonathan K. Bullard wrote:<br>
&gt; My initial reaction is that I&#39;d rather a problem in the up/down<br>
&gt; scripts generates a fatal error, so if there&#39;s a problem in the<br>
&gt; Tunnelblick scripts somebody will report it. In my experience, almost<=
br>
&gt; nobody pays attention to warnings, and mostly, those who do are<br>
&gt; worried about warning that don&#39;t matter.<br>
<br>
</span>From how I read Selva&#39;s mail, an error in the script will still =
create<br>
a fatal error.=C2=A0 <br>
<br>
The difference is that today, if you have --script-security 1 and a --up <b=
r>
config, that combination will cause an error, while after the change, this =
<br>
will only cause a warning.<br>
<br>
Selva, did I read that correctly?<br></blockquote><div><br></div><div>Unfor=
tunately no. This patch will trigger only a warning for both a script error=
</div><div>and inability execute the script due to script-security setting.=
</div><div><br></div><div>If actual errors in up/down scripts should trigge=
r M_FATAL, we can change the</div><div>patch to just bypass the script exec=
ution if script security is &lt; 2. It would be a</div><div>bit ugly like t=
his:</div><div><br></div><div><div>- =C2=A0 =C2=A0 =C2=A0 =C2=A0openvpn_run=
_script(&amp;argv, es, 0, &quot;--up/--down&quot;);</div><div>+ =C2=A0 =C2=
=A0 =C2=A0 openvpn_run_script(&amp;argv, es, (script_security &gt;=3D SSEC_=
SCRIPTS)? S_FATAL : 0, &quot;--up/--down&quot;);</div></div><div><br></div>=
<div><br></div><div>For some reason the code path involved is somewhat conv=
oluted:</div><div><br></div><div>First we log a warning that external scrip=
ts require script_security &gt;=3D 2.</div><div>But fully knowing its going=
 to fail we still call openvpn_run_script(). The flag</div><div>that say er=
ror out or warn is set in this call and script permission is</div><div>chec=
ked just before executing:</div><div><br></div><div>openvpn_run_script() --=
&gt; openvpn_execve_check() --&gt; openvpn_execve_allowed()</div><div><br><=
/div><div>When the latter returns an error due to script-security, openvpn_=
execve_check()</div><div>fails with a slightly misleading message.</div><di=
v><br></div><div>Selva</div></div></div></div>

--000000000000124b440570192eb3--

