From: Heiko Hund <heiko.hund@...1489...>
Date: Thu, 22 Oct 2015 07:44:13 +0200
Message-ID: <240917770.LK0kVOX9dJ@...2001...>
In-Reply-To: <CAKuzo_jSiw75PaTed_5DWMbM=X313b75EH6vh9erXS2Q-3fK8Q@...278...>
References: <56211F0D.2010806@...515...> <56261F0D.9020208@...515...>
	<CAKuzo_jSiw75PaTed_5DWMbM=X313b75EH6vh9erXS2Q-3fK8Q@...278...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Creating a Windows team for OpenVPN?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On Tuesday 20 October 2015 22:12:06 Selva Nair wrote:
> The interactive service (based on a quick scan through the code) looks to
> be very useful on a desktop with a single user, allowing the GUI and open=
vpn
> to run with user privileges. I hope the "windows team" would soon start
> working on making the GUI to work with this new service :)

See, that's the current problem with the OpenVPN Windows things. Too many
people relying on other - non existing - people to do the work. That's why =
we
did not really get anywhere with the interactive service.

> But a sever admin would not want it in the system as it can allow any user
> with some VPN server account to change the routes etc using the
> service..(please correct me if I'm mistaken).

If you do not make the configuration directory writable to anyone, then you=
're
fine. IIRC the GUI has an command line option that would need to be changed=
 in
order to disable loading of arbitrary configs. Besides that the concept is
waterproof.

Heiko


Sophos Technology GmbH, Amalienbadstra=E1=BA=9Ee 41/Bau 52, D-76227 Karlsru=
he, Deutschland
Tel +49 (0)721 25516 0 Fax +49 (0)721 25516 200 E-Mail info@...2075... www.=
sophos.de
Sitz der Gesellschaft: Karlsruhe, Amtsgericht Mannheim HRB 712658
Gesch=C3=A4ftsf=C3=BChrer: Nicholas Bray, Pino von Kienlin, Wolfgang Hilper=
t, Jennifer Onslow.
Sophos GmbH, Gustav-Stresemann-Ring 1, 65189 Wiesbaden, Deutschland
Tel +49 (0) 611 5858-0 Fax +49 (0) 611 5858-1042 E-Mail info@...2075... www=
.sophos.de
Sitz der Gesellschaft: Wiesbaden, Amtsgericht Wiesbaden HRB 25915 Gesch=C3=
=A4ftsf=C3=BChrer: Nicholas Bray, Wolfgang Hilpert, Pino von Kienlin, Jenni=
fer Onslow

