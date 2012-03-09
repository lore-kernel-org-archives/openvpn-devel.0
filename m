From: Heiko Hund <heiko.hund@...1489...>
Date: Fri, 9 Mar 2012 14:42:26 +0100
Message-ID: <2610535.JtY05sqIlT@...1526...>
In-Reply-To: <2082061.FfdueT8x4P@...1526...>
References: <4F4CE4FE.3010009@...515...>
	<883843028.20120301125911@...449...> <2082061.FfdueT8x4P@...1526...>
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

On Thursday 01 March 2012 12:11:37 Heiko Hund wrote:
> On Thursday 01 March 2012 11:59:11 Carsten Kr=FCger wrote:
> > No. If you start a process in users context the user can modify it.
> > There is nothing you could do against.
>=20
> I'll do some tests next week and post my findings here.

Sorry, haven't had much time for tests this week. However, I've done some=20
reading here's the preliminary plans on how to secure openvpn.exe and the=20
named pipe handle.

It is false that you cannot set a process' mandatory label to a higher=20
integrity level than the one in the token. Vista introduced the=20
SE_RELABEL_NAME privilege specifically for that purpose. Apparently no defa=
ult=20
system account comes with the privilege assigned, though. As the "Local=20
System" account on Windows 7 does not have it I wouldn't say it's very=20
practical to go this way as admins would be forced to create a special=20
"OpenVPN Service" account in order to run openvpn.

Instead I plan to secure the process (and the probably the pipe handle as=20
well) against malicious operations by not granting the user any sophisticat=
ed=20
access to it, i.e. you can only inject code if you can write the process'=20
memory. This will be enforced by the security descriptor assigned to the=20
process by the service at creation time. The service account will own the=20
process object, so that the user cannot sneak his way in by modifying the=20
DACL.

Hope I haven't overseen anything. If I did I'll be happy to receive feedbac=
k.

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


