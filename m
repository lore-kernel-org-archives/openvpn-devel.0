References: <20180819200703.20362-1-gert@...1296...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <581066d5-41c4-9169-74b2-b15169cd4599@...2181...>
Date: Fri, 28 Sep 2018 18:09:32 +0800
MIME-Version: 1.0
In-Reply-To: <20180819200703.20362-1-gert@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="2vpWPaiIrz4povz8ZszfxCpRcyjUZdOGG"
Subject: Re: [Openvpn-devel] [PATCH] Fix combination of --dev tap and
 --topology subnet across multiple platforms.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2vpWPaiIrz4povz8ZszfxCpRcyjUZdOGG
Content-Type: multipart/mixed; boundary="s4frRCM0Eb4CDKb22LfrN450JYRy3A4Vk";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net
Message-ID: <581066d5-41c4-9169-74b2-b15169cd4599@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] Fix combination of --dev tap and
 --topology subnet across multiple platforms.
References: <20180819200703.20362-1-gert@...1296...>
In-Reply-To: <20180819200703.20362-1-gert@...1296...>

--s4frRCM0Eb4CDKb22LfrN450JYRy3A4Vk
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 20/08/18 04:07, Gert Doering wrote:
> --topology should have no effect in tap mode (tap is always "subnet"),
> but due to the way options are checked, setting "topology subnet" caught
> an improper branch on all non-linux and non-win32 platforms.
>=20
> Easily tested by adding "--topology subnet" to a "--dev tap" t_client
> test.
>=20
> Tested, verified, and fixed on FreeBSD 10.4, NetBSD 7.0.1, OpenBSD 6.0,
> and OpenSolaris 10.  Compile-tested on MacOS X.
>=20
> Trac: #1085
>=20
> Signed-off-by: Gert Doering <gert@...1296...>

After staring at the code I couldn't identify any issue and the logic
followed by the code is not more clear (for what it can be ..).

I had a discussion with Gert on IRC and he clarified some doubts I had
in a clear manner, therefore I am happy with this patch.


Acked-by: Antonio Quartulli <antonio@...515...>



--=20
Antonio Quartulli


--s4frRCM0Eb4CDKb22LfrN450JYRy3A4Vk--

--2vpWPaiIrz4povz8ZszfxCpRcyjUZdOGG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3o8ejP0lUW4GTX3J9FVsWUWDDm0FAlut/dwACgkQ9FVsWUWD
Dm0AQA/+Kji1smxJMqRDi6mG3kAM8uSl56lLe1jlLNT3TWD/GNae+wzbg39l/fTm
ttnpggSQPuz+D3m/QVSohgRaGe+l8Ukr8IPA6ZfEBd+81fqGvjFggqzC6uJ+kl/t
kOhxB94wlgi9ok3Ss8qdUNIc+2ZwXUoG9yQR6oGC8L6F8X3TzYQe9k+8jcJLu5F6
17d7X7OhRFp8L+EEBQ2oR3H851Vs6HHZvLzZq8M1/OaFGbJkwXyEnC6KM3VGjmvw
woocROG5wHy+YRTNYtCaUYRHEuwZ7Hu6b7Pfx8J08j3KIbvMHQF3Ytv6gMrrCzpE
ROnUcf/Dqvim0aV2+9b+C8pzVQazfv+/gINBv3EqX4hu8qJqq6WmtKrq9wBRk2ao
DsBPUPC27LsCUYJvpMT2AWaiP4TDvk9Kd2VD3KiB3Kp/4xOHZJnBAJDn5Wborqeu
fH7bmr6LcAlGSm2RQ4UXQ5AS2ZEI9KBgUbM59yAxq3zmnjUqag1wP5H7ZOUf1Dlx
1l1GV8lBBhAuZTPdkpVPNqLGy15D7shFMLstACSzYFQQeDtPqK94iSpJWSOt3UmE
pXz/YRWKYi9RUJOUHOW0VtovqyeVEmiXkGHMu7MMy7m83zo99aSs9zxSdHnAVogx
ip8WrgbBibeepQ7ricbGSErpfHX3eys2+mh3JkGjqkeT3AmIYbA=
=9RyW
-----END PGP SIGNATURE-----

--2vpWPaiIrz4povz8ZszfxCpRcyjUZdOGG--

