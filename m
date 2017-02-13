Date: Mon, 13 Feb 2017 09:31:37 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20170213083137.GK93896@...1296...>
References: <CAOAUwZH8aRg-5XLJaYjpzw6y9yptx-ma7QJVPJT-yKFE7cmUrw@...278...>
	<c3f91fee-f629-fd60-c66c-19d45df6f24f@...1856...>
	<CAOAUwZF0LYNAYESg1fKeNUhJr70pLcf89HTyxTQmf2S3RnoUBA@...278...>
	<0cdcbed7-801c-9cec-cd03-1252c06b4466@...1856...>
	<CAOAUwZEiSjAEmTka=w-4TePAoGEZBZG1r_5gS-wpXL+TLX7qCQ@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5VuzLDXibKSJvVYD"
Content-Disposition: inline
In-Reply-To: <CAOAUwZEiSjAEmTka=w-4TePAoGEZBZG1r_5gS-wpXL+TLX7qCQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Fix building with LibreSSL 2.5.1 by
 cleaning a hack.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Olivier W <olivierw.ml@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--5VuzLDXibKSJvVYD
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Feb 13, 2017 at 12:02:45AM +0100, Olivier W wrote:
> I'll be sending the patch with "git format-patch" + "git send-email"
> as I have three commits and I'm not sure how to send a single patch
> with only "git send-email"

Look at "git rebase --interactive", which will enable you to squash
three commits into a single one.  Then you can use "git commit --amend"
to work on the (combined) commit message until you're happy with it.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--5VuzLDXibKSJvVYD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYoW7pAAoJEB2Cnv7KVigS9pYL/jK2W0jof+WYF9u6U+moecp0
C34EdVIpznrV7RAjekl0U2R0aj9Xpx4MkGWs//chtPIm6ri1ZqbrUE/SkRmnMnA1
Bg0jeDHQHaVpRV92mZxZ+35aNewikr/ArzyPzZXrfTc75ZIbmgskbRXgABGhVR2b
JSIdsm8TyXr5ndSnAf2vGnWGhcugPK8tTZzpL7UK6dRDCsU+J1Nxf3h5NecnLKtN
KX5rcsXutl7wPZ1vl+2eWrLDZ6YysmJraRW8ods62HeOPnDbHUbkrNnAz5ChL+MR
1ZTOhFX+Nh21aTrpdBObGthZxvxhiB2DzaG6UJqTMZnXKWgAyFAqAQatIRLFNCfz
3adKepKUoTqWfs+iPsE/rXeWXpGMkn9rEyOKRvOIrWQ2rCQgmS9S2HkKnjS4q3Eg
JNIUDSwJGEW1JC3b2tMBnBW9LiSb6QnVCPUcYTR0WEF3NJNiFFFLaKyvc5fvmG82
S72sv5wSgsJuNapmHtnfA+e2HVdLQ9kuw3Uix32WLw==
=0/UE
-----END PGP SIGNATURE-----

--5VuzLDXibKSJvVYD--

