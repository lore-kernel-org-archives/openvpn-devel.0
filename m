From: "=?windows-1252?q?Fran=E7ois?= Revol" <revol@...260...>
Message-Id: <4215141998-BeMail@...261...>
Mime-Version: 1.0
Subject: [Openvpn-devel] OpenVPN 1.5.0 ported to BeOS (Zeta)
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Sat Aug  7 07:40:07 2004
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net
Cc: =?windows-1252?q?Fran=E7ois?= Revol <revol@...260...>

Hello,
With the advent of Zeta, the next incarnation of BeOS, using a real BSD
-like network
stack, we had the need for a VPN solution.
Zeta will feature a tuntap driver, which implements the new Linux
tuntap API,
and which I wrote some time ago.
I ported VTun, then OpenVPN 1.5.0.

The patch is here:
http://clapcrest.free.fr/revol/beos/patches/openvpn-1.5.0-beos.patch.002.txt
Might need some more cleanups, but I think I'll have a look at 2.0
soon.


Cheers,
Fran=E7ois  Revol -- yellowTAB - http://yellowtab.com

PS. I'm not subscribded yet.

