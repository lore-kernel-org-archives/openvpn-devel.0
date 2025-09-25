Date: Thu, 25 Sep 2025 20:14:53 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <aNWGnYzLNX22oadM@...1296...>
References: <010B9529-6C1E-454A-9846-26AC9581AFE9@...2722...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="OWPhB9i9naZzDco0"
Content-Disposition: inline
In-Reply-To: <010B9529-6C1E-454A-9846-26AC9581AFE9@...2722...>
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN 2.7_beta2 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

--OWPhB9i9naZzDco0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Sep 25, 2025 at 05:42:01PM +0300, Yuriy Darnobyt wrote:
> Important bug fixes since 2.7_beta1:
>=20
> * add proper input sanitation to DNS strings to prevent an attack coming=
=20
> from a trusted-but-malicous OpenVPN server (CVE-2025-10680, affects
> unixoid systems with --dns-updown scripts and windows using the built-in
> powershell call)

Let me emphasize this.  If you followed my advice to "please go and test
2.7_beta1" and installed a --dns-updown script (for example by compiling
and then "make install"), and there is a risk that you connect to an
openvpn server that is not trustworthy -> please upgrade ASAP.

Also, do not use openvpn configs from untrusted sources with 2.7_beta1
under unixoid OSes.

If your OpenVPN server is fully trusted, and you know where the configs
are coming from, then there is no attack angle.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--OWPhB9i9naZzDco0
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJo1YadAAoJEB2Cnv7KVigSyvQL+wcXRtQ6c6hkuP925VIqsqgi
aczp9TGf14DxF1nXd+fayNaCzJyiG2s+jYOwRcTG20tQfF9drNAlV4t3xhqkKbJL
CCuTRuQByrNBZzj7Z5uA+0hr55FZLhyoGxgAfjLvah4TXt5mQwVNIxcrYk3fN946
9fqMYM4fjWui5jMQXLx0iGLpc71O2JvxXzxdIy8wiszNmFZIbWLe4HB8fpkBVveK
4XedEvdkwE0W4FQFYPdi769/Ad/Gn5oPyhAq3gs7PG0zziNnL3vkDVARII21Nu2c
t4o9Ao/JhWkyLL44RvppHK5VKwewuSoECrBOYYUVQll9YyQ/8XRlbRjKjcrcE0oc
7LLxgDkbBOjzmdBj20GXqcaRn/l3joM4yA9btUoZdNnTghj2Pz4oynDsrG3TXaKl
1YxwlZZ/1TQ9WQgBY10XtYdokppQA0MP4G5no7OJrCV+CGCjWkrFLzZzygGyZhcB
S0EAHJ2UL8QDCrYyD0rrumiBiaGquTc2P/ByUcNv0Q==
=/371
-----END PGP SIGNATURE-----

--OWPhB9i9naZzDco0--

