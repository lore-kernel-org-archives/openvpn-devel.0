From: Heiko Hund <hhund@...194...>
Date: Fri, 18 Mar 2011 17:26:51 +0100
References: <20110317054155.GA9684@...1029...>
	<201103181442.48308.hhund@...194...>
	<20110318144325.GF26254@...1029...>
In-Reply-To: <20110318144325.GF26254@...1029...>
MIME-Version: 1.0
Message-Id: <201103181726.51810.hhund@...194...>
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

Hi Thomas.

On Friday 18 March 2011 15:43:25 Thomas Glanzmann wrote:
> > > Fri Mar 18 13:56:53 2011 Error opening 'HTTP Proxy' auth file:
> > > C:\DOCUME~1\adglth0\LOCALS~1\Temp\openvpn_authfile.: Das System kann
> > > die angegebene Datei nicht finden.   (errno=3D2)
> >=20
> > That's a openvpn error message not one of the GUI. Did you see the dot
> > (.) at the end of the filename? How does openvpn know about it? I
> > don't see it mentioned in your configuration.
>=20
> I thought that the GUI now adds a line to the openvpn command line when
> starting the config and writing out the above file, but it doesn't seem
> to do that.  Am I mistaken?

I checked and you are right. I blindly believed the proxy credentials are a=
lso=20
queried from the user via the management interface but that's not the case=
=20
currently. Haven't look too much at the proxy code obviously. =3D) The GUI =
could=20
use the auto flag with the --http-proxy option in the future, I'll give it =
a=20
try next week.

The incomplete filename is caused by a too small buffer in the GUI. You mus=
t=20
be using a hostname for the proxy and it's somewhere close to 30 characters=
=20
long, right? I'll add a bug to the tracker for this then. In the meantime,=
=20
could you please try if it works for you using the proxy IP address.
=20
> > How or where did it mention this? I can't recall removing anything like
> > it.
>=20
> When I install openvpn 2.2 RC from the openvpn community website[1] it
> says 'Use Internet Explorer Settings (manually configured)'. Your
> version says 'Use Internet Explorer Settings'.

Yes, I remember removing this. Thought it had no additional information.
Maybe a better solution would be to query the system for the right proxy.=20
Pointers anyone?

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

