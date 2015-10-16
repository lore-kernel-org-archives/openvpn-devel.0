Message-ID: <56211F0D.2010806@...515...>
Date: Fri, 16 Oct 2015 19:00:13 +0300
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Creating a Windows team for OpenVPN?
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

In Delft we talked about issues with Windows version of OpenVPN quite a=20
lot. Of the top of my hat I can recall the following isuses:

- The tap-windows/tap-windows6 drivers have fairly bad performance
- In Windows 10 there are DNS leaks
- The service wrapper (openvpnserv.exe) is effectively broken for=20
Windows 8 and later
- The service wrapper has very limited functionality
- The OpenVPN-GUI we bundle has several major issues, most related to=20
having to run it as an admin
- Suspend/hibernate seems to break OpenVPN tunnels quite often
- Building for Windows is and has always been a pain

In a nutshell, Windows development a timesink and nobody wants to do it=20
and/or does not have the required skills. Moreover, nobody wants to be=20
tagged as the "Windows guy", because that would mean being the go-to=20
person for all Windows problems.

I'm thinking it might make sense to create a dedicated Windows team that=20
could share the burden of Windows issues amongst themselves, without any=20
one person gettings tagged the "Windows guy". I would naturally be part=20
of the team, because I already build the official OpenVPN installers and=20
tap-windows drivers, plus I've worked with openvpn-gui quite a lot and=20
am working on a replacement for openvpnserv.exe.

The Windows team could have a separate board on OpenVPN forums and maybe=20
even a separate IRC channel. This is fairly typical arrangement in Linux=20
distributions, which have topic- and language-specific groups. We could=20
then point people with Windows issues/patches/development questions etc.=20
to the Windows team.

Thoughts?

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

