Date: Wed, 08 Apr 2009 12:02:00 -0500
From: "Karl O. Pinc" <kop@...1206...>
References: <1239166995l.18482l.9l@...1207...>
	<F9B005F620B74BD29BB0A36AF509BCED@...576...> <1239203062l.18482l.11l@...1207...>
	<49DCC18D.6040509@...273...>
In-Reply-To: <49DCC18D.6040509@...273...> (from
	matt@...273... on Wed Apr  8 10:23:57 2009)
Message-Id: <1239210120l.18482l.13l@...1207...>
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
Content-Type: text/plain; DelSp=Yes; Format=Flowed; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Matt Wilks <matt@...273...>
Cc: openvpn-devel@lists.sourceforge.net


On 04/08/2009 10:23:57 AM, Matt Wilks wrote:
> Karl O. Pinc wrote:
> > On 04/08/2009 07:58:12 AM, dave wrote:
> >
> > Yeah.  On Debian it just installs and seems to work.  But there must
> > be more involved, somewhere, to have it go from source to nsis
> > installer.
>=20
> Is there a specific reason you are attempting to build the OpenVPN
> .exe
> (are you trying to make a custom executable)?  You could just use a
> compiled version (install in Windows, grab all the files), set up the
> proper directory hierarchy and use NSIS to create a custom installer
> package.  The NSIS stuff works under Linux.

Thanks for the response.

No, I don't want a custom executable.  I just want to make my
own Windows installer (on Linux).

I'm not certain that installing in Windows and grabbing all the files
will always work.  For example there's an i386 and amd64
tapinstall.exe.  Are they both always installed and then one run?
I can imagine similar issues surrounding what's installed and/or
run on various versions of MS Windows.  I don't want to have
to have all combinations of Windows and hardware available
on which to do an install just to get the binaries.  I don't know
the details of how the installer deals with the combination of
architectures and OS versions.  (I don't really care
beyond what I'll have learn to modify the existing
installer for my purposes.)  The point being I
don't want to rely on any particular installer implementation
or choice of packaging.

Equally important (for me) is that I don't want to rely
on having to have a (secured) Windows box -- on which to
do anything.  In my case access to Windows is an inconvenience,
sometimes more, sometimes less of one but always a bother.
In any case I have a lot more trust in the security of
the OpenVPN build team's Windows boxes than I have in the security
of the Windows boxes to which I have access.

---

On an unrelated note I notice that building the 2.1 rc15
nsis installer on Linux for Windows gives me 3 warnings:

3 warnings:
   install function "GetWindowsVersion" not referenced - zeroing code=20=20
(125-174) out

   label "fileass" not used
   label "tryaddtap" not used

I don't get the first when I build an installer on Windows.
(I do get the second 2 warnings.)
The first warning leaves me with an ungood feeling.
I will investigate.
If anyone would care to clue me in that'd be great.  Otherwise
should I post a patch to this list if I figure it out?

Regards,

Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                  -- Robert A. Heinlein

