From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <dd574ef9-5c0c-6725-327a-8b3d70b09891@...515...>
Message-ID: <d76e879b-be00-9754-09ac-28ca7c3eb8be@...515...>
Date: Wed, 4 Oct 2017 10:50:28 +0300
MIME-Version: 1.0
In-Reply-To: <dd574ef9-5c0c-6725-327a-8b3d70b09891@...515...>
Content-Type: multipart/mixed; boundary="------------21B79EAB7A781061DB96F38F"
Content-Language: en-US
Subject: [Openvpn-devel] Summary of the community meeting (Wed,
 27th Sep 2017)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------21B79EAB7A781061DB96F38F
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Resending this as Sourceforge downtime apparently ate the original.

---

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Wednesday 27th Sep 2017
Time: 19:00 CET (17:00 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2017-09-27>

The next meeting has not been scheduled yet.

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

chipitsine, mattock and ordex participated in this meeting.

--

Noted that the meeting invitation had a wrong date (26th) but correct
weekday (Wed). We discussed in the meeting the possibility of making the
sending of the invitations automatic (as they're all pretty much the
same with just the dates changing).

--

Talked about the OpenVPN 2.4.4 and 2.3.18 releases. Nobody has heard of
any problems with them, except that due to SF.net downtime the release
announcements were duplicated.

--

Talked about patchwork. Samuli has already done most of the
configuration, with mostly the web proxy and SSL setup missing. He hopes
to have patchwork running by EOB on Thursday (28th).

--

Discussed the possibility of having community involved more in server
maintenance. Noted that this is already the case for the buildslaves,
which are running on mattock's, cron2's and slypknot's own servers,
respectively. One way to make use of community sysadmins would be to
have a separate physical server running outside of the OpenVPN Tech
intranet (for security). This server could be split into multiple
virtual machines which could then be managed jointly by community and
OpenVPN Tech sysadmins to provide various community-facing services.

--

Talked about our release cycle, which was agreed to be quite slow. It
was estimated that patchwork should help quite a bit, as it will make
the daily patch management less messy.

It was also agreed that our policy on what goes into maintenance
releases (e.g. 2.4) is not clear-cut like "only bug fixes", but more
along the lines "this is small and non-intrusive enough to go in". An
alternative approach was suggested:

  2.x.y+1 should only fixes bugs from 2.x.y
  2.x+1.0 should introduce new features, no matter if 1 or 2

The heavy alpha/beta/rc/final release cycle was also seen as one thing
that holds us back from speeding up the release cycle. Skipping it and
going (more or less) directly to a .0 release was seen as an option (but
only if the new .0 release is not huge compared to the previous .0).

Lack of predictable release schedule was also seen as one of the
possible reasons why our releases take time - without a deadline things
like patch review tend to get low priority.

Another problem is that making a release is quite a bit of effort (3-4
hours) for mattock. There is tons of automation, but it's in bits and
pieces here and there. For example:

- sbuild_wrapper (for building Debian/Ubuntu packages)
- openvpn-windows-buildtest (Windows "buildslave" + snapshot creator)
- make-openvpn-release.sh
  - internal
  - produces various changelogs, tarballs, man-pages for Trac
  - signs and pushes release files to webservers

It was agreed that getting all of this running on a single server would
help quite a bit. Mattock is planning on eventually integrating most of
the above into a (Python) application that

- Gets change notifications from GitHub
- Takes the code (e.g. Git commit or tag)
- Produces "something" out of it
  - debs, rpms, tarballs and Windows installers, changelogs, man-pages

As a first step that application would just reuse the services provided
by the above tools, but later it would take over some of the
responsibilities from them[*]. The application would eventually allow us
to make "releases" on every commit, making the line between "snapshot"
and "release" quite vague.

--

Discussed the "travis-ci: make testing binary deterministic" openvpn3
pull request by ordex. Ordex explained what it does and mattock approved
and merged the PR during the meeting.

--

Next meeting is scheduled for next week at the same time.

---

Full chatlog has been attached to this email.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

[*] Things not really touched upon in the meeting:

- Notification provider(s)
  - send notifications, e.g.
    - send email reports of build success/failure
    - send release announcements
- Producers
  - these produce something tangible, e.g.
    - tarball, NSIS, MSI, .deb, .rpm, changelog, man-page...
- Publishing providers
  - Push what was produced to "some place", e.g.
    - tarballs to webservers
    - packages to apt/yum repo
    - Windows installers to a Chocolatey repository
    - man-page on Trac
    - changelog on Trac

Much of the application could be fairly general purpose instead of being
only usable for the OpenVPN project.


--------------21B79EAB7A781061DB96F38F
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2017-09-27.txt"
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2017-09-27.txt"
Content-Transfer-Encoding: quoted-printable

(19:56:53) L'argomento di #openvpn-meeting =C3=A8: Meeting 2017-09-27 19:=
00 CEST: Agenda at https://community.openvpn.net/openvpn/wiki/Topics-2017=
-09-27
(19:56:53) L'argomento per #openvpn-meeting =C3=A8 stato impostato da ord=
ex!~linuxaro@...2309.../batman/ordex a 07:22:46 su 26/09/2017
(19:58:36) mattock: almost meeting time if I got the time right in the in=
vitation :)
(20:00:32) ordex: 5 minutes ?
(20:00:57) mattock: sounds good to me
(20:05:52) mattock: so quiet here
(20:08:30) mattock: argh, wrong date in the invitation subject line
(20:08:40) mattock: correct info everywhere else afaics
(20:09:19) mattock: I guess it would make sense to automate sending of th=
e invitations if we really have a meeting every week
(20:09:51) chipitsine: hi
(20:10:05) mattock: hi
(20:10:18) mattock: we're waiting for people to join
(20:14:04) ordex: syzzer: cron2 ?
(20:16:49) mattock: perhaps we could tackle topics #1 and #3
(20:17:02) mattock: 1. OpenVPN 2.4.4 release aftermath (if any)=20
(20:17:21) mattock: I have not heard of any problems (except that SF.net =
has been down and there were duplicate release announcements due to that
(20:17:21) ordex: ok
(20:17:32) ordex: yeah I received 4 emails from you :D
(20:17:38) mattock: yeah, 2x2
(20:18:07) ordex: :P
(20:18:08) mattock: chipitsine: have you heard of any issues regarding 2.=
3.18 or 2.4.4?
(20:18:45) chipitsine: I watch jlund/streisand notices
(20:18:58) ordex: what is that?
(20:19:19) chipitsine: personal vpn gateway
(20:19:44) ordex: ah ok
(20:19:51) chipitsine: they usually notice checksum mismatch when they de=
cide to upgrade openvpn
(20:20:10) chipitsine: no issues yet
(20:20:12) mattock: ok
(20:20:25) ordex: nice
(20:20:31) mattock: this time there is zero chance for checksum/GPG signa=
ture mismatches
(20:20:41) mattock: only the correct files have ever been online :P
(20:20:59) chipitsine: ordex: https://github.com/jlund/streisand
(20:21:00) vpnHelper: Title: GitHub - jlund/streisand: Streisand sets up =
a new server running L2TP/IPsec, OpenConnect, OpenSSH, OpenVPN, Shadowsoc=
ks, sslh, Stunnel, a Tor bridge, and WireGuard. It also generates custom =
instructions for all of these services. At the end of the run you are giv=
en an HTML file with instructions that can be shared with friends, family=
 members, and fellow activists. (at github.com)
(20:21:07) ordex: chipitsine: yeah found it, thanks!
(20:21:21) ordex: mattock: never say never :P
(20:21:26) ordex: but it seems it went fine :D
(20:22:00) mattock: yep
(20:22:13) ordex: ok
(20:22:17) mattock: #3 patchwork pending (help needed?)=20
(20:22:21) ordex: so is there anything else that needs to be done for the=
 release?
(20:22:23) ordex: or are we good?
(20:22:25) ordex: everything is out?
(20:22:26) mattock: we're fully done
(20:22:27) ordex: the PR article?
(20:22:34) mattock: there was actually the odd problem with debian packag=
es
(20:23:04) ordex: yup
(20:23:10) mattock: in a nutshell our apt repo management software (freig=
ht) did not work nicely with GPG 2.x (used to sign the packages)
(20:23:22) mattock: I had a workaround for it which caused unintended sid=
e-effects
(20:23:40) mattock: I worked around the problem in another way and now we=
're golden
(20:24:02) ordex: awesome!
(20:24:03) ordex: :)
(20:24:04) mattock: I've been trying to get a fix upstream but it has bee=
n a bit challenging
(20:24:15) ordex: not responding?
(20:24:42) mattock: well I'm actually one of the founders of the project =
and the guys do respond, but getting a general-purpose fix seems tricky
(20:25:01) ordex: oh ok
(20:25:10) mattock: but it's on my JIRA "in progress" so it won't be forg=
otten about
(20:25:51) mattock: anyways: patchwork
(20:26:01) mattock: so I bit the bullet today and started setting it up
(20:26:40) ordex: cool
(20:26:56) ordex: do you need any help? or you feel you can get this done=
 in a reasonable time while juggling the rest? :D
(20:27:07) mattock: right now it's only missing a couple of things afaics=
:
(20:27:07) mattock: - it does not yet receive emails (e.g. from IMAP)
(20:27:07) mattock: - there's no webserver in front yet
(20:27:07) mattock: - certificates are not present (this is trivial to fi=
x though)
(20:27:22) mattock: I hope to have it running by end of tomorrow
(20:27:41) chipitsine: too late to help?
(20:27:45) ordex: oh that would be very nice
(20:27:52) ordex: then we have to let it process all the old emails
(20:28:07) ordex: does it need to be configured to understand the "applie=
d" emails ?
(20:28:14) ordex: or does it check with git ?
(20:28:28) mattock: ordex: I don't know the details yet
(20:28:34) ordex: oky
(20:29:01) chipitsine: "let it process all the old emails" - would be rea=
lly nice
(20:29:34) mattock: chipitsine: I can handle this one - but we should def=
initely have the capability to have "community-maintained" servers
(20:29:58) mattock: for things that don't need to be directly connected t=
o the OpenVPN Tech intranet
(20:30:09) ordex: yeah
(20:30:34) mattock: anyways, most of the time in setting up patchwork (or=
 any other service) is converting the configuration into Puppet code
(20:30:41) chipitsine: some dedicated hardware?
(20:31:08) mattock: it is of course quite a bit more effort up-front, but=
 it pays off the next time (e.g. if the thing break, is hacked, new serve=
r is built, etc.)
(20:31:16) mattock: plus the code is self-documenting
(20:31:33) mattock: chipitsine: possibly yes
(20:31:47) ordex: well also a vps somewhere should work
(20:31:55) mattock: one thing where we use community resources a lot is i=
n buildslaves
(20:32:02) ordex: actually, I believe it may make sense to have a communi=
ty server where we have all our things
(20:32:31) mattock: I have several buildslave VMs running at my own serve=
r, as does cron2 and slypknot
(20:32:44) ordex: mattock: all private hosts?
(20:32:59) mattock: yes, running on each person's own hardware
(20:33:06) ordex: do we really need "many" different hosts? or could all =
run on the same hardware ?
(20:33:07) mattock: bound together in the same VPN
(20:33:13) ordex: I see
(20:33:30) mattock: well we could have a single physical server which run=
s a dozen different operating systems
(20:33:37) mattock: assuming all the operating systems are virtualizable
(20:33:52) mattock: but I think they are
(20:33:58) ordex: ah right, because the problems are the various platform=
s
(20:34:02) ordex: ok
(20:34:04) mattock: linux, bsd, etc.
(20:34:12) mattock: nothing _really_ funky like AIX
(20:34:23) ordex: if that can be done, it may make sense to focus on one =
hw only and have all the buildslaved there. might make sense, no?
(20:34:24) ordex: lol
(20:34:30) ordex: that's cron2's stuff :P
(20:34:33) mattock: yes
(20:34:45) mattock: we definitely could move the buildslaves to a single =
host
(20:34:59) mattock: and have different people manage each of them
(20:35:08) mattock: from the community, just like now
(20:35:21) ordex: yup
(20:35:54) ordex: potentially we could also have a VM for patchwork on th=
e same host
(20:36:07) mattock: yes
(20:36:30) ordex: ok
(20:37:00) ordex: so now, we should find funds for that :)
(20:37:08) mattock: yeah
(20:37:22) mattock: also, I've tested setting up buildslaves on EC2 and i=
t became rather painful
(20:37:28) mattock: can't recall why because it was some years ago
(20:37:31) ordex: maybe openvpn inc could help here, assuming we stop usi=
ng some of their instances because we move them all on one hw
(20:37:33) ordex: ah ok
(20:37:33) mattock: but EC2 was not very good for it
(20:38:02) ordex: we could just rent a dedicated server somewhere and set=
 that up
(20:38:24) mattock: I will ask Andrew about that - he knows the pricing p=
retty well
(20:38:51) ordex: oky
(20:39:08) mattock: done
(20:39:08) ordex: but i think this is something that will require sometim=
es..even if we get the "OK" from them
(20:39:15) ordex: ok
(20:39:18) mattock: yep
(20:39:24) mattock: maybe we could touch topic #4 slightly
(20:39:28) ordex: btw, earlier I was asking about the "PR" ?
(20:39:30) ordex: for 2.4.4 ?
(20:39:52) mattock: ah yes
(20:40:02) ordex: do we have it ? or is it WIP ?
(20:40:13) mattock: David provided some final comments but I have not hea=
rd anything since
(20:40:20) mattock: so it is WIP
(20:40:51) ordex: oky
(20:41:07) ordex: so i guess David will follow up as soon as he has a con=
nection and a desk :p
(20:41:12) mattock: probably yes
(20:41:37) ordex: oky
(20:41:40) ordex: good
(20:41:41) ordex: #4
(20:41:43) mattock: #4 our release cycle
(20:41:53) mattock: a) smooth patch review=20
(20:41:59) mattock: patchwork should help with this
(20:42:04) ordex: yeah I hope so
(20:42:17) mattock: b) better distinction of what goes into master and wh=
at not
(20:42:30) ordex: and also, right now we have no "deadline" so some peopl=
e use to procrastinate reviews as it is a low priority task
(20:42:43) ordex: having a more fixed release cycle may help with that to=
o...
(20:42:52) ordex: (still for a))
(20:42:54) mattock: yep, I see what you mean
(20:43:11) ordex: oky
(20:43:29) mattock: generally when we discuss this topic it becomes a fig=
ht between dazo and cron2 :P
(20:43:43) ordex: about b): right now we push stuff into a maintenance re=
lease simply because "it is small and who knows when we'll release next"
(20:43:44) mattock: or rather, when we discuss c) reduce time between maj=
or releases=20
(20:43:59) ordex: while having a more stable cycle will help understandin=
g better how to plan features
(20:44:01) ordex: right
(20:44:06) ordex: :D
(20:44:16) ordex: why does it become  afight ?
(20:44:35) ordex: I never heard either argument .. so I should wait and s=
ee I guess :)
(20:44:43) mattock: I think it is, at root, about what people think const=
itutes a major release
(20:45:10) mattock: as in "it has a bunch of big features" or "it increme=
nts the major version number"
(20:45:35) mattock: I would prefer to forget about the word "major" and m=
ake smaller "major" releases more often
(20:45:55) ordex: I only reason in term of "features" and "bugfixes"
(20:46:08) ordex: 2.x.y+1 should only fixes bugs from 2.x.y
(20:46:18) ordex: 2.x+1.0 should introduce new features, no matter if 1 o=
r 2
(20:46:38) ordex: but should make a clear distinction between new behavio=
urs/API/bugs and only-bug-fixes
(20:46:39) ordex: imho
(20:46:54) mattock: semantic versioning?
(20:47:08) ordex: I don't know what that means
(20:47:22) ordex: but I associate the minor release with "maintenance rel=
ease"
(20:47:24) mattock: http://semver.org/
(20:47:50) mattock: although using semantic versioning would get us into =
trouble with openvpn3, lol :P
(20:47:54) ordex: along those lines, yes
(20:48:04) ordex: yeah we don't need to follow that to the letter
(20:48:05) mattock: we can never go beyond 2.x
(20:48:20) ordex: I would not consider the API breakage a need for a majo=
r change
(20:48:23) ordex: because we are not a library
(20:48:33) mattock: makes sense imho
(20:48:35) mattock: but yes, I think the line between what goes=20
(20:48:37) ordex: thus I'd just increase the x in 2.x
(20:48:46) mattock: into each release is a bit arbitrary
(20:48:57) ordex: yeah
(20:49:03) mattock: like "this seems small/non-invasive enough"
(20:49:07) ordex: the reason why I see this clear differenciation is only=
 one: stability
(20:49:25) ordex: when you have a 2.x, you want it to become stable, so t=
hat people can rely on it
(20:49:53) ordex: therefore any 2.x.y should be aimed to that
(20:49:55) mattock: and as you said, as we release rarely, we have to bac=
kport stuff to old release branches
(20:50:12) ordex: right, which becomes painful
(20:50:23) mattock: stuff which does not necessarily "belong" to those re=
lease branches
(20:50:53) ordex: right, with the justification that "we save time at som=
e point", but exposes us to a bigger risk. and honestly, these are all sy=
mptoms of the non-planning imho
(20:51:06) ordex: just dfferent sides of it
(20:51:27) mattock: but yes, there are differing opinions on this matter,=
 although we agreed many years ago to aim for a steady (12 month?) releas=
e cycle
(20:51:56) ordex: it's utterly huge, don't you think so ?
(20:52:26) chipitsine ha abbandonato la stanza (quit: Quit: chipitsine).
(20:52:34) ordex: well, it also depends how much effort we think we'll pu=
t into it
(20:52:37) mattock: if we need to go through the heavy alpha->beta->rc->f=
inal release cycle then 12 months is probably reasonable
(20:52:43) ordex: right
(20:52:50) ordex: but we don't have QA nor all of that :P
(20:53:19) mattock: one of the arguments against short release cycles was=
/is that the using the release machinery takes lots of effort
(20:53:22) mattock: which is true atm
(20:53:23) ordex: our alpha->beta->rc->final is basically shifted to our =
maintenance releases
(20:53:47) ordex: you mean "releasing" by itself is time consuming ?
(20:53:58) mattock: so, for example, 2.5.0 would be an "alpha"?
(20:54:08) mattock: yes, releases do take quite a bit of time
(20:54:21) mattock: we do have lots of automation, but it is not well-int=
egrated
(20:54:27) ordex: would it still be a problem if we were to do it one eve=
ry 3 months for example ?
(20:54:33) ordex: *once
(20:54:45) mattock: depends on the number of releases in that period
(20:54:57) mattock: one release takes me about 3 hours if all goes smooth=
ly
(20:55:16) ordex: re: 2.5.0: I would not call it alpha, but right now we =
can basically say that it is. because we have no QA so we release and the=
n we fix bugs as they come
(20:56:03) ordex: therefore if you zoom out we will still need a number o=
f months to get to the 2.5.y that is really stable. it was just a compari=
son with your alpha->beta->rc... statement
(20:56:24) mattock: I get your point, yes
(20:57:01) mattock: anyways, I've been playing with the idea of writing a=
 more robust application for automating "releases"
(20:57:12) ordex: that would be nice
(20:57:26) mattock: something which gets code changes (e.g. new Git commi=
t or a tag) and produces "things" out of it
(20:57:34) ordex: are all the script available?
(20:57:36) ordex: yeah exactly
(20:57:58) ordex: gets a tag and produces the various packages. the only =
input should hopefully be the password of the key signing the packages :P
(20:58:01) mattock: testing could be integrated into it also
(20:58:05) ordex: yup
(20:58:21) ordex: are all the scripts used during a release publicy avail=
able right now ?
(20:58:32) mattock: most of them are
(20:58:45) mattock: either under "OpenVPN" or "mattock" in GitHub
(20:59:01) mattock: sbuild_wrapper, for example
(20:59:04) ordex: we could also create a separate repo (also a private on=
e if you want at the beginning) where we can put all this studd
(20:59:05) ordex: stuff
(20:59:06) ordex: ah ok
(20:59:07) mattock: and openvpn-windows-buildtest
(20:59:12) ordex: but that's somehow generic, no?
(20:59:14) mattock: openvpn-build
(20:59:30) ordex: oh yeah
(20:59:32) mattock: well sbuild_wrapper is kind of generic, but not 100%
(20:59:41) ordex: I see
(20:59:44) mattock: a good start would be to have all of this running on =
the same server
(20:59:49) mattock: then integration would be easier
(20:59:55) ordex: absolutely
(21:00:00) mattock: I would probably make this a Python application
(21:00:06) ordex: are all the steps documented somewhere as a checklist?
(21:00:22) ordex: yeah python is an idea
(21:00:28) mattock: with different "providers" for different end results =
(deb, rpm, msi, exe, etc.)
(21:00:45) mattock: and for different publishing methods (e.g. scp to web=
server, put to apt repo)
(21:01:09) mattock: something that can be extended and holds in one piece=
 when the code grows (unlike shell scripts)
(21:01:30) mattock: at first what exists could be crudely integrated and =
then replaced over time
(21:01:49) ordex: yes
(21:01:52) ordex: I'd start small
(21:01:56) ordex: and put together what we have
(21:02:01) ordex: and then slowly improve it
(21:02:02) mattock: each of the tools does have it's own documentation
(21:02:38) mattock: I will probably create some diagrams to illustrate th=
e idea and the architecture
(21:03:02) ordex: sounds good!
(21:03:09) mattock: but in any case, eventually we could have a "release"=
 for each commit
(21:03:20) mattock: like we actually do right now for Windows installers
(21:03:22) ordex: however, in the attempt of saving time, I'd really try =
to get stuff together as they are now
(21:03:26) ordex: yeah
(21:03:29) mattock: yep, definitely
(21:03:43) ordex: once the thing is in place we could decide also to run =
nightly builds
(21:03:54) ordex: *to create
(21:04:07) ordex: only on nights when there were changes :P
(21:04:20) mattock: we could also make the application listen to notifica=
tions from GitHub
(21:04:41) ordex: yeah, how to pull the trigger can be customized based o=
n what we think works better
(21:04:42) mattock: that would be quite a bit simpler than polling actual=
ly (openvpn-windows-buildtest does polling in Bash and it's a bit nasty)
(21:04:51) ordex: yeah
(21:05:34) mattock: anyways, when I have a bit of free (work) time I will=
 start working on this
(21:05:46) mattock: because solving this more elegantly would help me a l=
ot on every release
(21:05:52) ordex: yeah
(21:05:59) ordex: less stress, less error prone and less time :)
(21:06:02) mattock: oh, and there is also a script "make-openvpn-release.=
sh" which is internal right now, but much of it could be public
(21:06:13) ordex: oh ok
(21:06:15) mattock: so there are tons of bits and pieces here and there, =
but nothing coherent
(21:06:24) mattock: it's on bitbucket somewhere
(21:06:24) ordex: yeah
(21:06:37) ordex: we really have to put everything in one place as first =
step
(21:06:47) ordex: openvpn-build is probably a good place to start with
(21:06:49) mattock: yep, and that can be done relatively easily
(21:07:19) mattock: the openvpn-build VM has openvpn-build (for releases)=
 plus openvpn-windows-buildtest (for snapshots), so making it bigger and =
moving sbuild_wrapper there would help
(21:07:42) mattock: anyways, $wife is calling me already
(21:07:46) mattock: perhaps we could call this a day?
(21:07:58) ordex: one last thing
(21:08:01) mattock: shoot
(21:08:09) ordex: would you merge my last pull request for travis? :D
(21:08:20) mattock: yes I can
(21:08:23) ordex: that fixes he behavious of the testing binary
(21:08:30) ordex: otherwise it would randomly fail
(21:08:30) mattock: care to send a link - I had a brief look at it earlie=
r
(21:08:38) ordex: and travis-ci will say FAIL too
(21:08:42) ordex: yup
(21:08:58) ordex: https://github.com/OpenVPN/openvpn3/pull/21
(21:08:59) vpnHelper: Title: travis-ci: make testing binary deterministic=
 by ordex =C2=B7 Pull Request #21 =C2=B7 OpenVPN/openvpn3 =C2=B7 GitHub (=
at github.com)
(21:13:23) mattock: I'm interested in understanding what -DNOERR does
(21:13:42) mattock: I could not immediately find the correct man-page - d=
o you have a link
(21:14:31) mattock: also noticed that my laptop did not have _any_ C comp=
iler - it's probably been too long since I compiled my own kernels, lol :=
P
(21:14:42) ordex: -D if just a way to create defines at runtime
(21:14:46) ordex: equal to #define
(21:14:54) ordex: so that is just doing #define NOERR
(21:15:16) ordex: but since we do it onthe command line, it has the benef=
it of being done *before* parsing any source file
(21:15:25) ordex: and proto.cpp has an #ifndef NOERR ....
(21:15:30) ordex: where it creates lossy links
(21:15:45) ordex: so it's an internal proto.cpp behaviour that we tweak w=
ith a define at compile time
(21:16:03) ordex: mattock: how can a laptop not have a C compiler :D it d=
oes not exist !
(21:16:23) mattock: ah, now I see
(21:16:39) mattock: it looked like a real compiler flag :P
(21:16:46) mattock: but yes, of course -D is for define
(21:16:55) ordex: :D
(21:18:42) mattock: merged
(21:18:52) mattock: ok, now I need to split, family getting restless
(21:18:54) mattock: :D
(21:18:57) ordex: cool, thanks! we should get another mail from coverity =
soon
(21:18:59) ordex: yesss
(21:19:00) ordex: enjoy!
(21:19:02) ordex: good night!
(21:19:05) mattock: thanks and good night!
(21:19:10) mattock: I will send the summary tomorrow
(21:19:22) ordex: sounds good, bye!


--------------21B79EAB7A781061DB96F38F--

