Date: Fri, 16 Dec 2016 22:52:03 +0100
From: Christian Hesse <list@...1798...>
Message-ID: <20161216225203.609cf163@...1799...>
In-Reply-To: <fe5adcf8-b61e-3bb8-8810-4d8826ec3696@...2080...>
References: <20161216155755.29931-1-list@...1798...>
	<0f4adf76-7aa8-99e1-8fa4-e11f4e574909@...2080...>
	<20161216200919.68d61c42@...1799...>
	<fe5adcf8-b61e-3bb8-8810-4d8826ec3696@...2080...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/VCd9Rx1_45tWzDwO/QKqSJa";
	protocol="application/pgp-signature"
Subject: Re: [Openvpn-devel] [PATCH 1/1] do not race on RuntimeDirectory
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn@...2080...>
Cc: Christian Hesse <mail@...1798...>, openvpn-devel@lists.sourceforge.net

--Sig_/VCd9Rx1_45tWzDwO/QKqSJa
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

David Sommerseth <openvpn@...2080...> on Fri, 2016/12/16 22:15:
> On 16/12/16 20:09, Christian Hesse wrote:
> > David Sommerseth <openvpn@...2080...> on Fri, 2016/12/16
> > 19:14:=20=20
> >> On 16/12/16 16:57, Christian Hesse wrote:=20=20
> >>> From: Christian Hesse <mail@...1798...>
> >>>
> >>> Different unit instances create and destroy the same RuntimeDirectory.
> >>> This leads to running instances where the status file (and possibly
> >>> more runtime data) is no longer accessible.
> >>>
> >>> So create a RuntimeDirectory per instance.
> >>>
> >>> Signed-off-by: Christian Hesse <mail@...1798...>
> >>> ---
> >>>  distro/systemd/openvpn-client@...1685... | 2 +-
> >>>  distro/systemd/openvpn-server@...1685... | 4 ++--
> >>>  2 files changed, 3 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/distro/systemd/openvpn-client@...1685...
> >>> b/distro/systemd/openvpn-client@...1685... index 5618af3..fcb5302 100=
644
> >>> --- a/distro/systemd/openvpn-client@...1685...
> >>> +++ b/distro/systemd/openvpn-client@...1685...
> >>> @@ -9,7 +9,7 @@
> >>> Documentation=3Dhttps://community.openvpn.net/openvpn/wiki/HOWTO [Ser=
vice]
> >>>  Type=3Dnotify
> >>>  PrivateTmp=3Dtrue
> >>> -RuntimeDirectory=3Dopenvpn-client
> >>> +RuntimeDirectory=3Dopenvpn-client@%i=20=20=20=20
> >>
> >> I am quite sure we tested this, without any luck.  We ended up with a
> >> directory named openvpn-client@%i ... well, we used openvpn-client-%i,
> >> but the principle should be the same.
> >>
> >> This *might* have been fixed in a newer systemd releases, but as we ha=
ve
> >> RHEL7 as the oldest release we need to ensure this works properly there
> >> too.
> >>
> >> For the server side, we used status-%i.log to avoid clashing on the
> >> status log.
> >>
> >> debbie10t did plenty of testing with various configurations, so he can
> >> probably fill out more details in the various test cases he used.  We
> >> should probably document those tests in our wiki though.=20=20
> >=20
> > Running systemd 232 here and everything works as expected. This is with
> > unit files from current master:
> >=20
> > # systemctl start openvpn-server@...2216...
> > # systemctl start openvpn-server@...2217...
> > # systemctl stop openvpn-server@...2217...
> > # ls -l /run/openvpn-server/
> > ls: cannot access '/run/openvpn-server/': No such file or directory
> >=20
> > And the same with my patch applied:
> >=20
> > # ls -l /run/openvpn-server@...2218.../status.log=20
> > -rw------- 1 root root 8419 Dec 16
> > 20:03 /run/openvpn-server@...2218.../status.log
> >=20
> > From systemd.exec(5) about RuntimeDirectory=3D:=20=20
> >> Takes a list of directory names. If set, one or more directories by the
> >> specified names will be created below /run (for system services) [...]
> >> when the unit is started, and removed when the unit is stopped.=20=20
> >=20
> > So this works as long the no service is stopped or fails.
> >=20
> > I do not have RHEL7 around... What exactly fails there?=20=20
>=20
> The directory is literally named 'openvpn-server@%i'

Ok, that's bad. So another idea... Let's remove RuntimeDirectory=3D and
RuntimeDirectoryMode=3D from unit files. Instead we provide a file openvpn.=
conf
to be installed to /usr/lib/tmpfiles.d/ containing:

d /run/openvpn-client 0710 root root -
d /run/openvpn-server 0710 root root -

systemd will create the directories for us and nobody will
(unintentionally) delete them. As /run is volatile we do not have to care.
--=20
main(a){char*c=3D/*    Schoene Gruesse                         */"B?IJj;MEH"
"CX:;",b;for(a/*    Best regards             my address:    */=3D0;b=3Dc[a+=
+];)
putchar(b-1/(/*    Chris            cc -ox -xc - && ./x    */b/42*2-3)*42);}

--Sig_/VCd9Rx1_45tWzDwO/QKqSJa
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXHmveYAHrRp+prOviUUh18yA9HYFAlhUYgMACgkQiUUh18yA
9HahZQf8CdRbMv2trvS/WvzYyho6CPX62mQTFXpMs+KJzjvJdrr/rvM0pKD2vDQG
dbLBmGQaqXzjeGa+UgHJKog8wVRB9r4HIh1QhziRGJRt7Z8u18G8217nRxdRfqbq
tp2gpiQbtgPassOVJ26A7f9DQnY4ukFOYNOjO57sZ5H+mGtG0QpaQeE01Oot5ImV
WkrVKpPEq/18QGvAv5BqfidHjth6ncJqnWnKQ67RIaY4+lWF/VjKcBJ5hVw0vqZ6
2NWkjFaR7LV+sQTexLhyy9X1rWKyBIUDDtdJ+od0vT5Oms3mp+vW1v4KDXsZ5pns
Xate1SK9Uypt9d8z9ORKOWQ8QBWPnQ==
=9NyG
-----END PGP SIGNATURE-----

--Sig_/VCd9Rx1_45tWzDwO/QKqSJa--

