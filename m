MIME-Version: 1.0
From: Selva Nair <selva.nair@...277...>
Date: Sat, 31 Oct 2015 13:03:42 -0400
Message-ID: <CAKuzo_hdohByd29VTjx=Q7bM9zZCqp85W=u=nJwJ3-HLqN1zSg@...278...>
Content-Type: multipart/alternative; boundary=001a11443346dff50405236987e3
Subject: [Openvpn-devel] Windows: stopping openvpn using nssm
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a11443346dff50405236987e3
Content-Type: text/plain; charset=UTF-8

Hi,

When nssm is used to start openvpn, "nssm stop service-name" appears to
terminate the process not so gracefully. Especially, the log doesn't show
the usual "SIGTERM received, sending exit-notify" (for example) nor does
the the management interface get the state change message saying EXITING.
(Tested on version 2.3.6)

I thought adding --service to the command line may cure this, but it
doesn't. Any suggestions on how to teach openvpn to process termination by
nssm as a SIGTERM, or make nssm send a SIGTERM?

Thanks,

Selva

--001a11443346dff50405236987e3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>Hi,<br><br></div>When nssm is used to start open=
vpn, &quot;nssm stop service-name&quot; appears to terminate the process no=
t so gracefully. Especially, the log doesn&#39;t show the usual &quot;SIGTE=
RM received, sending exit-notify&quot; (for example) nor does the the manag=
ement interface get the state change message saying EXITING.=C2=A0 (Tested =
on version 2.3.6)<br><br></div><div>I thought adding --service to the comma=
nd line may cure this, but it doesn&#39;t. Any suggestions on how to teach =
openvpn to process termination by nssm as a SIGTERM, or make nssm send a SI=
GTERM?<br><br></div><div>Thanks,<br><br></div><div>Selva<br></div><div><br>=
</div><br></div>

--001a11443346dff50405236987e3--

