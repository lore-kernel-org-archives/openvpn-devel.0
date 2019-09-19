References: <20190919072820.9913-1-a@...2181...>
 <b7bb33b3-f4f3-7286-7565-669a2a86a6b0@...1856...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <d97b80d7-dc7e-496f-48f5-64f8cf9e81eb@...2181...>
Date: Thu, 19 Sep 2019 14:13:40 +0200
MIME-Version: 1.0
In-Reply-To: <b7bb33b3-f4f3-7286-7565-669a2a86a6b0@...1856...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="OOwCCo7WJx9KISnEATqiBXmraF7mrHjtL"
Subject: Re: [Openvpn-devel] [PATCH] t_net.sh: wait for NO-CARRIER bit to
 settle before starting test
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OOwCCo7WJx9KISnEATqiBXmraF7mrHjtL
Content-Type: multipart/mixed; boundary="ouWQmyFsoT4epUdsGz6qcvWq3JyzQkZvZ";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <d97b80d7-dc7e-496f-48f5-64f8cf9e81eb@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] t_net.sh: wait for NO-CARRIER bit to
 settle before starting test
References: <20190919072820.9913-1-a@...2181...>
 <b7bb33b3-f4f3-7286-7565-669a2a86a6b0@...1856...>
In-Reply-To: <b7bb33b3-f4f3-7286-7565-669a2a86a6b0@...1856...>

--ouWQmyFsoT4epUdsGz6qcvWq3JyzQkZvZ
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 19/09/2019 11:17, Steffan Karger wrote:
>> diff --git a/tests/t_net.sh b/tests/t_net.sh
>> index 18799d12..97e947ab 100755
>> --- a/tests/t_net.sh
>> +++ b/tests/t_net.sh
>> @@ -34,6 +34,13 @@ reload_dummy()
>>  {
>>      $RUN_SUDO $openvpn --dev $IFACE --dev-type tun --rmtun >/dev/null
>>      $RUN_SUDO $openvpn --dev $IFACE --dev-type tun --mktun >/dev/null
>> +
>> +    # it seems that tun devices will settle on NO-CARRIER while not con=
nected to
>> +    # any process, but this won't happen immediately. To avoid having t=
he
>> +    # NO-CARRIER bit appear in the middle of the tests - which would co=
mpromise
>> +    # the results - let's wait 1 sec here for it to settle.
>> +    sleep 1
>> +
>>      if [ $? -ne 0 ]; then
>>          echo "can't create interface $IFACE"
>>          exit 1
>>
>=20
> This return value check now checks that sleep succeeded instead of the
> openvpn --mktun command. I don't think that is what you intended.
>=20

You're absolutely right.
The sleep should be moved right after the if-check.

Will send a new patch to fix that.

Regards,


--=20
Antonio Quartulli


--ouWQmyFsoT4epUdsGz6qcvWq3JyzQkZvZ--

--OOwCCo7WJx9KISnEATqiBXmraF7mrHjtL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEOj/Eejms5Fxtp0v4pNfqZUlHtXIFAl2DcPQACgkQpNfqZUlH
tXKcEA/+IWLrEnxOMADlyHhPejEDtZMWz00t4CwHIG25VpZ+HrUC06J5fkYJ5DT0
rhcPyfRGPSy0Ctdzgg7y2pKOcxd2glP5VIXpgJlJc3Vn9Wq7ikvRBf69RTy+GqCS
iHiWkOk6FJoEzuI+DRlP2doXwYmZa2XaQRHysxTMQUI8OXFEtC9LsjdvWBMoVrwa
cf2mzZWdv0ueXguIstrB49Bka7PExI5hayjViAE/KDBDWNyUfFeURy+aGI/mrc1O
somKnfJpN3zAG3uuu02x7bys/oGiybS7XHtnzJq8L/bWszAp8PZuXFZ+6zuStGK1
hsGvYq6Ffft42wcHVRbK9Pd8qXp6Gg7K/69MXFDG3hhx/B4xDxlZnbZQ/N8N9SRF
k1xEdY5WGVgL/MpCLge/YK/vTUJIFlriQLISlKffu6FNBMyAZ9ZMEO98JSL9mhw0
CXaaYT3vmm8FACzZ75+exipqSj6h0qKVNzqQQgkGJA4YtElXMawnXPgZYQier7bj
7bv2NO5DvETZrMPBidlUxjDQ3v+9IKpRkcOs88JMsqpqgcRMwsruV4y+5vJz1aps
aYZp63cYnPC7nEW3UCXXrWJcABm3XrH9/jRZF5DAURUtBcD+M1kXBhnRg0t8H2VM
oaSHI+6SkCytspEj4hUt1vaD32M2NaytXKhgXnB+YFbpo7YnNsk=
=iaMs
-----END PGP SIGNATURE-----

--OOwCCo7WJx9KISnEATqiBXmraF7mrHjtL--

