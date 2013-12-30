Date: Mon, 30 Dec 2013 21:50:33 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20131230205032.GH226@...1296...>
References: <52ADF633.8040003@...1856...> <20131216073024.GC161@...1296...>
	<52C0AF83.5010501@...1856...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CD/aTaZybdUisKIc"
Content-Disposition: inline
In-Reply-To: <52C0AF83.5010501@...1856...>
Subject: Re: [Openvpn-devel] [PATCH] Use RSA_generate_key_ex() instead of
	deprecated, RSA_generate_key()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

--CD/aTaZybdUisKIc
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Dec 30, 2013 at 12:25:55AM +0100, Steffan Karger wrote:
> I've given the stripping out a little more thought and think I'm in
> favour of stripping this out of 2.4, but keep support in 2.3 to not
> break anything for minor releases. Removing this cipher mode sounds
> like a feature to me ;)

Thanks for your explanation.  Yes, this sounds good to me.

As Arne also ACKed the patch, I'll merge it into 2.3 only ("soonish").

Could I ask you to provide a patch to remove this for 2.4?

thanks,

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--CD/aTaZybdUisKIc
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUsHcmKkuBuNlUUl1AQKPWAP9GKXVTz0MvQ5qx+1t4hdrxxfU6VJqlo+4
IMNCjjxDl3SKwiin6jDjeb6J8GwDR9cscfxCRziKXSy+DMQTKhItGUIJytEBGfNX
4l7ssRdku6b6pTUd4i4ECD6hOyoTTpXCIgJJhJa3Fk5BnhDCeSyVSQD9h6ZQdHNM
Jet9AHix7B0=
=6nsA
-----END PGP SIGNATURE-----

--CD/aTaZybdUisKIc--

