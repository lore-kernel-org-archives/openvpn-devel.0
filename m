Message-ID: <4B20CFFD.5090900@...515...>
Date: Thu, 10 Dec 2009 12:39:57 +0200
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <4B1CD805.80508@...515...>	<20091209101748.GA6688@...30...>
	<4B1F81D7.9030000@...515...> <4B1F9202.9070804@...1114...>
In-Reply-To: <4B1F9202.9070804@...1114...>
Subject: Re: [Openvpn-devel] OpenVPN project organization [WAS: Introducing
 OpenVPN Community Manager]
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
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

David Sommerseth ha scritto:
> On 09/12/09 11:54, Samuli Sepp=E4nen wrote:
> >> On Mon, Dec 07, 2009 at 12:25:09PM +0200, Samuli Sepp=E4nen wrote:
> >>=20=20=20
> >>> Hello everybody,
> >>>
> >>> I'm the newly appointed community manager for OpenVPN Technologies. I
> >>> will be acting as a liaison between OpenVPN community and OpenVPN
> >>> Technologies. I will help us (the company) make our development more
> >>> community-oriented, e.g. by providing the tools and making development
> >>>=20=20=20=20=20
> >> [snip]
> >>
> >> Hi Samuli,
> >>
> >> Welcome! I hope the communication with the community will improve with
> >> your help. In this regard, I'd like to know if it's in your duties to
> >> deal with bug reports/feature requests, since there's a bunch [1] of
> >> them reported in the Debian Bug Tracking System.
> >>
> >> Please don't hesitate to contact me if you need my help at any time.
> >>
> >> Thanks,
> >>
> >> Alberto
> >>
> >> [1]
> http://bugs.debian.org/cgi-bin/pkgreport.cgi?include=3Dtags:upstream;dist=
=3Dunstable;package=3Dopenvpn
> >>
> >>=20=20=20
> > Hi Gonzales,
>
> > We're definitely committed to making OpenVPN as close to a true
> > community project as possible. This will require rethinking how OpenVPN
> > development is done. In theory it's easy: just delegate responsibility
> > to community members. The problem is how to keep the work organized so
> > that the new development process actually produces better (and faster)
> > results. This is something I've already discussed with some community
> > members. One option mentioned was the Linux kernel model. In our case,
> > James would be Linus who (mostly) reviews other people's patches and
> > applies them.
>
> I strongly encourages such a model.  This might be not needed
> information what I'm providing here now, but I'll add it for those who
> are don't know or just are interested in one approach of how such a
> community can work.  This is purely my own experiences with working with
> such communities.
>
> I believe James have received several patches in the past from people on
> the mailing list - or directly.  At least I hope he keeps an eye on the
> mailing list and might have an idea who might be potential candidates to
> help out in his "inner circle".  Anyhow, it is important that this
> circle includes people which he can trust 100%.  Each of these persons
> (maybe they will concentrate on different parts of the OpenVPN code, but
> this they need to arrange between themselves) will then pay attention to
> patches which hits their segment/interest field and they can validate
> these patches.  It don't need to be many persons, it can be one or it
> can be fifteen, the amount is not that important, especially not right
> now.  The important part is that there are someone who reviews and keeps
> an open dialogue with the community and also have a good connection with
> James.  They will either include patches into their own source trees, or
> kick them back to be reworked or cancelled completely.
>
> Patches which are accepted will then be sent to James for a final review
> and inclusion.  If James don't like it, it must be discussed on the
> mailing list so that everyone can see and understand why it was rejected
> and how to make it more acceptable for inclusion.  If James can take the
> time to bring this discussion on the mailing list directly himself in
> these cases, that would bring the needed transparency.  Further, it
> should hopefully not happen too often, as James' "inner circle" should
> already have made sure it is suitable for inclusion.
>
> These "inner circle" people do not need to be "community members".  I
> don't know how big the OpenVPN Technologies Inc. company is, but it can
> even be people from here.  But it is important that 1) James trust these
> persons ultimately and will be willing to grant them more privileges, 2)
> that these people are active and visible in the community.  Even patches
> these people write themselves should be posted to the openvpn-devel list
> (or other another more suitable one).  That way, more eyes can pay
> attention and raise awareness if something seems to be wrong or needs to
> be discussed.
>
> This part is, IMHO, the most important part to get implemented first.
> The rest will basically come as a result of this.
>
> > I think we'd also need to build teams for various
> > purposes, e.g. for QA, packaging, different GUI's... this would enable
> > easy participation in OpenVPN development, whether you're a coder or
> > not. This is something Ubuntu has done pretty well.
>
> Agreed, but this will need to come a litter bit later on.  IMHO, get the
> development cycle in shape then QA and packaging/release engineering
> must come immediately afterwords.  QA can most probably be done in
> cooperation with the bigger Linux distributors as well.  The Fedora
> community is working hard on a big testing framework called Beaker,
> which is aimed at automatic testing of software.  (I even think Beaker
> might support Windows testing in the future as well, but I have not
> checked it out)  Other distroes might have similar systems as well.  The
> important thing is to make use of what is already existing.
>
> Before a proper automated testing is in place, having a written and
> publicly available "How to QA test" documentation is needed.  What
> should be tested and how.  Define different testing phases (Tier-1,
> Tier-2, etc) and what these testing phases needs to include.  Getting
> involved in test testing part will require some development knowledge,
> but not in-depth details of OpenVPN.
>
> Another topic which is needed to be included is documentation.  This
> would be to organise the documentation and make sure all features are
> documented, review documentation to make sure it works as expected etc,
> etc.  This part do not necessarily require any coding skills at all.
>
> > Currently we're
> > lacking basic community services (e.g. forums, trackers, wiki,
> > [sub]project hosting), but we're working on that. However I think the
> > basic development model should be agreed upon before building any
> services.
>
> Forums and wikis exists, even though unofficial ones.  But all these
> services are also available via sourceforge.net as well.  Anyhow, I
> agree this is not so urgent.
>
> What I do see as much more urgent is actually a better distributed
> VCS/RCS.  I believe SVN is used now - but I don't recall where I found
> the URL for it (and I have lost now, I believe).  There's also a rather
> outdated CVS tree on sourceforge.net.  This needs to be cleaned up, and
> a publicly available source tree must be made available.
>
> I'm tracking OpenVPN releases by importing the source tar balls into my
> own git tree, to be sure I can update my OpenVPN patch quick and
> efficient.  But I'd like to do this based on a publicly available source
> tree, which is tagged with the releases packaged and made available.  I
> don't care too much what it is, but I hope it will not be anything worse
> than SVN (like CVS).  But if another more modern and proper DVCS is
> chosen, I'd applaud that!
>
> The model I've suggested above, will work very well with git.  But I
> know choosing/changing VCS is almost as brutal as a religion war, which
> I don't want to neither support nor trigger.  But I do believe a better
> DVCS (than CVS or SVN) is needed for this to work more flawlessly and
> efficient, no matter what DVCS is chosen.  I just hope it will be an
> Open Source based one.
>
> And if James don't want to change it, fine! Just make SVN URLs publicly
> and easily available.  Anyhow, when starting on the next version when
> 2.1 is finally released, it is a good time to at least consider the
> options.
>
>
>
> kind regards,
>
> David Sommerseth
The SVN repository URL's are here:

http://www.openvpn.net/index.php/open-source/documentation/miscellaneous/su=
bversion-repository.html

I checked the logs and last update in 2.1 branch was from 2009-11-20, so
it's probably 100% up-to-date. I agree with you for the most part.
Beaker sounds interesting, as I guess OpenVPN probably lends itself well
to automated testing. Unlike, say, applications with rich user
interfaces. Anyways real human QA/testing is nevertheless necessary. I'm
sure there are professional testers in the community who could lead the
testing team.

I'll talk to James about these issues a.s.a.p. - unless he takes parts
in the conversation, that is :).

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc




