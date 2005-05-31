Subject: Re: [Openvpn-devel] Re: Re: Radius support (Authentification,
	Authorization and Accounting)
From: Torge Szczepanek <openvpn-devel@...239...>
In-Reply-To: <200505311009.03402.ralfluebben@...68...>
References: <200504291033.00667.ralfluebben@...68...>
	 <d7fjlh$hrc$1@...165...> <1117524566.11540.16.camel@...23...>
	 <200505311009.03402.ralfluebben@...68...>
Message-Id: <1117542280.11895.14.camel@...23...>
Mime-Version: 1.0
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
Date: Tue May 31 05:27:36 2005
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Am Dienstag, den 31.05.2005, 10:09 +0000 schrieb Ralf L=FCbben:

> If a client connects the nas port number is locked , if a client disconne=
ct=20
> the port number is freed.=20
> A new client will always get the least number of the array.
>=20
> Would this behaviour ok?

Yes. That would be OK.

> How many nas port numbers will I need?
> I think 1000 will be enough or can there be more than 1000 clients at=20
> the same time?

Hmm. Must there be a limit? I am asking since I had some troubles with a
PPTP VPN pushing this to more than 100 or 256 users. So software
hardlimits aren't really a good choice. If this isn't to much work I
would suggest to put in a dynamic variable. Since you are using C++ you
might just use a STL type? I don't know whether STLs are portable across
platforms...




