Date: Thu, 6 Oct 2016 19:01:43 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20161006170142.GD78279@...1296...>
References: <784d3a54-24a9-dc57-b1f3-a8010d7e99db@...277...>
	<20161006121736.GB78279@...1296...>
	<50515770-ae2b-ee70-9ada-452f69cce800@...1227...>
	<a24673c2-2aca-7bcb-6826-23335bf5a557@...277...>
	<6ccb18ab-8434-6433-8f21-aabc4459955e@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vYN7BrMefepn8YqN"
Content-Disposition: inline
In-Reply-To: <6ccb18ab-8434-6433-8f21-aabc4459955e@...277...>
Subject: Re: [Openvpn-devel] Slight change to buildbot t_client.sh.in &
 t_client.rc
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: debbie10t <debbie10t@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--vYN7BrMefepn8YqN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Oct 06, 2016 at 04:47:21PM +0100, debbie10t wrote:
> As I am on possibly the cheapest internet in the UK and "-i 1000"
> solves the problem, i expect simply including say "-i 2000" in
> t_client.sh.in will be sufficient for just about anywhere, unless
> you try to run a buildslave in the jungles of Borneo !

To repeat this: *no*.  We're not including -i 2000 by default in the
script, because that will slow down things for all testers (and t_client
takes enough time as it is, I run it interactively often enough).

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--vYN7BrMefepn8YqN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQCVAwUBV/aDdqkuBuNlUUl1AQI3WQP+ML4qNESo8HChh86ua3BP3TvZftXWbGER
RTLLFHDChbrJJeZzGG5Bp32sm2+BFer4kdBAhT2no+RApj0bFUbnCcnNkhGGmWS7
ojR/aXPLtIGLOLYzRyeL4Qm3iOcHrDQJA+QdyikePRbGSwKBH9FKJ54aDimx6Dkb
QLfsI79dqvM=
=rOQF
-----END PGP SIGNATURE-----

--vYN7BrMefepn8YqN--

