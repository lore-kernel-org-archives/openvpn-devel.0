Date: Tue, 27 Apr 2010 10:26:27 -0500
From: "Karl O. Pinc" <kop@...1206...>
In-Reply-To: <20100427105843.9402.qmail@...1287...> (from peter@...1287... on
	Tue Apr 27 05:58:43 2010)
Message-Id: <1272381987.25907.0@...1207...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Unpackaged Windows binaries (Was: Re:
 [Openvpn-users] [ANN] OS X packages - OpenVPN 2.1.1)
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
To: Peter Stuge <peter@...1287...>
Cc: openvpn-devel@lists.sourceforge.net

On 04/27/2010 05:58:43 AM, Peter Stuge wrote:
> Karl O. Pinc wrote:
> > IMO OpenVPN is encouraging bad practices by supplying packages for
> > distros that include OpenVPN.
>=20
> Ideally the package for that distro as made by OpenVPN is always
> equivalent to the one made by the distributor.
>=20
> What do I mean? I mean that I'm happy with .spec files and the likes,
> that make up the source code for a particular kind of binary package,
> being committed upstream.
>=20
> And if they are, then it's of course fairly easy for upstream to use
> them, and to make packages which are at the very least compatible
> with the distribution.

I agree.
It is useful for OpenVPN to distribute .spec files and
equivalents for use by disto packagers.

>=20
> And, I think that since it is downloaded from a site other than the
> distributor's, users who actually do grab packages "manually" will be
> able to tell the difference from a package delivered by the
> distributor.

The question is not whether users can tell the difference, it's
whether users know enough to know the advantages of getting
their packages from their distro.  I believe that most users
are unaware of these advantages because they have experience=20
only with OSs that force them to arrange for their own=20
systems integration.  IMO the widespread failure to integrate disparate
software and the consequent gradual degradation of so many systems,
often ending in a disk wipe and OS re-install, demonstrates
the extent of the problem.  While OpenVPN's users are clearly
the cream of the crop, hip, techo-savvy, and sporting
shiny white smiles, I don't believe they are immune
and the OpenVPN project should encourage them to make
good choices.  This would help toward a good long-term
OpenVPN experience.  The current policy that makes
pre-packaged downloads available without explanation
does nothing to encourage good sysadmin practice and
puts a bad choice one click away.

Giant problem?  No.  They'll always be plenty of ways
to make bad choices. I'd be ok with making distro specific packages=20
available so long as you also tell the end-user they are=20
probably better off without them.  :)

Regards,

Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                 -- Robert A. Heinlein


