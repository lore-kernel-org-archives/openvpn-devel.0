Date: Thu, 18 Aug 2022 09:10:01 +0000
From: tincantech <tincantech@...2282...>
Reply-To: tincantech <tincantech@...2282...>
Message-ID: <_uM8yZ4irz2llJwaaxyuSL85KKacU344R3Rx0VWBZRbYJwai-A2aCE5SPLhSUbzC-jg3och9rt1J7RdgzBkj9vAlPrI6p-rwka9bYGapdI8=@protonmail.com>
In-Reply-To: <6900ED88-65D7-450E-8A3A-3D9509D206AD@...2692...>
References: <6900ED88-65D7-450E-8A3A-3D9509D206AD@...2692...>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1_s8YaYYIX9V7nOdStcjDvrRti3QdnzcXuOvpZTnNtZg"
Subject: Re: [Openvpn-devel] Possible bug?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Magnus Larsson <list@...2692...>
Cc: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.

--b1_s8YaYYIX9V7nOdStcjDvrRti3QdnzcXuOvpZTnNtZg
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Magnus,

can you report this as an issue on github, please ?

https://github.com/OpenVPN/easy-rsa/issues

My first guess would be the version of openssl 3.0.1 is at fault.

Thanks,
Richard



Sent with Proton Mail secure email.

------- Original Message -------
On Thursday, August 18th, 2022 at 02:37, Magnus Larsson via Openvpn-devel <=
openvpn-devel@lists.sourceforge.net> wrote:


> Hi,
> I just moved from Ubuntu 20.04 LTS (where the exact command works fine an=
d does not prompt for pass phrase) to Red Hat Enterprise Linux 9 and instal=
led Easy-RSA via EPEL.
>
> When I run=C2=A0./easyrsa=C2=A0build-ca nopass as root, it still prompts =
for PEM pass phrase:
>
>
> # ./easyrsa build-ca nopass
> Using SSL: openssl OpenSSL 3.0.1 14 Dec 2021 (Library: OpenSSL 3.0.1 14 D=
ec 2021)
> Enter PEM pass phrase:
> Enter PEM pass phrase:
> Enter PEM pass phrase:
> Enter PEM pass phrase:
> 80DB8DBF7D7F0000:error:0480006D:PEM routines:PEM_def_callback:problems ge=
tting password:crypto/pem/pem_lib.c:62:
> 80DB8DBF7D7F0000:error:07880109:common libcrypto routines:do_ui_passphras=
e:interrupted or cancelled:crypto/passphrase.c:175:
> 80DB8DBF7D7F0000:error:1C80009F:Provider routines:p8info_to_encp8:unable =
to get passphrase:providers/implementations/encode_decode/encode_key2any.c:=
116:
>
>
>
>
> #=C2=A0./easyrsa --version
> EasyRSA Version Information
> Version: =C2=A0 =C2=A0 3.0.8
> Generated: =C2=A0 Wed Sep =C2=A09 15:59:45 CDT 2020
> SSL Lib: =C2=A0 =C2=A0 OpenSSL 3.0.1 14 Dec 2021 (Library: OpenSSL 3.0.1 =
14 Dec 2021)
> Git Commit: =C2=A0f12e00e53b4f486ce3d119ca429198780fa694ac
> Source Repo: https://github.com/OpenVPN/easy-rsa
>
>
>
>
> #=C2=A0ls -l
> total 8
> lrwxrwxrwx 1 root root =C2=A0 29 Aug 17 18:56 easyrsa -> /usr/share/easy-=
rsa/3/easyrsa
> lrwxrwxrwx 1 root root =C2=A0 41 Aug 17 18:56 openssl-easyrsa.cnf -> /usr=
/share/easy-rsa/3/openssl-easyrsa.cnf
> drwx------ 9 root root 4096 Aug 17 20:10 pki
> -rw-r--r-- 1 root root =C2=A0332 Aug 17 18:56 vars
> lrwxrwxrwx 1 root root =C2=A0 36 Aug 17 18:56 vars.example -> /usr/share/=
doc/easy-rsa/vars.example
> lrwxrwxrwx 1 root root =C2=A0 32 Aug 17 18:56 x509-types -> /usr/share/ea=
sy-rsa/3/x509-types
>
>
>
>
> # cat /etc/os-release
> NAME=3D"Red Hat Enterprise Linux"
> VERSION=3D"9.0 (Plow)"
> ID=3D"rhel"
> ID_LIKE=3D"fedora"
> VERSION_ID=3D"9.0"
> PLATFORM_ID=3D"platform:el9"
> PRETTY_NAME=3D"Red Hat Enterprise Linux 9.0 (Plow)"
> ANSI_COLOR=3D"0;31"
> LOGO=3D"fedora-logo-icon"
> CPE_NAME=3D"cpe:/o:redhat:enterprise_linux:9::baseos"
> HOME_URL=3D"https://www.redhat.com/"
> DOCUMENTATION_URL=3D"https://access.redhat.com/documentation/red_hat_ente=
rprise_linux/9/"
> BUG_REPORT_URL=3D"https://bugzilla.redhat.com/"
>
>
> REDHAT_BUGZILLA_PRODUCT=3D"Red Hat Enterprise Linux 9"
> REDHAT_BUGZILLA_PRODUCT_VERSION=3D9.0
> REDHAT_SUPPORT_PRODUCT=3D"Red Hat Enterprise Linux"
> REDHAT_SUPPORT_PRODUCT_VERSION=3D"9.0"
>
>
>
>
> #=C2=A0dnf repolist
> Updating Subscription Management repositories.
> repo id =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0repo name
> codeready-builder-for-rhel-9-x86_64-rpms =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 Red Hat CodeReady Linux Builder for RHEL 9 x86_64 (RPMs)
> epel =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Extra Packages for Enterprise Linux 9 - x86=
_64
> rhel-9-for-x86_64-appstream-rpms =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Red Hat Enterprise Linux 9 for x86_64 - =
AppStream (RPMs)
> rhel-9-for-x86_64-baseos-rpms =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Red Hat Enterprise Linux 9 for=
 x86_64 - BaseOS (RPMs)
>
>
>
>
> #=C2=A0getenforce
> Disabled
>
>
>
>
> #=C2=A0uname -a
> Linux test 5.14.0-70.22.1.el9_0.x86_64 #1 SMP PREEMPT Tue Aug 2 10:02:12 =
EDT 2022 x86_64 x86_64 x86_64 GNU/Linux
>
>
>
> Let me know if you need additional information.
>
> Thanks,
> Magnus
>
-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsBzBAEBCAAGBQJi/gHXACEJEE+XnPZrkLidFiEECbw9RGejjXJ5xVVVT5ec
9muQuJ3FpAf9FRWGhWLwzc8ONkqdMM0yts3GHGMhQ6ZqzILJjLh4Udgn5NlI
IV7InwTHZZm7IE6q4IWhzSqGA/KjIc23Xydsz29Vh0BDoDDZemeXkjYdxCQd
gRDIMuzMLTqCQIoI9FqeWKKQW9r5cG9qwIpUwiBh2BUmub2D0hb7P0SVEWur
+moGPLU1neXIhlL2F6hbTqtl/wNxr2V5qLfODrRJpiEyKQNa1C8GvvqXJR2r
BYRA2vyoFIGn+krBMBb2lcExGhioWr4gzecFolqOin9e/i3pCCii1Xl4/XI5
BqHP31VoNmc88CLmOhSn/At3kagcnou9WDsA8DbJabW1/MPeGjKpXQ=3D=3D
=3DukTL
-----END PGP SIGNATURE-----

--b1_s8YaYYIX9V7nOdStcjDvrRti3QdnzcXuOvpZTnNtZg
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

--b1_s8YaYYIX9V7nOdStcjDvrRti3QdnzcXuOvpZTnNtZg
Content-Type: application/pgp-signature; name="publickey - tincantech@...2282... - 0x09BC3D44.asc.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - tincantech@...2282... - 0x09BC3D44.asc.sig"

wsBzBAABCAAGBQJi/gHXACEJEE+XnPZrkLidFiEECbw9RGejjXJ5xVVVT5ec9muQuJ2xtwf+MDxf
Inqyv890YgWFK0xdRDqcBlvCq940lrqAiVu/chc5DjbMNasvYa5HMVrfubGIfPSdfxg+peNBLLbT
XR1QgL0RNGibpNVTd1Ut2nKz0jRH6i6gq6XK6zTOvRWENX+zZhReiwdE0k85gRsIRTmYra27d6Eg
iu8VwZ6OyJGNsbMKxLCbaeBdXR1BIXsBljL1xIg1yNky8TQPHWdoxumoJfWkAbmAYgW33pcsAAfC
6QbVg1dEQ3UBSpfK79kx0nsehoL6RlAFNlijhowOZjRXADuBohWnIbhIDO27lUd1yy/aOa27+h6E
GiVAu/dHHYJwYcv05occKA2bDiR3tepxbg==

--b1_s8YaYYIX9V7nOdStcjDvrRti3QdnzcXuOvpZTnNtZg--


