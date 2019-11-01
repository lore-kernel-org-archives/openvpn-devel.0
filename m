References: <6a1b6995-67c1-e30b-bdc1-af1d5485fda5@...515...>
 <d34d5974-30ac-6949-9be4-7f4a55126564@...515...>
 <bf866bdc-4be0-fea9-92d1-61d27ce7ecda@...277...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <df929876-8c63-0934-02f6-4ac7186d986e@...515...>
Date: Fri, 1 Nov 2019 20:28:13 +0200
MIME-Version: 1.0
In-Reply-To: <bf866bdc-4be0-fea9-92d1-61d27ce7ecda@...277...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="FZHPnKEHkJlKxHRVb7GQSsjI4Ud9ddrYC"
Subject: Re: [Openvpn-devel] OpenVPN 2.4.8 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Ton van Vliet <epposan@...277...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FZHPnKEHkJlKxHRVb7GQSsjI4Ud9ddrYC
Content-Type: multipart/mixed; boundary="g9tRjGwAiAE9EOccZ9jXAi9ya8uYfgVPL"

--g9tRjGwAiAE9EOccZ9jXAi9ya8uYfgVPL
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Il 01/11/19 18:58, Ton van Vliet ha scritto:
> Hi,
>=20
> A sincere 'Thank You' to all developers for their continuous work done
> on OpenVPN !
>=20
> Both the 2.4.8-I601-Win7 and 2.4.8-I602-Win7 executables fail with 'An
> error occurred installing the TAP device drivers.'

What operating system are you running exactly?

> After running the 2.4.8 installer, all of my (named) TAP devices had
> disappeared (I have more than one!)
>=20
> Reinstalling the previous 2.4.7-Win7 version (twice) brought them all
> back to life again.
>=20
> Is there a way I can get more detailed information about what could be
> causing this. It is the first time that I encounter this error.

Yes there is:

<https://community.openvpn.net/openvpn/wiki/ManagingWindowsTAPDrivers>

In particular check C:\Windows\inf\setupapi.dev.log. It contains
installation logs for Windows drivers in general, not just tap-windows6.
It generally gives a pretty good idea of the problem. It should not have
any sensitive information in it so you can post the relevant lines here.

Samuli

>=20
> --=C2=A0
> Ton
>=20
> On 31-10-19 13:04, Samuli Sepp=C3=A4nen wrote:
>> Hi,
>>
>> We recently found out that the code signing certificate the 2.4.8
>> Windows installers use expired a couple of weeks ago. I will get a new
>> certificate today evening (~6 hours) and push out new installers.
>>
>> This problem only seems to affect the prompt you get when you
>> double-click on the installer executable. You probably see "Unknown
>> publisher" there. Besides that Windows seems to be perfectly happy with
>> the executables and libraries. That is the main reason why a problem
>> such as this was able to slip through testing.
>>
>> Samuli
>>
>> Il 31/10/19 12:27, Samuli Sepp=C3=A4nen ha scritto:
>>> The OpenVPN community project team is proud to release OpenVPN 2.4.8. It
>>> can be downloaded from here:
>>>
>>> <https://openvpn.net/community-downloads/>
>>>
>>> This is primarily a maintenance release with bugfixes and improvements.
>>> The Windows installers (I601) have several improvements compared to the
>>> previous release:
>>>
>>> * New tap-windows6 driver (9.24.2) which fixes some suspend and resume
>>> issues
>>> * Latest OpenVPN-GUI
>>> * Considerable performance boost due to new compiler optimization flags
>>>
>>> A summary of all included changes is available here:
>>>
>>> <https://github.com/OpenVPN/openvpn/blob/release/2.4/Changes.rst>
>>>
>>> A full list of changes is available here:
>>>
>>> <https://community.openvpn.net/openvpn/wiki/ChangesInOpenvpn24>
>>>
>>> Please note that LibreSSL is not a supported crypto backend. We accept
>>> patches and we do test on OpenBSD 6.0 which comes with LibreSSL, but if
>>> newer versions of LibreSSL break API compatibility we do not take
>>> responsibility to fix that.
>>>
>>> Also note that  Windows installers have been built with NSIS version
>>> that has been patched against several NSIS installer code execution and
>>> privilege escalation problems:
>>>
>>> <https://community.openvpn.net/openvpn/wiki/NSISBug1125>
>>>
>>> Based on our testing, though, older Windows versions such as Windows 7
>>> might not benefit from these fixes. We thus strongly encourage you to
>>> always move NSIS installers to a non-user-writeable location before
>>> running them. Our long-term plan is to migrate to using MSI installers
>>> instead.
>>>
>>> Compared to OpenVPN 2.3 this is a major update with a large number of
>>> new features, improvements and fixes. Some of the major features are
>>> AEAD (GCM) cipher and Elliptic Curve DH key exchange support, improved
>>> IPv4/IPv6 dual stack support and more seamless connection migration when
>>> client's IP address changes (Peer-ID). Also, the new --tls-crypt feature
>>> can be used to increase users' connection privacy.
>>>
>>> OpenVPN GUI bundled with the Windows installer has a large number of new
>>> features compared to the one bundled with OpenVPN 2.3. One of major
>>> features is the ability to run OpenVPN GUI without administrator privil=
eges.
>>>
>>> For full details, look here:
>>>
>>> <https://community.openvpn.net/openvpn/wiki/ChangesInOpenvpn24>
>>>
>>> The new OpenVPN GUI features are documented here:
>>>
>>> <https://github.com/OpenVPN/openvpn-gui>
>>>
>>> Please note that OpenVPN 2.4 installers will not work on Windows XP.
>>>
>>> For generic help use these support channels:
>>>
>>> Official documentation:
>>> <http://openvpn.net/index.php/open-source/documentation/howto.html>
>>> Wiki: <https://community.openvpn.net>
>>> Forums: <https://forums.openvpn.net>
>>> User mailing list: <http://sourceforge.net/mail/?group_id=3D48978>
>>> User IRC channel: #openvpn at irc.freenode.net
>>>
>>> Please report bugs and ask development questions here:
>>>
>>> Bug tracker and wiki: <https://community.openvpn.net>
>>> Developer mailing list: <http://sourceforge.net/mail/?group_id=3D48978>
>>> Developer IRC channel: #openvpn-devel at irc.freenode.net (requires
>>> Freenode registration)
>>>
>>>
>>> Samuli
>>>
>>>
>>>
>>> _______________________________________________
>>> Openvpn-devel mailing list
>>> Openvpn-devel@lists.sourceforge.net
>>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>>>
>>
>>
>> _______________________________________________
>> Openvpn-devel mailing list
>> Openvpn-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20
>=20
>=20
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20



--g9tRjGwAiAE9EOccZ9jXAi9ya8uYfgVPL--

--FZHPnKEHkJlKxHRVb7GQSsjI4Ud9ddrYC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAl28eT0ACgkQKVhNn0CG
RXjCNwf9HJ8Lg5MH5glUyx6VpLQzOxg3TVOLvBJOSyOpGUVzKbz4cdkcDyXnekmG
xDM0mDpQavaziFjxJFy5zBPfa7/+aTE5jZKmV+t3MJvYM8+XxGZynScVnFYoHYpa
t/X9sS4thLoIQMrusKFVbjSF7SAiZjmGsQv1e1ZV/rYiceRNftJ0+PDKlZ0LTjBL
BGF0wDURVLSmElrH6jkKJ2puMN0xp9NNWVu49dlA/lm2gVdeHeBu26xwdbETli6H
Kh5pK2IjLYfNGI6fW5tbXWPj7mzbw9uesWpV8OJNeD1HaX2n/VnuW69famDeGPNb
9tKqtoiMsFwk7eBpzpXhbG8UzD8MBQ==
=M13C
-----END PGP SIGNATURE-----

--FZHPnKEHkJlKxHRVb7GQSsjI4Ud9ddrYC--

