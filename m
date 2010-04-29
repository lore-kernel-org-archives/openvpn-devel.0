From: Heiko Hund <hhund@...194...>
Date: Thu, 29 Apr 2010 08:30:07 +0200
References: <4BD83FC0.5090607@...515...>
	<201004281638.57498.hhund@...194...>
	<4BD8E485.9060701@...1299...>
In-Reply-To: <4BD8E485.9060701@...1299...>
MIME-Version: 1.0
Message-Id: <201004290830.07398.hhund@...194...>
Subject: Re: [Openvpn-devel] Any volunteer Windows devs to change OpenVPN
	proxying code to use "new" InternetQueryOption API?
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
To: openvpn-devel@lists.sourceforge.net

On Thursday 29 April 2010 03:44:37 Jason Haar wrote:
> On 04/29/2010 02:38 AM, Heiko Hund wrote:
> > If the service is started by the GUI it still makes sense to use user
> > specific proxy settings, doesn't it? One could consider auto-proxy for
> > auto-started VPNs a misconfiguration, as well. Or am I mislead?
>=20
> I think it's critical. Most enterprise networks have egress filtering
> (ie default to blocking outbound with business-exceptions) and web
> access via proxies. They will use WPAD (via HTTP or DHCP) or perhaps
> they are a Windows shop and use Active Directory policies to "tell" MSIE
> how to operate on a particular network. Don't forget enterprise networks
> tend to span continents and so static entries are not appropriate -
> different proxies for different sites within the same company are common.

I agree. Had assumed that WinHttpGetIEProxyConfigForCurrentUser and=20
InternetQueryOption are returning the proxy from WPAD if IE is set to=20
automatic mode. Do you know if they do?

Heiko
--=20
Heiko Hund | Software Engineer | Phone +49-721-25516-237 | Fax -200
Astaro GmbH & Co. KG | An der RaumFabrik 33a | 76227 Karlsruhe | Germany

Astaro GmbH & Co. KG
Commercial Register: Mannheim HRA 702710
Headquarter Location: Karlsruhe
=20
Represented by the General Partner Astaro Verwaltungs GmbH
An der RaumFabrik 33a | 76227 Karlsruhe | Germany=20
Commercial Register: Mannheim HRB 708248
Executive Board: Gert Hansen, Markus Hennig, Jan Hichert, G=FCnter Junk, Dr=
.=20
Frank Nellissen

