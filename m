From: Heiko Hund <hhund@...194...>
Date: Fri, 18 Mar 2011 14:42:47 +0100
References: <20110317054155.GA9684@...1029...>
	<201103181331.51247.hhund@...194...>
	<20110318130226.GD26254@...1029...>
In-Reply-To: <20110318130226.GD26254@...1029...>
MIME-Version: 1.0
Message-Id: <201103181442.48308.hhund@...194...>
Subject: Re: [Openvpn-devel] OpenVPN GUI and ntlm Proxy password
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: Text/Plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Thomas Glanzmann <thomas@...1029...>
Cc: openvpn-devel@lists.sourceforge.net, info@...454...

Hi Thomas,

On Friday 18 March 2011 14:02:26 Thomas Glanzmann wrote:
> > Maybe you want to check out the latest snapshot and see if it works
> > for you.  The GUI uses the OpenVPN management interface for
> > communication and monitoring since a while now. So, there's a fair
> > chance it'll work right away or won't be much work to make it work. =3D)
>=20
> It did not work, because it couldn't read or write the file
>=20
> Fri Mar 18 13:56:53 2011 Error opening 'HTTP Proxy' auth file:
> C:\DOCUME~1\adglth0\LOCALS~1\Temp\openvpn_authfile.: Das System kann die
> angegebene Datei nicht finden.   (errno=3D2)
>
> containing the credentials. But the directory exists.

That's a openvpn error message not one of the GUI. Did you see the dot (.) =
at=20
the end of the filename? How does openvpn know about it? I don't see it=20
mentioned in your configuration.
=20
> I also saw a few other things that are confusing:
>=20
>         - The 'About' button mentions GUI version 1.3

Yes, it's just a snapshot of the current standing in the repository not a n=
ew=20
released version. There'll be some time passing until it gets a new version.
=20
>         - When using 'Intenet Explorer' to determine the proxy, it
>           doesn't work with proxy pac but doesn't mention  it (the
>           OpenVPN Gui 1.3 did mention that it doesn't work with proxy
>           pacs).

How or where did it mention this? I can't recall removing anything like it.

Regards
Heiko
--=20
Heiko Hund | Software Engineer | Phone +49-721-25516-237 | Fax -200
Astaro GmbH & Co. KG | An der RaumFabrik 33a | 76227 Karlsruhe | Germany
Commercial Register: Mannheim HRA 702710 | Headquarter Location: Karlsruhe
=20
Represented by the General Partner Astaro Verwaltungs GmbH
An der RaumFabrik 33a | 76227 Karlsruhe | Germany=20
Commercial Register: Mannheim HRB 708248 | Executive Board: Gert Hansen,
Markus Hennig, Jan Hichert, G=FCnter Junk, Dr. Frank Nellissen

