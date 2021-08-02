Date: Mon, 02 Aug 2021 14:25:43 +0000
From: tincantech <tincantech@...2282...>
Reply-To: tincantech <tincantech@...2282...>
Message-ID: <6RsDUmySrPGEV7JavznUFEqlLE9Zr2jMUy7CVSgHYrO1YXdtSi8NwmLMpL7X1vcdFOXQblmZB0OmOcw3UJzDkOMvXQLvaQsBuGeqlCXA7kc=@protonmail.com>
In-Reply-To: <20210802095211.693800-1-arne@...1227...>
References: <20210802095211.693800-1-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1_88ZYSXoeLRUA7mNiWXR1pOYqkHz9FiKKyfL7GyOU"
Subject: Re: [Openvpn-devel] [PATCH v3] Add example script demonstrating
 TOTP via auth-pending
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.

--b1_88ZYSXoeLRUA7mNiWXR1pOYqkHz9FiKKyfL7GyOU
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi,

Sent with ProtonMail Secure Email.

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90

On Monday, August 2nd, 2021 at 10:52, Arne Schwabe <arne@...1227...> wrote:

> Signed-off-by: Arne Schwabe arne@...1227...
>
> Patch v3: Some minor cleanups in the script (rename CNs, add more comment=
s)
>
> Signed-off-by: Arne Schwabe arne@...1227...
>
> doc/man-sections/script-options.rst | 3 +
>
> sample/sample-scripts/totpauth.py | 111 ++++++++++++++++++++++++++++
>
> 2 files changed, 114 insertions(+)
>
> create mode 100755 sample/sample-scripts/totpauth.py
>
> diff --git a/doc/man-sections/script-options.rst b/doc/man-sections/scrip=
t-options.rst
>
> index f48e5818d..6517f8474 100644
>
> --- a/doc/man-sections/script-options.rst
>
> +++ b/doc/man-sections/script-options.rst
>
> @@ -147,6 +147,9 @@ SCRIPT HOOKS
>
> :code:`auth_control_file or further defer it. See `--auth-user-pass-verif=
y`
>
> for details.
>
> -   For a sample script that implement TOTP (RFC 6238) based two-factor
> -   authentication, see :code:`sample-scripts/totp.py`.

sample-scripts/totp.py -> sample-scripts/totpauth.py

Checked everything else and it all LGTM.
-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsBzBAEBCAAGBQJhCABYACEJEE+XnPZrkLidFiEECbw9RGejjXJ5xVVVT5ec
9muQuJ1MTgf+KJa9xstxZXVoGhTer7jFDn+EQdKeBQT3S2JOiu/lLVrGFhCG
+4nEXmsVSN/G/UIqwIzTfe0c6bTALGeEI4YUjL2Rsqixt96xxVUWeer+YVdv
DF4Jxza/vCagzH3uszCpvBgiqB4YIhk7ZaTpLGfXqbY0VgVrwUD1AYPPWPFH
tssgUx5UxSqqoT+AnIpsHTkT/svKCmd1d5IYLjAPy0I9+2vhBQEauWr4f/xa
eoRJb6CQET3z3Lag9DEuqct/k4kT+twS4WYh4Ljr5SzNhuRZV+fbqHQYgk3n
50QttAoUmgzVKkwPSzwTd6u5DZUiT4KyH5REeqAOdwzNYwmxjwKCkQ=3D=3D
=3DYOUk
-----END PGP SIGNATURE-----

--b1_88ZYSXoeLRUA7mNiWXR1pOYqkHz9FiKKyfL7GyOU
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

--b1_88ZYSXoeLRUA7mNiWXR1pOYqkHz9FiKKyfL7GyOU
Content-Type: application/pgp-signature; name="publickey - tincantech@...2282... - 0x09BC3D44.asc.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - tincantech@...2282... - 0x09BC3D44.asc.sig"

wsBzBAABCAAGBQJhCABYACEJEE+XnPZrkLidFiEECbw9RGejjXJ5xVVVT5ec9muQuJ2Uxwf/Xl2Q
i1p/yyeyBxGkeL4vAxyD7YWvtvnNbu1NKiDIykfat/zf/0J8dkM/bko7fMMOFBIfpH13kOJLedRV
t0J/3PFA9T3hpzQFRUP4WZmy3hb7/zkzE9+S/o9wDaEsjQa+UCfb8RAhufnIXmO5+gdhD+kupDIt
+1RNNQ+1xgjlmdGSeHsAzALAwsw6BIk+IB2yS/tW1f2MzX3rgRlBFWAdaOwUB9jNCzFSJ/Da9EOx
/MREhbbelGu3cogaq8PP56Os8WVO+SaUHLQR4cNsmAmBjJfSN4Mpa8BoQ/8ljQLxXujRdJCvwovs
r8MWBQQ6Wn2Pdfdm0Md+BcgfyjjWsZmzOw==

--b1_88ZYSXoeLRUA7mNiWXR1pOYqkHz9FiKKyfL7GyOU--


