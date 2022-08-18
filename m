Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
From: Magnus Larsson <list@...2692...>
In-Reply-To: <_uM8yZ4irz2llJwaaxyuSL85KKacU344R3Rx0VWBZRbYJwai-A2aCE5SPLhSUbzC-jg3och9rt1J7RdgzBkj9vAlPrI6p-rwka9bYGapdI8=@protonmail.com>
Date: Thu, 18 Aug 2022 07:53:24 -0400
Message-Id: <35DD1515-30B5-48DB-A6E7-6B504C5C7912@...2692...>
References: <6900ED88-65D7-450E-8A3A-3D9509D206AD@...2692...>
 <_uM8yZ4irz2llJwaaxyuSL85KKacU344R3Rx0VWBZRbYJwai-A2aCE5SPLhSUbzC-jg3och9rt1J7RdgzBkj9vAlPrI6p-rwka9bYGapdI8=@protonmail.com>
Subject: Re: [Openvpn-devel] Possible bug?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: tincantech <tincantech@...2282...>
Cc: openvpn-devel@lists.sourceforge.net

Thanks a lot, will do!

On August 18, 2022, at 05:10, tincantech <tincantech@...2282...> wrote:

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
>=20
> When I run ./easyrsa build-ca nopass as root, it still prompts for PEM pa=
ss phrase:
>=20
>=20
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
>=20
>=20
>=20
>=20
> # ./easyrsa --version
> EasyRSA Version Information
> Version:     3.0.8
> Generated:   Wed Sep  9 15:59:45 CDT 2020
> SSL Lib:     OpenSSL 3.0.1 14 Dec 2021 (Library: OpenSSL 3.0.1 14 Dec 202=
1)
> Git Commit:  f12e00e53b4f486ce3d119ca429198780fa694ac
> Source Repo: https://github.com/OpenVPN/easy-rsa
>=20
>=20
>=20
>=20
> # ls -l
> total 8
> lrwxrwxrwx 1 root root   29 Aug 17 18:56 easyrsa -> /usr/share/easy-rsa/3=
/easyrsa
> lrwxrwxrwx 1 root root   41 Aug 17 18:56 openssl-easyrsa.cnf -> /usr/shar=
e/easy-rsa/3/openssl-easyrsa.cnf
> drwx------ 9 root root 4096 Aug 17 20:10 pki
> -rw-r--r-- 1 root root  332 Aug 17 18:56 vars
> lrwxrwxrwx 1 root root   36 Aug 17 18:56 vars.example -> /usr/share/doc/e=
asy-rsa/vars.example
> lrwxrwxrwx 1 root root   32 Aug 17 18:56 x509-types -> /usr/share/easy-rs=
a/3/x509-types
>=20
>=20
>=20
>=20
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
>=20
>=20
> REDHAT_BUGZILLA_PRODUCT=3D"Red Hat Enterprise Linux 9"
> REDHAT_BUGZILLA_PRODUCT_VERSION=3D9.0
> REDHAT_SUPPORT_PRODUCT=3D"Red Hat Enterprise Linux"
> REDHAT_SUPPORT_PRODUCT_VERSION=3D"9.0"
>=20
>=20
>=20
>=20
> # dnf repolist
> Updating Subscription Management repositories.
> repo id                                                                  =
  repo name
> codeready-builder-for-rhel-9-x86_64-rpms                                 =
  Red Hat CodeReady Linux Builder for RHEL 9 x86_64 (RPMs)
> epel                                                                     =
  Extra Packages for Enterprise Linux 9 - x86_64
> rhel-9-for-x86_64-appstream-rpms                                         =
  Red Hat Enterprise Linux 9 for x86_64 - AppStream (RPMs)
> rhel-9-for-x86_64-baseos-rpms                                            =
  Red Hat Enterprise Linux 9 for x86_64 - BaseOS (RPMs)
>=20
>=20
>=20
>=20
> # getenforce
> Disabled
>=20
>=20
>=20
>=20
> # uname -a
> Linux test 5.14.0-70.22.1.el9_0.x86_64 #1 SMP PREEMPT Tue Aug 2 10:02:12 =
EDT 2022 x86_64 x86_64 x86_64 GNU/Linux
>=20
>=20
>=20
> Let me know if you need additional information.
>=20
> Thanks,
> Magnus
>=20
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
<publickey - tincantech@...2282... - 0x09BC3D44.asc><publickey - tincantech=
@...2282... - 0x09BC3D44.asc.sig>


