Date: Fri, 27 Aug 2010 13:19:49 -0500
From: "Karl O. Pinc" <kop@...1206...>
References: <1282918823.3789.0@...1207...> <4C77E4E8.4080505@...1114...>
In-Reply-To: <4C77E4E8.4080505@...1114...> (from
	openvpn.list@...1114... on Fri Aug 27 11:16:40 2010)
Message-Id: <1282933189.20817.2@...1207...>
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
To: David Sommerseth <openvpn.list@...1114...>
Cc: Openvpn-devel@lists.sourceforge.net

On 08/27/2010 11:16:40 AM, David Sommerseth wrote:
> On 27/08/10 16:20, Karl O. Pinc wrote:
> > On 08/27/2010 03:50:55 AM, David Sommerseth wrote:
> >> -----BEGIN PGP SIGNED MESSAGE-----
> >> Hash: SHA1
> >>
> >> On 09/04/09 19:44, Karl O. Pinc wrote:
> >>>
> >>> On 04/09/2009 07:58:46 AM, Karl O. Pinc wrote:
> > So, is it worth doing any work at all on this?

>=20
> No problem!  I would say it makes sense to give some documentation=20
> how
> to do this.  And you've already done a great job here!

Ok.  Good.



> >> [...snip...]
> >>
> >> +         <li> Add the 2 lines:<br /><code>File
> >> +         "myserver.ovpn"</code><br /><code>File "ca.crt"</
> code><br
> /
> >>>
> >> +         to the <code>nsi/openvpn.nsi</code> file at the bottom=20
> of
> >> +         the section titled: <code>Section "${P`'RODUCT_NAME}
> >> Service"
> >>                                                ^^^^^^^^^^^^^^^
> >> Is this really correct?
> >
> > Dunno.  At one point I tested everything.  This would include
> > in the new installer those files, which are what's needed to
> > run a openvpn client that validates the server with a certificate.
> > The point of the entire exercise being to create a single installer
> > that contains everything needed to run openvpn.
>=20
> Understood.  It was just the syntax with ${P`'RODUCT_NAME} which
> looked
> very odd to me.  If it's correct, I won't object to that.

That's what you do in m4 to ensure text is not macro expanded.
(I guess I'm doing some m4 here...)



Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                 -- Robert A. Heinlein


