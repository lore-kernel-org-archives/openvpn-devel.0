References: <1479153490-6259-1-git-send-email-steffan@...1856...>
	<1479153967-6788-1-git-send-email-steffan@...1856...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <e95b939e-9486-eaf4-b351-4423c7dbfd33@...2080...>
Date: Mon, 14 Nov 2016 22:35:49 +0100
MIME-Version: 1.0
In-Reply-To: <1479153967-6788-1-git-send-email-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH v2] Deprecate key-method 1
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 14/11/16 21:06, Steffan Karger wrote:
> Key method 2 has been the default since OpenVPN 2.0, and is both
> more functional and secure.  Also, key method 1 was only ever
> supported for peer-to-peer connections (i.e. not for
> client-server).
>=20
> Let's get rid of some legacy and phase out key method 1.
>=20
> v2: add Changes.rst entry, and update man page
>=20
> Signed-off-by: Steffan Karger <steffan@...1856...> --- Changes.rst
> | 7 +++++++ doc/openvpn.8         | 5 ++++- src/openvpn/options.c |
> 6 ++++++ 3 files changed, 17 insertions(+), 1 deletion(-)

I wanted to give this an ACK ... but I think we should just remove it
all together as we seem to be in a broken state already.

/usr/sbin/openvpn --dev tun --local 192.168.122.1 --lport 1194 \
         --remote 192.168.122.100 --rport 194 \
         --secret ../../sample/sample-keys/ta.key 0 \
         --ifconfig 10.8.0.10 10.8.0.20 --verb 3 \
         --key-method 1
Options error: Parameter key_method can only be specified in TLS-mode,
i.e. where --tls-server or --tls-client is also specified.
Use --help for more information.

That is with /usr/sbin/openvpn --version:
OpenVPN 2.3.11 x86_64-redhat-linux-gnu [SSL (OpenSSL)] [LZO] [EPOLL]
[PKCS11] [MH] [IPv6] built on May 10 2016

So unless I messed up my simple and stupid static key p2p mode tunnel,
this doesn't work at all with v2.3.  And git master haven't "fixed"
this issue.

If nobody noticed this by now, then nobody really uses --key-method.


- --=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYKi41AAoJEIbPlEyWcf3yVasP/0vlhDldY6i+HkBGrlMg1OxK
TnuTlqdoz3pg3q3DJT20+7plpsXdahfymB3cETwI27A71gTLx3o894f0zZDAGNvU
b2svnA7VSGnQMc0E8Bg6puyZJi88MtIibNtVScuu47POumS8I/FcRYB6TVIyr815
MU9q7dsyVXeX9rHBKY7gXfgZGkvBnTEOS67HimIF/fxY+mHQffYJAyRwlZcFZ78V
HW3ymUa/FY28AKMMSaa0xemuaCM6bthIYd7H7o02kTLOVKHXoqgKOG0Axd7yL9i0
pLuzPSiPGrIojw8W1i/n2X50RMTfKhrevwpCD6GYu9LS013et7LLiLGlvEKFbgOJ
NjTd+A5yHjDx75YZ9LQr8I0Tb/Ix6Xm41NCdDQaykSDmztCpWm11tGZuOxEDVUeC
wuzHGfwox7lG2Q+M9rW3V/w077eVwxLg4gFuUD+w3S9qKwTuPw5PGH0R7zojL22T
tb626KAbOFQjk3NzDG97HCWC3BPB7LT5anPuLcxdsrL3Wf05DqarcBEJp3nQQgnm
r1jCg09awOAld4kcmyE57rPCc8/GahTHbDFTLu5s5XI7Auo6LCqHecuhJgslT3Qk
LGNP8PVb8LK80sfmvXInvNtxh3zdvRo+YD9tluXbPcs+ynbxD/8mBaib84aLhyw5
FGPPexuZhKkAINHyduu2
=3DNQRH
-----END PGP SIGNATURE-----

