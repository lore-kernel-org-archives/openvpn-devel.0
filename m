References: <20200622113022.23047-1-davids@...515...>
 <0c62f389-39dc-b896-ec89-c864a1076089@...1227...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <f79b3d70-13bc-4dab-4a7c-826eb10318c9@...2080...>
Date: Mon, 22 Jun 2020 14:29:10 +0200
MIME-Version: 1.0
In-Reply-To: <0c62f389-39dc-b896-ec89-c864a1076089@...1227...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="o0C8eLBq4BUyBatT7JLnSV7qkZLU134Su"
Subject: Re: [Openvpn-devel] [PATCH] systemd: Change the default cipher to
 AES-256-GCM for server configs
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>, David Sommerseth <davids@...515...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--o0C8eLBq4BUyBatT7JLnSV7qkZLU134Su
Content-Type: multipart/mixed; boundary="RWNel5lWhw9JTjqsdWCTe6e2jEpv27WJi";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: Arne Schwabe <arne@...1227...>, David Sommerseth <davids@...515...>,
 openvpn-devel@lists.sourceforge.net
Message-ID: <f79b3d70-13bc-4dab-4a7c-826eb10318c9@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] systemd: Change the default cipher to
 AES-256-GCM for server configs
References: <20200622113022.23047-1-davids@...515...>
 <0c62f389-39dc-b896-ec89-c864a1076089@...1227...>
In-Reply-To: <0c62f389-39dc-b896-ec89-c864a1076089@...1227...>

--RWNel5lWhw9JTjqsdWCTe6e2jEpv27WJi
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 22/06/2020 14:21, Arne Schwabe wrote:
>=20
>>  PrivateTmp=3Dtrue
>>  WorkingDirectory=3D/etc/openvpn/server
>> -ExecStart=3D@...2235...@/openvpn --status %t/openvpn-server/status-%i.log =
--status-version 2 --suppress-timestamps --config %i.conf
>> +ExecStart=3D@...2235...@/openvpn --status %t/openvpn-server/status-%i.log =
--status-version 2 --suppress-timestamps --cipher AES-256-GCM --ncp-ciphers=
 AES-256-GCM:AES-128-GCM:AES-256-CBC:AES-128-CBC:BF-CBC --config %i.conf
>>  CapabilityBoundingSet=3DCAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_BIND_SERVICE=
 CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SYS_CHROOT CAP_DAC_OVERRIDE CAP_AUDI=
T_WRITE
>>  LimitNPROC=3D10
>>  DeviceAllow=3D/dev/null rw
>>
>=20
> NACK.
>=20
> Setting ncp-cipher to include BF-CBC by default allows BF-CBC in configs
> that did not allow it before. Basically any config that had something
> other than cipher BF-CBC and no ncp-ciphers in it will now allow clients
> with BF-CBC to connect. I don't want force users to set ncp-cipher to a
> sane value since the systemd unit file doesn't.

That will break existing configs on the next upgrade.  Do we want do do tha=
t?

I'm fine with removing BF-CBC, but it is scheduled for removal in OpenVPN 2=
.6.

<https://community.openvpn.net/openvpn/wiki/DeprecatedOptions#Policy:Remova=
lofinsecureciphers:Cipherswithcipherblock-sizelessthan128bitsmostcommonlyBF=
DESCAST5IDEAandRC2>


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--RWNel5lWhw9JTjqsdWCTe6e2jEpv27WJi--

--o0C8eLBq4BUyBatT7JLnSV7qkZLU134Su
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJe8KQWAAoJEIbPlEyWcf3yEvoP/3fbsN19f4iuYJDqXtDadoAC
2FxhMVSL9SVwY21m4TP8DkBUsRZnr8/zu5nkXpwMBrm9n9Y4jiPdv/gEh4RRU0m6
9l6hfjDyYb19darmvzQPaGxURAdpOvITFgmP1YhGGlv2aKGEMz1Fk3NTEFU0M/qK
klX58MR1hYKjx+w7gM1xEaHYZ1MqJMcGH1MXJKzpGKFbJ8eTqaMnrM+MxHKBR6XT
Cm7kbdna21BVVGsjuEGwIPQlRgQ0/RKZbMwTj+jc4BQfrBr2E0rIGxx5ROchxctj
1SCpdnP71O23+DPlyQiaRRZfhSUa+T3IUYQWzT0sHfHQB9ePt3HXzkGrITGTlZmS
4AJYwFmXIFJr0lg/gQxMaK1qoYkgaYT9sNXIRJ5wA1SGmQX/wvLZCIJYDExi4PPY
R2Av52TeioMFFF5E7UZZFazbCoiQ5ZvaOaoewge6N60skD7FH/lHAhzLoVfo50/Q
M6w/+BPpbgZfLpPVKni08s2p32Ip4va6evCpkKLMG2+0K3d4kX3tgFlmyloUZY/n
kVmAgB5scBL9JBhGwJgOqYZcocKhDUwfDi4Td/AdLxa3ZS/vJiFcMUvqZPEleuU3
PWevRJMAN4+9CE3eTUa9kZH8z8VHWhEc9KYGovyD84lb3pAQEPJ8x62o9LYxDWjn
NtcNzTa10/Ct0d6FzJeZ
=DwcB
-----END PGP SIGNATURE-----

--o0C8eLBq4BUyBatT7JLnSV7qkZLU134Su--

