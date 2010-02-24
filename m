Date: Wed, 24 Feb 2010 04:20:50 -0600
From: "Karl O. Pinc" <kop@...1206...>
In-Reply-To: <4B84E51D.6070401@...515...> (from samuli@...515... on Wed
	Feb 24 02:36:45 2010)
Message-Id: <1267006850.14776.0@...1207...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Feature removal policy [WAS: Re: [PATCH v2] Do
 not randomize resolving of IP addresses in getaddr()]
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Samuli =?iso-8859-1?q?Sepp=E4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On 02/24/2010 02:36:45 AM, Samuli Sepp=E4nen wrote:
>=20
> >> If someone who explicitly chooses a functionality
> >> needs to get a warning about the default they
> >> should get this warning at ./configure time --
> >> the time they make the choice.=20
> >>=20=20=20=20=20
> >
> > The only time I can think of that a warning should
> > be delivered to those who explicitly choose
> > functionality in the process of deprecation
> > is to, _after_ the default has changed,
> > deliver a ./configure time warning to those
> > who explicitly choose the default telling them
> > that they no longer have to be explicit because
> > they are choosing what is now the default.
> >
> > It hardly seems worth it.
> >
> >=20=20=20
> Runtime warnings about deprecated features are important for users=20
> who
> use packages rather than build from source.

Yes.  I've since had second thoughts about this.  It seems to me
that there should be ./configure options for the use of package
maintainers that allow the enable/disablement of such runtime
warnings.  Maintainers may decide to that some features are part
of their distribution, put a note in their changelog, and move forward.

>=20
> Could you guys take a look at the current FRP draft and let me know=20
> if
> it needs modifications:

I need to re-read it.  Particularly with an eye towards changes
that are only enabled at compile time v.s. changes to defaults
that the user requests at runtime in the OpenVPN config file.

...
> So it'd take  24 - 36 months to get rid of a feature, depending on
> when
> (in the release cycle) it's deprecated. There are ways to speed up=20
> the
> process. We could, for example, have two processes depending on
> feature
> type:
>=20
> 1) longer process for features we know people depend on, but which
> need
> to be removed nevertheless (for whatever reason)
> 2) shorter process for features somebody _might_ use - like the
> randomization feature discussed earlier

By putting control over runtime warning messages into ./configure
(along with the enablement of the feature iteslf)
you put control over deciding which features fall into category 1
and which in category 2 into the hands of the end-user.  This
becomes significant when you put such control into the hands
of a distribution's package maintainer who can set policy
for entire groups of users.  A distro maintainer can
enable the feature and turn off the warning and speed
up the process of depreciation for their users if they
think the change is trivial.

I would think that this would be the best way to make as
many people happy as possible.=20=20

And of course OpenVPN retains
control over the ./configure defaults which can be nice=20
and conservative.  Taking 24-36 months to change something can=20
be a good thing.


Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                 -- Robert A. Heinlein


