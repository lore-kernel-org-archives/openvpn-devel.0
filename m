Message-ID: <558AD438.9050105@...515...>
Date: Wed, 24 Jun 2015 19:00:56 +0300
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Writing an OpenVPN-specific NSSM configuration
	frontend?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

There is a question at the end, so scroll down if you're impatient :).=20
Anyways, some of you may know I've been looking into NSSM:

<http://nssm.cc>

The idea is to use NSSM to replace the OpenVPN Service Wrapper=20
("openvpnserv.exe") which is buggy, unmaintained, causes all sorts of=20
issues and seems disintegrate more and more with every new Windows release.

NSSM on is actively maintained[1] general purpose service manager which=20
can launch an arbitrary program and restart it if it crashes. NSSM=20
registers itself as a Windows service and manages a set of services,=20
which can be arbitrary programs. In our case nssm.exe would run a=20
command such as this:

..\bin\openvpn.exe --config default.ovpn

The working directory would be set to C:\Program Files\OpenVPN\config.=20
Should an OpenVPN process die, nssm.exe would respawn it immediately.=20
Note that each OpenVPN connection is monitored separately.

For the corporate use-case simply bundling nssm.exe along with=20
instructions and maybe a simple template script would suffice:

<https://community.openvpn.net/openvpn/wiki/IntegratingOpenvpnWithNssm>

However, in the general case we have a problem. OpenVPN connections can=20
be added and removed by the user at a whim, so the user has to be able=20
to configure nssm.exe him/herself at any time. All we'd really need is a=20
GUI similar to this:

---
"OpenVPN connections to launch and monitor automatically on boot:"

[x] foo
[x] bar
[  ] def
---

Checking or unchecking a checkbox would simply run nssm.exe with=20
appropriate command-line parameters. If the user needs more fine-grained=20
control over nssm.exe's behavior he/she can resort to using nssm.exe's=20
GUI or command-line.

After several hours of research I'm leaning towards one of these options:

1) An interactive batch file

This would do the trick, but would be fairly crude and unsophisticated.=20
Powershell would be way better, but Windows Vista (not EOL until 2017)=20
does not have it installed by default.

2) Simple C# GUI application

Write a real C# application would be way more work than #1, but still=20
not a huge task. In addition this  application could be later extended=20
for other tasks such as turning on/off openvpnserv.exe and=20
adding/removing tap-windows adapters.

---

Any other suggestions on how to solve this issue? Am I overlooking some=20
obvious? And most importantly: does anyone feel like participating in=20
this fun Windows development adventure? :P

Best regards,

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

[1] That said, according Git logs the project is maintained by a single=20
person.

