Message-ID: <44C6D78073AD4F91B8A4B3D2F040430C@...2089...>
From: <debbie10t@...277...>
References: <56C3205A.6050408@...515...>
Date: Tue, 16 Feb 2016 22:28:52 -0000
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Always including tap-windows6,
	openvpn-gui and easy-rsa in openvpn-build -generated Windows
	installers?
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
To: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>, openvpn-devel@lists.sourceforge.net

Hi

I am not particularly looking forward to the flood of confused
windows users. Perhaps a new Windows Forum/board could
be considered for such a change ..

my2c :-)


----- Original Message -----=20
From: "Samuli Sepp=E4nen" <samuli@...515...>
To: <openvpn-devel@lists.sourceforge.net>
Sent: Tuesday, February 16, 2016 1:12 PM
Subject: [Openvpn-devel] Always including tap-windows6, openvpn-gui and
easy-rsa in openvpn-build -generated Windows installers?


Hi,

Currently openvpn-build allows producing installers which do not
_contain_ tap-windows6, openvpn-gui or easy-rsa at all. On top of this
one can - at install time - select which of the contained components are
intalled.

Let me know if you have good arguments on why we should have the option
to generate installers without the said components. If nobody speaks up,
I'll remove the conditional code from openvpn.nsi while preparing for
the OpenVPN 2.4 release.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

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


