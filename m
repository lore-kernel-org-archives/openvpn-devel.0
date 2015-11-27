From: Heiko Hund <heiko.hund@...1489...>
Date: Fri, 27 Nov 2015 10:22:24 +0100
Message-ID: <1552629.Ma3QbTa36D@...1526...>
In-Reply-To: <5655D069.5010906@...1400...>
References: <1447254557-22524-1-git-send-email-heiko.hund@...1489...>
	<5655D069.5010906@...1400...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] extend management interface command
	"state"
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
To: Arne Schwabe <schwabe@...1400...>
Cc: openvpn-devel@lists.sourceforge.net

On Wednesday 25 November 2015 16:14:49 Arne Schwabe wrote:
> Am 11.11.15 um 16:09 schrieb Heiko Hund:
> >        and EXITING to show the reason for the disconnect),
> >
> > -  (d) optional TUN/TAP local IP address (shown for ASSIGN_IP
> > -      and CONNECTED), and
> > -  (e) optional address of remote server (OpenVPN 2.1 or higher).
> > +  (d) optional TUN/TAP local IPv4 address
> > +  (e) optional address of remote server,
> > +  (f) optional port of remote server,
> > +  (g) optional local address,
> > +  (h) optional local port, and
> > +  (i) optional TUN/TAP local IPv6 address.
> > +
> > +Fields (e)-(h) are shown for CONNECTED state,
> > +(d) and (i) are shown for ASSIGN_IP and CONNECTED states.
> > +
> > +(e) is available starting from OpenVPN 2.1
> > +(f)-(i) are available starting from OpenVPN 2.4
>
> Should we add a note that e,f are the connect time and changed because
> of --float? Otherwise ACK from me.

I don't know, anyone else? Another option could be to "connect" again after
floating if this is not done at the moment. But then I think think that wou=
ld
be outside of the scope of this patch.

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

