Date: Sat, 11 Jun 2016 20:14:34 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160611181434.GT62247@...1296...>
References: <0d1ed9a2-71f4-f791-3633-9937b3764de1@...1227...>
	<1465656195-12722-1-git-send-email-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jIYo0VRlfdMI9fLa"
Content-Disposition: inline
In-Reply-To: <1465656195-12722-1-git-send-email-arne@...1227...>
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--jIYo0VRlfdMI9fLa
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Jun 11, 2016 at 04:43:15PM +0200, Arne Schwabe wrote:
> With this change all timeouts before the first packet from the OpenVPN se=
rver are unified into the server-poll-timeout option.
>=20
> The default of 120s has been chosen to be a safe value is larger as it is=
 larger the sums of the old small timeouts.

One thing I noticed when testing which is not *caused* by this patch but
which you/we might want to fix while at it.

When talking to a "deaf" HTTP proxy - namely, one that accepts the TCP
connect, but then never sends back anything (try 195.30.4.1:23, it's
a "Teergrube" to annoy wannabe hackers) the timeout will fire at the
correct interval - 25s in my test, but then it won't restart but exit:

Sat Jun 11 20:05:59 2016 Attempting to establish TCP connection with [AF_IN=
ET]195.30.4.1:23 [nonblock]
Sat Jun 11 20:06:00 2016 TCP connection established with [AF_INET]195.30.4.=
1:23
Sat Jun 11 20:06:00 2016 Send to HTTP proxy: 'CONNECT 10.0.0.1:51196 HTTP/1=
.0'
Sat Jun 11 20:06:00 2016 Send to HTTP proxy: 'Host: 10.0.0.1'
Sat Jun 11 20:06:24 2016 recv_line: TCP port read timeout expired: Operatio=
n now in progress (errno=3D115)
Sat Jun 11 20:06:24 2016 SIGTERM[soft,init_instance] received, process exit=
ing

The same thing happens if I lure openvpn into trying a SOCKS proxy connecti=
on
to that host:

Sat Jun 11 20:10:47 2016 Attempting to establish TCP connection with [AF_IN=
ET]195.30.4.1:23 [nonblock]
Sat Jun 11 20:10:48 2016 TCP connection established with [AF_INET]195.30.4.=
1:23
Sat Jun 11 20:10:53 2016 socks_handshake: TCP port read timeout expired: Op=
eration now in progress (errno=3D115)
Sat Jun 11 20:10:53 2016 SIGTERM[soft,init_instance] received, process exit=
ing


... while all *other* connection failures I could test trigger a SIGUSR1=20
restart...

- plain TCP connection timeout:

Sat Jun 11 20:12:09 2016 Attempting to establish TCP connection with [AF_IN=
ET]195.30.4.1:20 [nonblock]
Sat Jun 11 20:12:34 2016 TCP: connect to [AF_INET]195.30.4.1:20 failed: Con=
nection timed out
Sat Jun 11 20:12:34 2016 SIGUSR1[connection failed(soft),init_instance] rec=
eived, process restarting
Sat Jun 11 20:12:34 2016 Restart pause, 5 second(s)

- TCP connects, but "only dead air":

Sat Jun 11 20:12:48 2016 Attempting to establish TCP connection with [AF_IN=
ET]195.30.4.1:23 [nonblock]
Sat Jun 11 20:12:49 2016 TCP connection established with [AF_INET]195.30.4.=
1:23
Sat Jun 11 20:12:49 2016 TCP_CLIENT link local: (not bound)
Sat Jun 11 20:12:49 2016 TCP_CLIENT link remote: [AF_INET]195.30.4.1:23
Sat Jun 11 20:13:14 2016 Server poll timeout, restarting
Sat Jun 11 20:13:14 2016 SIGUSR1[soft,server_poll] received, process restar=
ting

(interesting enough, no "Restart pause" here)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--jIYo0VRlfdMI9fLa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBV1xVCKkuBuNlUUl1AQIuuwP/e3dq454HzLPVaPnAF0Z0C/+bmN7n6wCx
D0NpHwcfdAjiTyGQK3V8e85i+fFXHnPl9kS1WtpIJ0RaMhjzs+Qbm/iSVKqP05bx
B+fyzu3L9WRRfS380kYscFannhvZqfA7xb2P5a/v8djZVSuIm5mrEVdjTMNsiqLY
5cQz4jW91sg=
=/eVG
-----END PGP SIGNATURE-----

--jIYo0VRlfdMI9fLa--

