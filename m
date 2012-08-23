References: <1345727389.42365.YahooMailNeo@...1744...>
	<3026659.dQ0z7Nl7Cc@...1745...>
	<1345733114.69457.YahooMailNeo@...1747...>
	<4D629B87-3EE4-471D-8A58-4C8D28EE2C2E@...1286...>
Message-ID: <1345735851.47115.YahooMailNeo@...1744...>
Date: Thu, 23 Aug 2012 23:30:51 +0800 (SGT)
From: Amm Vpn <ammdispose-vpn@...109...>
In-Reply-To: <4D629B87-3EE4-471D-8A58-4C8D28EE2C2E@...1286...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] patch for 2.2.2 to include --script-dir
Reply-To: Amm Vpn <ammdispose-vpn@...109...>
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
To: Eric Crist <ecrist@...1286...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>





----- Original Message -----
> From: Eric Crist <ecrist@...1286...>
> To: Amm Vpn <ammdispose-vpn@...109...>
> Cc: Heiko Hund <heiko.hund@...1489...>; "openvpn-devel@...290...=
net" <openvpn-devel@lists.sourceforge.net>
> Sent: Thursday, 23 August 2012 8:19 PM
> Subject: Re: [Openvpn-devel] patch for 2.2.2 to include --script-dir
=A0
>>  So best is to make OpenVPN itself secure. And run only scripts from=20
>> particular directory. (script-dir)


> I don't really see how this adds any security.=A0 Perhaps it makes it eas=
ier=20
> to code your front-end, but it doesn't offer anything in the way of=20
> security, since it's an option passed in the config or on the command lin=
e,=20
> it can be changed at-will by whomever runs the program.

Umm, same applies for script-security parameter as well. How does that add =
security?
If person has access to config file he can change script-security level as =
well and then
run any RANDOM command at his will.

So why was such an option added too? Please do not assume that it will be o=
nly you who would
be modifying config file. In my case I have to allow access to subordinate.

My point here is script-security does not really give you TRUE security.

Script-dir makes sure that ONLY script from particular directory (say /etc/=
openvpn/scripts)
are run. This should infact be hardcoded in openvpn at compile time. (which=
 my patch
does not do yet but instead made is config option)

Any script NOT in that directory should not be run at all.

Currently openvpn BLINDLY runs any script which in my opinion is too danger=
ous. One
breach and intruder can simply erase your whole harddisk.

My idea of script-dir is taken from sendmail concept of smrsh.
http://www.faqs.org/docs/securing/chap22sec182.html

In my case person does not have direct access to machine. But only to confi=
g file.
Now if I make sure that he cant change script-dir, it secures my whole mach=
ine.

Otherwise there is noway I can give access to config file to him without wo=
rrying
about him running "rm -rf /"

Hope I am able to convey my idea. Just trying to patch a flaw in openvpn, i=
n my opinion=A0=A0=A0=20

Amm


