Date: Fri, 17 Feb 2017 17:41:31 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20170217164131.GU93896@...1296...>
References: <CAKh=nwGz-NSEcSY9KhQ12gC1GNXP6XOBTEO3FdP8gyJN5VTggg@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TuzloVs6SlI5NjIZ"
Content-Disposition: inline
In-Reply-To: <CAKh=nwGz-NSEcSY9KhQ12gC1GNXP6XOBTEO3FdP8gyJN5VTggg@...278...>
Subject: Re: [Openvpn-devel] build against openssl 1.1.0
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Emmanuel Deloget <logout@...260...>
Cc: openvpn-devel@lists.sourceforge.net

--TuzloVs6SlI5NjIZ
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Feb 17, 2017 at 05:35:04PM +0100, Emmanuel Deloget wrote:
> I understand that I'm the new guy in town, but can you allow me to
> make the formal request to ditch OpenSSL 0.9.8, 1.0.0 and 1.0.1 and
> require at least version 1.0.2?

I'm not going to make a call on any of these versions, I just want
to point out that we do need to (and *want* to) support older release
of distributions that do not ship "most recent" OpenSSL versions yet.

So we're somewhat caught in the middle between arch linux with 1.1.0
and something like RHEL that ships seriously old OpenSSL (with patches).

This said, we need to regularily re-evaluate what the oldest distribution
is that a given OpenVPN branch should support, and then we can drop support
for older OpenSSL versions...

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--TuzloVs6SlI5NjIZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYpye7AAoJEB2Cnv7KVigS2XAL/RTc2wr4Rq+etdTZcdAsagzI
TeeDlyokcrWUR56LXYF9Ab96CvF/EMra/B3wULvTvjhfZmRmVaOFSE8dE+34gAVV
F1ZAyXce7Umldd83/hWV5tL6RL3EMAuHZIYiKuYX7MU8ActsJiNLsv2an0tV3T1i
81v97He+My8rj0bbSaOT2KXTXImkZdj2q2/ZD9JOV1Oq7UNO419HnRRKFtpZTP2w
pfBt7ib2q6LlPheoTWkUzGsIZi0fOk6//aD7TSZD/AMSuYI1AS6tBQPFHr2NLGXy
Vc+Zrm2qyG1qYBLMYcbpWIXSfcew55L6d0AT4Bz9IaOJfDhuvhA6dpBC84o86niP
BpJoVWtzr+haX4mWLJZDHBkHCT2syvlo03sOh3a5F9oJrw1ydn8Q/fIY2g0KFM10
jXAX5dXk+V7HFybq4QDfudWwfLef5K2xOhcxW35c9ppUUkoqO3W0ME5waxulIVS0
HtdCEaoP+1VIm0G9ixq9W2Ja/WpDCAWGaRiLclyihg==
=X/n3
-----END PGP SIGNATURE-----

--TuzloVs6SlI5NjIZ--

