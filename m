MIME-Version: 1.0
From: Selva Nair <selva.nair@...277...>
Date: Mon, 28 Nov 2016 21:12:01 -0500
Message-ID: <CAKuzo_hBp_otOSFdQAZk3Ezf-9APeJDyapZVgF67Kc6-OX0Cow@...278...>
Content-Type: multipart/alternative; boundary=001a114d8ca456cee30542671e58
Subject: [Openvpn-devel] Trac 777 excessive logging with explicit-exit-notify
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a114d8ca456cee30542671e58
Content-Type: text/plain; charset=UTF-8

Hi,

Trac 777 reports repeated SIGUSR1 triggering during exit-notification wait
and log trashing.

As Gert pointed out this is partly related to "commit
63b3e000c9141f4ca03a374354da26334257bc18
<https://community.openvpn.net/openvpn/changeset/63b3e000c9141f4ca03a374354da26334257bc18/>,
which basically is a fix for #687"
<https://community.openvpn.net/openvpn/ticket/687>

Looked into this further and I can reproduce it even on Linux with some
carefully timed ctrl-c. To see this, TLS negotiation timeout has to happen
during the exit-notification wait --- use an unreachabe udp port,
--exit-notify 5 and press ctrl-c just before the 60 second handshake_window
expires. --ping-restart > 60 sec required too.

The relevant code path is active only while in the event loop. If the loop
cannot continue due to io error or timeout, it does a SIGUSR1 restart which
we ignore during an exit-notify wait period. Control goes back to the event
loop and it promptly triggers restart again. Ideally the code triggering
SIGUSR1/SIGHUP should check whether SIGTERM is pending (due to exit-notify)
before setting signal, but there are too many places from where it can
trigger. (Refactoring signals is still a work in progress on my side).

So I suggest to handle this in ignore_restart_signals() in sig.c, by
remapping "soft" restart signals to SIGTERM and cause an immediate exit.
This is sensible because, if the event loop cannot continue, exit-notify
too cannot. Hard signals come from management or the OS (kill -HUP pid, or
ctrl-c kind) and cannot get into a loop, those need not be remapped, thus
allowing for exit-notify to complete.

Alternatively, it could also be done in remap_signal() which currently
re-maps SIGUSR1 to SIGHUP when appropriate.

A patch follows.

With the patch applied:

press ctrl-C just before TLS Error will trigger:

Mon Nov 28 19:43:43 2016 us=288138 SIGTERM received, sending exit
notification to peer
Mon Nov 28 19:43:44 2016 us=313371 TLS Error: TLS key negotiation failed to
occur within 60 seconds (check your network connectivity)
Mon Nov 28 19:43:44 2016 us=313405 TLS Error: TLS handshake failed


*Mon Nov 28 19:43:44 2016 us=313502 Converting soft SIGUSR1 received during
exit notification to SIGTERM*
*(It would have triggered a barrage of SIGUSR1 s here otherwise)*

Mon Nov 28 19:43:44 2016 us=313606 TCP/UDP: Closing socket
Mon Nov 28 19:43:44 2016 us=313641 SIGTERM[soft,exit-with-notification]
received, process exiting

Selva

--001a114d8ca456cee30542671e58
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,<br><br>Trac 777 reports repeated SIGUSR1 triggeri=
ng during exit-notification wait and log trashing.<br><br>As Gert pointed o=
ut this is partly related to &quot;commit <a class=3D"gmail-changeset" href=
=3D"https://community.openvpn.net/openvpn/changeset/63b3e000c9141f4ca03a374=
354da26334257bc18/" title=3D"Ignore SIGUSR1/SIGHUP during exit notification

This allows exit ...">63b3e000c9141f4ca03a374354da26334257bc18</a>, which b=
asically is a fix for <a class=3D"gmail-new gmail-ticket" href=3D"https://c=
ommunity.openvpn.net/openvpn/ticket/687" title=3D"Bug / Defect: SIGTERM (so=
ft) lost if followed by a SIGUSR1/SIGHUP restart during the ... (new)">#687=
&quot;</a><br><br>Looked into this further and I can reproduce it even on L=
inux with some carefully timed ctrl-c. To see this, TLS negotiation timeout=
 has to happen during the exit-notification wait --- use an unreachabe udp =
port, --exit-notify 5 and press ctrl-c just before the 60 second handshake_=
window expires. --ping-restart &gt; 60 sec required too. <br><br>The releva=
nt code path is active only while in the event loop. If the loop cannot con=
tinue due to io error or timeout, it does a SIGUSR1 restart which we ignore=
 during an exit-notify wait period. Control goes back to the event loop and=
 it promptly triggers restart again. Ideally the code triggering SIGUSR1/SI=
GHUP should check whether SIGTERM is pending (due to exit-notify) before se=
tting signal, but there are too many places from where it can trigger. (Ref=
actoring signals is still a work in progress on my side).<br><br>So I sugge=
st to handle this in ignore_restart_signals() in sig.c, by remapping &quot;=
soft&quot; restart signals to SIGTERM and cause an immediate exit. This is =
sensible because, if the event loop cannot continue, exit-notify too cannot=
. Hard signals come from management or the OS (kill -HUP pid, or ctrl-c kin=
d) and cannot get into a loop, those need not be remapped, thus allowing fo=
r exit-notify to complete.<br><br>Alternatively, it could also be done in r=
emap_signal() which currently re-maps SIGUSR1 to SIGHUP when appropriate.<b=
r><br>A patch follows.<br><br></div><div>With the patch applied:<br></div><=
div><br>press ctrl-C just before TLS Error will trigger:<br><br>Mon Nov 28 =
19:43:43 2016 us=3D288138 SIGTERM received, sending exit notification to pe=
er<br>Mon Nov 28 19:43:44 2016 us=3D313371 TLS Error: TLS key negotiation f=
ailed to occur within 60 seconds (check your network connectivity)<br>Mon N=
ov 28 19:43:44 2016 us=3D313405 TLS Error: TLS handshake failed<br><b>Mon N=
ov 28 19:43:44 2016 us=3D313502 Converting soft SIGUSR1 received during exi=
t notification to SIGTERM<br><br></b></div><i>(It would have triggered a ba=
rrage of SIGUSR1 s here otherwise)</i><b><br></b><div><br>Mon Nov 28 19:43:=
44 2016 us=3D313606 TCP/UDP: Closing socket<br>Mon Nov 28 19:43:44 2016 us=
=3D313641 SIGTERM[soft,exit-with-notification] received, process exiting<br=
><br></div><div>Selva<br></div></div>

--001a114d8ca456cee30542671e58--

