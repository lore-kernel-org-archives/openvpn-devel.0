Date: Wed, 30 Oct 2013 09:35:23 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20131030083523.GL161@...1296...>
References: <CAN_jwOsXhs-qTqOmrqhNk+Jf6-pRSBVVTovShLGgQAKKTZkE4g@...278...>
	<554440252.59882.1380270883311.JavaMail.zimbra@...1795...>
	<CAN_jwOvixY5Jz7Rheq-=o40saprsoQmxRB9yn3-jdCmFa9VM0A@...278...>
	<52456F61.3000104@...1114...>
	<CAN_jwOt4kiM09YjZi5=jh6qFgQTpLFgPOSO1opFOF72EY8fyCw@...278...>
	<CAN_jwOuJcwF-Co0r=pukUHO2z0a0ff5xtERp7_mc2PYot9yv-Q@...278...>
	<CAN_jwOuQR6rxUTA5Nho9tBkvSBMU75Yzfv=PFpFUHa2Kq8=E2A@...278...>
	<20131023141829.GA13900@...1296...>
	<20131023162618.GP161@...1296...>
	<CAN_jwOsnDbhxuR-buwk6JE2ST_JDfmaLuB0ffe=g6dAc4my6bQ@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kU1KBl72y3ES5hCz"
Content-Disposition: inline
In-Reply-To: <CAN_jwOsnDbhxuR-buwk6JE2ST_JDfmaLuB0ffe=g6dAc4my6bQ@...278...>
Subject: Re: [Openvpn-devel] Does openvpn 2.3.2 has memory leak?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Brad Zhang <hebei5000@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--kU1KBl72y3ES5hCz
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Oct 30, 2013 at 02:55:42PM +0800, Brad Zhang wrote:
> Thank you very much for your patch. I applied it on openvpn 2.3.2 release
> version. Memory leak issue is improved,   but maybe also have  a little
> memory leak.
> Here is my test result.

Thanks for testing.

If I understand you right, OpenVPN + OpenSSL is ok now, but OpenVPN +=20
PolarSSL is still leaking memory at renegotiaton time?

(A very small increase in memory, as for the openvpn case 283m->286m after
many rounds of renegotiation, is propably unavoidable due to some memory=20
fragmentation.  It should not continue to increase at every renegotiation,
though...)

Adriaan, Steffann, any idea whether the PolarSSL glue code (or PolarSSL
itself) might do something unreasonable here?  Haven't tested with Polar
and Valgrind yet...

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--kU1KBl72y3ES5hCz
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUnDEy6kuBuNlUUl1AQKACQP+PQJDuWxbeVdZGcEIzTWiUsSDOcDKhJIr
oorplBwN62pRxKVDQwSWKxoNvz0hf4BBa2NLTqJ8w/X6AEUYyef+dzPjko2RUKxd
R8IWdoPBC4osGsEnXGwLI7TNAz2FCnYkSp3g2vICOQSWQncJVhOyI8vSnrxMQX/i
udKXAV582Q0=
=RFrW
-----END PGP SIGNATURE-----

--kU1KBl72y3ES5hCz--

