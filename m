MIME-Version: 1.0
From: Selva Nair <selva.nair@...277...>
Date: Fri, 12 Feb 2016 14:47:26 -0500
Message-ID: <CAKuzo_iGh60f6nhKL39pgLVjYsuq479V1cU8_N9NPccJ1_2+8A@...278...>
Content-Type: multipart/alternative; boundary=001a113d54f8ec8af7052b97f039
Subject: [Openvpn-devel] interactive service and stdout/stderr pipes
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a113d54f8ec8af7052b97f039
Content-Type: text/plain; charset=UTF-8

Hi,

Currently the interactive service uses anonymous pipes for stdout and
stderr in CreateProcess to start OpenVPN. But the service doesn't actively
read from these pipes until the process exits with a non-zero error code.
Any output thus read goes to the service pipe and EventLog which a casual
end user never sees.

The bad side of this is the potential for deadlock which is especially bad
when verb > 3: the pipe buffer may run out early causing write to block in
msg (), with no or little output in the management interface.

Shall we change this to use /dev/null (i.e, "NUL" on windows) for both
stdout/stderr ?

Selva

--001a113d54f8ec8af7052b97f039
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>Currently the interactive service u=
ses anonymous pipes for stdout and stderr in CreateProcess to start OpenVPN=
. But the service doesn&#39;t actively read from these pipes until the proc=
ess exits with a non-zero error code. Any output thus read goes to the serv=
ice pipe and EventLog which a casual end user never sees.</div><div><br></d=
iv><div>The bad side of this is the potential for deadlock which is especia=
lly bad when verb &gt; 3: the pipe buffer may run out early causing write t=
o block in msg (), with no or little output in the management interface.</d=
iv><div><br></div><div>Shall we change this to use /dev/null (i.e, &quot;NU=
L&quot; on windows) for both stdout/stderr ?</div><div><br></div><div>Selva=
</div></div>

--001a113d54f8ec8af7052b97f039--

