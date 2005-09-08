Message-ID: <1e6368e805090813104568d337@...278...>
From: Leonard Isham <leonard.isham@...277...>
Reply-To: leonard.isham@...277...
Subject: Re: [Openvpn-devel] New subnet topology feature ready for testing
In-Reply-To: <Pine.LNX.4.58.0509081353010.12112@...41...>
Mime-Version: 1.0
References: <Pine.LNX.4.58.0509062125110.12112@...41...>
	 <1e6368e805090804304b1d7ae9@...278...>
	 <Pine.LNX.4.58.0509081103120.12112@...41...>
	 <1e6368e80509081126163dce34@...278...>
	 <Pine.LNX.4.58.0509081353010.12112@...41...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Thu Sep  8 13:11:12 2005
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: James Yonan <jim@...41...>
Cc: openvpn-users@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net

On 9/8/05, James Yonan <jim@...41...> wrote:
> On Thu, 8 Sep 2005, Leonard Isham wrote:
>=20
> > On 9/8/05, James Yonan <jim@...41...> wrote:
> > >
> > > On Thu, 8 Sep 2005, Leonard Isham wrote:
> > >
> > > > On 9/8/05, James Yonan <jim@...41...> wrote:
> > > > >
[snip]
> >
> > Please bear with a  network geek's rambling for a minute.
> >
> > 1. There is a windows install available.
>=20
> Yes.
>=20
> > 2. the tar file can become an RPM with RPMBuild, correct?
>=20
> Yes.
>=20
> > I'd have to deal with:
> >
> > 1. Disabling openvpn updates via yum.
> > 2. This is a branch that will not be "merged" back in until 2.1 beta.
> > 3. 2.0.3 or other updates will not include this unless I figure out
> > how to "merge/diff" the patch in, and that may break it.
> >
> > I to go with it, but not being a developer fear that not being able to
> > merge patches and even complie for windows...
>=20
> I plan to treat the "TO" (topology-supporting) branch as a beta series
> until the 2.1 beta series formally begins -- that means it will be
> updated, changes from the 2.0.x branch will get merged in, and when I make
> releases, there will always be a .tar.gz, .zip, and Windows installer
> .exe.
>=20

OK than I have to decide if I'll use beta in production.  Don't get me
wrong I respect the quality of your beta releases more than most
others.  I have OpenVPN RCs in production, but I don't know about
beta...

--=20
Leonard Isham, CISSP=20
Ostendo non ostento.

