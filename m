References: <1345727389.42365.YahooMailNeo@...1744...>
	<3026659.dQ0z7Nl7Cc@...1745...>
Message-ID: <1345733114.69457.YahooMailNeo@...1747...>
Date: Thu, 23 Aug 2012 22:45:14 +0800 (SGT)
From: Amm Vpn <ammdispose-vpn@...109...>
In-Reply-To: <3026659.dQ0z7Nl7Cc@...1745...>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: Heiko Hund <heiko.hund@...1489...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>



Hi

>________________________________
> From: Heiko Hund <heiko.hund@...1489...>
>To: openvpn-devel@lists.sourceforge.net; "ammdispose-vpn@...109..." <ammdi=
spose-vpn@...109...>=20
>Sent: Thursday, 23 August 2012 7:15 PM
>Subject: Re: [Openvpn-devel] patch for 2.2.2 to include --script-dir
>=20
>Hi
>
>On Thu 23 08 2012 21:09:49 ammdispose-vpn@...109... wrote:
>> So my idea was
>> 1) Add a new option called script-dir
>> 2) Frontend will not allow word "script-dir" in config file (so admin ca=
nt
>> change it)=20
>> 3) script-dir will be passed on command line
>>=20
>> This way admin can not run anything other than what I have put in
>> script-dir. This also helps prevent accidentally run script in some other
>> path.
>
>As this is very specific to you frontend, why doesn't your frontend simple=
=20
>check the path names in the config for correctness before deploying it?


Umm, I suppose this feature may be useful for other purposes. Atleast adds =
a level of security.


Regarding my frontend, frontend is very basic, Simple textarea in a form.
I do not want to complicate it by parsing each line, each type of config va=
lue and verifying them for
correctness and secureness.


Also want it to be forward compatible, in a sense, lets say tomorrow some o=
ther config is
introduced which runs some other script. Then I do not want to re-code my f=
rontend to
check for new config entry.

So best is to make OpenVPN itself secure. And run only scripts from particu=
lar directory. (script-dir)


Regards

Amm.


