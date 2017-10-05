From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <c09edfe0-8a4c-dbae-cf14-2b468b4b50a4@...515...>
Message-ID: <5b26a0d5-9bb7-fe1b-a4b5-7960b6d72363@...515...>
Date: Thu, 5 Oct 2017 12:59:49 +0300
MIME-Version: 1.0
In-Reply-To: <c09edfe0-8a4c-dbae-cf14-2b468b4b50a4@...515...>
Content-Type: multipart/mixed; boundary="------------BE83A887723960910977BD3A"
Content-Language: en-US
Subject: [Openvpn-devel] Summary of the community meeting (Wed, 4th Oct 2017)
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
--------------BE83A887723960910977BD3A
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Wednesday 4th Oct 2017
Time: 19:00 CET (17:00 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2017-10-04>

The next meeting has not been scheduled yet.

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

chipitsine, cron2, dazo, mattock and ordex participated in this meeting.

--

Talked about patchwork. The instance setup by mattock works, but there's
at least one glitch to fix before patchwork is ready for production use.
In addition some users need to be made "maintainers" so that we can
change the state of patches. Bouncing old patch emails to patchwork
seemed to work fine.

Also discussed possible integrations with CI systems such as Travis and
Buildbot. Noted that running CI automatically on patches would be tricky:

- Security issues: patches are coming from untrusted sources
- Matching patch with a branch
- Building a single patch may fail as it may depend on other patches

Agreed that we should start using patchwork first and look into CI
integration later.

--

Discussed how to best manage code that is under "contrib" directory in
the main OpenVPN repository:

<https://github.com/OpenVPN/openvpn/tree/master/contrib>

Mattock will send a separate email to openvpn-devel list about this topic.

--

Full chatlog attached.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

--------------BE83A887723960910977BD3A
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2017-10-04.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2017-10-04.txt"

(20:01:13) mattock: good evening
(20:07:51) mattock: it is bit quiet here :)
(20:07:52) dazo: hey :)  lot's of life here :)
(20:08:01) mattock: haha, beat you to it :P
(20:08:08) dazo: :-P
(20:09:00) ordex: prot
(20:10:04) ordex: mattock: what's wrong with this pre-release of patchwor=
k ?
(20:11:56) mattock: ordex: what do you mean by pre-release?
(20:12:08) ordex: mattock: the one you showed us in xmpp
(20:12:15) ordex: I replied you there
(20:12:38) mattock: "for example for "[Openvpn-devel] Fixed that "--bind =
ipv6only" did not work due to incorrect parameter processing. ...     " i=
t did not understood gert's email was an "applied""
(20:12:51) mattock: getting it to understand those things may need a bit =
more work
(20:13:03) ordex: alright
(20:13:21) ordex: is there some collection of regexp used to match "appli=
ed" and similar?
(20:13:33) mattock: yes, there are some defaults
(20:13:36) mattock: let's see
(20:13:38) ordex: ok
(20:14:52) mattock: here's some of the magic: http://patchwork.readthedoc=
s.io/en/stable-2.0/usage/headers/
(20:14:55) vpnHelper: Title: Hint Headers Patchwork 2.0-alpha documentati=
on (at patchwork.readthedocs.io)
(20:15:18) ordex: alright
(20:15:20) mattock: this might be useful also: http://patchwork.readthedo=
cs.io/en/stable-2.0/usage/delegation/
(20:15:21) vpnHelper: Title: Autodelegation Patchwork 2.0-alpha documenta=
tion (at patchwork.readthedocs.io)
(20:15:32) mattock: it can also handle Acked-By and such - trying to find=
 the documentation
(20:15:46) ordex: oh these are hints for patchwork
(20:15:48) ordex: explicit hints
(20:16:41) dazo: well if we need to change subject lines, or add "flags" =
or "tags" in the body or mail headers ... it's easy for us to rework that=
 in our mail generator scripts
(20:16:42) mattock: http://patchwork.readthedocs.io/en/stable-2.0/usage/o=
verview/ in section "Tags"
(20:16:44) vpnHelper: Title: Overview Patchwork 2.0-alpha documentation (=
at patchwork.readthedocs.io)
(20:17:06) ordex: dazo: maybe, for the applied email
(20:31:59) ordex: I have an idea for tls-crypt-v2!
(20:32:06) ***ordex takes note
(20:32:44) ***dazo is curious
(20:33:12) ordex: I add you to the CC list then :D
(20:34:16) mattock: shall we start for real now? :P
(20:34:19) ordex: regarding patchwork: I think the easiest thing to do is=
 to have the hint being set in the headers when sending an "applied"
(20:34:29) ordex: let's start for *real*!
(20:34:30) ordex: :D
(20:34:46) mattock: digging up the agenda
(20:34:57) mattock: https://community.openvpn.net/openvpn/wiki/Topics-201=
7-10-04
(20:34:58) vpnHelper: Title: Topics-2017-10-04 =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)
(20:35:39) mattock: maybe skip "tls-crypt-v2: avoid user fingerprinting" =
today?
(20:35:47) dazo: yeah
(20:35:49) ordex: yeah
(20:35:51) ordex: we had enough
(20:35:51) ordex: :D
(20:35:59) mattock: so #2 patchwork
(20:36:29) mattock: the instance is running now
(20:36:35) mattock: and seems to work for the most part
(20:36:36) dazo: mattock: is there some configuration option to be able t=
o understand Acked-by?  Or should I update our git helper scripts?
(20:36:45) mattock: dazo: I don't know yet
(20:36:58) mattock: documentation claims that the basic linux kernel tags=
 are understood
(20:37:05) ordex: mattock: how about old patches that have not been commi=
tted yet? do we need to add them manually?
(20:37:35) dazo: if it is not configurable, it is very easy to update our=
 helper scripts ... they can be found here, actually https://gitlab.com/d=
azo/misc-git-tools/
(20:37:36) vpnHelper: Title: David Sommerseth / misc-git-tools =C2=B7 Git=
Lab (at gitlab.com)
(20:38:36) ordex: well, people sending acks won't know that they have to =
use those headers
(20:38:41) ordex: no?
(20:38:44) mattock: ordex: the way patchwork operates is that mails are d=
ownloaded locally and passed on to a helper script that parses them and a=
dds them to the patchwork database
(20:39:10) ordex: mattock: and I guess only new mails are downloaded, no?=

(20:39:13) dazo: ordex: I thought the "PATCH applied" mails can be the tr=
igger, that is the formal approval ... but yeah, you have a point
(20:39:23) mattock: the patches are in patchwork now are such that were s=
ent after I had created the patchwork@...515... email account and subsc=
ribed it to openvpn-devel
(20:39:50) mattock: so, if old patches were somehow to arrive at that mai=
lbox then patchwork would see them
(20:39:55) ordex: dazo: yeah, but the nice thing is that even before appl=
ying a patch, you can already have a summary of how many ACKs it got. thi=
s is why it is nice to have it parse every reply
(20:40:08) ordex: mattock: I see
(20:40:11) dazo: yeah, that's what I realised mid-sentence :)
(20:40:12) ordex: mattock: can we "bounce" them?
(20:40:19) mattock: ordex: we can try
(20:40:25) ***ordex does not know how to do it
(20:40:32) ordex: can anybody do it=20
(20:40:32) ordex: ?
(20:40:48) mattock: I don't know the internals of how patchwork figures o=
ut what to do with a patch
(20:41:03) mattock: like, does it check sender address or just the [openv=
pn-devel]=C2=A0header in the subject
(20:41:29) mattock: it would probably be possible to fool patchwork, but =
I'm not sure if it is worth it
(20:41:33) dazo: if the mails are bounced, there's only mail headers adde=
d, existing headers + body are identical
(20:41:48) mattock: that would probably work
(20:42:02) ordex: yap
(20:42:12) ordex: can anybody bounce? or only the original sender of the =
mail?
(20:42:52) dazo: I think anyone who knows the patchwork address can bounc=
e .... which after this meeting means the whole internet :-P
(20:43:31) mattock: if that becomes a problem we can always create new, s=
uper-secret account and subscribe it to patchwork :P
(20:43:38) dazo: :)
(20:43:39) ordex: :P
(20:43:47) ordex: I thought bouncing was done somehow through the mailer =
daemon
(20:44:06) ordex: like "send this email to all the people that haven't re=
ceived it before and that are subscribed now"
(20:44:08) ordex: but apparentlyno..
(20:44:47) dazo: ordex: There's a nice add-on to Thunderbird .... and (al=
)pine have a specific bounce "key", I'd be surprised if mutt is missing i=
t too
(20:44:58) dazo: and that's all mail clients which matters, right? :-P
(20:45:01) mattock: dazo: feel free to bounce old patches
(20:45:11) ***ordex searches the add-on
(20:45:31) mattock: I'll look into the Acked-By thing quickly
(20:45:59) dazo: ordex: Mail Redirect
(20:45:59) mattock: http://patchwork.readthedocs.io/en/stable-2.0/usage/o=
verview/#tags
(20:46:00) vpnHelper: Title: Overview Patchwork 2.0-alpha documentation (=
at patchwork.readthedocs.io)
(20:46:22) ordex: dazo: yup
(20:46:28) mattock: I'll check patchwork admin UI to see if those needs t=
o be enabled somehow
(20:46:54) mattock: three tags are configured out of the box: Acked-By, R=
eviewed-By, Tested-By
(20:47:38) ordex: yeah
(20:47:39) mattock: I can grant admin access to those who need it
(20:47:48) mattock: to the patchwork admin interface
(20:48:06) mattock: right now it is intranet-only, but if needed, I could=
 allow access also from the community VPN
(20:48:14) mattock: for community deveopers
(20:49:03) ordex: I don't think we need people to acces that pretty often=

(20:49:16) ordex: as soon as two or three people have access (just for em=
ergency) it should be fine
(20:49:22) mattock: yeah, agreed
(20:49:36) ***ordex is trying to redirect one email
(20:49:53) ordex: yes!
(20:49:55) ordex: it appeared
(20:51:00) dazo: I've used Mail Redirect to bouncing the mails from secur=
ity@ to openvpn-devel@
(20:51:37) mattock: ordex: \o/
(20:51:42) ordex: <o
(20:51:51) mattock: ordex, dazo: can you register to patchwork so that I =
can grant you moderator rights?
(20:51:53) dazo: regarding - bouncing patches, I don't think it makes sen=
se to go too far into the history .... lots of the old patches won't appl=
y cleanly any more
(20:51:57) ordex: I just registered
(20:52:00) mattock: ok
(20:52:01) dazo: mattock: sure ...
(20:52:10) ordex: dazo: right
(20:52:21) ordex: I just want to make sure that cron2 know how long is hi=
s pipe
(20:52:21) ordex: :P
(20:52:47) ordex: the confirmation link is not working ... still loading
(20:53:09) mattock: ordex: can you PM the link to me?
(20:53:10) dazo: lol
(20:53:24) ***dazo need a URL too
(20:53:34) dazo: ahh!  https
(20:53:45) ordex: ah yeah
(20:53:49) ordex: if I prepend https it works
(20:53:54) ordex: good catch!
(20:54:08) mattock: ok so it hands out http URLs?
(20:54:29) ***dazo is so used to auto-redirect and HTST (which won't work=
 regardless, as it is the first visit)
(20:54:33) ordex: right
(20:54:43) ordex: mattock: right
(20:55:03) ordex: dazo: you have auto-redirect for everywebsite? I use HT=
TP Everywhere for firefox
(20:55:04) mattock: ok, I will see if I can fix that in patchwork - if no=
t, I will redirect
(20:55:11) ordex: ok
(20:55:22) ordex: grep for "/confirm/" :P
(20:56:02) dazo: ordex: all web servers I configure, I add the redirect .=
=2E.. hmmm https everywhere have been disabled .... I'd forgotten why
(20:56:13) ordex: ah ok
(20:56:20) ordex: yeah i also do that for my servers
(20:57:23) ordex: mattock: the "delegate to" menu is empty. I guess we ne=
ed people to register and then be assigned the Dev role?
(20:57:37) mattock: yeah, I'm looking into the roles thing now
(20:57:43) mattock: but people do need to register first
(20:57:57) mattock: there also seems to be a mapping between a user and o=
ne or more emails
(20:58:06) ordex: yeah I registered 2
(20:58:13) mattock: so, if you use several email addresses all of those c=
an still be linked to one patchwork user
(20:58:42) ordex: yup
(20:58:42) dazo: that's good :)
(20:58:52) ordex: btw, patchwork should have multiple hooks... I wonder i=
f in the *future* we could have it apply the patches to a temporary branc=
h and run travis, like we do on Github for the PRs
(20:58:55) cron2: re!
(20:58:59) ordex: there he is! :)
(20:59:00) dazo: welcome!
(21:00:06) chipitsine: ordex, do you mean "patchwork" branch on github ?
(21:00:13) mattock: cron2: hi!
(21:00:27) ordex: chipitsine: nono, I was thinking about local processing=

(21:00:47) ordex: but it was just an idea for the future
(21:00:54) ordex: would need some work
(21:01:05) ordex: cron2: register! we have patches to assign you :D
(21:01:57) chipitsine: own installation of travis?
(21:02:07) cron2: ordex: this not how it works :)
(21:02:25) ordex: :D
(21:03:13) mattock: hmm, Patchwork documentation helpfully tells me that =
there are "Standard users" and "Maintainers", but nowhere I can find the =
place where I configure a user to be a maintainer
(21:03:16) mattock: more searching...
(21:03:20) ordex: chipitsine: either just run the tests locally, or send =
the work to travis (but the latter I don't think can be done)
(21:03:46) ordex: chipitsine: but anyway, this is easy to DoS, so better =
to dump the idea for now :P
(21:04:24) mattock: ordex: yep, we've touched upon the DoS aspect in the =
past
(21:04:50) chipitsine: well, travis-ci will run tests for any github bran=
ch, so ... if patchwork will create branches, they will be tested at no e=
ffort
(21:05:47) ordex: chipitsine: yeah, but think about creating one branch p=
er patch..sounds a bit too much maybe
(21:07:00) cron2: I would start easy with "if it does not *apply* to mast=
er, patchwork sends a reject mail" (and drops the patch).  This would be =
the most basic sanity check - if that one works, we can add local compile=
 tests (... with some unprivileged user, etc.)...
(21:07:29) dazo: yeah, that makes sense
(21:07:44) ordex: yeah
(21:08:24) ordex: although "does not apply to master" is not always meani=
ngful because sometimes a patch is sent and said to be explicitly based o=
n something else (i.e. another pending patch)
(21:08:50) ordex: that would make things complicated
(21:08:54) dazo: fair point
(21:10:25) ordex: maybe we start with "let's track patches"=20
(21:10:35) ordex: then we add decorations later as we see fit :P
(21:11:09) mattock: "Delegation of patches to any registered Patchwork us=
er (previously one had to be a registered maintainer)." (from http://patc=
hwork.readthedocs.io/en/stable-2.0/releases/cashmere/?highlight=3Dmaintai=
ner)
(21:11:11) vpnHelper: Title: v1.1 Series (=E2=80=9CCashmere=E2=80=9D) Pat=
chwork 2.0-alpha documentation (at patchwork.readthedocs.io)
(21:11:17) mattock: I wonder if the "maintainers" feature is gone?
(21:11:27) mattock: ordex: +1
(21:12:00) ordex: right nw my "delegate to" menu is empty
(21:12:11) mattock: ok, so there is one clear bug in the installation: it=
 sends http URLs whereas the server is https-only
(21:12:34) mattock: there is a separate "admins" list in patchwork config=
 file
(21:12:43) mattock: I hope we don't have to go edit that directly
(21:12:52) ordex: argh
(21:13:01) chipitsine: I had a look at pachwork, there's weird thing, the=
y use github for patchwork development
(21:13:02) ordex: but sounds like we don't need to be "admin", no?
(21:13:18) chipitsine: not patchwork for patchwork (that would make sense=
)
(21:13:27) ordex: chipitsine: :D
(21:13:31) ordex: they would loop!
(21:13:42) chipitsine: oh,really
(21:13:52) dazo: patchwork is primarily a review tool, where you interact=
 with it on a mailing list
(21:14:03) dazo: it is to get an overview of what is needed to be done
(21:14:18) dazo: github is a very different development model, not using =
mailing lists at all
(21:14:40) dazo: but yeah, they should eat their own dogfood, I agree :)
(21:15:21) cron2: quagga/frrouting is using patchwork big-style, with "if=
 a patch does not pass full build test, it's rejected before a human even=
 looks at it" - which I consider a bit heavy, but there's expertise we ca=
n tap into
(21:16:10) dazo: actually having some kind of build tests does help ... b=
ut then it needs to understand which branch it should apply it to; unless=
 it is aimed for master
(21:16:11) mattock: let's get the thing rolling and then get excited :P
(21:16:29) mattock: what if we touch topic #3 a bit?
(21:16:44) mattock: I will have a look at the "maintainers" thing when I'=
m less tired
(21:17:12) mattock: I'm sure there's a way to make people maintainers as =
my "Delegate to" menu was also empty, even though I was logged in as an a=
dmin
(21:17:19) ordex: yeah
(21:17:20) ordex: ok
(21:17:24) ordex: what's topic #3 ?
(21:17:29) mattock: Review of how to accept contrib scripts.=20
(21:18:01) mattock: this was discussed in some length on openvpn-devel ch=
annel earlier today
(21:18:19) dazo: I'm torn in both directions .... low threshold ... but w=
e've also been burnt, with keychain-mcd
(21:18:21) cron2: I would opt for "we do at least a quick review for obvi=
ously glaring nonsense", *and* we put a big "beware! this is not official=
ly maintained code, it might break and scare your cat!" sign
(21:19:16) cron2: (the problem with "just accept it, because nobody has t=
ime for review" is that it will backfire later on "you have this script a=
nd it ate my dog! all your fault!", so some level is needed)
(21:19:24) dazo: yeah
(21:20:12) dazo: I'm also thinking we should consider at least to move co=
ntrib/ out of the core tree .... put it in a separate openvpn2-contrib.gi=
t repository, which is also a signal that this isn't maintained on the sa=
me level as openvpn.git
(21:20:23) ordex: "you have this script and it ate my dog!" :D
(21:20:41) ordex: dazo: +1, I like the idea of splitting
(21:20:43) cron2: I never fully understood why that helps anything... mov=
ing out easy-rsa made it somewhat fully unmaintained instead
(21:21:21) ordex: cron2: keeping it in-tree would have somehow forced cor=
edev to have a look every now and then, you think?
(21:21:22) mattock: the bonus of having contrib code in the main tree tha=
t it benefits from Coverity and such
(21:21:23) dazo: I'd claim that easy-rsa wouldn't have been more maintain=
ed if we had it in our current tree .... I think keeping things focused i=
s better
(21:21:29) cron2: moving it out sends a clear signal "we don't want to ha=
ve to do anything with it"
(21:21:52) mattock: or rather "we want somebody else to have something to=
 do with it"
(21:21:55) cron2: mattock: not really, as coverity only looks at things t=
hat get built at "make" time
(21:22:22) dazo: yeah, otherwise I think keychain-mcd would have exploded=
 in our face long before
(21:22:23) cron2: ordex: if it's in tree, it's at least to some extent a =
responsibility we accept, yes
(21:22:39) mattock: well yeah, but we could run the contrib code through =
buildbot for example (although we could do that with external repo as wel=
l)
(21:22:51) cron2: (like, "please merge this patch otherwise it will not w=
ork with more recent perl/python/... versions", etc)
(21:23:13) dazo: mattock: contrib/ isn't really covered by automake (Make=
file.am) ... except "add these files/dirs into the tarball"
(21:24:10) mattock: dazo: yeah, but on the buildbot side at least we can =
run whatever tests we want, regardless of the standard build process
(21:24:43) mattock: but having stuff in openvpn main git repo is not a re=
quirement there
(21:24:59) mattock: as for "openvpn-contrib" - who would contribute to th=
at project/repo?
(21:25:18) dazo: I don't fully accept that moving contrib/ out means we d=
on't have to take care of it .... for easy-rsa, there were some people vo=
lunteering to take responsibility - which they did quite well in the begi=
nning
(21:25:18) chipitsine: people can have stuff in their own repos
(21:25:22) mattock: wouldn't it be better to just have a separate project=
/repo for every contributed module/piece of code?
(21:25:24) ***cron2 would propose keeping it in, but with much more relax=
ed rules
(21:25:27) chipitsine: like AirVPN already does
(21:25:53) dazo: mattock: not convinced that gives any other "benefit" th=
an even more management
(21:25:58) chipitsine: "openvpn-contrib" does not look any better than pu=
tting code into own repo
(21:25:59) cron2: mattock: that leads to chaos - look at radiusplugin.  m=
ultiple forks, none of them really "maintained", and users might not even=
 find the least buggy one
(21:26:13) dazo: yeah
(21:26:25) mattock: cron2: so the problem with radiusplugin is that there=
 is no maintainer, right?
(21:26:33) mattock: not really a problem with the approach afaics
(21:27:04) mattock: although I do agree that GitHub tends to generate unm=
aintained forks
(21:27:11) dazo: but lets flip it around ... we've had 4 versions of a yu=
bikey perl script floating on the ML waiting for review .... we already n=
ow doesn't really put much efforts into contrib/
(21:27:22) cron2: mattock: someone wrote it, someone forked it and fixed =
bugs, someone forked that and fixed more bugs, ...
(21:27:31) cron2: no "home" repo
(21:27:39) mattock: cron2: yeah, ic
(21:29:05) dazo: or to say it differently ... how can we encourage more p=
eople to get involved in maintaining contrib/?
(21:29:43) cron2: some sort of central coodination will be needed, to sho=
w that there is interesting stuff *in there* that they can use, and impro=
ve
(21:29:44) ordex: yeah
(21:29:50) cron2: not sure if people go looking there today
(21:29:52) dazo: by separating it out, we can give commit access to those=
 people - which might be a bit more inspiring than having to go through c=
ron2 and myself to get things into the public repos
(21:30:09) cron2: like, "I have this auth-gen problem here, where can I f=
ind a sample script"?
(21:31:01) mattock: dazo: splitting of openvpn-gui and openvpn-build was =
a success
(21:31:16) cron2: dazo: if we set the rules "<list> can send pull request=
 and we'll consider it good enough for contrib/", that's nearly as easy a=
s "having commit access"
(21:31:29) mattock: so the "split things out" thing can work very well in=
 some cases
(21:31:58) mattock: cron2: sounds reasonable
(21:32:14) dazo: And I think easy-rsa slowed down as v3 wasn't really pac=
kaged and shipped around .... so people drifted away
(21:32:20) cron2: openvpn-gui was a surprising success - who has commit t=
here?
(21:32:27) cron2: only mattock, right?
(21:32:35) dazo: selva, d12fk I believe
(21:32:36) mattock: selva
(21:32:40) cron2: ah
(21:32:58) mattock: plus we've had many contributors
(21:33:28) mattock: dazo: the main maintainer of easy-rsa 3 (pekster) mov=
ed to other things
(21:33:36) mattock: which made it stall
(21:33:46) dazo: right ... and I think ecrist took over too
(21:33:47) mattock: meanwhile we were stuck with unmaintained easy-rsa 2
(21:33:58) mattock: yeah, ecrist took over but only a month or so ago
(21:34:00) dazo: but easy-rsa-3 is ready for deployment=20
(21:34:15) dazo: at least that's the impression i get from /topic on #ope=
nvpn
(21:34:28) dazo: "EasyRSA v3.0.3 Released!"
(21:35:07) dazo: (I have even tried to get things rolling with the easy-r=
sa package in Fedora, but no success getting in contact with the maintain=
er)
(21:35:58) mattock: I think we could start with what cron2 suggested - al=
lowing PRs to "contrib/"
(21:36:19) mattock: I would need to split soon btw
(21:36:46) dazo: I think that is just delaying what will come eventually =
=2E.. a split .... but that's my personal opinion
(21:37:23) cron2: maybe we can bring in more official project maintainers=
 that way...
(21:37:39) cron2: don't try to drive everything away :-) - we need more c=
ore maintainers that actually want to *maintain*
(21:38:15) cron2: (I'm happy that ordex came up and started to rip out st=
uff :-) - but the boring chore of "review, commit, document" could use mo=
re trusted shoulders)
(21:38:26) cron2: then I could go back to "wreck the code"
(21:38:29) ordex: I also think cron2 is a good idea. if we get much inter=
est then we could decide to split it later and let it be maintained bythe=
 interested people
(21:38:43) dazo: I don't see it as "drive everything away" ... I see it a=
s actually opening up for more involvement, lower the barrier to contribu=
te (as to many, contributing to the core openvpn is a higher barrier)
(21:41:02) mattock: I agree with dazo, but as we've seen with easy-rsa-ol=
d (not a success), easy-rsa (not a success), openvpn-build (success), ope=
nvpn-gui (success), the results are not easy to predict
(21:41:21) mattock: I would have thought that easy-rsa would get a fair a=
mount of maintainers, given how widely it is used probably
(21:41:23) mattock: but no
(21:41:35) mattock: I mean, easy-rsa-old, i.e. easy-rsa 2
(21:41:55) mattock: tbh most of openvpn-gui development lies on Selva's s=
houlders
(21:41:59) dazo: I think if we had paid attention and pushed easy-rsa-3 m=
ore consistently on the earlier releases, things could have been somewhat=
 differently
(21:42:07) mattock: possibly yes
(21:42:34) cron2: who has committed to openvpn-build besides mattock and =
chipsistine?
(21:43:04) dazo: https://github.com/OpenVPN/openvpn-build/graphs/contribu=
tors
(21:43:05) vpnHelper: Title: Contributors to OpenVPN/openvpn-build =C2=B7=
 GitHub (at github.com)
(21:43:25) cron2: oh, and selva, of course :)
(21:43:27) dazo: https://github.com/OpenVPN/openvpn-gui/graphs/contributo=
rs
(21:43:28) vpnHelper: Title: Contributors to OpenVPN/openvpn-gui =C2=B7 G=
itHub (at github.com)
(21:43:59) mattock: not a big project, but people are clearly using it
(21:44:10) dazo: https://github.com/OpenVPN/easy-rsa/graphs/contributors
(21:44:11) vpnHelper: Title: Contributors to OpenVPN/easy-rsa =C2=B7 GitH=
ub (at github.com)
(21:44:20) dazo: I wouldn't say easy-rsa is a complete disaster
(21:44:54) mattock: indeed, I was surprised about that graph...
(21:45:36) dazo: now, this is a disaster ... https://github.com/OpenVPN/e=
asy-rsa-old/graphs/contributors
(21:45:37) vpnHelper: Title: Contributors to OpenVPN/easy-rsa-old =C2=B7 =
GitHub (at github.com)
(21:45:57) mattock: openvpn-gui is the winner by a clear margin though
(21:46:14) mattock: quite a few contributors with many patches
(21:46:19) dazo: yeah, which is quite natural, as it is the main interfac=
e for Windows
(21:46:37) mattock: and also "not ready" like "easy-rsa-old"
(21:47:21) mattock: one option would be to ask the people who contributed=
 to "contrib/" about what they think
(21:48:44) mattock: anyways, getting late
(21:49:08) mattock: start with cron2's suggestion and improve as needed?
(21:49:16) mattock: this does not need to be set on stone
(21:50:07) ordex: +!
(21:50:08) dazo: sure, we can try that .... I just wonder how we will mov=
e forward though
(21:50:08) ordex: +1
(21:50:37) ordex: we can decide that based on what feedback we get. maybe=
 we should send an email to the ml to announce this new "policy" ?
(21:50:40) mattock: dazo: for starters, document the fact on GitHub, on T=
rac and in READMEs as necessary
(21:50:41) cron2: +1
(21:50:44) mattock: ordex: +1
(21:50:54) mattock: let's send email to openvpn-devel first
(21:50:58) ordex: yup
(21:51:03) dazo: +1
(21:51:14) mattock: excellent, so many +1's
(21:51:16) mattock: :P
(21:51:21) mattock: anything else for today?
(21:51:44) dazo: I think you wanted to split :-P
(21:52:03) mattock: yes I did and do
(21:52:05) mattock: but I'm polite
(21:52:06) mattock: :P
(21:52:34) dazo: :)
(21:52:35) mattock: anyways, we'll have a meeting next week again, so let=
's not overdo it today
(21:52:44) dazo: +1 ;-)
(21:52:49) mattock: we already broke our one hour rule by 52 minutes
(21:53:00) mattock: I will write the summary tomorrow
(21:53:14) mattock: I can also send the email about "Accept PRs to contri=
b/" at the same time
(21:53:25) mattock: gg guys!
(21:53:27) mattock: -> split
(21:53:45) ordex: enjoy!

--------------BE83A887723960910977BD3A--

