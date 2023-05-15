From: Melvin Vermeeren <vermeeren@...2730...>
Date: Mon, 15 May 2023 15:00:43 +0200
Message-ID: <2129642.Ii9rTq9gLj@...2731...>
In-Reply-To: <683dac5b-4bfb-d359-4382-1f09cf57820f@...2108...>
References: <7072303.gtipl9YmvM@...2731...> <ZGDXETofVi68X7Ah@...1296...>
 <683dac5b-4bfb-d359-4382-1f09cf57820f@...2108...>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2275764.Bm8zEkEi59";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [Openvpn-devel] Automatically restart Linux systemd OpenVPN
 client service on failure
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net, David Sommerseth <dazo+openvpn@...2108...>
Cc: Arne Schwabe <arne@...1227...>, Gert Doering <gert@...1296...>

--nextPart2275764.Bm8zEkEi59
From: Melvin Vermeeren <vermeeren@...2730...>
Date: Mon, 15 May 2023 15:00:43 +0200
Message-ID: <2129642.Ii9rTq9gLj@...2731...>
Organization: vermware
In-Reply-To: <683dac5b-4bfb-d359-4382-1f09cf57820f@...2108...>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; protected-headers=v1
Content-Transfer-Encoding: 7bit

Hi all,

On Sunday, 14 May 2023 21:12:08 CEST David Sommerseth wrote:
> We ended up only enabling this on the server config by default, as it
> was some good points (which I don't recall right now) about not
> restarting the client configs automatically.  It might have been due to
> avoid DDoS the server in larger deployments, if a bad option would be
> pushed to all clients or something like that.

These are some good points. For server-side currently it is RestartSec=5s, 
which I agree makes sense for server. To avoid too aggressive connection 
spamming can we not set the client restart interval to a much higher value?

If OpenVPN itself does not fatal error/crash, the back-off interval mechanism 
is used for reconnect with the --connect-retry option. The default maximum 
wait time after a bunch of attempts is 300 seconds (5 minutes).

Knowing this is the worst case scenario for all common setups, I think we 
safely can set RestartSec=300s without any risk of DDoS or similar, as this 
timeout matches the slowest reconnection interval of OpenVPN internally.

Personally I think RestartSec=60s or RestartSec=120s is also fine, but I 
understand being conservative with a change like this. In the end I don't 
really care if it takes "one" or "a few" minutes as long as the client does 
reconnect if something went wrong inside or outside the OpenVPN process.

Thoughts on this?

Thanks!

-- 
Melvin Vermeeren
Systems engineer
--nextPart2275764.Bm8zEkEi59
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiu1YAh/qzdXye6Dmpy9idxbqnZYFAmRiLPwACgkQpy9idxbq
nZZMsQ//c0gmdDp4s89BlfT3E4K8mZ+D2d64c+cnlxrB2w4dzoryAFPJ9gwEJCo0
audLJw7BrfygUU0IhCE+U0zqdE7mePmUbkAtEcWuN5fa3JE+8LqCKxBzdsl/TBzQ
7Gh/kkGBR3zVEec2y+5PcHKhHLUzbxUjl5jFPICEUFjyBrUiTpXdns4eMuUUFjiO
LqeYRf6vbKHrKCZ20BTjqIyWQToVwDwPCbHZYEaoINr9SY4hMtsQLtcYHLD2sjn2
J55DWYaL8/1BPhUhX5S04HkmdImJYANDegOOnvYYFFVtimEFgOFnVmVrqiJFlSZ8
2SnhU7Qzd+jNoTNtIIDvdRetTFujk0vB3ESoHzVUzJyilgaHOMXgfkitF0K2nlfB
zGsSCgzkw1mOv94Kf5FbWg/DihMJb10iIPXthCGeszBkIfGXhkFJbiQmefifvQfc
9ig5fUay3V2w49MO32mkviRCwL5tx8UgB5jTUsH4ZfVRyVkmBqHP7YMe2tzsXJIf
LFKZwOViD0R/48D7fpvdKgt4UL0AghTgFvO5YT68Lvmf4bbLAjqSMi/kxJ7VBOM8
ar408L/QLtgnsyrG9ceDVIjxZdvWO817kCB3WtVtJZMRyCwXfCqLKQ20KqBP+4f1
R5EKkVLiWxXFkTodRb+ZS4gFexWTyXWlBAujWl0qqt7ty7ggdeQ=
=QD/1
-----END PGP SIGNATURE-----

--nextPart2275764.Bm8zEkEi59--




