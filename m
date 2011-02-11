Message-ID: <4D550CD4.6050603@...515...>
Date: Fri, 11 Feb 2011 12:17:56 +0200
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080803010706080409010800"
Subject: [Openvpn-devel] Summary of the IRC meeting (10th Feb 2011)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------080803010706080409010800
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the previous community meeting.

---

COMMUNITY MEETING

Place: #openvpn-devel on irc.freenode.net
Date: Thursday, 10th Feb 2011
Time: 18:00 UTC

Planned meeting topics for this meeting were on this page:

<https://community.openvpn.net/openvpn/wiki/Topics-2011-02-10>

Next meeting will be announced in advance, but will be on the same
weekday and at the same time. Your local meeting time is easy to check
from services such as

<http://www.timeanddate.com/world clock>

or with

$ date -u


SUMMARY

cron2, dazo, ecrist, jamesyonan, krzee, mattock, psha were present
in this meeting.

--

Discussed the 2.2-rc release. The only thing that held it back was lack
of Windows installer. Now a fully functional installer is available:

<http://build.openvpn.net/downloads/releases/openvpn-2.2-rc-install-preview=
-5.exe>

Although 2.2-rc could be released right now, agreed that mattock's
buildsystem patches should be merged with beta2.2 branch first. Mattock
promised to start sending them out on Friday (Feb 11th).

Decided to postpone fixing the only known (un)installer bug ("Start menu
entries not removed on Vista/7") until final 2.2 release to avoid
further delay. The issue is detailed here:

<http://nsis.sourceforge.net/Shortcuts_removal_fails_on_Windows_Vista>

This bug exists in all previous installers, and is easy to work around
by removing the start menu entries manually.

--

Discussed documentation migration from openvpn.net to the Trac Wiki.
Francis had asked for "Access Server" and "Hosted Service" buttons in
the Trac button row:

<https://community.openvpn.net/openvpn/wiki>

After lengthy discussion ended up in the following layout:

| Commercial Products | Docs | Wiki | Forums | Source | Bugs | Report
Bug | Download |

The switch from "Ticket" to "Bug" tries ensure that people post only
real bug reports to Trac, instead of support or feature requests. The
latter are more suited for the forums, IRC or mailing lists.

Note that the removal of buttons does not affect Trac functionality. So,
"Timeline" and "Roadmap" are still available (/timeline, /roadmap)

--

Discussed "Sctp implementation in openvpn" issue briefly:

<https://forums.openvpn.net/topic7615.html>

Mattock promised to ask the author to contact OpenVPN developers.

--

Discussed the "Windows auto-connect when starting gui" issue briefly:

<https://forums.openvpn.net/topic7623.html>

It's best to ask about this from d12fk on IRC. He's the maintainer for
the new OpenVPN-GUI:

<https://sourceforge.net/projects/openvpn-gui>

---

Full chatlog as an attachment

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


--------------080803010706080409010800
Content-Type: text/plain; charset="utf-8";
 name=openvpn_irc_meeting_chatlog_2011-02-10.txt
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="openvpn_irc_meeting_chatlog_2011-02-10.txt"

(20:00:48) ***psha entering prophet mode
(20:00:49) mattock: tadaa...
(20:01:16) psha: you'll either burn your dinner or break ipad!
(20:01:26) ***psha leaving prophet mode
(20:01:44) psha: computers and kitched are mutual exclusive
(20:01:48) psha: oops, meeting
(20:02:40) cron2: emptying dishwasher...
(20:02:44) mattock: dazo: why not just postpone the buildsystem patches unt=
il 2.2-final?
(20:03:36) mattock: it'll take at least a couple of days to clean them up +=
 time required to get them ACKd
(20:04:03) cron2: rc should be identical to final except for bugfixes
(20:04:30) ***ecrist agrees with cron2=20
(20:05:07) mattock: I think for code that's a good practice... but for the =
build system? Windows installer won't contain any code at all, and *NIX use=
rs won't use the new buildsystem
(20:05:13) jamesyonan [~jamesyona@...1320...] =EF=BF=BD=EF=BF=BD entrato ne=
l canale.
(20:05:13) modalit=EF=BF=BD=EF=BF=BD (+o jamesyonan) da ChanServ
(20:05:52) dazo: mattock: I'm tempted to agree with you ... but we do chang=
e the code repository, including the beta2.2 branch due to where we have ou=
r build environment code
(20:06:12) mattock: yeah, that's true
(20:06:17) dazo: and so a tag must include your build changes
(20:07:06) dazo: This is one of the core reasons, I would like to get windo=
ws building and wintap driver out of the the openvpn tree, to a separate tr=
ee
(20:07:28) mattock: yep, that would help
(20:07:43) mattock: will beta2.2 branch we dumped after 2.2-rc release?
(20:07:52) cron2: but it will bring in lots ofnew complications
(20:08:06) cron2: lk
(20:08:10) cron2: argh
(20:08:12) dazo: cron2: not necessarily so much
(20:08:38) ***dazo admits he might be naively optimistic, but he has big ho=
pe in that git submodule will solve that
(20:09:00) dazo: but I do know that one challenge is the shared tun.[ch] co=
de
(20:09:20) mattock: I guess the meeting has now begun :)
(20:09:41) mattock: topics here: https://community.openvpn.net/openvpn/wiki=
/Topics-2011-02-10
(20:09:42) ecrist: to a degree, it's been going for ~4 hours
(20:09:43) vpnHelper: Title: Topics-2011-02-10 =EF=BF=BD=EF=BF=BD=EF=BF=BD =
OpenVPN Community (at community.openvpn.net)
(20:09:56) dazo: heh
(20:10:05) dazo: ecrist: just unofficially ;-)
(20:10:06) mattock: ecrist: the meeting never ends
(20:10:16) ecrist: s/meeting/party
(20:10:37) mattock: jamesyonan: we're thinking whether my buildsystem patch=
es should be merged to beta2.2 branch before 2.2-rc release
(20:10:58) mattock: I should be able to push the patches to the -devel mail=
inglist tomorrow evening, if necessary
(20:11:07) jamesyonan: sounds good
(20:11:28) mattock: however, I fear they will require changes, which will p=
ush back 2.2-rc release even further
(20:12:18) ecrist: need to pay the piper at some point...
(20:12:20) mattock: and the discussion on the ml probably takes a while, no=
 matter what
(20:12:26) ecrist: better, imho, to get it out of the way
(20:14:02) dazo: mattock: I'll be as quick as possible getting those patche=
s reviewed as best as I can ... if d12fk and hopefully Hartimer, or others =
here in IRC can have take a look, that would indeed improve the review speed
(20:14:25) mattock: ok, that would be great!
(20:14:28) dazo: however, this is the building environment, they don't need=
 to be reviewed as "careful" as the openvpn code
(20:15:09) mattock: the build system will need a few modifications to remov=
e the last manual steps
(20:15:19) mattock: even after my 5-10 patches
(20:15:41) mattock: so, no release until buildsystem patches are merged?
(20:15:54) psha: do you expect that most of other windows users will use it?
(20:16:01) psha: or do they still need old buildsystem?
(20:16:23) psha: or windows users just download and install binary installe=
r?
(20:16:33) mattock: psha: personally, I don't think anybody will use it unt=
il the few remaining issues are fixed and the entire process is fully docum=
ented
(20:16:37) dazo: the majority of windows users are binary users
(20:16:48) mattock: for a good reason :)
(20:16:54) dazo: :)
(20:17:11) psha: they is it important to merge it in main codebase?
(20:17:18) dazo: developers will most likely use the new python stuff on wi=
ndows ... and the autotools variant when cross compiling from other platfor=
ms
(20:17:21) psha: dazo suggestion about external tool is right to me
(20:17:43) mattock: psha: you mean the submodule approach?
(20:18:12) psha: submodule is just tech detail :) ideologicaly it's externa=
l tool as i undestand
(20:18:55) dazo: mattock and psha is talking about the same thing, in my ey=
es :)
(20:19:46) psha: so why not to have it as external and not push -rc in the =
future?
(20:20:07) mattock: dazo: what side-effects would that have?
(20:20:17) mattock: or is this more a philosophical issue?
(20:20:17) cron2: well, make it external, then - but make very good documen=
tation how to get it etc.
(20:20:38) dazo: yeah, we need to rewrite some docs to match the new world =
order, so to say
(20:20:46) psha: main question is who is target audience? one build system =
or majority of windows users...
(20:21:28) dazo: but basically ... it should be enough to clone the git win=
dows-build tree, and then do git submodule init ; git submodule update ... =
and then you should get the openvpn source code in a separate directory whi=
ch the build tool would use
(20:22:03) dazo: so mattock, we do need to look closer at how the build too=
l will like that we move the root dir of the openvpn source code
(20:22:26) mattock: dazo: it should work fine with a few modifications
(20:22:33) psha: it's currently in main tree?
(20:22:40) mattock: it already changes directories
(20:22:47) dazo: perfect!
(20:23:01) mattock: and all dependencies are stored in $OPENVPN_BUILD_HOME/=
..
(20:23:14) dazo: I would say we should get the final 2.2 release out the do=
or, and then we begin messing with separating out the python build stuff
(20:23:15) mattock: e.g. lzo, openssl etc
(20:23:39) mattock: the small gap between 2.2-rc and 2.2 would give me time=
 to get the patches together
(20:23:50) mattock: speaking of the gap... how long would it be?
(20:24:38) mattock: there are no showstopper anymore
(20:24:39) dazo: mattock: I'm talking about full separation first in 2.3 ..=
.. 2.2 is settling down, I don't want to change it too much, even though it=
s just the build tool, before we carve 2.2 into a stone
(20:24:49) mattock: ok
(20:25:13) dazo: I would say we can let 2.2-RC run for 2-3 weeks ... depend=
ing on the download numbers
(20:25:39) dazo: and if we don't have enough download numbers, we could do =
a weekly reminder on the mailing list ... that we would like to have it wel=
l tested asap
(20:25:43) mattock: would my buildsystem stuff go to beta2.2? or should I r=
ebase them to some other branch?
(20:25:49) ecrist: mattock: it may be beneficial if you could make download=
 stats available to devs/community somewhere
(20:25:57) mattock: ecrist: I agree
(20:26:04) dazo: mattock: it will go into beta2.2 ... and that will become =
a new master branch
(20:26:08) mattock: I'll ask andrew about that
(20:26:16) mattock: dazo: ok, good
(20:26:37) dazo: when we're live ... I will also create a released branch, =
where we will merge in stuff from master in the future=20
(20:26:59) dazo: and the master branch will become what bugfix2.1 and feat_=
misc in reality is today
(20:27:33) krzee: +1
(20:27:36) mattock: so, signing the installer, then?
(20:27:52) mattock: and the release packages?
(20:28:16) dazo: when git tree is tagged, with 2.2-RC, new tarballs created=
, windows package rebuilt ... then, signing and release
(20:28:47) mattock: why rebuild the windows installer?
(20:29:11) dazo: because we have new tarballs ... and to be sure they reall=
y do build ... that all commits needed are in the git tree
(20:29:33) dazo: When 2.2-RC is released .... then we wait for reports, con=
sider what we need to do in the beta2.2 branch ... tag as v2.2.0 ... new ta=
rballs, rebuild, sign and release
(20:29:50) ecrist: do we have release notes for 2.2 yet?
(20:29:57) dazo: it's in the works
(20:29:59) ecrist: ok
(20:30:19) mattock: we should mention the --enable-password-save, but link =
to the latest ml discussion about that
(20:30:25) mattock: or the same discussion will happen again
(20:30:25) dazo: well, I meant ChangeLog ... but release notes, we should h=
ave that as well, on second thought
(20:30:34) dazo: yeah
(20:30:58) dazo: and we need to make aware of that 2.2-RC have the shortcut=
 issue in start menu ... that needs to be fixed in 2.2 final
(20:31:30) mattock: dazo: re: rebuilding installer... the code it contains =
is HEAD from beta2.2 branch. Does the tagging add anything to it?
(20:31:56) dazo: your HEAD commit ID may not be the same as mine when I com=
mit it to the official tree
(20:32:19) dazo: in fact, it will not be the same ... so the commit tree wh=
ich is signed with the tagging will not be the same
(20:34:03) mattock: the windows installer won't contain any traces of git a=
nd should be exactly the same even after git tagging
(20:34:21) mattock: so, if I'm not missing something, it (=3Dinstaller) cou=
ld be signed right now (if we want)
(20:35:23) dazo: then how can I be sure you have not forgotten to send me o=
ne important patch, which we won't notice until someone tries to build it f=
rom the git tree after the release?
(20:36:38) mattock: ok, I was under the impression that we were not going t=
o include the buildsystem patches in 2.2-rc
(20:37:09) dazo: Oh, I'm sorry if I was unclear there ... I want those patc=
hes into the tree before we release 2.2-RC
(20:37:22) mattock: ok, now this starts to make sense :)
(20:37:29) dazo: then we spin new tarballs, tag the tree, rebuild, sign and=
 release
(20:37:44) mattock: sounds like a plan
(20:37:55) dazo: goodie! :)
(20:38:18) mattock: jamesyonan: could you also review the buildsystem patch=
es? I'd hate to have them break something in AS client build
(20:39:01) mattock: I'll need to make some further modifications to more ea=
sily use prebuilt TAP drivers
(20:39:08) mattock: currently it's a bit clunky
(20:39:16) mattock: =3Dpartially manual
(20:41:00) cron2: it would indeed be nice to say "USE_PREBUILT=3D1" and hav=
e the installer auto-download all that's missing
(20:41:21) dazo: +1
(20:41:40) dazo: but lets keep this feature on the side line until 2.2-RC i=
s out :)
(20:41:45) mattock: cron2: +1 for autodownloading
(20:41:49) mattock: yep
(20:42:23) mattock: so, I'll cleanup my git tree tomorrow, setup git email =
stuff and send the patches
(20:42:37) mattock: and ask everybody kindly to accept my stuff, even if it=
's crappy ;)
(20:43:18) dazo: heh :)
(20:43:22) dazo: sounds like a plan :)
(20:43:24) mattock: though it should not be too bad
(20:43:32) mattock: that's 2.2-rc stuff, then
(20:43:38) dazo: we'll just make you the maintainer of the new windows-buil=
d git tree when we separate it out ;-)
(20:43:54) mattock: oh... forced labour never ends :P
(20:44:15) mattock: ...if I had known what I know now...
(20:44:20) cron2: regarding forced labour... does buildbot run t_client.sh =
nowadays?
(20:44:44) dazo: heh
(20:44:47) mattock: cron2: mmm... no... I intended to fix that, but got dis=
tracted
(20:45:01) dazo: that's for the final 2.2 release :)
(20:45:02) mattock: _but_ I promised to set that up after 2.2-rc release :)
(20:45:24) mattock: also, none of the buildslaves up now, Win7 is a memory =
hog
(20:45:29) mattock: and 2GB is not that much
(20:45:33) mattock: (on my server)
(20:46:11) mattock: I think we should discuss the openvpn.net -> Trac docum=
ent migration for a while
(20:46:14) mattock: what do you think?
(20:46:50) mattock: so, it's ok for Francis and others
(20:47:53) ***dazo is all in favour of doing that
(20:47:59) mattock: but Francis asked if I could add "Hosted service" and "=
Access server" buttons to the Trac button row (next to "Wiki", "Downloads" =
etc)
(20:48:07) mattock: I think that's a fair deal
(20:48:42) ***cron2 trades against IPv6 on www.openvpn.net *duck*
(20:48:53) mattock: he was worried about traffic getting diverted from open=
vpn.net to Trac without a clear way to get "exposed" on the commercial prod=
ucts
(20:48:55) dazo: well, at least a proper and clear backlink to the commerci=
al side of OpenVPN
(20:49:12) mattock: I tend to agree with him
(20:49:22) cron2: I'm fine with that - we now have a nice link from commerc=
ial->community, so it's only fair to have a link back
(20:49:32) mattock: excellent!
(20:49:35) cron2: of course community is more advanced regarding IPv6, no s=
urprise here :-)
(20:49:47) mattock: this brings another issue: there are too many buttons i=
n the Trac button row already :)
(20:49:48) dazo: we probably should avoid adding separate "hosted openvpn s=
ervices" and "access server" as separate links ... but something which indi=
cates the commercial offerings are really appropriate in my eyes
(20:49:50) krzee: +1
(20:50:07) psha: why not to export 'static' docs to commercial site regular=
y (daily, weekly) from Trac?
(20:50:13) psha: so official part is still openvpn.net?
(20:50:20) mattock: psha: that's correct
(20:50:35) mattock: and yes, migration would work, if it can be done automa=
tically
(20:50:57) psha: i've just took a brief look at trac and it seem be capable=
 of RST markup
(20:51:13) psha: which has extermly good support in part of export formats
(20:51:16) mattock: hmm, never heard of that
(20:51:23) psha: so take RST source from trac, compile it to HTML and place=
 on openvpn.net
(20:51:36) dazo: well, on the official pages, only released versions should=
 be reflected ... and by separating clearer on what's community edition and=
 what's commercial version ... we might make support easier on ML and #open=
vpn
(20:51:37) psha: http://trac.edgewall.org/wiki/WikiRestructuredText
(20:51:38) vpnHelper: Title: WikiRestructuredText =EF=BF=BD=EF=BF=BD=EF=BF=
=BD The Trac Project (at trac.edgewall.org)
(20:51:50) psha: dazo: good point
(20:51:57) dazo: it's enough of people who download the AS client and belie=
ve they're using the community edition
(20:52:40) mattock: dazo: even now?
(20:52:43) psha: i'm always overlook managment questions :(
(20:53:13) mattock: I understood people got confused when the "Client softw=
are" link was on openvpn.net... but now it's harder to get confused :)
(20:53:16) dazo: mattock: It has improved ... but I've not paid that much a=
ttention to #openvpn lately ... krzee and ecrist may have a better idea
(20:53:22) mattock: mkay
(20:53:30) ecrist: what did I do?
(20:53:38) mattock: ecrist: nothing (this time) :P
(20:54:17) mattock: so, a single button for AS + hosted service would be be=
tter?
(20:54:30) ecrist: yes
(20:54:31) s7r [~s7r@...1450...] =EF=BF=BD=EF=BF=BD entrato nel canale.
(20:54:34) ecrist: I thinkn so
(20:54:36) mattock: "Products"?
(20:54:49) dazo: Can even be "Commercial version"
(20:54:54) psha: dazo: +1
(20:54:57) ecrist: Commercial Products
(20:55:05) dazo: yeah, that's what I meant :)
(20:55:07) mattock: ecrist: +1
(20:55:09) psha: ecrist: +2
(20:55:10) psha: :)
(20:55:12) ecrist: but that's what I said.
(20:55:14) ecrist: :P
(20:55:21) s7r: <connect></connect> tags are available only when using AS ?=
 don't work with community project?
(20:55:30) krzee: theres nothing on the front page that would make me think=
 there is 2 options, a free version where i need to be a tech, and a paid v=
ersion where i dont
(20:55:37) dazo: s7r: that's for #openvpn
(20:55:44) dazo: (and we're having a meeting here now)
(20:55:50) mattock: krzee: true
(20:56:10) mattock: mind if I truncate the "Documentation" button "Docs"?
(20:56:13) krzee: mattock, honestly i think youd get more sales if that was=
 clear on the front page
(20:56:28) mattock: krzee: oh, you mean openvpn.net?
(20:56:34) krzee: yes
(20:56:41) krzee: mattock, people end up saying things like "I'll paypal yo=
u X if you set this up for me"
(20:56:55) psha: mattock: better shrink 'Browse Source' to 'Source'
(20:57:03) mattock: psha: good idea
(20:57:14) mattock: or "Code"?
(20:57:22) ecrist: Code works
(20:57:30) ecrist: Docs is OK, too
(20:57:44) psha: sure
(20:57:46) mattock: it's just that the Trac button row will start looking s=
illy if it wraps on two lines
(20:57:49) dazo: mattock: Docs sounds find to me .... I would probably say =
"Source", "Code" is more ambiguous
(20:58:22) mattock: "Docs" + "Source"
(20:58:30) mattock: and "Commercial Products"
(20:58:31) dazo: mattock: can we take out "Timeline", I don't beleive that'=
s used by many at all
(20:58:48) mattock: dazo: fine with me, it's not that useful
(20:58:48) dazo: $$$=EF=BF=BD=EF=BF=BDProducts?
(20:58:53) mattock: l33t
(20:59:01) ecrist: it's where RSS feed is found...
(20:59:02) dazo: :)
(20:59:19) psha: mattock: Search may be removed=20
(20:59:21) mattock: note that removing stuff from button row does not disab=
le anything, except the link
(20:59:23) dazo: yeah, but the RSS don't use that link on the toolbar, I be=
live ;-)
(20:59:24) psha: there is search button in header
(20:59:38) mattock: psha: oh yes, that's true
(20:59:40) dazo: View Tickets -> Tickets
(20:59:55) psha: dazo: lot of one letter buttons ;)
(21:00:02) dazo: Downloads -> Get IT!
(21:00:02) psha: D, W, F, ...
(21:00:08) dazo: heh
(21:00:22) psha: Get IT For Free Now!!11
(21:00:34) psha: Download is really better
(21:00:53) ecrist: FrEe VeRsIoN1!!!1
(21:01:00) ecrist: add some camel case for fun
(21:01:08) psha: mattock: Timeline is very useful feature of trac
(21:01:32) mattock: I'll try to visualize the new button row
(21:01:44) ecrist: mattock: also, some CSS is screwed up, at least for me, =
with the buttons
(21:01:58) dazo: psha: but we don't use that feature actively, nor do we pr=
omote it ... trac got it's own history ... and git is redirected to sf.net
(21:02:01) psha: but really you'd better try several variants and descide w=
hats better when you see them
(21:02:16) dazo: :)
(21:02:42) psha: dazo: that's trac own history :) but gathered in one place
(21:03:10) mattock: | Commercial Products | Docs | Wiki | Forums | Timeline=
 | Roadmap | Source | View Tickets | New Ticket | Download |
(21:03:28) mattock: maybe swapping those around a little
(21:03:56) ecrist: do we use roadmap?
(21:03:57) ***dazo don't see 'Roadmap' on todays line
(21:04:36) psha: mattock: View Tickets -> Tickets?
(21:04:41) psha: as alreadyy suggested by dazo
(21:04:59) mattock: oh, I thought about that too, but missed dazo's suggest=
ion
(21:05:03) mattock: why not
(21:05:16) dazo: Or "Bugs"?
(21:05:21) mattock: | Commercial Products | Docs | Wiki | Forums | Timeline=
 | Roadmap | Source | Tickets | New Ticket | Download |
(21:05:25) mattock: is it just bugs?
(21:05:28) mattock: feature requests?
(21:05:46) psha: dazo: yea, and 'New Bug' button ;)
(21:05:55) cron2: we only have old bugs
(21:05:55) psha: or 'Add Bug'
(21:06:14) psha: but really they are not bugs
(21:06:23) dazo: no, not necessarily only bugs ... but it's shorter and sta=
tes clearer what we really wants there
(21:06:35) psha: dazo: you really want bugs there?! :)
(21:06:41) mattock: dazo: good point...
(21:06:47) dazo: rather in a bug tracker than in the code ;-)
(21:07:08) mattock: what if somebody wants to file a feature request?
(21:07:16) mattock: is it mailing lists or forums then?
(21:07:27) mattock: "Bugs" would clearly state what we want
(21:07:31) mattock: "Ticket" does not
(21:07:50) dazo: yeah, I would say so ... and we can create a "bug ticket" =
on features we decide to implement
(21:07:52) dazo: to track them
(21:08:35) mattock: is it "New bug", "Old bug" or "Add bug"?
(21:08:48) psha: Issues as in googlecode?
(21:08:54) ***dazo votes for "New bug"
(21:09:27) mattock: psha: issue is not as clear as bug... it can be interpr=
eted as a support request I think
(21:09:29) dazo: "Add bug" sounds interesting, and more like a FAQ itme ...=
. "How to add a bug to OpenVPN?  Write crappy code!"
(21:10:05) mattock: "New Bug" sounds a bit funny, but I'll give it a +0,5
(21:10:22) psha: mattock: i'm not native speaker so i don't see such differ=
encies...
(21:10:40) mattock: "Report bug"?
(21:10:56) psha: dazo: that's was a joke :) New Bug sounds less crappy
(21:11:06) psha: however best one is Report Bug
(21:11:11) psha: but it's too long...
(21:11:23) mattock: well, I don't think so... the button row would be this:
(21:11:29) mattock: | Commercial Products | Docs | Wiki | Forums | Timeline=
 | Roadmap | Source | Bugs | Report Bug | Download |
(21:11:38) mattock: I think that would fit
(21:11:49) mattock: and if timeline can be removed...
(21:12:01) dazo: Timeline and Roadmap can go out, IMO
(21:12:14) dazo: we can rather add them as separate links in a wiki page la=
ter on
(21:12:17) mattock: we can always put links to the Wiki pages
(21:12:23) mattock: :)
(21:12:35) psha: dazo: +0.5 mattock: +0.5 (i'm fair!)
(21:12:56) mattock: | Commercial Products | Docs | Wiki | Forums | Source |=
 Bugs | Report Bug | Download |
(21:13:04) mattock: that's neat
(21:13:16) mattock: acceptable for everyone?
(21:13:16) dazo: that even fits into one line in my IRC client :-P
(21:13:19) dazo: ACK
(21:13:24) ecrist: ack
(21:13:30) psha: ack
(21:13:48) ecrist: remove the timeline tab, but the functionality needs to =
stay
(21:13:48) mattock: dazo: in a hurry?
(21:13:55) psha: ecrist: it's there
(21:13:57) mattock: ecrist: it will, no functionality is affected
(21:14:02) psha: append timeline/ and you'll get it
(21:14:04) psha: same for roadmap
(21:14:11) ecrist: ok
(21:14:17) cron2: ok, need to leave -> f00d
(21:14:22) mattock: cron2: bye!
(21:14:32) psha: cron2: enjoy
(21:14:33) mattock: dazo: do you still have some time?
(21:14:46) dazo: mattock: I'm at home now, so I'm fine right now ... but I =
do have plenty of stuff to do besides this meeting too :)
(21:14:59) krzee: tickets are only bugs tho?
(21:15:31) mattock: krzee: yep... I think forums/mailing lists/IRC are more=
 suited for feature requests (if that's what you mean)
(21:15:47) dazo: we're trying to "resize" it a little bit ... feature reque=
sts will be discussed in ML or forums, and things we want to implement, we =
add as a "bug"
(21:16:03) mattock: krzee: I added your topics here: https://community.open=
vpn.net/openvpn/wiki/Topics-2011-02-10
(21:16:05) vpnHelper: Title: Topics-2011-02-10 =EF=BF=BD=EF=BF=BD=EF=BF=BD =
OpenVPN Community (at community.openvpn.net)
(21:16:34) krzee: | Commercial Products | Docs | Wiki | Forums | Timeline |=
 Source | Tickets | New Ticket | Download |
(21:17:21) mattock: I think bug is better, if we can accept that there are =
_some_ non-bugs there
(21:17:34) mattock: e.g. our to be implemented features
(21:17:43) dazo: agreed
(21:17:57) krzee: ok
(21:18:04) mattock: "Bug" should direct users to only file bug reports there
(21:18:13) dazo: janjust cleaned up stuff there today ... and he found seve=
ral "bugs" which was more support tickets
(21:18:38) mattock: krzee: I'll respond to this guy: https://forums.openvpn=
.net/topic7615.html
(21:18:40) vpnHelper: Title: OpenVPN Support Forum sctp implementation in o=
penvpn : Wishlist (at forums.openvpn.net)
(21:18:44) mattock: ask him to mail to openvpn-devel
(21:18:47) krzee: and isnt Roadmap just something on the wiki? or is the id=
ea that by putting it there we'll get max feedback on it?
(21:19:38) psha: krzee: Roadmap is summary of open bugs
(21:19:41) mattock: you mean Trac's roadmap feature, or the Roadmap page?
(21:19:48) dazo: Roadmap in the toolbar is more a planning overview, to see=
 the progress of milestones and such things in Trac
(21:20:06) dazo: Roadmap on the man wiki page, is what we would like some f=
eedback on
(21:20:25) mattock: this one: https://community.openvpn.net/openvpn/wiki/Ro=
adMap
(21:20:27) vpnHelper: Title: RoadMap =EF=BF=BD=EF=BF=BD=EF=BF=BD OpenVPN Co=
mmunity (at community.openvpn.net)
(21:22:01) mattock: krzee: this one is for d12fk: https://forums.openvpn.ne=
t/topic7623.html=20
(21:22:03) vpnHelper: Title: OpenVPN Support Forum Windows auto-connect whe=
n starting gui : Wishlist (at forums.openvpn.net)
(21:23:36) mattock: shall we postpone the "PPP gateway" stuff?
(21:24:38) dazo: Yeah, we can do that ... that's v2.3 stuff anyway
(21:24:59) mattock: ok
(21:25:07) mattock: then I think we're done
(21:25:23) mattock: I'll start pushing out the patches tomorrow
(21:25:48) mattock: and edit the Trac button row
(21:26:01) mattock: when 2.2 stuff is behind us, we can think of the docume=
ntation migration
(21:26:07) mattock: FAQ should probably be the first one
(21:26:14) dazo: ack
(21:26:27) s7r ha abbandonato il canale.
(21:26:34) dazo: mattock: please bug me as much as you want to get git send=
-email setup
(21:27:04) dazo: I'll be at a Developers Conference tomorrow (and probably =
some time on Saturday), but I'll try to be online as much as possible
(21:27:11) mattock: dazo: I will, if I have any issues... but now that I've=
 tackled building OpenVPN on Windows there's no stopping me ;)
(21:27:27) dazo: hehe :)
(21:27:36) dazo: I'm sure git stuff will be easier :)
(21:27:42) psha: Mattock The Unstoppable
(21:27:43) mattock: it will
(21:27:54) mattock: psha: ack
(21:27:55) psha: if not on windows :)
(21:28:08) mattock: Windows could only delay, not stop me :)
(21:28:27) mattock: it's like walking in deep mud
(21:28:42) mattock: anyways, I'll write the summary tomorrow
(21:29:13) dazo: thx a lot!  This was yet another good meeting!
(21:29:14) mattock: people get some extra time to test "openvpn-2.2-rc-inst=
all-preview-5.exe"
(21:29:18) mattock: agreed!
(21:29:25) mattock: dazo: have fun at the developer conference!
(21:29:32) dazo: thx!  I'll do my best :)

--------------080803010706080409010800--

