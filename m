From: Heiko Hund <heiko.hund@...1489...>
Date: Mon, 12 Mar 2012 12:28:01 +0100
Message-ID: <1841057.UQlKImHBjp@...1526...>
In-Reply-To: <9710628022.20120309180907@...449...>
References: <4F4CE4FE.3010009@...515...> <2610535.JtY05sqIlT@...1526...>
	<9710628022.20120309180907@...449...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN 2.3-alpha1 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net
Cc: Carsten =?ISO-8859-1?Q?Kr=FCger?= <C.Krueger@...448...>

Hi Carsten,

On Friday 09 March 2012 17:09:07 Carsten Kr=FCger wrote:
> I tried the following (disabled kernel process hacker):
> 1. run an instance of notepad as user Carsten (normal windows user, no
> admin) 2. entered "testtesttest"
> 3. run an instance of process hacker as user Carsten
> 4. tried to write to memory -> worked, closed process hacker
> 5. run an instance of process hacker as admin and stripped permissions for
> user Carsten completly, closed process hacker=20
> 6. run an instance of process hacker as user Carsten
> 7. tried to write to memory -> failed as you expected
> 8. add full permissions to process for user Carsten -> works !!!!!!!

This won't work with openvpn.exe started by the service. In your test the=20
process object security descriptor was owned by the user. The owner of an=20
object is always granted write access to the security descriptor of the=20
object, thus you could change the permissions back to whatever you desired.=
=20
The openvpn.exe process security descriptor will be owned by the user the=20
service is run as, i.e. Local System. That's what I meant by "The service=20
account will own the process object, so that the user cannot sneak his way =
in=20
by modifying the DACL."

Regards
Heiko
--=20
Heiko Hund | Software Engineer | Phone +49-721-25516-237 | Fax -200
Astaro a Sophos Company | Amalienbadstr. 41 Bau 52 | 76227 Karlsruhe | Germ=
any
Commercial Register: Mannheim HRA 702710 | Headquarter Location: Karlsruhe
=20
Represented by the General Partner Astaro Verwaltungs GmbH
Amalienbadstra=DFe 41 Bau 52 | 76227 Karlsruhe | Germany=20
Commercial Register: Mannheim HRB 708248 | Executive Board: Gert Hansen,
Markus Hennig, Jan Hichert, G=FCnter Junk, Dr. Frank Nellissen


