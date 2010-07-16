Message-ID: <4C401426.9020908@...515...>
Date: Fri, 16 Jul 2010 11:11:18 +0300
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <4C4007BC.8010909@...515...>
In-Reply-To: <4C4007BC.8010909@...515...>
Subject: Re: [Openvpn-devel] Summary of the IRC meeting (15th Jul 2010)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


> Discussed various mechanisms to make security vulnerability discussions
> secure. Sending of security vulnerability reports to us could be done
> securely with a simple HTTPS webapp. Alternatively, we could make an
> official PGP public key available for sending in reports. There are two
> options for securing discussions on the security mailinglist:
>
> - everybody uses the same PGP public/private keypair which expires, say,
> after one year
> - everybody uses personal PGP keys for communication: all need to have
> the public keys of everyone else and each mail has to be encrypted once
> for every recipient
>
> Agreed that the second option is better, if mail clients can be
> configured to do multiple encryption automatically. Samuli promised to
> check if Thunderbird + Enigmail supports this. Samuli also promised to
> check if SF.net mailinglists could be used for the -security ml.
>=20=20=20
As promised, I did some digging... Thunderbird + Enigmail _should_ be
able to encrypt messages using several public keys based on the target
address (e.g. openvpn-security@lists.sourceforge.net):

<http://enigmail.mozdev.org/documentation/pgprules.php>

I currently only have David's public PGP/GnuPG key - if somebody else
cares to share his key, we could test if this works in practice.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


