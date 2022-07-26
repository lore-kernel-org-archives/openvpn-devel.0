MIME-Version: 1.0
From: Selva Nair <selva.nair@...277...>
Date: Mon, 25 Jul 2022 22:36:02 -0400
Message-ID: <CAKuzo_jd0jh8ZDKU2bsOric9Fef7uS+Nd+Ra3Tnkz1dSNUcoRg@...278...>
Content-Type: multipart/alternative; boundary="0000000000004ddd5205e4ac2b2f"
Subject: [Openvpn-devel] Response from management i/f lost in some cases.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0000000000004ddd5205e4ac2b2f
Content-Type: text/plain; charset="UTF-8"

Hi,

Generally we expect a response of "SUCCESS: ...." or "ERROR: ..." to every
command sent to the management interface (in mult-line cases, a terminating
line with "END" too). I've noticed a couple of situations where this is
either missing or gets lost.

(i) While in the hold state, sending "signal SIGHUP" returns only the
following reply:
>HOLD:Waiting for hold release:0
instead of "ERROR: signals are currently disabled", followed by the above
line. (management signals are disabled when on hold).

(ii) The second case is somewhat complex -- at times the daemon does not
send back any response. I've seen this happen only if a command is sent by
the management client when the demon is busy sending LOG messages -- for
example, the user wants to restart and we send "signal SIGHUP" -- if this
gets no response we stall in the GUI waiting for the reply.

I think this is what's happening:  M_CLIENT messages are dropped by
virtual_output_callback() when it gets called recursively. When the daemon
is outputting, say, log lines to the client the above function gets called,
it then calls management_io() to send the message out. But, in
management_io() we process both reads and writes and if a read comes in at
that time, we process it synchronously, generate the response with
flag=M_CLIENT, end up in recursing into virtual_output_callback(). The
response gets dropped there because recursive_level > 0 (recursion not
allowed).

As one cannot control when a user may hit reconnect, this needs to be
fixed.

Would it be okay to allow a few levels of recursion in
virtual_output_callback? One seldom sends more than a couple of commands in
a succession especially when not prompted by the daemon. Allowing
recursive_level up to 5 (or even 3) would go a long way.

Regards,

Selva

--0000000000004ddd5205e4ac2b2f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div><br></div><div>Generally we expect a re=
sponse of &quot;SUCCESS: ....&quot; or &quot;ERROR: ...&quot; to every comm=
and sent to the management interface (in <span class=3D"" id=3D":4cx.1" tab=
index=3D"-1" role=3D"menuitem" aria-haspopup=3D"true" style=3D"">mult</span=
>-line=C2=A0cases, a terminating line with &quot;END&quot; too). I&#39;ve n=
oticed a couple of situations where this is=C2=A0 either missing or gets lo=
st.</div><div><br></div><div>(i) While in the hold state, sending &quot;sig=
nal SIGHUP&quot; returns only the following reply:</div>&gt;HOLD:Waiting fo=
r hold release:0<div>instead of &quot;ERROR: signals are currently disabled=
&quot;, followed by the above line. (management signals are disabled when o=
n hold).</div><div><div><br></div></div><div>(ii) The second case is somewh=
at complex -- at times the daemon does not send back any response. I&#39;ve=
 seen this happen only if a command is sent by the management client when t=
he demon=C2=A0is busy sending LOG messages -- for example, the user wants t=
o restart and we send &quot;signal SIGHUP&quot; -- if this gets no response=
 we stall in the GUI waiting for the reply.</div><div><br></div><div>I thin=
k this is what&#39;s happening:=C2=A0 M_CLIENT messages are dropped by virt=
ual_output_callback() when it gets called recursively. When the daemon is o=
utputting, say, log lines to the client the above function gets called, it =
then calls management_io() to send the message out. But, in management_io()=
 we process both reads and writes and if a read comes in at that time, we p=
rocess it synchronously, generate the response with flag=3DM_CLIENT, end up=
 in recursing into virtual_output_callback(). The response gets dropped the=
re because recursive_level &gt; 0 (recursion not allowed).</div><div><br></=
div><div>As one cannot control when a user may hit reconnect, this needs to=
 be fixed.=C2=A0=C2=A0</div><div><br></div><div>Would it be okay to allow a=
 few levels=C2=A0of recursion in virtual_output_callback? One seldom=C2=A0s=
ends more than a couple of commands in a succession especially when not pro=
mpted by the daemon. Allowing recursive_level up to 5 (or even 3) would go =
a long way.</div><div><br></div><div>Regards,</div><div><br></div><div>Selv=
a</div></div>

--0000000000004ddd5205e4ac2b2f--

