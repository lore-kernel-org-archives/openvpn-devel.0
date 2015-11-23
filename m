Date: Mon, 23 Nov 2015 23:28:45 +0200
From: Samuli =?ISO-8859-1?Q?Sepp=E4nen?= <samuli@...515...>
Message-Id: <20151123232845.2130679a83b52b78d248ff4d@...515...>
In-Reply-To: <20151123120058.b809b16797a7f9db28ea6d3c@...515...>
References: <20151123120058.b809b16797a7f9db28ea6d3c@...515...>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="Multipart=_Mon__23_Nov_2015_23_28_45_+0200_GGWoG5FDUSYp4eHF"
Subject: Re: [Openvpn-devel] Topics for today's (Monday,
 23rd Nov 2015) community meeting
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--Multipart=_Mon__23_Nov_2015_23_28_45_+0200_GGWoG5FDUSYp4eHF
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

Here's the summary of today's IRC meeting.

- ---

COMMUNITY MEETING

Place: #openvpn-devel on irc.freenode.net
Date: Monday 23rd Nov 2015
Time: 20:00 CET (19:00 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2015-11-23>

The next meeting has not been scheduled yet, but will probably be=20
arranged two weeks from now.

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, jamesyonan, mattock, OSTIFDerek and syzzer participated in this meet=
ing.

- ---

Discussed OSTIF.org, which has chosen OpenVPN as one of the sponsored proje=
cts:

<https://ostif.org/>

OSTIF will start a Kickstarter funding round in Dec 1st. They have identifi=
ed 130 VPN providers using OpenVPN, all of which are potential contributors=
. The first goal of OSTIF.org is to hire a suitable company to do a securit=
y (code) review of both OpenVPN 2.x and 3.x. After that the bug bounty syst=
em will be initiated, aimed at both finding bugs and fixing them. OSTIFDere=
k will send a link to the Kickstarter page once it's up. Then we just wait =
and see what amount of donations we'll get and move on from there. The deta=
ils with distributing bounties can be discussed later and adapted in use as=
 needed.

- --

Discussed the Flattr micro-donations system:

<https://flattr.com/>

Agreed that transparency in how funds are used is essential. Depending on h=
ow much money can be raised, the initial plan is to use the donations to sp=
onsor travel costs for core developers who currently pay for the developer =
hackathon costs from their own pockets.

- --

Discussed setting up Travis-CI and Coverity for OpenVPN. Syzzer's test setu=
p is now working ok, and he will provide a patch to OpenVPN that adds a .tr=
avis.yml. We will configure Coverity and Travis to track a special Git bran=
ch which we will periodically update; this is required because the number o=
f daily/weekly builds is throttled.

- --

Discussed the OpenVPN 2.3.9 release. The following patches will go in, if p=
ossible:

1) Support for username-only auth file (6e9373c846)

While this is a new feature, it was accepted to 2.3.9 because it's fairly u=
nintrusive and provides functionality that many people seem to want.

2) Tap-windows6 bugfix (assigned to jamesyonan)
3) Avoid partial authentication state when using --disabled in CCD configs
4) The query username/password patchset
5) CHANGES.rst (assigned to mattock)
6) Windows 10 DNS leak fix/workaround

- --

Discussed a few of the Trac tickets. Ticket #180 is similar to dazo's patch=
 for #521, so cron2 will try to poke dazo tomorrow about it. Cron2 assigned=
 #91 to himself. Mattock will see if adding a generic "old FAQ" redirect wo=
uld be doable (#323). Cron2 closed #593, which had been sorted out earlier.

- --

Discussed the proposal to move Git "master" branch to mbedTLS 2.x. The prob=
lem is that mbedTLS 1.3 will EOL on 31st Dec 2016, and at that time OpenVPN=
 2.4 will almost certainly be out. Support for OpenVPN 2.3 will end when Op=
enVPN 2.4.0 is released, so if we're quick with 2.4, we don't have to port =
the "release/2.3" branch over to mbedTLS 2.x at all.

- ---

Full chatlog has been attached to this email.

- --=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlZThQ0ACgkQwp2X7RmNIqMxlQCgiIp1KUDjKM0Q3Zk9xeoAaFHt
ppwAoJte/daCb98qp84ecT4v8ZyJIS7s
=3DL0k+
-----END PGP SIGNATURE-----

--Multipart=_Mon__23_Nov_2015_23_28_45_+0200_GGWoG5FDUSYp4eHF
Content-Type: text/plain;
 name="openvpn_irc_meeting_chatlog_2015-11-23.txt"
Content-Disposition: attachment;
	filename="openvpn_irc_meeting_chatlog_2015-11-23.txt"
Content-Transfer-Encoding: quoted-printable

(20:56:02) mattock: hi OSTIFDerek!
(20:56:08) mattock: the meeting starts in 4 minutes
(20:56:53) ***cron2 looks for his laptop...
(20:57:02) OSTIFDerek: hi! I'm good to go!
(20:58:11) syzzer: hi, me too :)
(21:04:34) mattock: hi guys!
(21:04:49) cron2: no girls...
(21:05:04) mattock: are there?
(21:05:36) mattock: OSTIFDerek: do you want to discuss your project/organiz=
ation a bit before we start?
(21:05:58) OSTIFDerek: Sure
(21:06:05) cron2: syzzer: could you stop finding memory leaks, please :-) -=
 is this 2.3 or master or both?
(21:06:07) gava100 [~gava100@...2093...] =C3=A8 entrato nella stanza.
(21:06:25) syzzer: cron2: both - and coverity already found this one in 201=
1 ;)
(21:06:34) OSTIFDerek: Me and two close friends have formed an organization=
 to crowdsource funding for improving open source projects.
(21:06:39) syzzer: it's quite harmless though
(21:07:13) jamesyonan [~jamesyona@...2094...] =C3=
=A8 entrato nella stanza.
(21:07:16) OSTIFDerek: the aim is to establish bug-bounties, get profession=
al audits, and secure contracts for addition of features
(21:07:17) syzzer: cron2: also see the note in the patch (outside of commit=
 msg)
(21:07:19) mattock: hi jamesyonan!
(21:07:23) jamesyonan: hi
(21:07:34) mattock: OSTIFDerek: jamesyonan is the "father" of OpenVPN
(21:07:41) mattock: two openvpn's actually :P
(21:07:52) cron2: syzzer: no idea which bogon wrote that code
(21:08:16) mattock: cron2, syzzer: I hate to interrupt you guys, but Derek =
is trying to talk :P
(21:08:17) OSTIFDerek: nice to meet you james!
(21:08:30) syzzer: mattock1: ack. :x
(21:08:32) jamesyonan: Hi Derek
(21:08:55) OSTIFDerek: so our main aims for OpenVPN are to get 2.x and 3.x =
audited professionally, and to establish a $5000 bug-bounty
(21:09:10) mattock: the OSTIF.org site: https://ostif.org/
(21:09:14) OSTIFDerek: samuli and I have been going back and forth about ho=
w the bounties should work
(21:09:32) mattock: and we here have discussed the challenges a bit also
(21:09:42) mattock: we here =3D openvpn developers
(21:09:47) OSTIFDerek: oh and a heads up on the site, if it doesn't load pr=
operly, i just cloudflared the site to get ready for our kickstarter and re=
ddit AMA, and it is having performance problems, i am troubleshooting them =
after this meeting
(21:11:01) mattock: OSTIFDerek: regarding the $5000 bug bounty - has there =
been progress? as in "has money exchanged hands"?
(21:11:09) OSTIFDerek: we also have two artists working on that front page =
image image (the map) to make the text more visible
(21:11:52) OSTIFDerek: we are doing our initial fundraiser to actually begi=
n the bug bounties on Dec 1st, i'd estimate we could begin with bounties tw=
o weeks after the kickstarter ends, so around Jan 14th.
(21:12:10) mattock: ah, I see
(21:13:00) OSTIFDerek: we are actually having a meeting this evening to beg=
in our solicitng of donations to ~130 VPN providers prior to the kickstarter
(21:13:21) mattock: that many? :P
(21:13:39) mattock: is the meeting public, or internal?
(21:13:52) OSTIFDerek: yeah, i'm not excepting anything from the "fly by ni=
ght" ones, but the larger VPNs could be a strong source of long-term support
(21:14:15) mattock: yeah, I don't think a small montly "fee" is too much to=
 ask
(21:14:21) mattock: for a common cause
(21:14:21) OSTIFDerek: internal, but i'd be perfectly open to having anyone=
 from the supported projects present and giving their input
(21:14:58) mattock: is the kickstarter page up already?
(21:15:51) OSTIFDerek: it is not, we have it configured via an account but =
they won't let us post the kickstarter until it begins (i believe), my part=
ner Amir is handling the Kickstarter page itself.
(21:16:27) mattock: can you send a link to me/us when the page is up?
(21:17:10) OSTIFDerek: it will be on Hangouts @ 7PM CST, but yes i can send=
 a link
(21:17:46) mattock: I mean the kickstarter page
(21:18:28) OSTIFDerek: oh the page, of course
(21:18:33) mattock: one question... we've discussed the practical problems =
with any kind of bounty systems in the past
(21:18:40) mattock: and there are plenty of issues
(21:19:01) OSTIFDerek: yeah, it is a thorny subject
(21:19:35) mattock: I wonder if we should have a joint meeting with all the=
 sponsored project + OSTIF.org and see if we can reach a consensus
(21:19:58) mattock: or is every project different enough to warrant a diffe=
rent approach
(21:19:58) mattock: ?
(21:20:18) OSTIFDerek: originally we wanted to have a single bug bounty pro=
gram that covered all 5 supported projects, but it looks like we will be do=
ing a different bounty system for each project
(21:20:31) mattock: ok
(21:20:48) mattock: then we might want to have a separate "bounty" meeting =
at some point
(21:20:52) mattock: for openvpn
(21:21:09) OSTIFDerek: for example, VeraCrypt and OpenSSL want bugs submitt=
ed via PGP only, and the setup you guys have doesn't give us a secure optio=
n, we have to rely on you reacting quickly to fix issues.
(21:21:34) syzzer: yeah, that actually is something we need to fix...
(21:21:51) mattock: well, we can use GnuPG/PGP, but having email group disc=
ussions with it can be a bit tricky
(21:22:13) OSTIFDerek: yeah, it's a bit of a nightmare
(21:22:22) mattock: we have a security mailing list, but that is not really=
 secure from the likes of NSA
(21:22:30) mattock: it is a closed list, though
(21:23:34) OSTIFDerek: i've noticed that you guys have responded very quick=
ly to threats, so i don't see it being a huge issue, but a secure system wo=
uld be better for obvious reasons
(21:24:40) syzzer: yes, I think we should consider that, but let's postpone=
 that for another time :)
(21:24:48) mattock: +1
(21:24:59) OSTIFDerek: agreed
(21:25:09) OSTIFDerek: are there any other hurdles that you guys want to di=
scuss now?
(21:25:34) syzzer: well, the main problem (at least for me) is that it is h=
ard to judge a book by its cover :)
(21:25:45) mattock: well the biggest hurdles are related to "who fixes the =
bugs" when/if money comes in
(21:25:56) mattock: and "who decides what bugs to fix"
(21:26:35) mattock: but that can of worms can/should be discussed separately
(21:26:39) OSTIFDerek: the idea is to have the "public" reviewing the code,=
 putting more eyes on the project because of the cash incentive
(21:26:40) mattock: imho
(21:26:54) syzzer: hehe, somehow I expect I will have to find some spare cy=
cles to invest in that :p
(21:27:03) OSTIFDerek: in other words, you would just be getting more bug r=
eports and responding to them as you normally would
(21:27:20) mattock: ah, so "find a bug" bounties?
(21:27:25) mattock: or "fix a bug" bounties?
(21:27:31) ***cron2 would like bug *fixes*, not necessarily "bug reports" a=
s such
(21:28:16) syzzer: OSTIFDerek: yes, that is both what I like and fear. we d=
on't have a big team and if this actually catches on, my girlfriend will st=
art complaining ;)
(21:28:16) OSTIFDerek: my suggestion would be to offer a lesser reward for =
a bug report with no fix
(21:28:35) mattock: that makes sense
(21:28:37) OSTIFDerek: and a greater reward for a bug that has a fix that i=
s ultimately accepted by OpenVPN
(21:28:48) mattock: we also have many open bug reports nobody has time to l=
ook into
(21:29:01) mattock: and tons of issues related to Windows in particular
(21:29:07) syzzer: fix would be nice, but still, even with a fix we will ne=
ed to do a decent impact assessment
(21:29:26) OSTIFDerek: and Ubuntu since they went systemd and broke everyth=
ing :(
(21:30:09) syzzer: anyway, I think we'll just have to see how this works ou=
t :)
(21:30:14) mattock: yeah
(21:30:26) mattock: this also ties in with ValdikSS's suggestion to use Fla=
ttr
(21:30:35) mattock: same can of worms to sort out
(21:30:41) mattock: so fix one, fix both
(21:30:43) syzzer: the responsible disclosure rules on the website look good
(21:31:45) OSTIFDerek: yeah, they were established by looking at other bug =
bounty programs and negotiating with OpenSSL (they have a large team and as=
sloads of funding, as well as very rigid processes for bug and code submiss=
ion)
(21:32:13) mattock: so now we wait for the Kickstarter to start and go on f=
rom there
(21:32:25) mattock: and we can always adjust the bounty system as needed
(21:32:33) mattock: no need for stagefright
(21:32:37) cron2: send all the moneys my way
(21:32:43) mattock: :P
(21:32:49) cron2: there's nice places on hawaii I have been told...
(21:32:52) OSTIFDerek: our main concern with OpenSSL is that their audit is=
 being done by iSec, and we don't like iSec getting all of the audit contra=
cts for critical open source software
(21:33:29) OSTIFDerek: especially being a british company with close ties t=
o the british government, and GCHQ is the most aggressive agency in the wor=
ld
(21:33:49) mattock: yeah
(21:33:59) mattock: are there any reasonable alternatives?
(21:34:16) OSTIFDerek: we have been talking to Kaspersky, but they have bee=
n very slow to respond
(21:35:01) OSTIFDerek: we have also reached out Quarkslabs which is French =
and has a solid team of reverse-engineers
(21:36:09) OSTIFDerek: they did a great job of auditing ChatSecure recently
(21:36:23) mattock: which company did the security audit(s) of Truecrypt?
(21:36:41) OSTIFDerek: iSec (NCC Group)
(21:36:51) OSTIFDerek: the british company we have concerns about
(21:37:10) OSTIFDerek: that also missed the local EOP vulnerability with th=
eir audit, Google Project Zero later caught it
(21:37:24) ***cron2 points at Fox-IT...
(21:37:54) cron2: (they might not be the right ones to formally audit OpenV=
PN but could help with other projects)
(21:38:10) syzzer: yeah, was about to say that
(21:38:11) mattock: https://opencryptoaudit.org/
(21:38:30) syzzer: in case you didn't knew: I work at Fox-IT ;)
(21:38:41) cron2: syzzer: really? whee!
(21:38:51) syzzer: part of my openvpn work is paid-for
(21:38:54) OSTIFDerek: Fox-IT would definitely be worth considering. Obviou=
sly there's a huge amount of crypto expertise there.
(21:38:54) cron2: (did you poke andj?)
(21:39:34) syzzer: cron2: yes, really. oh, yeah, I poked him over lunch tod=
ay. he remembered and had a guilty look on his face. let's see if that resu=
lts in reviews ;)
(21:39:39) cron2: lol
(21:40:33) syzzer: so, did we cover OSTIF? more questions?
(21:40:34) mattock: anything else about this topic today?
(21:40:39) mattock: :)
(21:41:05) syzzer: cron2: did mention he had ideas about 'moneyz' in genera=
l - not ostif-related
(21:41:06) mattock: I suggest we wait for the Kickstarter and see what kind=
 of funds we're talking about
(21:41:12) OSTIFDerek: yeah i'm available to answer any questions you guys =
have about anything
(21:41:17) gava100 ha abbandonato la stanza (quit: Ping timeout: 276 second=
s).
(21:41:23) mattock: OSTIFDerek: great, thanks!
(21:41:26) cron2: mattock1: any thoughts about flattr?
(21:41:29) OSTIFDerek: derek@...2095...
(21:41:50) syzzer: OSTIFDerek: thanks, and good luck with the lanch!
(21:42:22) mattock: OSTIFDerek: this channel is only used for meetings, so =
if you like, join #openvpn-devel
(21:42:38) mattock: you need to login to Freenode first, though
(21:42:48) OSTIFDerek: alright. I'll do that
(21:42:50) mattock: great!
(21:42:59) mattock: ok, let's move on to the next topic
(21:43:12) mattock: ah, Flattr
(21:43:27) cron2: a user direly wanted to send thank-you money yesterday...=
 :)
(21:43:43) mattock: jamesyonan: any thoughts on Flattr? We had a brief emai=
l exchange about that earlier
(21:44:00) mattock: cron2: I'm sure there would be many people and organiza=
tions willing to donate to OpenVPN
(21:45:16) jamesyonan: don't know much about Flattr, but it seems interesti=
ng
(21:46:15) mattock: the main concern is who would take the money and distri=
bute it to people
(21:46:21) mattock: and what would the money be used for
(21:46:27) syzzer: yep
(21:46:37) mattock: that, of course, would be related to "how much we get"
(21:47:10) mattock: and we'd need transparency, just like OSTIF.org, on how=
 the money is being used
(21:47:48) mattock: people need to realize - preferably before donating - w=
hether the money goes to fixing bugs or buying beers in an OpenVPN hackthon
(21:48:24) mattock: I haven't checked if Flattr supports showing where the =
money is aimed at
(21:49:23) syzzer: yes, I fully agree on transparency. even if flattr doesn=
't have us the platform, we should have it on the website.
(21:50:21) mattock: Flattr takes 10% of the donations: https://flattr.com/s=
upport/faq
(21:50:24) mattock: which is reasonable I think
(21:50:43) mattock: anyways, I can have a closer look at how Flattr works a=
nd report back
(21:51:02) mattock: the problems we'd solve with Flattr are mostly the same=
 as with OSTIF.org bounties/direct funding
(21:51:13) syzzer: we could simply start with a statement explaining that w=
e use it for travel money and beers, and will reconsider that if the amount=
 of money becomes enough to start thinking about pays development
(21:51:24) syzzer: *paid
(21:51:42) mattock: I think sponsoring travel for people who have to pay fo=
r the travel themselves is a good start
(21:51:51) mattock: like Arne and David(?)
(21:51:53) syzzer: yes, agreed.
(21:52:04) syzzer: and cron2, I think?
(21:52:07) mattock: oh yes
(21:52:28) cron2: I do
(21:53:07) syzzer: I consider Fox paying my tickets as a way for Fox to spo=
nsor openvpn, and I think we want to keep doing that :)
(21:53:17) cron2: heh, yes :)
(21:54:09) mattock: so, I will do a bit more research on Flattr
(21:54:11) mattock: next topic?
(21:54:17) syzzer: yes
(21:54:19) mattock: Setting up Travis-CI and coverity for OpenVPN (syzzer)
(21:54:39) syzzer: yeah, so all that seems to be working now
(21:54:56) syzzer: (except that coverity is a bit busy today)
(21:55:15) syzzer: "Your build is in the queue to be analyzed. There are 20=
 builds ahead of it.", as of 19:50
(21:55:38) syzzer: so right not it works like this
(21:55:57) syzzer: (1) add a .travis.yml file to the repo
(21:56:09) syzzer: (2) specify a branch for coverity to trigger on
(21:56:21) syzzer: (3) update the coverity branch every now and then
(21:56:52) syzzer: the reason to not simply use 'release/2.3' as a coverity=
 branch is that we only get a limited number of scan per day/week
(21:56:56) cron2: how does it work? so, what happens when you doing what?
(21:57:25) cron2: where does it get compiled and analyzed?
(21:57:25) syzzer: https://github.com/OpenVPN/openvpn/blob/coverity_scan/.t=
ravis.yml
(21:57:42) syzzer: ^^ that is the config for travis-ci
(21:58:13) cron2: this is something run by github?
(21:58:29) syzzer: which will run a 'make test' using that for each update =
of each branch with a .travis.yml file in it
(21:58:29) syzzer: https://travis-ci.org/OpenVPN/openvpn
(21:59:43) syzzer: don't know exactly who runs it 'company in germany' says=
 wikipedia
(22:00:10) cron2: so this is "just a public service" that runs build tests =
on github projects, and then sends the report to coverity?
(22:00:13) cron2: fascinating
(22:00:33) syzzer: for commits on the coverity_scan branch, travis will cre=
ate a special coverity tarball and send it to coverity for analysis
(22:01:20) syzzer: since all this seems to be working just fine now, I thin=
k we should add the .travis.yml to the master and release/2.3 branches
(22:01:47) cron2: without coverity? or with coverity?
(22:02:01) syzzer: that will not yet run coverity
(22:02:14) syzzer: I will have to keep updating the coverity_scan branch ev=
ery now and then
(22:02:32) syzzer: or someone else can, of course. then I don't need commit=
 rights anymore.
(22:02:59) cron2: ic
(22:03:19) cron2: what would travis-ci then do? "just compile, make check"?
(22:03:24) syzzer: yes
(22:03:32) syzzer: and it would do that too for each pull request
(22:03:53) cron2: magic
(22:04:26) syzzer: sounds like a good plan/
(22:04:28) syzzer: ?
(22:05:27) cron2: yep
(22:05:45) syzzer: ok, I'll send a patch to add the .travis.yml file :)
(22:07:03) cron2: ok, 2.3.9
(22:07:09) mattock: +1
(22:08:49) syzzer: any reason to include 6e9373c84639382c in particular?
(22:08:56) cron2: so, this commit is the "auth-user-pass file with just use=
rname"
(22:09:07) cron2: it seems to be functionality that users want, and is fair=
ly non-intrusive
(22:09:26) cron2: (unlike "make auth-user-pass accept <<inline>>", which is=
 fairly intrusive)
(22:09:41) cron2: but then it *is* a new feature, and not a bugfix
(22:09:52) syzzer: well, we have more of those
(22:09:55) syzzer: like peer-id
(22:10:08) cron2: this is why I bring it up :)
(22:10:08) syzzer: so fine by me
(22:12:12) cron2: any other options?
(22:13:47) mattock: oh, one thing: Rafael Gava contacted me earlier today, =
asking about the status of his patch
(22:13:52) mattock: does that ring a bell?
(22:14:11) mattock: (we might want to cover that patch if we can still loca=
te it)
(22:14:26) cron2: "sitting on the list, waiting to be procesed"
(22:14:53) syzzer: ah, the client-ip patch
(22:15:26) cron2: came across it a few days ago, but there's stuff I consid=
ered more important - dazo's, for example, which are scheduled for tomorrow
(22:16:23) mattock: ok
(22:16:47) mattock: so "what is missing" and "timeline" next?
(22:17:09) syzzer: if there's nothing that needs to go in, I say release as=
ap
(22:18:05) cron2: there is lots of stuff, so I could go on for a while :) -=
 but dazo's "disabled" bugfix is an important one, and then we should see t=
hat we can get it out, right
(22:20:02) syzzer: I'll start working on a patch to move to polarssl 1.3 th=
en :)
(22:20:14) cron2: mattock1: what release date would be convenient for you?
(22:20:43) mattock: hmm
(22:21:22) mattock: the tap-windows6 fix should go in, if possible
(22:21:32) cron2: well, any word on that?
(22:21:35) mattock: no
(22:21:41) mattock: I can poke about it again
(22:21:45) syzzer: jamesyonan: any news?
(22:21:54) mattock: oh yes, jamesyonan is here :P
(22:21:58) cron2: oh, the "--auth-user-pass + systemd is broken" needs atte=
ntion
(22:22:16) cron2: mine, unfortunately :) but maybe I can get that done tomo=
rrow
(22:22:49) jamesyonan: are you asking about tap-windows6 fix?
(22:22:53) mattock: yes
(22:23:04) mattock: or lack of it
(22:23:06) jamesyonan: yeah, I can put together a patch for that
(22:23:11) mattock: great!
(22:24:04) mattock: is anything blocking http://thread.gmane.org/gmane.netw=
ork.openvpn.devel/10486 ?
(22:24:10) mattock: except "no time to review"?
(22:24:38) cron2: "someone needs to explain why this fixes the bug" - or "r=
eview and figure out what the surrounding code does"
(22:26:02) cron2: but I intend to work on that tomorrow
(22:26:12) cron2: cannot be that hard - and maybe dazo will be around to ask
(22:26:22) mattock: yep
(22:26:38) mattock: I will also need to create the CHANGES.rst file
(22:26:48) cron2: oh, indeed, that would be nice
(22:26:48) mattock: what about Win10 + DNS?
(22:27:45) cron2: the patch we have on the list is for master and Selva Nai=
r says "it looks good now" - for 2.3 it would need the #ifdef's, and not-ha=
ve the build system changes (because they break XP) - and then you'd need t=
o figure out how to build vista+ and xp variants
(22:30:25) mattock: yeah
(22:30:44) mattock: I would so love to drop Windows XP support at this poin=
t :P
(22:30:54) cron2: no :)
(22:31:10) mattock: let's drag the dead horse indefinitely? :P
(22:31:16) cron2: (I could see that you want that, but there's still so man=
y XP users out there...)
(22:31:27) cron2: as long as we maintain 2.3 - so we should see that we can=
 2.4 out, finally
(22:31:27) mattock: well, I
(22:31:33) mattock: 'll see how painful it will be
(22:32:03) cron2: someone could do a review of Arne's compression v2 patch =
- that would help getting closer to 2.4...
(22:33:15) syzzer: I could do that, but I also need to find time for AEAD...
(22:34:03) cron2: so you're out :)
(22:35:07) mattock: do we want to review any of the patches today, or are t=
hey too hairy?
(22:35:56) ***cron2 tends to not wanting that
(22:36:20) syzzer: let's first see if we can get the discussion items done
(22:36:34) cron2: leaves trac tickets
(22:36:54) mattock: that leave trac tickets?
(22:36:57) mattock: leaves
(22:37:05) mattock: or "let's dump trac tickets for today"?
(22:37:46) cron2: #180 is similar to dazo's patch for #521 (iirc), so I'll =
try to poke him tomorrow about it
(22:38:03) cron2: #323 is mattock1's - so what do you need us to do?
(22:40:03) cron2: #91 is embarrassing... taking
(22:41:48) mattock: I think hildeb's suggestion in #323 sounds good
(22:41:48) cron2: #593 - any comments what to do with that now?
(22:42:47) cron2: there seem to be a few extra "q" in the URL, but yes...
(22:43:37) mattock: lol, indeed
(22:46:44) mattock: commented on the ticket
(22:46:45) syzzer: no clue about #993 -> "networking" :p
(22:46:55) syzzer: #593, that is
(22:47:49) mattock: I have no comments on #593 either
(22:48:03) mattock: #993 -> networking -> cron2
(22:48:06) cron2: there is no actual bug :) - it's more a documentation thi=
ng "if you make your packets smaller than you must, processing needs more C=
PU!"
(22:48:16) mattock: that's a reasonable fix
(22:48:20) ***cron2 does not want to see trac tickets over 900 :)
(22:49:15) cron2: mattock1: uh, the idea wasn't to change the *code* in 2.3=
.9, but to change the *redirect* to point to the right FAQ article :-)
(22:49:32) cron2: we should not have two-line URLs in openvpn itself...
(22:51:43) mattock: yes, but the URL is created by openvpn, right?
(22:51:49) mattock: or "is in openvpn"
(22:51:55) cron2: the short one, yes
(22:52:10) mattock: yeah
(22:52:23) mattock: that URL has been obsolete for like 5 years
(22:52:32) cron2: I'm fine with having a new short(-ish) one in there that =
redirects to the long one - but this one is just too long :)
(22:52:43) mattock: well you have a point there
(22:53:31) mattock: basically I'd need to add a redirect for the entire old=
 FAQ URL
(22:53:39) mattock: the #dhclientserv part is handled by the browser
(22:54:23) mattock: I'll see what I can do, and we go from there
(22:54:26) cron2: good point :)
(22:54:32) cron2: #593 closed!
(22:54:47) syzzer: good
(22:55:22) syzzer: question - what email adress should I put in the 'notifi=
cation_email' section of the travis coverity scan?
(22:56:06) syzzer: -devel@? security@?
(22:56:31) syzzer: hmm, or maybe it will just work without one
(22:57:12) cron2: what will it do without one?
(22:57:18) cron2: just put it into the web page?
(22:57:33) syzzer: no clue - the docs just say 'enter a email to send notif=
ications to'
(22:57:47) syzzer: let's see what happens
(22:57:50) cron2: but I'd actually like to see new reports without going th=
ere... so maybe we could have a scan-reports@...515... that points to "wh=
oever is interested"?
(22:57:53) ***cron2 <-
(22:58:15) syzzer: people can subscribe to the coverity project to get noti=
fications, iirc
(22:58:37) mattock: that would be optimal in that I would not need to do an=
ything :P
(22:58:39) ***cron2 hasn't seen anything from there
(23:00:42) cron2: ok, account settings says I *should* see something...
(23:01:00) syzzer: was about to ask that :p
(23:02:05) mattock: I have email notifications turned on in Coverity, and I=
 have not seen anything either afaict
(23:02:13) mattock: for "All projects"
(23:02:25) mattock: Last build analyzed 15 days ago
(23:02:25) cron2: mattock1: since you want to do something, could you add m=
ilestones for 2.3.10, 2.3.11?
(23:02:37) mattock: yup, just a sec
(23:02:39) cron2: that was the one that sent to security@ and scared james =
:)
(23:03:13) mattock: done
(23:05:38) mattock: ok, anything else for today, or are we golden?
(23:05:48) syzzer: mbed tls 2.x :)
(23:05:53) mattock: ah
(23:06:16) cron2: we skipped that :) (but we might want scan-reports@...2096...=
n.net anyway... *poke*)
(23:06:37) mattock: do we have confirmation that Coverity is not sending no=
tifications based on project settings?
(23:06:39) syzzer: if that is created, put me on it
(23:07:16) syzzer: I can not confirm or deny anything (since my personal ma=
il was in the notification_email section...)
(23:08:05) mattock: well, I have to have a look at the mailing list things =
in Rackspace anyways
(23:08:18) mattock: because we've capped the limit of 4 "external" addresse=
s on security@...515... anyways
(23:08:29) mattock: so no more people on the list unless we do something
(23:09:29) mattock: so mbedTLS
(23:09:48) mattock: what is the difference between 1.3.x and 2.x, API-vise
(23:09:49) mattock: ?
(23:10:01) mattock: "completely different"?
(23:12:03) syzzer: "needs quite some changes"
(23:12:21) syzzer: i.e., you don't want to support both 1.3 and 2.x in a si=
ngle branch
(23:12:24) mattock: what would the benefits be?
(23:12:30) syzzer: longer support
(23:12:31) cron2: 1.3 is end of life
(23:12:37) cron2: -ish
(23:12:40) syzzer: 1.3.x ends 31-12-2016
(23:12:50) mattock: that's not really EOL then
(23:13:05) ***cron2 wonders how to get a review on this
(23:13:08) syzzer: it's too close by the time we release 2.4 ;)
(23:13:17) syzzer: yes, that is the hard part...
(23:13:30) cron2: well, that's the important point: EOL will be right in th=
e middle of the 2.4 lifespan
(23:13:31) syzzer: changes are not *very* intrusive btw
(23:13:58) syzzer: there's just too many of them to start #ifdef'ing
(23:14:19) cron2: is there an mbedtls migration document that can be used t=
o review the changes?
(23:14:33) ***cron2 can run tests, but will not go into fully understanding=
 polarssl....
(23:14:56) syzzer: cron2: yes, there is
(23:15:07) cron2: you could just link that from the commit message :)
(23:15:14) syzzer: still plenty of room for interpretation though
(23:15:28) syzzer: yes, I will, and I will explain some of the decisions too
(23:16:08) syzzer: so now the more tricky question
(23:16:32) syzzer: how long do we expect to support 2.3, and do we want to =
migrate that too?
(23:16:57) cron2: last I remember we wanted to migrate that to 1.3 first :)
(23:16:58) mattock: we supported 2.2.x only until 2.3.0 was released I beli=
eve
(23:17:21) cron2: we actually did a 2.2.x release since then, for something=
 truly serious (which I can't remember)
(23:17:27) mattock: so if we use the same policy, we might not need to supp=
ort mbedtls 2.x in OpenVPN 2.3
(23:17:38) mattock: cron2: yeah, but that was just a source release
(23:17:43) cron2: right
(23:17:47) syzzer: ok, let's stick at 1.3 for now then
(23:17:59) mattock: so "if you silly persons are still using 2.2 here is a =
fix you can use"
(23:18:47) mattock: so mbedtls 2.x for "master" before 2.4 release + try to=
 avoid mbedtls 2.x for "release/2.3"
(23:18:55) mattock: another good reason to push out 2.4 finally
(23:18:57) cron2: yep
(23:18:58) syzzer: yep
(23:19:01) cron2: yep
(23:19:06) mattock: yep?
(23:19:07) mattock: :P
(23:19:10) cron2: yep!
(23:19:21) cron2: and now I'm tired :)
(23:19:46) mattock: yeah, 23:19 here, need to hit the sack
(23:19:47) syzzer: me too
(23:20:06) mattock: I'll work on some of my tasks tomorrow
(23:20:24) cron2: so do I - good night
(23:20:51) syzzer: good night!
(23:25:40) mattock: good night!
(23:25:43) mattock: sending the summary real soon

--Multipart=_Mon__23_Nov_2015_23_28_45_+0200_GGWoG5FDUSYp4eHF--

