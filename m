Date: Wed, 30 Jun 2021 22:56:49 +0000
From: tincantech <tincantech@...2282...>
Reply-To: tincantech <tincantech@...2282...>
Message-ID: <P_ZqTHMMD5zv_kUeNix7rzuNV00OT9o2LqrU8BdYhMVaq6j5vdLe5YKK3AS13531enQBYdltUJp8Ks7eNCm3xBBfnWo7t9GGHw526akJXwU=@protonmail.com>
In-Reply-To: <zi-Vj2bRDxVU6FgVs0cJcBRxRwZ8B6q5EYNx4g1mHxOg0o5sQneGqWmwMQEwkZ_fcYxWkcTTYPZC7pXDJn6WZQBsS_RyBduPltGkRhsIX2M=@protonmail.com>
References: <zi-Vj2bRDxVU6FgVs0cJcBRxRwZ8B6q5EYNx4g1mHxOg0o5sQneGqWmwMQEwkZ_fcYxWkcTTYPZC7pXDJn6WZQBsS_RyBduPltGkRhsIX2M=@protonmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1_xes3KZLDV9uHdyjUdNFNrKUE2eNcx551OrjVIGYZ0"
Subject: Re: [Openvpn-devel] --tmp-dir and systemd PrivateTmp incompatibility
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: tincantech <tincantech@...2282...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.

--b1_xes3KZLDV9uHdyjUdNFNrKUE2eNcx551OrjVIGYZ0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi

the problem is three fold:
3.
How would I then point scripts to the systemd assigned folder ?
(Yet another env var: systemd_private_tmp)

The most logical answer is "To take matters into my own hands"
and specify my own temporary location but that does not sound
like a "secure" approach generally .. which is the point of using
systemd to "secure" things, in the first place.

stuck in a rabbit hole ..
R
-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsBzBAEBCAAGBQJg3PaaACEJEE+XnPZrkLidFiEECbw9RGejjXJ5xVVVT5ec
9muQuJ2gSQgAj8sL20yh3H+lruv30ZyMG3l3sMd81FZdhMQpn1yGbFNqDeit
geuooC8RIQ1636Sa4UD/TxEZy5e0gU0SfRcaX1+383cV33iFUXHCahMlVAO5
/CDY7yCi+sXuacvR7TpoR6f3hB0zaF0P+XUNH/K0CUE76P1F1csFlGpvycCx
6yjIIJo/fWx2VFS7FiPSwK3l2AreLKo8aQAjo/RWnY/AB6uKVbl/l9qKdhn0
appzLGAzDRbjhpSunp20BtruVu0X5t2fxh6GYpkSy1V8cBI4EZkSu6IfKZpD
olhzDOPswOFKNdwu5CUYIbRJ03lVInxJo/kb0z9rgcy29SKii8Eisw=3D=3D
=3D1l7e
-----END PGP SIGNATURE-----

--b1_xes3KZLDV9uHdyjUdNFNrKUE2eNcx551OrjVIGYZ0
Content-Type: application/pgp-keys; name="publickey - tincantech@...2282... - 0x09BC3D44.asc"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - tincantech@...2282... - 0x09BC3D44.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tDQpWZXJzaW9uOiBPcGVuUEdQLmpz
IHY0LjEwLjEwDQpDb21tZW50OiBodHRwczovL29wZW5wZ3Bqcy5vcmcNCg0KeHNCTkJGdndTY2NC
Q0FET21IRW5RbExtT2pKUnRKTDJsNTNNTHd3RlR5N1huRXBzM2IxUTBVd1dZRkN2DQpMMm9OcDBu
cmRHbEtLREpxNTBZMDlTUitVUllCUW1LbVkzRW16cHlVSUtNL3JnbzFSeXViSHBNUkhiRHANCjdK
cDhMeGtmZkZCVkpqL3Q1Vk1wRDZlTVI2YVVjaVFqZ1JMOE5aZTYrVDd4ZlhYWHdWNWhvUmVaM2pP
Kw0KekhpNlNSN3hUdkdYbGErTVF6NkVFcFdubGJMdmcyb3J0OUtzZXVWallycXZSTXhjZFAwbzlj
WldKNWVwDQpKTm1nZUI2TTcrT1cwOFUxU3NYdEtycExSY0k2eUttVjM4amh6UHIyWmdQOXJtcmxF
clIvMWlxUVFIWFkNCm84LzBEZlB5RjBtSDl5blFJaUxFL2wrRll1NHJzRzhWaUtseGhYY3plUHpB
dExDamlCMGEwbVJWQUJFQg0KQUFITk55SjBhVzVqWVc1MFpXTm9RSEJ5YjNSdmJtMWhhV3d1WTI5
dElpQThkR2x1WTJGdWRHVmphRUJ3DQpjbTkwYjI1dFlXbHNMbU52YlQ3Q3dIOEVFQUVJQUNrRkFs
dndTY2NHQ3drSENBTUNDUkJQbDV6MmE1QzQNCm5RUVZDQW9DQXhZQ0FRSVpBUUliQXdJZUFRQUtD
UkJQbDV6MmE1QzRuUUJEQi85WlVvOUJPWEpSNjFObQ0KMDJvWi84YVJYTzlOblVTRnQ2R0xPV2NE
TnZBczRJSldNRFZFUWZZYW5iKzQyMVFOZC81ZDZIMWlYRitpDQo0TERLME02YWdDK2dzTkZKbmpQ
R0l0dlB0ajdXeWp5blpSeDhENDBQUFhpZ2ZIWXV3Mm9SdTBscitQMXANCjFxZVVlNE5iY3FJdjhJ
SXZMejJ6Q2xZWk9OZ0FzUVZjTkFIaTdaNG9ydFEyaW8yQkFWai84MTlKUFlNdA0KdEhnWTgxd1Mx
Vjd2OEdEVFpnOG9hUGhYR2ZhQzRUWkZHdFpyL2J5YmNxcnNvMzVqYVFtQzU0eE1iWHBGDQpBVXJj
M3VHVk9IK09kRy9CVzJnY1lxcHZVRkJ1a1h4Q1VCWUhQMk5mWGhOZnpHdDluQzF1bE5LWWVQMTkN
ClRHbE9vckJNWUlBRUhvR3h2cGJVWGZiYU5XQ1V6c0JOQkZ2d1NjY0JDQUM5S3lWWlJTNWFNYUc1
UGkwbg0KZng4YU5vczNiWXAyNDZNdGZhb0tCZlRRQXJkK0daVytXbkZ5SkVpU3lMZHowclV1dHlD
QWRmNWxnVkgrDQpXdkx2SW1pR3JTcnpWcE1UMm5DUzA5THFMNTBRano4QTdncDVIL2hRenRaOGlO
eXNHRDlOTzQ2T25JNzUNCjkwZEhmQ3JYalFQU0Z0RkdzVHpnRHhRSWlNdXp6OURSN0Jla0tQbXVP
RkloQmU5ZUVacWJ4YzhSV2VRdA0KaGE3aS9EckpUUk5LMWFPQURRRlZ1VjEvQW01VGhHUFdGTS9Z
SlV5VFloTVcweWVQaDQ1T2JXdVJRWmtzDQpsK2FPbTRMMEtHRERZbG0vRlF4L0VNQ3Vidmx6eS96
eERkQjZucUZpaDJxWnJmeW1uaVNPS2FqRzBqb1QNCnBab3ovRXorNGZBdGc2eTBQc3BOUjZpZEFC
RUJBQUhDd0drRUdBRUlBQk1GQWx2d1NjY0pFRStYblBacg0Ka0xpZEFoc01BQW9KRUUrWG5QWnJr
TGlkUmUwSC9qNUNJRklBdWN1YWlFTWtMa05LRUFPNXM3eDQ3ZU55DQpHUGZac2x5WStIanpHVTBk
MDdNa2tHbVZrUFRWendxVnpOWmJueTdaQXYxemxXMFV5MHlIcDFBUHB5WXQNCjhidVVwcFRCcTdk
NDdvZ3hFUll6dC9MYzJMNWEvVktGTlJiaE4xL1hRbVBpejJFbGU0dHlpcGJUYXBjeQ0KK3pieWZ6
QU1EMTNjSWRaMTNoVHNOUDBvbGdCaEFxVUFVVVlweFJsa0FIZUorRHQzTmJ6SFM0S1FLNTM4DQpO
Si9sN2JYU0tzR3FvWXFKZVo4Vk5CeHdXV1VidUc0ampyaDQzTUlSZ1VaNVdzUFVZVjZIeDA1NmtN
amINCi9iWUJqSTBURU12SDgxNjB1cXpGWGVIdll5VWxxMFNpbkQvWjlpb0llOFFkc0hHQkRVSVJZ
WXViMXBPOA0KcXJDelJaeDBvTkE9DQo9L0RlYQ0KLS0tLS1FTkQgUEdQIFBVQkxJQyBLRVkgQkxP
Q0stLS0tLQ0K

--b1_xes3KZLDV9uHdyjUdNFNrKUE2eNcx551OrjVIGYZ0
Content-Type: application/pgp-signature; name="publickey - tincantech@...2282... - 0x09BC3D44.asc.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - tincantech@...2282... - 0x09BC3D44.asc.sig"

sOkDgryUUOk27rcprGli5uTjXqZfZWcHp1m5Awr5LFJeQbIWOxWa2sVvjssuaWTr

--b1_xes3KZLDV9uHdyjUdNFNrKUE2eNcx551OrjVIGYZ0--


