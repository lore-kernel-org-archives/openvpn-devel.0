Date: Fri, 16 Dec 2016 20:09:19 +0100
From: Christian Hesse <list@...1798...>
Message-ID: <20161216200919.68d61c42@...1799...>
In-Reply-To: <0f4adf76-7aa8-99e1-8fa4-e11f4e574909@...2080...>
References: <20161216155755.29931-1-list@...1798...>
	<0f4adf76-7aa8-99e1-8fa4-e11f4e574909@...2080...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/Iwf7QbNY_kaBw4N5S7cNrTP";
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

--Sig_/Iwf7QbNY_kaBw4N5S7cNrTP
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

David Sommerseth <openvpn@...2080...> on Fri, 2016/12/16 19:14:
> On 16/12/16 16:57, Christian Hesse wrote:
> > From: Christian Hesse <mail@...1798...>
> >=20
> > Different unit instances create and destroy the same RuntimeDirectory.
> > This leads to running instances where the status file (and possibly
> > more runtime data) is no longer accessible.
> >=20
> > So create a RuntimeDirectory per instance.
> >=20
> > Signed-off-by: Christian Hesse <mail@...1798...>
> > ---
> >  distro/systemd/openvpn-client@...1685... | 2 +-
> >  distro/systemd/openvpn-server@...1685... | 4 ++--
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/distro/systemd/openvpn-client@...1685...
> > b/distro/systemd/openvpn-client@...1685... index 5618af3..fcb5302 100644
> > --- a/distro/systemd/openvpn-client@...1685...
> > +++ b/distro/systemd/openvpn-client@...1685...
> > @@ -9,7 +9,7 @@
> > Documentation=3Dhttps://community.openvpn.net/openvpn/wiki/HOWTO [Servi=
ce]
> >  Type=3Dnotify
> >  PrivateTmp=3Dtrue
> > -RuntimeDirectory=3Dopenvpn-client
> > +RuntimeDirectory=3Dopenvpn-client@%i=20=20
>=20
> I am quite sure we tested this, without any luck.  We ended up with a
> directory named openvpn-client@%i ... well, we used openvpn-client-%i,
> but the principle should be the same.
>=20
> This *might* have been fixed in a newer systemd releases, but as we have
> RHEL7 as the oldest release we need to ensure this works properly there t=
oo.
>=20
> For the server side, we used status-%i.log to avoid clashing on the
> status log.
>=20
> debbie10t did plenty of testing with various configurations, so he can
> probably fill out more details in the various test cases he used.  We
> should probably document those tests in our wiki though.

Running systemd 232 here and everything works as expected. This is with unit
files from current master:

# systemctl start openvpn-server@...2216...
# systemctl start openvpn-server@...2217...
# systemctl stop openvpn-server@...2217...
# ls -l /run/openvpn-server/
ls: cannot access '/run/openvpn-server/': No such file or directory

And the same with my patch applied:

# ls -l /run/openvpn-server@...2218.../status.log=20
-rw------- 1 root root 8419 Dec 16 20:03 /run/openvpn-server@...2218.../sta=
tus.log
--Sig_/Iwf7QbNY_kaBw4N5S7cNrTP--
