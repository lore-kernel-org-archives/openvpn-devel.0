Mime-Version: 1.0 (Mac OS X Mail 6.0 \(1485\))
From: Eric Crist <ecrist@...1286...>
In-Reply-To: <1345733114.69457.YahooMailNeo@...1747...>
Date: Thu, 23 Aug 2012 09:49:10 -0500
Message-Id: <4D629B87-3EE4-471D-8A58-4C8D28EE2C2E@...1286...>
References: <1345727389.42365.YahooMailNeo@...1744...>
	<3026659.dQ0z7Nl7Cc@...1745...>
	<1345733114.69457.YahooMailNeo@...1747...>
Subject: Re: [Openvpn-devel] patch for 2.2.2 to include --script-dir
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Amm Vpn <ammdispose-vpn@...109...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On Aug 23, 2012, at 09:45:14, Amm Vpn <ammdispose-vpn@...109...> wrote:

>> Hi
>>=20
>> On Thu 23 08 2012 21:09:49 ammdispose-vpn@...109... wrote:
>>> So my idea was
>>> 1) Add a new option called script-dir
>>> 2) Frontend will not allow word "script-dir" in config file (so admin c=
ant
>>> change it)=20
>>> 3) script-dir will be passed on command line
>>>=20
>>> This way admin can not run anything other than what I have put in
>>> script-dir. This also helps prevent accidentally run script in some oth=
er
>>> path.
>>=20
>> As this is very specific to you frontend, why doesn't your frontend simp=
le=20
>> check the path names in the config for correctness before deploying it?
>=20
> Umm, I suppose this feature may be useful for other purposes. Atleast add=
s a level of security.
>=20
> Regarding my frontend, frontend is very basic, Simple textarea in a form.
> I do not want to complicate it by parsing each line, each type of config =
value and verifying them for
> correctness and secureness.
>=20
> Also want it to be forward compatible, in a sense, lets say tomorrow some=
 other config is
> introduced which runs some other script. Then I do not want to re-code my=
 frontend to
> check for new config entry.
>=20
> So best is to make OpenVPN itself secure. And run only scripts from parti=
cular directory. (script-dir)


I don't really see how this adds any security.  Perhaps it makes it easier =
to code your front-end, but it doesn't offer anything in the way of securit=
y, since it's an option passed in the config or on the command line, it can=
 be changed at-will by whomever runs the program.

-----
Eric F Crist

