Date: Wed, 30 Nov 2022 21:53:35 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y4fCzwr781gUglV9@...1296...>
References: <Y4Shyldcb82P6An8@...1296...> <Y4SjdkeiOPhTUfVv@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="0PE999r4efSezmgz"
Content-Disposition: inline
In-Reply-To: <Y4SjdkeiOPhTUfVv@...1296...>
Subject: Re: [Openvpn-devel] new P2P NCP wart...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--0PE999r4efSezmgz
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Nov 28, 2022 at 01:03:02PM +0100, Gert Doering wrote:
> On Mon, Nov 28, 2022 at 12:55:54PM +0100, Gert Doering wrote:
> > 2022-11-28 12:55:25 us=3D199080 ERROR: failed to negotiate cipher with =
peer and --data-ciphers-fallback not enabled. No usable data channel cipher
> > 2022-11-28 12:55:25 us=3D199092 ERROR: Failed to apply P2P negotiated p=
rotocol options
>=20
> Thinking about this a bit - what I think this should do is SIGUSR1=20
> itself, so reconnect (subject to the usual exponential decay) or exit,
> depending on user config.

Fixed by the lala land patch (commit 8187bbba5cdfa46fe).

Thanks, Arne.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--0PE999r4efSezmgz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjh8LPAAoJEB2Cnv7KVigSGp4MAIGh3Fq1Yeg0+zMQtjPFByzs
VkJAPkr9bEHsB6XWOpmReJqYpRMyaqLKNV6hqysRuw45PjFpvRPx/ffRSWm3L/9M
qem8w6BTVF8u7Y9uRupecWU5MQr4sUz5brJetRWs7O0GEpE5OjL7xg+jV1qK388V
inrHlgNaoqr/ubtPNhADD0CIpSpEZfnicfl/7MICa86fIUw8X+9UzOhmjahIyY/8
iSUqiD6GJq7v0GgLTfFm5aHl9YzC4TG7FKBPHyyb1YUKX6cIFTKV9dNxshi9B+Zj
g1p6RN2ECSidkrGtNor7K77DdfK3VGFzOZg2+s9jzbWtu5u7/oC26CIPyni2prWw
aJ9xf0BwBErh3ikjyD/KfBbKZZJb/Yzf2k1l5513Byk8NAtVb5KHeRHcWvXWNDJr
5RMuccwWfkklMlLXJBsRKjqNv12zxJf/ksaAhhrif0STPKJ5/54lOuz/0Bw0YQgT
mUTXt3Izw8Clf1YpURVXRmqr8VeV12mPOxcpE2QjLg==
=Zw2n
-----END PGP SIGNATURE-----

--0PE999r4efSezmgz--

