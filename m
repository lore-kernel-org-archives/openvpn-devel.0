Date: Fri, 17 Apr 2020 23:35:06 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200417213506.GI1431@...1296...>
References: <0a607581-4179-a97b-1e8b-e19dd6bd85bd@...515...>
 <CAEsd45Q+GvZf3du9FYCaLiPeupN88UTv3BjE1dzPKsJO2hzFjQ@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="RIQnQgS+cNEhgDa4"
Content-Disposition: inline
In-Reply-To: <CAEsd45Q+GvZf3du9FYCaLiPeupN88UTv3BjE1dzPKsJO2hzFjQ@...278...>
Subject: Re: [Openvpn-devel] OpenVPN 2.4.9 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "Jonathan K. Bullard" <jkbullard@...277...>
Cc: Samuli =?iso-8859-1?Q?Sepp=E4nen?= <samuli@...515...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--RIQnQgS+cNEhgDa4
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Apr 17, 2020 at 05:16:56PM -0400, Jonathan K. Bullard wrote:
> On Fri, Apr 17, 2020 at 8:47 AM Samuli Sepp=E4nen <samuli@...515...> wrot=
e:
> >
> > The OpenVPN community project team is proud to release OpenVPN 2.4.9. It
> > can be downloaded from here:
> >
> > <https://openvpn.net/community-downloads/>
>=20
> I'm having trouble verifying 2.4.9.tar.gz with GPG. I'm pretty
> clueless about gpg, but I think it may not have been signed with the
> correct key.

It's a new subkey, and gpg is pretty retarded about importing new
subkeys to an existing key - as in: it will just not do anything.

So for me (to import a new private key when subkeys rotate) I need
to totally remove the key from the keyring, and then re-add it to
get the new subkey.

That said...

> $ gpg --import security-key-2019.asc

... the new subkeys are just a few weeks old, so we need to publish
a new key bundle with the new subkeys.

Samuli...?

(And people wonder why nobody is using PGP crypto)

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--RIQnQgS+cNEhgDa4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJemiEJAAoJEB2Cnv7KVigSrRsL/08upMRokxQ0X8IWFseiw+fB
MSaFFLyVzhz/3cHJU26/LIm5SUeroasQbRlsp22YSm0ETUoSH9+Qdh0/jVokx3nW
zg3gu9+rxXV3BJk1usTtXdO0dmt6lTHfVfel9zJPDKfNVYF/B0z5sENntN1jlmwC
4L1Ed08yzTRGbCJ2BvjkoMge/0f+RVsInKuOxz2NuWO90EtPUkuh3Zd3u6/Y90+A
XF4TmvJJRzXBYLBiZdEGFu8DjXlhE5ORRerEnD+tqRlWnHENCrpRUqJmm9jR+nru
mf3J7ReaRbayQQtLvqJI5yDohx96BJ6eTkWnfLbBDNziScqJYrhA9lho1pmllPuj
Ob1uQSYwU23MkdDorgxGUfYzGN4k18jIygU6KsxJbJI43JcOYzDj5XQsWfqNN2gX
/wSSjZi7pTkJu/8TEI2mTKc8vEAKtpq0BKIDh/nq2BKD3EEBDIryL3EcyzYR7rey
cJzjXZ3NequSJlUZPP724wYw01HLyCuv3bgeTuYkPw==
=IlAl
-----END PGP SIGNATURE-----

--RIQnQgS+cNEhgDa4--

