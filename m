From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <56C32BCD.1050407@...515...>
Date: Tue, 16 Feb 2016 16:01:49 +0200
MIME-Version: 1.0
Subject: [Openvpn-devel] Handling bitness (32/64) for OpenVPN Windows
	installers
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

We currently produce four installers per OpenVPN 2.3.x release:

- 64-bit for Windows Vista+
- 32-bit for Windows vista+
- 64-bit for Windows XP
- 32-bit for Windows XP

The latter two will be dropped in OpenVPN 2.4 alpha releases, which are=20
due fairly soon[*]. That leaves us with one 32-bit and one 64-bit=20
installer. While that is not too bad, things could be simpler. Here are=20
a few suggestions:

1) Combine 32-bit and 64-bit installers into one

Is there a use-case for installing 32-bit OpenVPN on a 64-bit system?=20
If not, we could combine both 32-bit and 64-bit binaries into a single=20
installers and, at install time, select the correct ones to install.=20
This would increase installer size from ~1.8MB to ~3.3MB.

2) Drop the 64-bit installer altogether

This option was brought forth earlier, and while it felt to me like a=20
step back, I could not point my finger at any concrete issues. If you=20
know of any pros or cons, please speak up.

3) Hide the 32-bit installers better, but keep them available

Currently both 32-bit and 64-bit installers are displayed side-by-side=20
on the download page. Because of this it is difficult to tell how many=20
people really _need_ the 32-bit version, and how many just download it=20
out of habit, or by mistake. Making the download link for 32-bit=20
installer(s) less prominent would probably give us the answer. If=20
complaints started coming in we could backpedal real quickly.

Unfortunately 32-bit Windows systems are not going away anytime soon, so=20
"64-bit only" is not an option[**].

4) Maintain the status quo

Do not change anything.

---

Let me know which of the options seems most reasonable. It would be good=20
to reach some consensus before OpenVPN 2.4-alpha1 is released.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

[*] All the major functionality is in Git "master" or is being actively=20
reviewed.
[**] E.g.=20
<http://news.softpedia.com/news/Microsoft-Explains-Why-Windows-10-32-Bit-Is=
-Still-Needed-469563.shtml>

