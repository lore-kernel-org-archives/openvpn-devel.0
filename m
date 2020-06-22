References: <20200622113022.23047-1-davids@...515...>
 <0c62f389-39dc-b896-ec89-c864a1076089@...1227...>
 <f79b3d70-13bc-4dab-4a7c-826eb10318c9@...2080...>
 <b5dec3fb-a1fd-3705-a69b-e5e19e7356c9@...1856...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <f291df77-2362-23f1-61ea-d0a1bee52ed6@...2080...>
Date: Mon, 22 Jun 2020 19:59:41 +0200
MIME-Version: 1.0
In-Reply-To: <b5dec3fb-a1fd-3705-a69b-e5e19e7356c9@...1856...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="L0Zct5uBipOyPqAuqgl5BstfVyeByisg0"
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
--L0Zct5uBipOyPqAuqgl5BstfVyeByisg0
Content-Type: multipart/mixed; boundary="lJajwTiB0MsE3LzFPkKTdBniaUL8yUQqD";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net
Message-ID: <f291df77-2362-23f1-61ea-d0a1bee52ed6@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] systemd: Change the default cipher to
 AES-256-GCM for server configs
References: <20200622113022.23047-1-davids@...515...>
 <0c62f389-39dc-b896-ec89-c864a1076089@...1227...>
 <f79b3d70-13bc-4dab-4a7c-826eb10318c9@...2080...>
 <b5dec3fb-a1fd-3705-a69b-e5e19e7356c9@...1856...>
In-Reply-To: <b5dec3fb-a1fd-3705-a69b-e5e19e7356c9@...1856...>

--lJajwTiB0MsE3LzFPkKTdBniaUL8yUQqD
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 22/06/2020 14:43, Steffan Karger wrote:
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

Yes, I agree that Arne got a point.  But I'm not completely convinced break=
ing
configs in OpenVPN 2.5 without a prior note that it will stop working.  Our
warning only screams "you shouldn't use ciphers with block sizes < 128 bits=
",
it doesn't say "this will stop working in a future release".

OpenVPN 2.4.9 gives this warning:

    WARNING: INSECURE cipher with block size less than 128 bit (64 bit).  T=
his
    allows attacks like SWEET32.  Mitigate by using a --cipher with a larger
    block size (e.g. AES-256-CBC).

The community has been informed it will stop working in 2.6, not before this
release.

This must be documented properly and log warnings updated to indicate
short-term workarounds.

I could be willing to consider breaking configs for ciphers in a later 2.5.x
release as long as users are properly warned *when* it will stop working - =
and
that users gets a real chance to fix configs before we do break their confi=
gs
- where a workaround approach could be considered and available from v2.5.0
(on the other hand, if they change their configs, they should swap ciphers
instead of applying a workaround for a dying cipher - but for some it might=
 be
a bit more complicated to do such a swap).

We need to find a good middle-way for OpenVPN 2.5, where we clearly signal
"weak ciphers will be removed" and when we will do that.  While also moving
forward and break as few configs as possible and not make configs weaker th=
an
before.


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--lJajwTiB0MsE3LzFPkKTdBniaUL8yUQqD--

--L0Zct5uBipOyPqAuqgl5BstfVyeByisg0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJe8PGNAAoJEIbPlEyWcf3yhQsQAIz6I5t5i0ba1nBAz+SIPfZc
EpRZqNx8UqIu2VjmB0Qn1n1IoU5Ax3G7Hta4yhOv1fjfWnF18WX0dc86j/uPEBUK
J7Nrr4IQITHX4ZAouoVv3j1Cdf4CJu2RhX9ORmNXUFXYSa8dXN1h4Rv6Aqou0g51
tM7ZyfoTaSXXVqaT7aVYQQpSrDblqw42cBUEDxYNfdRukSqConpvxqJEr3fwc2l2
MDh82Fvh1fLnf2CWUQ2etiOGr3rZGadget9i0bxE04i0Dee5H8WCQKNNSI8hz6bm
2eJu8o7Ims1Ynbt7g+prDAN3Za3gFxVZ47CfuP9nNbNZhs6lZtClIcvl04iYExrj
9EoJSQjSXJvFiFz6I+rmzCJHkIcLoefZrwHixrJA+X1xliG1V92S0LotKKJQ5Vl5
F0syv93hpWPr6tWdN0yXhOQSTtVMICA9zjCJV3Z7CJRVu5fYaNG17Ui/fdCni/kh
Hy7MRXq588VlA5G+cEhC3kdvFv4dKruNZdVz6/FPX5Cp5yNvPygZZkWs+CsbJsQK
4Ibb96lF5c0R7aGrljiiLSe3Qrbu+wrtxpwoBGza1+mrmrhWojBTE0Y+BlqqKgXd
mseEumeKv95nLl5IH1ZJRpe7xgbxNmd/ea46UXxCWBTmxaSa1mXM8mqCp39KrXmy
LqbiL23w95gdoY51rqRq
=N70d
-----END PGP SIGNATURE-----

--L0Zct5uBipOyPqAuqgl5BstfVyeByisg0--

