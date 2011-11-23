Date: Wed, 23 Nov 2011 16:04:04 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20111123150404.GF8496@...1296...>
References: <20111123102344.GA8496@...1296...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iwXckgchTSXh1pHY"
Content-Disposition: inline
In-Reply-To: <20111123102344.GA8496@...1296...>
Subject: Re: [Openvpn-devel] extra patches needed for tap driver bugfix
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--iwXckgchTSXh1pHY
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Nov 23, 2011 at 11:23:44AM +0100, Gert Doering wrote:
> bugfixing the tap driver is nice and well, but I think we MUST bump the
> driver version as well, and we SHOULD have a check in tun.c to refuse
> operation if the known-buggy version (9.8) is detected.

Samuli built an installer with this (using the python build system),
which can be found here:

  http://build.openvpn.net/downloads/snapshots/openvpn-2.3-cron2-install.exe

I have tested this on Windows XP SP3, where the resulting tap driver
is correctly identified (version 9.9) and "ping with small packets" also
works correctly.  So I consider this to be "good!".

OTOH, two problems remain:

 - the installer has issues on Windows 7 - openvpn.exe doesn't find the
   tap driver on Samuli's test box.  So if someone else could test this
   on a "clean" machine, this would be appreciated.  (The driver is not
   signed, so you need to run in test mode).

 - the openvpn.exe binary that Samuli built doesn't work on XP, it's
   missing the inet_ntop symbol.  Which surprises me somewhat, as I thought
   we had this fixed months ago already???  Can someone shed some light
   on it...

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--iwXckgchTSXh1pHY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTs0LZKkuBuNlUUl1AQJiZgP+IPkRdCO1s/smuxQapPU3ZxrwzMivSOTf
EhrAff9kc3rZYvBiRO5lQVWBfB+RjWzb62OW0bbFyh14+pIXisdqCekatM4CAi8k
cqQpJrj+/1hIwOZeDmqzpQf8PQgwXC2bYD2EhQ1Ti7XjY9kwzlfbidDwBa8QkogN
06nR4XsxYlc=
=6xr7
-----END PGP SIGNATURE-----

--iwXckgchTSXh1pHY--

