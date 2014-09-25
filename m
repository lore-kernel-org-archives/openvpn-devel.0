MIME-Version: 1.0
Date: Thu, 25 Sep 2014 03:04:02 -0300
Message-ID: <CAHfqr-Zo32XxeXEepPoW7g6iK6KnZPjDpZCr0cYYMXEGJi4Ttw@...278...>
From: Jorge Ramos <jframos@...1935...>
Content-Type: multipart/alternative; boundary=047d7b34354c32d9260503dd91f6
Subject: [Openvpn-devel] Problem with I603-64 under Vista 64 SP2
Reply-To: jramos@...1936...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--047d7b34354c32d9260503dd91f6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,



I installed openvpn-install-2.3.4-I603-x86_64.exe under Vista 64 SP2 and it
didn=E2=80=99t work. VPN connects but don=E2=80=99t work and openvpn-gui ca=
n=E2=80=99t stop openvpn
process. I have tried manually signaling the event sent to openvpn via
command line but it seems that openvpn wasn=E2=80=99t waiting on that. In t=
his
scenario a boot was impossible because openvpn didn=E2=80=99t die. I have to
poweroff the computer each new try (annoying and dangerous) !



I uninstall i603 and install openvpn-install-2.3.4-I003-x86_64.exe and
everything works as expected including the manual signaling of event (I did
it just to be sure, not a normal operation). The connection is usable, but
slow. Probably a network related problem.



I=E2=80=99m not sure if this is a bug or not.


Regards

Jorge Ramos

--047d7b34354c32d9260503dd91f6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"backg=
round-color:rgb(255,255,255)">Hello,</span></p>

<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"background-color:rgb(2=
55,255,255)">=C2=A0</span></p>

<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"background-color:rgb(2=
55,255,255)">I installed
openvpn-install-2.3.4-I603-x86_64.exe under Vista 64 SP2 and it didn=E2=80=
=99t work. VPN
connects but don=E2=80=99t work and openvpn-gui can=E2=80=99t stop openvpn =
process. I have
tried manually signaling the event sent to openvpn via command line but it
seems that openvpn wasn=E2=80=99t waiting on that. In this scenario a boot =
was
impossible because openvpn didn=E2=80=99t die. I have to poweroff the compu=
ter each new
try (annoying and dangerous) !</span></p>

<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"background-color:rgb(2=
55,255,255)">=C2=A0</span></p>

<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"background-color:rgb(2=
55,255,255)">I uninstall
i603 and install openvpn-install-2.3.4-I003-x86_64.exe and everything works=
 as
expected including the manual signaling of event (I did it just to be sure,=
 not
a normal operation). The connection is usable, but slow. Probably a network
related problem.</span></p>

<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"background-color:rgb(2=
55,255,255)">=C2=A0</span></p>

<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"background-color:rgb(2=
55,255,255)">I=E2=80=99m not
sure if this is a bug or not.</span></p>

<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"background-color:rgb(2=
55,255,255)"><br></span></p><p class=3D"MsoNormal"><span lang=3D"EN-US" sty=
le=3D"background-color:rgb(255,255,255)">Regards=C2=A0</span></p>

<p class=3D"MsoNormal">Jorge
Ramos<br></p></div>

--047d7b34354c32d9260503dd91f6--

