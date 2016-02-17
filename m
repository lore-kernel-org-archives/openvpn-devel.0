Message-ID: <4C31798F36DC4AEAB6F32F82028081C3@...2089...>
From: <debbie10t@...277...>
References: <56C32BCD.1050407@...515...>
Date: Wed, 17 Feb 2016 13:37:45 -0000
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Handling bitness (32/64) for OpenVPN
	Windowsinstallers
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; format="flowed"; charset="iso-8859-15"; reply-type="original"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net, =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>

I would say option 3 is better ..
doubling the installer size for 32bit seems like bloat! to me
plus .. why do all that extra work for something that will have
diminishing value ?

my2c

----- Original Message -----=20
From: "Samuli Sepp=E4nen" <samuli@...515...>
To: <openvpn-devel@lists.sourceforge.net>
Sent: Tuesday, February 16, 2016 2:01 PM
Subject: [Openvpn-devel] Handling bitness (32/64) for OpenVPN
Windowsinstallers


Hi,

We currently produce four installers per OpenVPN 2.3.x release:

- 64-bit for Windows Vista+
- 32-bit for Windows vista+
- 64-bit for Windows XP
- 32-bit for Windows XP

The latter two will be dropped in OpenVPN 2.4 alpha releases, which are
due fairly soon[*]. That leaves us with one 32-bit and one 64-bit
installer. While that is not too bad, things could be simpler. Here are
a few suggestions:

1) Combine 32-bit and 64-bit installers into one

Is there a use-case for installing 32-bit OpenVPN on a 64-bit system?
If not, we could combine both 32-bit and 64-bit binaries into a single
installers and, at install time, select the correct ones to install.
This would increase installer size from ~1.8MB to ~3.3MB.

2) Drop the 64-bit installer altogether

This option was brought forth earlier, and while it felt to me like a
step back, I could not point my finger at any concrete issues. If you
know of any pros or cons, please speak up.

3) Hide the 32-bit installers better, but keep them available

Currently both 32-bit and 64-bit installers are displayed side-by-side
on the download page. Because of this it is difficult to tell how many
people really _need_ the 32-bit version, and how many just download it
out of habit, or by mistake. Making the download link for 32-bit
installer(s) less prominent would probably give us the answer. If
complaints started coming in we could backpedal real quickly.

Unfortunately 32-bit Windows systems are not going away anytime soon, so
"64-bit only" is not an option[**].

4) Maintain the status quo

Do not change anything.

---

Let me know which of the options seems most reasonable. It would be good
to reach some consensus before OpenVPN 2.4-alpha1 is released.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

[*] All the major functionality is in Git "master" or is being actively
reviewed.
[**] E.g.
<http://news.softpedia.com/news/Microsoft-Explains-Why-Windows-10-32-Bit-Is=
-Still-Needed-469563.shtml>

---------------------------------------------------------------------------=
---
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=3D272487151&iu=3D/4140
_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel


