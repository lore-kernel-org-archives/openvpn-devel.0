Date: Sat, 10 Dec 2016 12:57:42 +0100
From: Christian Hesse <list@...1798...>
Message-ID: <20161210125742.101acc79@...1799...>
In-Reply-To: <1481339215.461706744@...2211...>
References: <20161209181303.20267-1-list@...1798...>
	<98427851-6cfd-70e8-df2a-c646fa6087da@...2080...>
	<20161209224646.1bc65baf@...1799...>
	<1481339215.461706744@...2211...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/m3jlpE+PO5DGWIOGOFg/=zL";
	protocol="application/pgp-signature"
Subject: Re: [Openvpn-devel] [PATCH 1/1] add more security features for
 systemd units
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: SviMik <svimik@...450...>
Cc: openvpn-devel@lists.sourceforge.net

--Sig_/m3jlpE+PO5DGWIOGOFg/=zL
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

SviMik <svimik@...450...> on Sat, 2016/12/10 06:06:
> > You can break this with something like:
> >=20
> > status /etc/openvpn/client/status.log
> >=20
> > in your configuration. Writing a status file
> > to /run/openvpn-{client,server}/status.log works, though. So the default
> > setups should be fine. Do we have any more cases where openvpn wants wr=
ite
> > access for whatever?=20=20
>=20
> From my configuration:
> 1) status

That is fine if it is written to /run/openvpn-{client,server}/. It breaks
with the status file in /etc/openvpn/{client,server}/ or example.

> 2) ifconfig-pool-persist

That is a problem... As the name suggests this should be persistent. :-/

> 3) tmp-dir (for storing openvpn_pf_*.tmp files)

Never used this. What is it for?
Anyway, I think this is not persistent stuff? Writing to /tmp/
or /run/openvpn-{client,server}/ should be fine.

> 4) client-connect script may want to write something

My scripts do some configuration and dbus-stuff, but do not write anything.=
..
Writing to read-only path would fail, of course.

> 5) a plugin may want to write something

Same here... /run/ and /tmp/ is fine, other paths fail.

> For me even the read-only option will break nearly *everything*. And for
> user it will be completely not obvious why his scripts doesn't work, why
> his status file is not updated, and what's wrong with ifconfig-pool-persi=
st.

Well, the error message should include something like: "cannot open file
'file': Read-only file system".

But this is more problematic than I thought initially.
--=20
main(a){char*c=3D/*    Schoene Gruesse                         */"B?IJj;MEH"
"CX:;",b;for(a/*    Best regards             my address:    */=3D0;b=3Dc[a+=
+];)
putchar(b-1/(/*    Chris            cc -ox -xc - && ./x    */b/42*2-3)*42);}

--Sig_/m3jlpE+PO5DGWIOGOFg/=zL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXHmveYAHrRp+prOviUUh18yA9HYFAlhL7bYACgkQiUUh18yA
9Ha0qwf/YPRNnL29DTr/tlj6EsCnNepSENxf7V6K/8Rlh5XpMtrg2pEBH4sWiF9b
lWvdFR70RKPpR3Apb72/IkBrJyeA2H1Xjty8HTR2p+y3UxPKZyIPhXdTwUpdWBIF
3nlVzMERRJP1UXT72ed5se399osH3oWwIqBitp+x3iRZcyFBIv5LsBrOoQ4SMBWN
5dM3N6M7z2FDegEIoszYhd5fnudFsTmWJNdyHZKQ1QE9X/AAc0Hy2urFSp+MvCFn
bBs1du4HC6euMFe+5WjUBKbmPZYoB1Ybl8sOHHSmek3kztAxFB5LKmZfoH45ceVu
0pedQfQfnt58rbvYBN6/nMROn1HKUw==
=jLYW
-----END PGP SIGNATURE-----

--Sig_/m3jlpE+PO5DGWIOGOFg/=zL--

