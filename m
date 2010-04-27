Date: Mon, 26 Apr 2010 21:19:33 -0500
From: "Karl O. Pinc" <kop@...1206...>
In-Reply-To: <DA715293-35F5-48ED-A5CF-372C8B67393A@...1348...>
	(from toby@...1348... on Mon Apr 26 18:19:31 2010)
Message-Id: <1272334773.8910.2@...1207...>
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
To: Toby Thain <toby@...1348...>
Cc: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

On 04/26/2010 06:19:31 PM, Toby Thain wrote:
>=20
> On 27-Apr-10, at 1:58 AM, Karl O. Pinc wrote:
> >
> > The problem addressed is that there only binaries available
> > for MS Windows are pre-packaged in an installer executable.
> > This means that anyone who wants stock binaries but a
> > modified installer has to recompile from source.
>=20
> For the OS X package, I chose to simply make two packages - one the=20=20
> generic binaries, and one for whatever configuration and keys are=20=20
> needed for a particular deployment. Could you do the same on Windows?

Sure, but this greatly increases the complexity for the
end-user.  Just adding another installer at least doubles the
complexity.  A custom install can be one-click.  The stock
OpenVPN installer (last I looked) presented the user
with many choices and is far more complex than a 1-click
install.

Getting the users to do anything at all can be tricky
(especially at the outlying ends of the pay scale).
The less that can go wrong the better.

> > But this only makes sense if OpenVPN _will_ release
> > unpackaged MS Windows binaries.  It makes sense to me;
> > the project is already releasing unpackaged Linux
> > binaries and it now talking about doing the same
> > for OS/X binaries.
>=20
> I don't think unpackaged OS X binaries are very useful, which is why=20
> I
>=20=20
> created the pkg+dmg.=20

I agree, because the Apple development kit is shipped,
if not installed, on every Mac.  (Last I looked.)  And
because ./configure ; make is painless.  MS Windows on
the other hand requires additional software=20
to compile anything.  And the FOSS choices, which
are the the ones most universally available, are non-trivial
to install and use.=20=20

I'd bet cross compiling  Un*x-to-Mac is easier too, but=20
I have no experience to back that up.
Now that OpenVPN is accepting more patches cross compiling
Un*x-to-MSWindows will probably get easier but it will
never be easy.

Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                 -- Robert A. Heinlein


