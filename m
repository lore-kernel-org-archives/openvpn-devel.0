Date: Wed, 10 Mar 2021 16:47:54 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20210310154754.GH976@...1296...>
References: <20210226134829.3589-1-arne@...1227...>
 <20210304114052.8577-1-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="zQ/HU6AW7OEKVkWa"
Content-Disposition: inline
In-Reply-To: <20210304114052.8577-1-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v4] Implement deferred auth for scripts
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

--zQ/HU6AW7OEKVkWa
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Mar 04, 2021 at 12:40:52PM +0100, Arne Schwabe wrote:
> This patch also refactors the if condition that checks the result of
> the authentication since that has become quite unreadable. It renames
> s1/s2 and extracts some parts of the condition into individual variables
> to make the condition better understandle
>=20
> Patch v2: add refactoring of the if condition
> Patch v4: fix documentation not mentioning method as 2nd line

Not sure yet what is happening, but this breaks deferred auth in plugins
- as in "they always succeed".

I have some test cases using plugin-auth-pam which delays for about 15
seconds (querying a nonexisting radius server) and then checks a local
auth+password file.  One of the cases should succeed "but be delayed",
one of the cases must fail "but delayed fail", because I send a username
that does not exists.

With this patch applied, authentication *succeeds* very fast in both
cases, even with wrong password.

The log file with this patch has:

2021-03-10 16:40:43 us=3D610286 2001:608:0:814::f000:21 VERIFY OK: depth=3D=
0, C=3DDE, ST=3DBavaria, L=3DMunich, O=3DOpenVPN community project, OU=3DSe=
rver Testing, CN=3Dcron2-freebsd-tc-amd64, emailAddress=3Dgert@...2576...
2021-03-10 16:40:43 us=3D612104 PLUGIN AUTH-PAM: do deferred auth '/tmp/ope=
nvpn_acf_2f305c6e47c6552f3e29e210b1c0baf.tmp'
2021-03-10 16:40:43 us=3D612428 PLUGIN AUTH-PAM: deferred authentication
2021-03-10 16:40:43 us=3D612823 PLUGIN AUTH-PAM: BACKGROUND: deferred auth =
for 'fbsd-tc-masterFoo', pid=3D21053
2021-03-10 16:40:43 us=3D612951 PLUGIN AUTH-PAM: cannot open '/tmp/openvpn_=
acf_2f305c6e47c6552f3e29e210b1c0baf.tmp' for writing: No such file or direc=
tory (errno=3D2)
2021-03-10 16:40:43 us=3D617812 2001:608:0:814::f000:21 TLS: Username/Passw=
ord authentication deferred for username 'fbsd-tc-masterFoo'=20
2021-03-10 16:40:43 us=3D618636 2001:608:0:814::f000:21 Control Channel: TL=
Sv1.3, cipher TLSv1.3 TLS_AES_256_GCM_SHA384, 2048 bit RSA
2021-03-10 16:40:43 us=3D618674 2001:608:0:814::f000:21 [cron2-freebsd-tc-a=
md64] Peer Connection Initiated with [AF_INET6]2001:608:0:814::f000:21:40868
2021-03-10 16:40:43 us=3D618705 cron2-freebsd-tc-amd64/2001:608:0:814::f000=
:21 MULTI_sva: pool returned IPv4=3D194.97.145.74, IPv6=3D2001:608:3:814::1=
000
2021-03-10 16:40:43 us=3D625942 cron2-freebsd-tc-amd64/2001:608:0:814::f000=
:21 OPTIONS IMPORT: reading client specific options from: /tmp/openvpn_cc_1=
cdbffdecac750624e0d4deb89a7ad1d.tmp
...
2021-03-10 16:40:43 us=3D626454 cron2-freebsd-tc-amd64/2001:608:0:814::f000=
:21 SENT CONTROL [cron2-freebsd-tc-amd64]: 'PUSH_REPLY,route 10.204.0.0 255=
.255.0.0,route-ipv6 fd00:abcd:204::/48,tun-ipv6,route-gateway 194.97.145.73=
,topology subnet,ping 10,ping-restart 30,compress lz4,ifconfig-ipv6 2001:60=
8:3:814::1000/64 2001:608:3:814::1,ifconfig 194.97.145.74 255.255.255.248,p=
eer-id 0,auth-tokenSESS_ID,cipher AES-256-GCM,key-derivation tls-ekm' (stat=
us=3D1)


Actually, there is a script involved as well - the server config has

# ASYNC (20s delay ueber pam_radius)
setenv deferred_auth_pam 1
plugin /.../openvpn-plugin-auth-pam.so "openvpn-global Login: USERNAME Pass=
word: PASSWORD"

# nebenbei auch noch das shell-interface validieren
script-security 3
auth-user-pass-verify /.../auth-user-pass-verify.sh via-env


if I remove the call to "auth-user-pass-verify", the plugin failure is
correctly detected and signalled again.  It also waits proper 15 seconds
again...

2021-03-10 16:44:31 us=3D527310 PLUGIN AUTH-PAM: BACKGROUND: deferred auth =
for 'fbsd-tc-masterFoo', pid=3D21861
2021-03-10 16:44:46 us=3D546819 PLUGIN AUTH-PAM: BACKGROUND: user 'fbsd-tc-=
masterFoo' failed to authenticate: User not known to the underlying authent=
ication module
2021-03-10 16:44:47 us=3D992782 2001:608:0:814::f000:21 SENT CONTROL [cron2=
-freebsd-tc-amd64]: 'AUTH_FAILED' (status=3D1)


... and no error messages about the auth_control_file missing.

So, it seems the cleanup of this nasty bit of logic has actually broken=20
it :-( (or introduced new and interesting corner cases)


I'll see if I can find sufficient brains to dig into this and see what
is happening.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--zQ/HU6AW7OEKVkWa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgSOopAAoJEB2Cnv7KVigS8WUMAK6WBMWg77ZEk30fRW4xiYGM
oqGD5oXVJKd6a3bnuT6y6QkSqrehNaG/BRuGhz7m9fAuby8ZT7CbUCmxfr5Gfacx
qhoNt1Ix4X/ii+X6D5pLlN6BYTx/LNb6rzQAVc6ZOFvwALypvQdWoNHxx3QAin5W
PcE8Rc+xhkIxyEFVFupmnjnbSt3ZaYZlzxseTV+naZSqZH4eO0Fn2+a9yxwBzD9g
CDkU4h2Ehf7s4Ozgm4d6FhHqmQNdu28Ujow/9EDvuRxAKcI939/bVAkDbMn4ZviR
IbT2ttRZhITdmg5RXpPr7Q1j0wpypqwXx0xeInygO3XQTgbJeXPEre5h1zHPldl6
Z0HTL8oMQjrFRFw5p32tk9A2eeLrpuFSrE709GkFwm6dKEtVvBmPZcgqjwJEbGHr
DAa0jEENkLVQdJaX/H6FiwU0fsEJxZMX9I9Dclu0tJARLYXNPNZNwhbw/6N/ukVW
POmW1zaEEjED1Eig+VTGldY4+zWYA+a8ZTBUj+XdFg==
=d8Ji
-----END PGP SIGNATURE-----

--zQ/HU6AW7OEKVkWa--

