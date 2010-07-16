Message-ID: <4C4019B7.5030307@...515...>
Date: Fri, 16 Jul 2010 11:35:03 +0300
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <4C4007BC.8010909@...515...> <4C401426.9020908@...515...>
In-Reply-To: <4C401426.9020908@...515...>
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

Samuli Sepp=E4nen ha scritto:
>> Discussed various mechanisms to make security vulnerability discussions
>> secure. Sending of security vulnerability reports to us could be done
>> securely with a simple HTTPS webapp. Alternatively, we could make an
>> official PGP public key available for sending in reports. There are two
>> options for securing discussions on the security mailinglist:
>>
>> - everybody uses the same PGP public/private keypair which expires, say,
>> after one year
>> - everybody uses personal PGP keys for communication: all need to have
>> the public keys of everyone else and each mail has to be encrypted once
>> for every recipient
>>
>> Agreed that the second option is better, if mail clients can be
>> configured to do multiple encryption automatically. Samuli promised to
>> check if Thunderbird + Enigmail supports this. Samuli also promised to
>> check if SF.net mailinglists could be used for the -security ml.
>>=20=20=20
>>=20=20=20=20=20
> As promised, I did some digging... Thunderbird + Enigmail _should_ be
> able to encrypt messages using several public keys based on the target
> address (e.g. openvpn-security@lists.sourceforge.net):
>
> <http://enigmail.mozdev.org/documentation/pgprules.php>
>
> I currently only have David's public PGP/GnuPG key - if somebody else
> cares to share his key, we could test if this works in practice.
>=20=20=20

Did some digging in the wonderful world of SF.net mailinglists...
Snippets from the GNU mailman admin interface:

"Require approval - require list administrator approval for subscriptions"

"*private_roster* (privacy): Who can view subscription list? When set,
the list of subscribers is protected by member or admin password
authentication."

*"generic_nonmember_action* (privacy): Action to take for postings from
non-members for which no explicit action is defined. When a post from a
non-member is received, the message's sender is matched against the list
of explicitly accepted
<https://lists.sourceforge.net/lists/admin/openvpn-als-devel/?VARHELP=3Dpri=
vacy/sender/accept_these_nonmembers>,
held
<https://lists.sourceforge.net/lists/admin/openvpn-als-devel/?VARHELP=3Dpri=
vacy/sender/hold_these_nonmembers>,
rejected
<https://lists.sourceforge.net/lists/admin/openvpn-als-devel/?VARHELP=3Dpri=
vacy/sender/reject_these_nonmembers>
(bounced), and discarded
<https://lists.sourceforge.net/lists/admin/openvpn-als-devel/?VARHELP=3Dpri=
vacy/sender/discard_these_nonmembers>
addresses. If no match is found, then this action is taken."

So it is possible to lock the list down pretty tightly, if required.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


