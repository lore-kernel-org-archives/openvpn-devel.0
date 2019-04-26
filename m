References: <CAEYw=WoZDJap1cwCh-SAqJr8KiQEv80XmBkVbVijTbCbOCOP0g@...278...>
 <CAEYw=Wqna4PnOf+ZQV2sqkrQ6sLdCUQgwxRnrFBVuRx60uAbZA@...278...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <24961e3f-19da-a7b3-50db-d67aef792b62@...2181...>
Date: Fri, 26 Apr 2019 15:46:53 +0200
MIME-Version: 1.0
In-Reply-To: <CAEYw=Wqna4PnOf+ZQV2sqkrQ6sLdCUQgwxRnrFBVuRx60uAbZA@...278...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="DtJ8Kv0KKCyXMi1qoZRbAzNExD3U6TODK"
Subject: Re: [Openvpn-devel] Client reconnect issues
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Pieter Hulshoff <pieter.hulshoff@...2499...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>, Openvpn-users@lists.sourceforge.net, Gert Doering <gert@...1296...>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DtJ8Kv0KKCyXMi1qoZRbAzNExD3U6TODK
Content-Type: multipart/mixed; boundary="UHKdyQ1uazMHutg2Ku3Dj0vmOJJsvhSBA";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Pieter Hulshoff <pieter.hulshoff@...2499...>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Openvpn-users@lists.sourceforge.net, Gert Doering <gert@...1296...>
Message-ID: <24961e3f-19da-a7b3-50db-d67aef792b62@...2181...>
Subject: Re: [Openvpn-devel] Client reconnect issues
References: <CAEYw=WoZDJap1cwCh-SAqJr8KiQEv80XmBkVbVijTbCbOCOP0g@...278...>
 <CAEYw=Wqna4PnOf+ZQV2sqkrQ6sLdCUQgwxRnrFBVuRx60uAbZA@...278...>
In-Reply-To: <CAEYw=Wqna4PnOf+ZQV2sqkrQ6sLdCUQgwxRnrFBVuRx60uAbZA@...278...>

--UHKdyQ1uazMHutg2Ku3Dj0vmOJJsvhSBA
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 26/04/2019 15:32, Pieter Hulshoff wrote:
>> Any thoughts on this matter? Is it true that this only happens with
>> mbedtls, and as such should this issue be taken up with that community in
>> stead of this one? Any idea on why the server would refuse a PUSH request
>> for an already existing connection?
>>

mbedtls is not responsible for answering PUSH_REQUEST messages.

mbedtls is just the SSL library providing a number of functionalities
and does not know anything about the OpenVPN protocol (which PUSH
messages belong to).

So, if this behaviour is different compared to when using OpenSSL, then
it means there is something else behind.

This said, OpenVPN has a protection that prevents a server to reply to a
PUSH_REQUEST from the same client more than once within 30 seconds.

Therefore if you are shutting down a client and restarting it within
this short timeframe, it is expected that you won't get any PUSH_REPLY.

Does this match your observations?

If not, could you please mention step by step what to do to reproduce
the faulty problem?

This will help on two fronts:
1) allow us to better understand your case
2) allow us to replicate the issue


Note: that using nobind probably fools this logic because the client
will re-connect using a different source port and thus will be
recognized as different.

Thanks.

Regards,


--=20
Antonio Quartulli


--UHKdyQ1uazMHutg2Ku3Dj0vmOJJsvhSBA--

--DtJ8Kv0KKCyXMi1qoZRbAzNExD3U6TODK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3o8ejP0lUW4GTX3J9FVsWUWDDm0FAlzDC80ACgkQ9FVsWUWD
Dm0t4w/+KMRJBVBHappXoKVd/gStW7CG09wZfkxrybYO5Dx5/kgOvTo/Y43Ni87p
MnbMQZgqpXMKwaUlY+o90zzlGRW954kxfOMzUJhwIoWMgUv8WLkDmcIhBpCqIhsU
4gEBbmP0SfAgA53dTk4d6b0kpcjRkghpwCpdvwsnDR0oTGLyw8ZbV9KryDcsGfOj
kXH28YZLenHXnGeisjgP7aTP6KZqBuFNZLIi26e2QeUBuCQgME5Q0Wnkv+d0SufW
X4AaSVukK7T5Re4RlM8OLLix2H+NiDz45W4kRemnDoRebxDOyx0MwgK5/JWlfWqQ
Ib26WI/cRTDz0+Tx0rhxK2u7rHMK+26z7i15TWkvLe1gxDFqNTKSuDj1tuj/1IVg
5EJM9IzqWB3SOcBcF+T4XEDzVUBt14hLtE2qXHyOEuFKV0quvOgSesNKekillNZG
uYUv/XEvJyinht+ccjfo4xIM0rHuGstsFd50QpFyrJuhetdCKqq1ed7AJyoXYJbb
m+ShJApbxR84qaRfTkyCAOvWAeO7wq/8pNVtrDu1Fx5TgGM3buNSGXzmjYTllr0v
8wZrmxnJQvoh/oOy5NAFl8YOPnJVYpr5LRZo+Jl/dYX1KGAd7oVRxKn/qK2nD58x
2UCDs26ZII3Qv2ZTQF2wh8S9gKewZ5pnvpQAV25wS6R7N+W1kwU=
=sgF9
-----END PGP SIGNATURE-----

--DtJ8Kv0KKCyXMi1qoZRbAzNExD3U6TODK--

