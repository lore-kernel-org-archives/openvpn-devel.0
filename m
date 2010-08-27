Date: Fri, 27 Aug 2010 09:20:23 -0500
From: "Karl O. Pinc" <kop@...1206...>
In-Reply-To: <4C777C6F.8000809@...1114...> (from
	openvpn.list@...1114... on Fri Aug 27 03:50:55 2010)
Message-Id: <1282918823.3789.0@...1207...>
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

On 08/27/2010 03:50:55 AM, David Sommerseth wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>=20
> On 09/04/09 19:44, Karl O. Pinc wrote:
> >=20
> > On 04/09/2009 07:58:46 AM, Karl O. Pinc wrote:
> >>
> >> On 04/09/2009 01:01:50 AM, Alon Bar-Lev wrote:
> >> > On Thu, Apr 9, 2009 at 6:03 AM, Karl O. Pinc <kop@...1206...>
> wrote:
> >> > > It occurs to me that if I want to do more than
> >> > > beg I should submit a patch, so one is attached.
>=20
> Sorry it has taken way too long time to get this one reviewed.  It's
> just been quite a lot to do, and this was not considered critical
> enough.
>=20
> > It occurs to me that it's no good having an unpackaged
> > Windows binary archive without instructions regarding
> > how to use it.
>=20
> Agreed!

So, is it worth doing any work at all on this?
I have not had the time to add to the weekly irc meeting
agenda and advocate live.  The arguments previously presented
in email cover the subject already.

>=20
> > Attached is a patch to INSTALL-win32.html that
> > documents how to make a custom Windows installer using
> > the archive produced by my previous patch.
> >=20
> > I hope OpenVPN will consider these patches for inclusion.
>=20
> Review follows below.
>=20
>=20
> - --- INSTALL-win32.html	2005-10-18 03:46:47.000000000 -0500
> +++ INSTALL-win32.html.patched	2009-04-09 12:38:59.000000000
> -0500
>     ^^^^^^^^^^^^^^^^^^
>=20
> This is not a file which is available directly in the source tree.=20=20
> It
> is in best case generated somehow.  How that is done, I have no idea
> (I'm not using Windows platform for development).  However, there is=20
> a
> INSTALL-win32.txt file - the patch should really be against that file
> -
> and without the HTML mark-ups.  Please do so against the git tree,
> preferably the feat_misc or master branch.

The file _was_ in the source tree, but is no longer.  I will
find the appropriate new file.

>=20
> [...snip...]
>=20
> +<p>Note that an MS Windows machine is <em>not</em> a requirement.</
> p>
>=20
> Why so? If I've understood you correctly, if having the needed=20
> windows
> binaries available, you just rebuild the NSIS installer.  This should
> be
> possible to do also in Linux or *BSD.

We are in agreement here.  Did you miss the word "not" in the
sentence or is there some other vagueness in the wording?

> [...snip...]
>=20
> +	<li>Nullsoft Install System<br />
> +	<a
> href=3D"http://www.nullsoft.com/free/nsis/">http://www.nullsoft.com/
> free/nsis/</a></li>
>=20
> This redirects to: http://nsis.sourceforge.net/Main_Page

Probably an a stale link.

>=20
> [...snip...]
>=20
> +         <li>Unpack the OpenVPN unpackaged windows binaries.  The
> +         result should be a directory, the unpacked OpenVPN binary
> +         directory.  This directory should have subdirectories.</li>
>=20
> Confusing sentences ... a lot of unpacked unpacked binaries unpacked.

How about "Unpack the OpenVPN tar file.  The result ..."?

> +
> +         <li>Using Internet Explorer (TM) navigate to the
> +         <code>nsi</code> subdirectory of the unpacked OpenVPN=20
> binary
> +         directory.
>=20
> Using "Internet Explorer"?!?  Why not "Using the file browser ..."?

I don't know.  I'll look into it if we go farther.
>=20
> +         <li>Right click on the icon labeled <code>openvpn</code>=20
> and
> +         select "Compile NSIS script".  Un*x users can use the
> +         <code>makensis openvpn.nsi</code> command.</li>
> +</ol>
>=20
> Okay, here you have the cross-platform stuff.  I'd probably prefer to
> state "Linux or *BSD users", as that is the supported platforms by
> NSIS.

Ok.


>=20
> [...snip...]
>=20
> +         <li> Add the 2 lines:<br /><code>File
> +         "myserver.ovpn"</code><br /><code>File "ca.crt"</code><br /
> >
> +         to the <code>nsi/openvpn.nsi</code> file at the bottom of
> +         the section titled: <code>Section "${P`'RODUCT_NAME}
> Service"
>                                                ^^^^^^^^^^^^^^^
> Is this really correct?

Dunno.  At one point I tested everything.  This would include
in the new installer those files, which are what's needed to=20
run a openvpn client that validates the server with a certificate.
The point of the entire exercise being to create a single installer
that contains everything needed to run openvpn.

>=20
> +         SecService</code></li>
> +</ol>
> +
> +<p>Note that putting your configuration and CA certificate files=20
> into
> +the <code>nsi</code> subdirectory is not the most organized=20
> approach.
> +It is simply the easiest way to get started with NSIS.</p>
>=20
> What about to explain properly how to do it more organised?  Most
> users
> won't care, and when they learn the sloppy way - they will never
> improve
> it if it works.

There are probably multiple good ways to do the job.  I can see
a quick mention of the options but past a certain point it's
all theory.  I look at it this way; most users' won't read
the instructions anyway.

>=20
> [...snip...]
>=20
>=20
> Thank you once again for you patch and patience.  If we can have=20
> these
> things straightened up, I'm able to pull it into the git tree.  As
> this
> patch do not touch any code, we can pretty sure get this on into the
> 2.2
> release.  We're about to send out a beta release pretty soon, but=20
> this
> patch have the possibility to get accepted into a later beta release.

Unfortunately you caught me at a bad time and I won't be able to work
on this for at least a couple of weeks and perhaps longer.
It's waited this long.  May as well let it wait and be done right
when it gets done.




Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                 -- Robert A. Heinlein


