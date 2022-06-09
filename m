Message-ID: <6db98ba0-9f0b-54dc-6c8c-cf06b5b79016@...376...>
Date: Thu, 9 Jun 2022 17:24:16 +0200
MIME-Version: 1.0
References: <f1dde3516874c6b9bec11fcbd121fad9@...2675...>
Content-Language: en-US
From: Bernhard Schmidt <berni@...376...>
In-Reply-To: <f1dde3516874c6b9bec11fcbd121fad9@...2675...>
Subject: [Openvpn-devel] Fwd: Bug#1012567: openvpn --mktun --dev-type tap
 --dev tap2 fails
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Hi,

I've received the following bug report for the dco-enabled OpenVPN 2.6=20
build currently sitting in Debian unstable. It looks like DCO is=20
interfering with the CLI option to create a tap interface.

Bernhard



---
Package: openvpn
Version: 2.6.0~git20220518+dco-2
Severity: important

Since 2.6.0~git20220518+dco-2 the following command fails:

openvpn --mktun --dev-type tap --dev tap2

with

Assertion failed at dco_linux.c:442 (tt-type =3D=3D DEV_TYPE_TUN)
Exit due to fatal error


I don't have dco support in the linux kernel.


openvpn --disable-dco --mktun --dev-type tap --dev tap2


works as a workaround, but I think --mktun --dev-type tap should=20
continue to work without it.

Regards,
--=20
Wolfgang Walter
Studentenwerk M=C3=BCnchen
Anstalt des =C3=B6ffentlichen Rechts
---

