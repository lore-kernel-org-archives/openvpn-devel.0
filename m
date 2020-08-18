Date: Tue, 18 Aug 2020 08:23:35 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200818062335.GV75094@...1296...>
References: <CAAWBBYPw=TZg1wftWZL5ABKVWkp7=6hpdaumLN2D24Cgr-E4pQ@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="dEhLd0jN5MocHkcT"
Content-Disposition: inline
In-Reply-To: <CAAWBBYPw=TZg1wftWZL5ABKVWkp7=6hpdaumLN2D24Cgr-E4pQ@...278...>
Subject: Re: [Openvpn-devel] 2.5-beta-1 Wintun requires SYSTEM privileges
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Rafael Gava <gava100@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--dEhLd0jN5MocHkcT
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Aug 18, 2020 at 12:06:18AM -0300, Rafael Gava wrote:
> 2020-08-17 19:15:39 us=3D424470 ERROR:  Wintun requires SYSTEM privileges=
 and
> therefore should be used with interactive service. If you want to use
> openvpn from the command line, you need to do SYSTEM elevation yourself
> (for example with psexec).

This can also happen if you run the GUI with admin privs (because then
it will not use the iservice *but* openvpn needs *more* privs than
"just administrator", and wintun can not be used at all).

[..]
> 1) Is there any problem in using openvpn with the wintun interface from an
> unsigned built release?
> 2) Is there any problem with wintun in using an unsigned nsis installer
> than the .msi one?

Not that I'm aware.  This looks more like "iservice not being used due
to admin privs when running the GUI".

You can crosscheck this fairly easy - if wintun does not work with the
message above, try running with the old tun/tap driver.  If that works,
and you see successful "netsh" commands in the log to set up routing, you=20
are running with admin privs.

> 3) I'm also trying to generate a msi installer with vagrant msibuilder but
> I'm getting the following error:

I can't say anything about that, sorry...

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--dEhLd0jN5MocHkcT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfO3PnAAoJEB2Cnv7KVigSQzsL/0NBBBckWoBvKWcl1ypdbwxP
uY1NXiKTvE5ZWnW1eGhuHqf7aKSkuk99GB6Uj1QD4SwFcnhVPeWBI9ydF9ywCuLD
7yofNWNlAlSnpusdC25Wo8TvSPOitzaaHNFNAePq+JGMii+IMyZKvIJ6H6rNhN64
TlBPaD236CoyBDvJiGfTuPTW2RXYkIz76a4QudlqAHErtavoK1Th1ncJBCgftrhC
KtBDJzNQ3GM+0v5XdK5HHpVNui75cLF1FZ2q3kxHHKo/c4Kn++dxAjttQj/vVajx
Ct+KK+5wiEvqrpl4a1G/XWCMAQ5EscD94+R19vqTNLOVRMjCwj+VBK3wD6/TJ4PP
17FEH/+a37l7Y5ymTDb1/1SrK3viYJWqV3o95twHbdLoVKu2qhqvlGmYc7+y7GPB
AVMwtp/tWGae24ayALolf6vVr6a8xwyVIg55kdqOB2EHJA8Bh1uR56ZSj1xohgzX
T4Fk3/T8sCodNdP0U0nYUwl7hhVaDenIdrICAxQH3w==
=dhtO
-----END PGP SIGNATURE-----

--dEhLd0jN5MocHkcT--

