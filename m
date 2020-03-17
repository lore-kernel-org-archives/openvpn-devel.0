References: <20200313130133.19045-1-samuli@...515...>
 <285d114f-89b4-992d-f8b1-5cec175994ca@...2080...>
 <CAKuzo_gDkHGy0j78hH33zeXKnsi=7NF8PvFNJQQpq7kf2-=Gbg@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <31ca48e1-deb8-7122-6f77-051b08e1b563@...2080...>
Date: Tue, 17 Mar 2020 11:06:53 +0100
MIME-Version: 1.0
In-Reply-To: <CAKuzo_gDkHGy0j78hH33zeXKnsi=7NF8PvFNJQQpq7kf2-=Gbg@...278...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="isFwSHfJC8Ko06xhqVc3rIagF4ZTrTY3F"
Subject: Re: [Openvpn-devel] [PATCH] Document some limitations of
 --auth-user-pass
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--isFwSHfJC8Ko06xhqVc3rIagF4ZTrTY3F
Content-Type: multipart/mixed; boundary="gnTqhQpvQmifiqf9SRCiKHWGbRMpVPzDk";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: Selva Nair <selva.nair@...277...>
Cc: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Message-ID: <31ca48e1-deb8-7122-6f77-051b08e1b563@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Document some limitations of
 --auth-user-pass
References: <20200313130133.19045-1-samuli@...515...>
 <285d114f-89b4-992d-f8b1-5cec175994ca@...2080...>
 <CAKuzo_gDkHGy0j78hH33zeXKnsi=7NF8PvFNJQQpq7kf2-=Gbg@...278...>
In-Reply-To: <CAKuzo_gDkHGy0j78hH33zeXKnsi=7NF8PvFNJQQpq7kf2-=Gbg@...278...>

--gnTqhQpvQmifiqf9SRCiKHWGbRMpVPzDk
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 16/03/2020 14:48, Selva Nair wrote:
[...snip...]
>> I would just rephrase it to say:
>>
>>   OpenVPN GUI v11 and newer uses its own internal username/password stor=
age
>>   independent of the --auth-user-pass file provided.  The file argument =
is
>>   ignored on such installations.
>=20
> I wish it behaved  like that. Unfortunately the file argument is not
> ignored in such cases. If the file has only username, openvpn.exe
> reads it from the file and then fails to prompt for password as there
> is no console available.

Ouch ... that is a pointless misbehavior.  Lets try to fix that.

> I propose to change this behaviour to: if --management-query-passwords
> is set (which the GUI does), ignore the file given in auth-user-pass
> and prompt both username and password from management. I think its
> only logical for a later option (in this case the one set by the GUI)
> to override a previous one. Anyway we do already ignore it if the file
> is "stdin".

Agreed!


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--gnTqhQpvQmifiqf9SRCiKHWGbRMpVPzDk--

--isFwSHfJC8Ko06xhqVc3rIagF4ZTrTY3F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJecKFCAAoJEIbPlEyWcf3yTSIQAI2yjVL12EqvfrznbS4kux7e
zwTxbTWxO4kib0yVdTcn+ElBl+CaR/xrbJ9FzgDHM3rKRQCv1pnAL3/Z6ZRf4Loo
jReFEOcay2bW92UqtswlxAhu4Cd4qmIOyXVeAvA7K199sDIfZmIES6oTEsg4aMQO
B9MMYNZFQ85Ff9ObnjxbfBBydQEXn77ut+L32GZqyo/geraEhAeTagtAE943KvaQ
twPjBOLLXiDwwYDgzBt8Rm+pQ4+oRQyPsCiBbd0QAPXDWhIq3r7qTIMkkiCrlQQ4
rDkHV1/WJTkrUSMAdLAUoejt1Ac0ihX0epJ5fBeGtbgdoJOqtyf7aNBdWBrduIgB
SueaDycOvOP89TridKiDWRU6HHVvXp/jIeGqTePmFORqncyOVlXx/B9xIMkXtoDR
lCNlv6RYwbpGp/SQnV8lG/ndT6l5a8z8aJkS71JXnoj63R1Vm68Mh4lbgpaoVRiM
Ja3mCxBPelNj59Vl91JZlw58L9CpNHg/ST29UmyrhKoDcS1/oZADKjmA6zxfoGL7
TKuXSReOq4Bf8CEHDXD8BuB68uuCKP4egKny2a6pbnE6mXGTuL5Zz/uYc/WT100I
G3hhBSnODHR76Dsqd6Vxvie7klds0PKueMG8uy+w+crA7o4MQMI6kJRw746o3Q+z
LGeH9Ocv0BO7MNUXhShy
=LdEn
-----END PGP SIGNATURE-----

--isFwSHfJC8Ko06xhqVc3rIagF4ZTrTY3F--

