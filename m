Date: Thu, 01 Apr 2010 10:19:01 -0500
From: "Karl O. Pinc" <kop@...1206...>
References: <4B8A614A.4020406@...1114...> <1267415326.30675.1@...1207...>
In-Reply-To: <1267415326.30675.1@...1207...> (from kop@...1206... on Sun Feb 28
	21:48:46 2010)
Message-Id: <1270135141.25169.1@...1207...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Unpackged Windows binaries? -- Problems
 building 2.1 rc15 on Windows XP
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: "Karl O. Pinc" <kop@...1206...>
Cc: openvpn-devel@lists.sourceforge.net

So, what is the status of this patch?  Would Openvpn
release "unpackaged" MS Windows binaries?  If so
you can apply the code patch and I'll rework the
documentation patch into where ever the documentation
currently exists.

On 02/28/2010 09:48:46 PM, Karl O. Pinc wrote:
> On 02/28/2010 06:27:54 AM, David Sommerseth wrote:
> > On 09/04/09 05:03, Karl O. Pinc wrote:
>=20
> <snip>
>=20
> > > The OpenVPN devs have a "built" source tree in which they run
> > > install-win32/buildinstaller.  My point being that
> > > if they would package it up
> > > and release it alongside the resultant installer
> > > none of these sorts of issues would ever come up.
> > >
> > > Attached is a patch that produces a un-nsis-installer
> > > windows binary release as part of the build process.
> > >
> > > Apply it with:
> > >
> > > cd openvpn
> > > patch -p1 < buildbinaryrelease.patch
> > >
> > > The result is a file named something like:
> > > openvpn-2.1_rc15-winbinaries.tar.gz
> > >
> > > I deliberately produce a tar.gz file
> > > rather than a zip file to keep
> > > Windows people from downloading it accidentally
> > > instead of the Windows installer exe.
> > >
> > > There is more work to be done.  The file needs to
> > > be signed and put on the website every time there's
> > > a release.  I don't see anything in svn to patch
> > > that would aid this process.
> >=20
> > Hi!
> >=20
> > I'm going through the mailing list, picking up patches which seems=20
> > not
> > to be included.  Is this patch still interesting to get included?=20
>=20
> I would like to see it included.=20=20
>=20
> The goal is to allow people to create
> custom installers for MS Windows without having to rebuild
> the source or cross compile.  The point of the patch
> is to support an "unpackaged" release of the MS Windows
> binaries.  In other words raw binaries that are not
> part of an installer, which can then be packaged
> using the nsis installer to produce a custom install.
>=20
> As noted above this means that the official OpenVPN project
> would have to actually release such binaries.  If the
> project does not want to do this there is no point in
> having the patch.
>=20
> So, this requires upstream approval.  In some ways this
> is no different from other patches, except that it requires
> ongoing work as new releases come out -- or if not that
> then a change to whatever automated process (unavailable to
> us, at least at the time the patch was written) that puts=20
> releases out to the public.
>=20
> > This
> > one applies cleanly to the master branch.
> >=20
> > I see that this patch is also followed by this one:
> >=20
> > <http://article.gmane.org/gmane.network.openvpn.devel/2581>
>=20
> Yes.  The second patch is to the documentation so that people
> know what to do with unpackaged MS Windows binaries.  Not
> much point in releasing the binaries unless there's documentation.
>=20
> >=20
> > This patch do not apply at all, as the standard checked out tree do
> > not
> > have INSTALL-win32.html, only INSTALL-win32.txt.  Is this correct?=20
> I
> > can't find this HTML file in the 2.1_rc15 nor 2.1_rc16, which was
> > current when this patch was sent to the mailing list.
>=20
> The OpenVPN site has restructured since this patch was written.
>=20
> I'd be happy to redo the documentation patch, but I don't see
> any point in doing so without some assurance that the effort
> will not be wasted.  How can I get some feedback on this?
>=20
> Regards,
>=20
> Karl <kop@...1206...>
> Free Software:  "You don't pay back, you pay forward."
>                  -- Robert A. Heinlein
>=20
>=20
> -------------------------------------------------------------------------=
-----
> Download Intel&#174; Parallel Studio Eval
> Try the new software tools for yourself. Speed compiling, find bugs
> proactively, and fine-tune applications for parallel performance.
> See why Intel Parallel Studio got high marks during beta.
> http://p.sf.net/sfu/intel-sw-dev
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20
>=20
>=20
>=20




Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                 -- Robert A. Heinlein


