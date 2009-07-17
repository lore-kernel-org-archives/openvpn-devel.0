Date: Thu, 16 Jul 2009 19:55:46 -0500
From: "Karl O. Pinc" <kop@...1206...>
References: <4A5EFE61.3020100@...41...>
	<20090716133751.GA8884@...33...>
	<4A5F9A9C.7000805@...41...>
In-Reply-To: <4A5F9A9C.7000805@...41...> (from jim@...41... on Thu Jul 16
	16:24:44 2009)
Message-Id: <1247792146l.16663l.0l@...1207...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] OpenVPN 2.1_rc19 released
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
To: James Yonan <jim@...41...>
Cc: Openvpn-devel@lists.sourceforge.net


On 07/16/2009 04:24:44 PM, James Yonan wrote:
> Matthias Andree wrote:
> > James Yonan schrieb:
> >
> >> 2009.07.16 -- Version 2.1_rc19
> > ...
> >
> >> * In configure.ac, use datadir instead of datarootdir for
> compatibility
> >>    with <autoconf-2.60.
> >
> > Dear Jim,
> >
> > This is backwards.  Please don't do that,

>=20
> We need to be able to build OpenVPN on older Linux distros, such as
> RHEL
> 4, that use pre-2.60 versions of autoconf.

I don't know about earlier, but autoconf 2.59 comes with

# m4_version_prereq(VERSION, [IF-OK], [IF-NOT =3D FAIL])
# ----------------------------------------------------
# Check this Autoconf version against VERSION.

AFICT this can be used to do things one way with older
versions and another with newer.

m4_version_preqreq(`2.60', datarootdir, datadir)

I can't say whether this is actually a better way
to do things.

Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                  -- Robert A. Heinlein

