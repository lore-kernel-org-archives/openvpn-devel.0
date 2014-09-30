Message-ID: <542A6728.6000707@...515...>
Date: Tue, 30 Sep 2014 11:17:44 +0300
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <54291DD9.6060802@...515...> <54297B80.8010902@...1147...>
In-Reply-To: <54297B80.8010902@...1147...>
Subject: Re: [Openvpn-devel] Any Windows-based OpenVPN servers available for
 fixing bug #432?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
To: Jan Just Keijser <janjust@...1147...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


> Hi Samuli,
>
> Samuli Sepp=E4nen wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> Hi,
>>
>> Does someone have a spare (=3Dnon-production) Windows-based OpenVPN serv=
er
>> (e.g. on EC2) which could be used to debug and fix #432?
>>
>> <https://community.openvpn.net/openvpn/ticket/432>
>>
>>=20=20=20
>
> I can set up a (semi public) VM running Windows 2012 or XP, but the
ticket mentions Windows 7 ; later this week I'll check if I can
reproduce the ticket on XP.
>
> cheers,
>
> JJK
>
Thanks JJK!

Just got more info from Thomas who's fixing the tap-windows6 issues.
According to him most of the bugs are actually triggered by user-space
code in OpenVPN 2.x which does not handle tap-windows errors correctly.
He's working on that issue right now.

Thomas said that access to a debugging system is needed only if this
particular bug is not fixed by the other bugfixes. I'll let you know
when we're ready for testing.

- --=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlQqZyQACgkQwp2X7RmNIqNAvgCfR1FPoxS8I/64Gp8VFG54JO4Z
GysAoJb3q5kfx7kUZ8ingsU55slExn++
=3Dtwi+
-----END PGP SIGNATURE-----



