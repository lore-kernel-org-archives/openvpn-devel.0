References: <20200528235423.27416-1-arne@...1227...>
 <bba548e3-f796-f871-fd52-450b3b1cbdab@...2080...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <d75c8b24-127d-09bf-3fe3-95a3884fad73@...1227...>
Date: Fri, 29 May 2020 16:21:59 +0200
MIME-Version: 1.0
In-Reply-To: <bba548e3-f796-f871-fd52-450b3b1cbdab@...2080...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="wgtFe0kNftN3pmqFcVx8BpAe1azxXaKB8"
Subject: Re: [Openvpn-devel] [PATCH] Add .git-blame-ignore-revs with
 reformat commits
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn@...2080...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wgtFe0kNftN3pmqFcVx8BpAe1azxXaKB8
Content-Type: multipart/mixed; boundary="Co9nZMQeqBhQ4Zumye4AAJlNi7P7puhyo"

--Co9nZMQeqBhQ4Zumye4AAJlNi7P7puhyo
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 29.05.20 um 15:51 schrieb David Sommerseth:
> On 29/05/2020 01:54, Arne Schwabe wrote:
>> This allows git blame to ignore reformatting changes and instead
>> shows the previous commit that changed the line.
>>
>> To avoid manually building the list of commits this commit
>> adds a file with a list of reformatting commits. I might have
>> missed a few but this should be a good start. To use the file
>> use:
>>
>>    git blame --ignore-revs-file=3D.git-blame-ignore-revs file
>>
>> or to automatically always use the file
>>
>>    git config blame.ignoreRevsFile .git-blame-ignore-revs
>>
>> Naming the file .git-blame-ignore-revs is a convention.
>>
>> Some more details in this random blog post:
>>
>> https://www.moxio.com/blog/43/ignoring-bulk-change-commits-with-git-blame
>>
>=20
> Feature-ACK ... the commit message could also mention that git 2.23 is ne=
eded
> as well.
>=20
>> Signed-off-by: Arne Schwabe <arne@...1227...>
>> ---
>>  .git-blame-ignore-revs                        | 29 +++++++++++++++++++
>>  .../managent-demo/management-demo-server.py   |  0
>>  contrib/ovpnkeys.py                           |  0
>>  3 files changed, 29 insertions(+)
>>  create mode 100644 .git-blame-ignore-revs
>>  create mode 100644 contrib/managent-demo/management-demo-server.py
>>  create mode 100644 contrib/ovpnkeys.py
>>
>> diff --git a/.git-blame-ignore-revs b/.git-blame-ignore-revs
>> new file mode 100644
>> index 00000000..3cc811cf
>> --- /dev/null
>> +++ b/.git-blame-ignore-revs
>> @@ -0,0 +1,29 @@
>> +# Uncrustify the tests/unit_tests/ part of our tree.=20
>> +da1574ef7826d73f01e120cbd1ba40ce39a305b7
>> +
>> +# Another round of uncrustify code cleanup.
>> +9cf7b4925a54d93fbea1cadcf3dc0e11f3ce358f
>> +
>> +# networking_sitnl.c: uncrustify file
>> +2c45d268ca65c522fbabb7c4dab5e721296b4623
>> +
>> +# Uncrustify tapctl and openvpnmsica
>> +6280d3d5536174934ee22d3840457d61896e0e3a
>=20
> Missing a blank line here, for consistency
>=20
>> +# tun.c: uncrustify
>> +baef44fc8769bbd99f4d699ce9f63180c29a5455
>> +
>> +# networking_sitnl.c: uncrustify file
>> +2c45d268ca65c522fbabb7c4dab5e721296b4623
>> +
>> +# uncrustify openvpn sources
>> +f57431cdc88f22fa4d7962946f0d3187fe058539
>> +
>> +# More broadly enforce Allman style and braces-around-conditionals
>> +4cd4899e8e80efae03c584a760fd107251735723
>> +
>> +# Merge 'reformatting' branch into master
>> +1f004b2f06e987d73e48f7fd7b96b0b248274f58
>=20
> Are you sure this "merge" commit shouldn't be commit 81d882d5 instead?
>

I am not sure to be honest, that is why I included both commits as
ignoring the merge commit might be instead then showing the other commit.

Arne



--Co9nZMQeqBhQ4Zumye4AAJlNi7P7puhyo--

--wgtFe0kNftN3pmqFcVx8BpAe1azxXaKB8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl7RGocACgkQFRhsZwKx
RFSS7g//Uy6nyRCWz+Ai8yfS5EhLKtxCBei3XxXosZxSikt68d3gObSUfYciTRBT
Cq9vHN7xCyeeUWHgiQskMmMPgOrfkBnKobKLB7JjwT3Oz3iXr4qwAjxPo51+HNxd
vw0LHbNam+MwNoDXXOPd4z+MR8btHUkD3jI8aIxHInBCSwml4qg7KQQMzwH1/xnp
Pwcn96Y1uwvMLRKxjfrixTjLITazDpR5h0OxIKHNpMGfKSpIsrkw2Sjjbzehv1q2
zAR019kwyywoRojsEtycsOeN1WKDpdx+6wsWsvx2oHqf93vd+ZDM4sXgrsSkp+YE
Pdb++XA10BGVFITPi/A32Z4kgQUrDCRiNI9RvSKMQuN2Ux2LXw+5fb8VWiKW6KR4
4cD8+x1Tq46ME0AcIHzaGYAO2huzSzbzDIL73jGNcTqMHd7OmMATAMAkZB9DFH25
WkepY1JdvQyvZcm7Rhiv0/vIRFK1mJh9aTc5fwou1m3wtk5fRpgHQYEuFoQg02rg
JqNpNRVP3MM2sfxjEBhy/ElgpFW8wW3s44T7xoYYyA13th+2SC/WDPXPPFt64giF
nVy1khnraRTToTtLMEgF/6RUnUACSnQ7bnHLbUmu78Y2xEKMK9yS5Du+h9FEG0HJ
mpsCCQWVrZSkCvsxILoSHIOYBnaBUJzR3ySW9dR5AcuCys7bP4Q=
=k0rW
-----END PGP SIGNATURE-----

--wgtFe0kNftN3pmqFcVx8BpAe1azxXaKB8--

