References: <20200622113022.23047-1-davids@...515...>
 <0c62f389-39dc-b896-ec89-c864a1076089@...1227...>
 <f79b3d70-13bc-4dab-4a7c-826eb10318c9@...2080...>
 <b5dec3fb-a1fd-3705-a69b-e5e19e7356c9@...1856...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <017a32ef-f2b9-b74e-c3ee-8817e0ad26b4@...1227...>
Date: Mon, 22 Jun 2020 16:01:02 +0200
MIME-Version: 1.0
In-Reply-To: <b5dec3fb-a1fd-3705-a69b-e5e19e7356c9@...1856...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="HhUhkPl67ZalXwOZ0mxjkNdX8BGuoUQdq"
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
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HhUhkPl67ZalXwOZ0mxjkNdX8BGuoUQdq
Content-Type: multipart/mixed; boundary="tOj3EopZMjdD5M5cin7SL1sJKhQn8hLy4"

--tOj3EopZMjdD5M5cin7SL1sJKhQn8hLy4
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 22.06.20 um 14:43 schrieb Steffan Karger:
> Hi,
>=20
> On 22-06-2020 14:29, David Sommerseth wrote:
>> On 22/06/2020 14:21, Arne Schwabe wrote:
>>>
>>>>  PrivateTmp=3Dtrue
>>>>  WorkingDirectory=3D/etc/openvpn/server
>>>> -ExecStart=3D@...2235...@/openvpn --status %t/openvpn-server/status-%i.lo=
g --status-version 2 --suppress-timestamps --config %i.conf
>>>> +ExecStart=3D@...2235...@/openvpn --status %t/openvpn-server/status-%i.lo=
g --status-version 2 --suppress-timestamps --cipher AES-256-GCM --ncp-ciphe=
rs AES-256-GCM:AES-128-GCM:AES-256-CBC:AES-128-CBC:BF-CBC --config %i.conf
>>>>  CapabilityBoundingSet=3DCAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_BIND_SERVI=
CE CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SYS_CHROOT CAP_DAC_OVERRIDE CAP_AU=
DIT_WRITE
>>>>  LimitNPROC=3D10
>>>>  DeviceAllow=3D/dev/null rw
>>>>
>>>
>>> NACK.
>>>
>>> Setting ncp-cipher to include BF-CBC by default allows BF-CBC in configs
>>> that did not allow it before. Basically any config that had something
>>> other than cipher BF-CBC and no ncp-ciphers in it will now allow clients
>>> with BF-CBC to connect. I don't want force users to set ncp-cipher to a
>>> sane value since the systemd unit file doesn't.
>>
>> That will break existing configs on the next upgrade.  Do we want do do =
that?
>>
>> I'm fine with removing BF-CBC, but it is scheduled for removal in OpenVP=
N 2.6.
>=20
> I think Arne has a very good point that it's kinda weird to "degrade"
> the NCP defaults.
>=20
> Making AES-256-GCM the default cipher for TLS-based connections (GCM
> won't work with static key configs) does not imply *removing* BF-CBC
> support. Maybe these should be the steps:
>=20
> 2.4: Use to AES-256-GCM when available (basically what NCP did)
> 2.5: Switch to AES-256-GCM as the default cipher (but allow overriding)
> 2.6: Remove support for small block ciphers all together
>=20
> Yes, this will probably break some (less secure) setups and make some
> people angry. But at some point people need to move on. We've been
> throwing warnings at them for a while now.

I had a different suggestion in the channel:

- Deprecate ncp-disable. Reason: Was a good debug switch when introduced
should not be necessary anymore.

- Introduce ncp-fallback-cipher for compatibility with ncp-disable/old
versions
    - needs to be a cipher from ncp-ciphers list
    - Eventually default the first cipher from ncp-ciphers list
    - in 2.5 default to --cipher if --cipher is set and automatically
add cipher to ncp-ciphers and set ncp-fallback-cipher.

    - If cipher is not set
	a) warn about that cipher will be ignored in p2mp mode and if BF-CBC is
still needed (e.g. peer 2.3 or older) that ncp-fallback-cipher should be set
        b) same a) but do it automatically for the user+warn


This allows us to eventually get rid of --cipher while providing still a
smooth transaction.

Arne


--tOj3EopZMjdD5M5cin7SL1sJKhQn8hLy4--

--HhUhkPl67ZalXwOZ0mxjkNdX8BGuoUQdq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl7wuZ4ACgkQFRhsZwKx
RFSC9RAAqKyZyuoSp7lfm0xaWdbgHONDIOZo33ua1MW+qcrk1WCrZQ4Cuz0jBXOY
r9vn+slYG3L++pWlPdPf+u3ZVWQ2LhauVlg+vFiivh3jYYJMvfrgiHllK8+IMFO9
uvIlNsUGpFP1OE+Rq3PUgANUs0g+0LgagRufIMtbClbiBQVDt9xrLluSzJauc8tE
1didwO+rl3XouqP0VPMBU31FYs63F2iQinRdgROcPFsYoMGQ02V8DeEsIs2OVt81
YLt9LaGKNjwFTxy3iIwUMbNS1Gv6bbOYIwZ6qJLCJz8cOzUAFIIvE45Gm48DqF6J
zT2dNZoLUM2x33AESrQlkTrPvnE3wE6hckEyK3koF1VcXIXcp97+KZzAOYperdSd
lbQIW9yM9AOJrAQdgvvBudhaMbNSDrydPQqJCsk3alpH01/cW2hNtFQHNacY3m5M
0Ikg7G8vYR/f2VOmnM1wB1hZpNgXoqlzm/BmWn+g0rtd3N/+MRpggpw8yuhYQg0n
uuF6sxKnyzs7aA/PZwhTgSDX23dwxaVKHq5wkSoJCBc2ZfOXfZ1QBEDEUp8Szzcf
xjwUOWA0zjd3sitwWq6H06Ct3F6P2BYvJ4Rr36dBbmL9EtlPNIkc+UmlA38hgxLT
GKxONzkuOqIqMPGFw07dRGGtljdPpyADebdQh0M8ICw9Tngtpj8=
=J4ny
-----END PGP SIGNATURE-----

--HhUhkPl67ZalXwOZ0mxjkNdX8BGuoUQdq--

