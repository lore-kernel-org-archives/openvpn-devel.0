Date: Sat, 11 Jun 2016 22:26:21 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160611202621.GU62247@...1296...>
References: <0d1ed9a2-71f4-f791-3633-9937b3764de1@...1227...>
	<1465656195-12722-1-git-send-email-arne@...1227...>
	<20160611181434.GT62247@...1296...>
	<CAKuzo_gJLLjMWM7RRP=QzHBAEA6==f1BhEEa8gjL2W_FcGN-5A@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yiup30KVCQiHUZFC"
Content-Disposition: inline
In-Reply-To: <CAKuzo_gJLLjMWM7RRP=QzHBAEA6==f1BhEEa8gjL2W_FcGN-5A@...278...>
Subject: Re: [Openvpn-devel] [[PATCH v3]] Remove http-proxy-timeout,
 socks timeout and set default of server-poll-timeout to 120s
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--yiup30KVCQiHUZFC
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Jun 11, 2016 at 02:47:47PM -0400, Selva Nair wrote:
> Isn't this controlled by the http-proxy-retry option which is off by
> default? Set that in the config and SIGUSR1 restart should happen, I
> think...

Right you are, and ditto for --socks-proxy-retry.

Sat Jun 11 22:23:50 2016 Attempting to establish TCP connection with [AF_IN=
ET]195.30.4.1:23 [nonblock]
Sat Jun 11 22:23:51 2016 TCP connection established with [AF_INET]195.30.4.=
1:23
Sat Jun 11 22:23:51 2016 Send to HTTP proxy: 'CONNECT 10.0.0.1:51196 HTTP/1=
.0'
Sat Jun 11 22:23:51 2016 Send to HTTP proxy: 'Host: 10.0.0.1'
Sat Jun 11 22:24:10 2016 recv_line: TCP port read timeout expired: Operatio=
n now in progress (errno=3D115)
Sat Jun 11 22:24:10 2016 SIGUSR1[soft,init_instance] received, process rest=
arting
Sat Jun 11 22:24:10 2016 Restart pause, 5 second(s)
[..]
Sat Jun 11 22:24:15 2016 Attempting to establish TCP connection with [AF_IN=
ET]195.30.4.1:23 [nonblock]


(Side note: you win the "who knows more obscure/rarely used OpenVPN options"
contest today :-) )

I do wonder how useful these settings are, and why they are not default...
they predate my OpenVPN involvement by many years.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--yiup30KVCQiHUZFC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBV1xz7KkuBuNlUUl1AQJgNAP/fmDrOIC+nmIK1sunXTchttMS8n7FAdPJ
38m0G3F6bWEf4ADyl8m9gIp51MgMne/jjqM7xOxPDyNge+Vureq6zejdkwz2q1Z3
zlkWwgE0YHR0YHul83yLKZEEYGV5WNvjQ5VgoiJ/UjbzMfdSUBRRmkFnQUl6uofI
aIHtG77GrJ0=
=aw0A
-----END PGP SIGNATURE-----

--yiup30KVCQiHUZFC--

