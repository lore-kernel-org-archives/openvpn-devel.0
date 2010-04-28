From: Heiko Hund <hhund@...194...>
Date: Wed, 28 Apr 2010 16:38:57 +0200
References: <4BD83FC0.5090607@...515...> <1272463949884053500@...1315...>
	<n2n9e0cf0bf1004280724s6c4280c6xb58950c706123e4c@...278...>
In-Reply-To: <n2n9e0cf0bf1004280724s6c4280c6xb58950c706123e4c@...278...>
MIME-Version: 1.0
Message-Id: <201004281638.57498.hhund@...194...>
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
Content-Type: Text/Plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net
Cc: Alon Bar-Lev <alon.barlev@...277...>

On Wednesday 28 April 2010 16:24:31 Alon Bar-Lev wrote:
> The IE API is user specific.
> As OpenVPN runs as a service using own user or system account, IE API
> is not suitable.

Sadly I haven't found the WinHttpGetProxyForUrl API in MinGW W32API. So, us=
e=20
of this might rather be a long-term goal as it takes a while to get it=20
included.

If the service is started by the GUI it still makes sense to use user speci=
fic=20
proxy settings, doesn't it? One could consider auto-proxy for auto-started=
=20
VPNs a misconfiguration, as well. Or am I mislead?

Heiko
--=20
Heiko Hund | Software Engineer | Phone +49-721-25516-237 | Fax -200
Astaro AG | An der RaumFabrik 33a | 76227 Karlsruhe | Germany

Executive Board: Markus Hennig, Jan Hichert, G=C3=BCnter Junk, Dr. Frank Ne=
llissen
Chairman of the Supervisory Board: Stanley J. Krasnow
Headquarter Location: Karlsruhe
Commercial Register: Mannheim HRB 108997

