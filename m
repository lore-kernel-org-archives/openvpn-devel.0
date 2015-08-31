MIME-Version: 1.0
From: Valentin Sawadski <valentin@...2062...>
Date: Mon, 31 Aug 2015 11:46:13 +0200
Message-ID: <CABgPX1maNQDV9XzTi8E8NCYSPPvAXgX2=-mza7j=1tQTUgEcXw@...278...>
Subject: [Openvpn-devel] Disable TLS for mode server
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Hello,

I'm looking for a way to remove any encryption or MAC from OpenVPN in
"--mode server".

Since I'm new to the OpenVPN code base my starting point right now
will be patching "options.c" to allow "--mode server" without TLS.
Will this already be enough to make it work or is TLS tightly
integrated into the workings of the mode?

Thanks for any pointers!

Best Regards,
Valentin

P.S. I know it is an odd request to remove the security of TLS but we
want to run a few experiments where the TLS overhead would bias our
results.

--=20
Valentin Sawadski
Founder & Embedded Software

Tel.: +49 - (0) 89 - 716 77 86 - 15
Fax: +49 - (0) 89 - 716 77 86 - 99
Mobil: +49 - (0) 162 - 460 163 4

facebook.com/tado | twitter.com/tado | youtube.com/tado
www.tado.com | tado=C2=B0 GmbH | Lindwurmstr. 76 | 80337 Munich | Germany
Managing Directors: Christian Deilmann | Johannes Schwarz | Leopold v. Bism=
arck
Registered with the Commercial Register Munich as HRB 194769 B |
VAT-No: DE 280012558

