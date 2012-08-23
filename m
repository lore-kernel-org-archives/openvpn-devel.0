Mime-Version: 1.0 (Mac OS X Mail 6.0 \(1485\))
From: Eric Crist <ecrist@...1286...>
In-Reply-To: <1345735851.47115.YahooMailNeo@...1744...>
Date: Thu, 23 Aug 2012 10:35:21 -0500
Message-Id: <1EA7600F-59D9-49DE-B74D-8FDE974A77CB@...1286...>
References: <1345727389.42365.YahooMailNeo@...1744...>
	<3026659.dQ0z7Nl7Cc@...1745...>
	<1345733114.69457.YahooMailNeo@...1747...>
	<4D629B87-3EE4-471D-8A58-4C8D28EE2C2E@...1286...>
	<1345735851.47115.YahooMailNeo@...1744...>
Subject: Re: [Openvpn-devel] patch for 2.2.2 to include --script-dir
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
To: Amm Vpn <ammdispose-vpn@...109...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On Aug 23, 2012, at 10:30:51, Amm Vpn <ammdispose-vpn@...109...> wrote:

> ----- Original Message -----
>> From: Eric Crist <ecrist@...1286...>
>> To: Amm Vpn <ammdispose-vpn@...109...>
>> Cc: Heiko Hund <heiko.hund@...1489...>; "openvpn-devel@...282...=
.net" <openvpn-devel@lists.sourceforge.net>
>> Sent: Thursday, 23 August 2012 8:19 PM
>> Subject: Re: [Openvpn-devel] patch for 2.2.2 to include --script-dir
>=20=20
>>> So best is to make OpenVPN itself secure. And run only scripts from=20
>>> particular directory. (script-dir)
>=20
>=20
>> I don't really see how this adds any security.  Perhaps it makes it easi=
er=20
>> to code your front-end, but it doesn't offer anything in the way of=20
>> security, since it's an option passed in the config or on the command li=
ne,=20
>> it can be changed at-will by whomever runs the program.
>=20
> Umm, same applies for script-security parameter as well. How does that ad=
d security?
> If person has access to config file he can change script-security level a=
s well and then
> run any RANDOM command at his will.
>=20
> So why was such an option added too? Please do not assume that it will be=
 only you who would
> be modifying config file. In my case I have to allow access to subordinat=
e.
>=20
> My point here is script-security does not really give you TRUE security.
>=20
> Script-dir makes sure that ONLY script from particular directory (say /et=
c/openvpn/scripts)
> are run. This should infact be hardcoded in openvpn at compile time. (whi=
ch my patch
> does not do yet but instead made is config option)
>=20
> Any script NOT in that directory should not be run at all.
>=20
> Currently openvpn BLINDLY runs any script which in my opinion is too dang=
erous. One
> breach and intruder can simply erase your whole harddisk.
>=20
> My idea of script-dir is taken from sendmail concept of smrsh.
> http://www.faqs.org/docs/securing/chap22sec182.html
>=20
> In my case person does not have direct access to machine. But only to con=
fig file.
> Now if I make sure that he cant change script-dir, it secures my whole ma=
chine.
>=20
> Otherwise there is noway I can give access to config file to him without =
worrying
> about him running "rm -rf /"
>=20
> Hope I am able to convey my idea. Just trying to patch a flaw in openvpn,=
 in my opinion=20=20=20=20

I still think this doesn't help anything that can't be solved in your own G=
UI.  Simply make sure that you prepend the full path on any scripts setup f=
rom your front-end and you help your own cause.  Additionally, strip any pa=
thing from the supplied arguments.  script-security was added by James befo=
re the community got heavily involved in development, so I can't say as to =
the real reasons for that change.  I am still thinking this is an unneeded =
patch with too-narrow a scope.

-----
Eric F Crist



