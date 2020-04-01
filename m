From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <f9786676-a7ad-8b0d-708a-ff724d27376c@...515...>
Message-ID: <c09f8c5e-4156-394c-c2f2-011b43371276@...515...>
Date: Wed, 1 Apr 2020 16:33:27 +0300
MIME-Version: 1.0
In-Reply-To: <f9786676-a7ad-8b0d-708a-ff724d27376c@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="SqYlXGcQBFaKNL5ffv028WS2Fwfvn78IF"
Subject: [Openvpn-devel] Summary of the community meeting (1st April 2020)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SqYlXGcQBFaKNL5ffv028WS2Fwfvn78IF
Content-Type: multipart/mixed; boundary="laPnDphWN2yIxons7OxMZnc04GVypGau3"

--laPnDphWN2yIxons7OxMZnc04GVypGau3
Content-Type: multipart/mixed;
 boundary="------------EE67FBF6E2961F1DECB00928"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------EE67FBF6E2961F1DECB00928
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Wed 1st April 2020
Time: 11:30 CEST (9:30 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2020-04-01>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, dazo, lev, mattock and plaisthos participated in this meeting.

---

Talked about issues in the current OpenVPN 2.x development model. It was
agreed that large patch series on the mailing list can be quite
problematic, in particular when review takes too much time and the
patches no longer apply cleanly to latest "master".

Nobody seemed to be opposed reviewing such large patchsets in an
external Git branch and, as the final step, rebasing the branch against
master and sending the emails to the mailing list for a formal ACK. This
way the ACK process would not be as likely to take too long to cause issues.

It was also noted that there is no technical substitute for spending
enough time on patch review, though we could always make use of more
automation for testing and merging.

Also noted that despite some disagreement on how to speed up our
development process the OpenVPN 2.5 release is moving forward nicely due
to the work put into it by the core developers.

Noticed that the Windows buildslave does not work for OpenVPN 2.4
builds. This should be fixed (by mattock).

---

Full chatlog attached

--------------EE67FBF6E2961F1DECB00928
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2020-04-01.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2020-04-01.txt"

(12:25:33) cron2: hurr, no agenda page
(12:30:13) dazo: From last week: <mattock> the topic pages is not there, =
will need to create it soonish
(12:30:14) dazo: :-P
(12:30:27) dazo: soonish wasn't soon enough :-P
(12:30:58) dazo: mattock: do we still need CF to mangle the URLs?
(12:31:13) mattock: hello
(12:31:28) mattock: oh yes
(12:31:29) mattock: well
(12:31:48) mattock: I copy-and-paste a topic page during the meeting
(12:31:57) mattock: you guys start talking :P
(12:32:14) dazo: butbutbut we don't what to talk about! :-P
(12:32:22) dazo: don't *know
(12:32:23) mattock: we do, 2.5 :D
(12:32:39) cron2: plus "commit/review rules"
(12:32:49) dazo: :)
(12:34:27) dazo: so ... commit/review stuff?
(12:34:30) mattock: ok now you can start: https://community.openvpn.net/o=
penvpn/wiki/Topics-2020-04-01
(12:35:33) cron2: dazo: basically, a continuation of the discussion on th=
e ML
(12:36:15) cron2: what are the rules that govern the mailing list / ACK /=
 merge process
(12:36:28) cron2: (and how can we speed it up without compromising transp=
arency)
(12:36:58) cron2: "we have a patch on the list", "i review a patch somewh=
ere else, which might or might not the same patch", "ACK on the list", "m=
erge of something else?" is certainly not the best approach
(12:37:05) dazo: Background: The challenge we currently have is that we d=
o have a bit of stuff for review which exists in git repos (mostly by act=
ive core community devs) .... and the submit patchset to mailing list, wa=
tch it age and get behind master, rinse and repeat 1-2 times ... it gets =
a bit annoying when reviewing and committing acked patches
(12:37:49) cron2: I have no issue with you working in private to get a pa=
tch set into a good shape, then one dev sends it to the list, and we get =
an ACK from the colleague *on the patches on the list*
(12:37:54) cron2: this is perfectly fine
(12:38:14) cron2: but "sending the ACK for a patch which is not what was =
reviewed" is not
(12:38:34) dazo: Agreed ... and we should build on that
(12:39:00) cron2: (not only "perfectly fine" but for larger patch set may=
be the only way to get the time delay and merge conflicts handled better)=

(12:39:33) cron2: OTOH, this won't really help with lingering patch sets =
that cannot find an interested reviewer - if we do not post, we don't eve=
n *know* that review is needed...
(12:40:00) dazo: So I do suggest that we make more active use of the the =
merge-request git feature, which depends on stuff being pushed to a publi=
c git repo ... but a URL to the repo is added to a cover-mail generated b=
y the git command line.
(12:40:22) dazo: Btw ... this is NOT for single patches
(12:40:31) dazo: this is useful for patch series
(12:40:37) cron2: Mmmh, not sure why this is an improvement
(12:41:04) cron2: if you are convinced that plaisthos' patch set is fine =
(for example), plaisthos can send-email, you can ACK on the list, I can m=
erge
(12:41:34) cron2: full transparency, without having to rely on the contin=
ous existence of some other git repo which might go away
(12:41:46) dazo: My idea, which is not completely figured out yet, is to =
make more use of merge requests and that we do 'git merge' from external =
repos, while keeping the review history
(12:41:57) dazo: which will ease the review and commit process
(12:42:42) dazo: review process knows where to fetch stuff from a git rep=
o, reviewer can document "I've reviewed these commit refs from this git r=
epo" ... committer can fetch the git repo, verify the commit refs and mer=
ge
(12:43:34) dazo: In this case, we will use a git merge commit ... where t=
he committer adds the proper mail-archive discussions (documentation of r=
eviews and acks) ... and this is easily viewable within in the git histoy=

(12:43:39) dazo: *history
(12:43:58) cron2: this does not really sound like "it would be less work =
for me", but let's spell this out in more detail
(12:46:08) dazo: In stead of the 'git ack-am' step X number of rounds on =
patch sets, you do a single 'git fetch $GITREPO', git log (I can provide =
a simple "git alias" which shows commit refs and subject on a single line=
 per commit) to verify git hashes ... and the just do 'git merge -s $remo=
te_branch' ... and done
(12:46:37) cron2: yes, and then I have 10+ patches merged in one go, one =
of them breaks building something... and then I go bisecting
(12:47:03) cron2: plus, I have the work of summarizing the mailing list d=
iscussion in the merge commit
(12:48:53) dazo: That's the thing ... if something breaks, you kick it ba=
ck and say "this doesn't work" ... and the contributor must fix it, you s=
houldn't need wasting time on bisect and the why part
(12:48:56) dazo: I would typically create a new branch from latest master=
, merge remote branch into that, build test ... if it succeeds, git check=
out master ; git rebase testbranch
(12:49:10) dazo: We can script that that summary
(12:49:47) lev_ [~lev@...2550...] =C3=A8 entrato nella stanza.
(12:49:54) cron2: right now, we have a patch granularity that says "each =
individual patch must be testable and not break anything".  This is impor=
tant for future bisects, so it MUST be tested patch-by-patch.
(12:50:17) dazo: If the git merge is used with the proper arguments, it w=
ill point at the external repo/branch by default .... and we can copy pas=
te the output of a script which has everything needed for the documentati=
on
(12:50:23) cron2: and this is why we have patch series that have 5 ACKs a=
nd 1 NAK...
(12:50:40) cron2: I do not think this approach will bring benefits to the=
 merging process
(12:51:04) dazo: And that's reasonable to test commit by commit.  But tha=
t is something our build infrastructure should do ... not us manually
(12:51:55) cron2: our build infrastructure is far away from full coverage=
 of openvpn features.  If we had full coverage, and a build infra that wo=
uld excercise this, in finite time, I'd agree
(12:52:06) dazo: for the git merge commit message ... I'm pretty sure tha=
t can be pre-generated by a script too, and just fed into the git merge c=
ommand
(12:52:27) cron2: so if a patch set modifies "feature A" and this is not =
tested by existing t_client/t_server tests, breakage will not be noticed =
by the buildbots
(12:52:54) cron2: but phrase it differently: *merge* effort is not our pr=
oblem today.  "Timely review is".
(12:53:24) cron2: If you give me 20+ patch sets, all ACKed, every second =
day, I reconsider that statement :-)
(12:54:02) dazo: But "timely review" is also tricky when git master moves=
 forward and patches fall behind.  And larger patch series do fall behind=
 more often, because it needs to be rebased to be easily testable by revi=
ewers
(12:54:40) cron2: do the review all you want on a separate git tree, then=
 one developer submits, the reviewer ACKs on the list.
(12:55:21) mattock: so ML patches are "for the record" basically
(12:55:23) dazo: All right ... if you're fine with status quo ... I'm not=
 going to push further
(12:56:38) cron2: dazo: I'm fine with status quo on that part.  So let's =
change the other part which I can fully see why you're all unhappy with.
(12:57:46) dazo: Currently, pulling patches from patchwork or mailing lis=
ts on larger patch sets are painful for review process, because it often =
lingers behind the target branch
(12:58:14) dazo: and it is painful for developers needing to regularly re=
send patches to ML, cluttering patchwork and ML, just to fall behind regu=
larly
(12:58:34) cron2: 11:54 < cron2> do the review all you want on a separate=
 git tree, then one developer submits, the reviewer ACKs on the list.
(12:59:02) cron2: if the mailing list post happens when the review is don=
e, the ACK can be sent right afterwards, and no need for resending, fall =
behind, ...
(12:59:17) dazo: But how do we properly document that "I reviewed these c=
ommits from this remote branch, rebased on master but not currently on ML=
"?
(12:59:27) cron2: not at all
(12:59:36) dazo: and that's where it halts
(12:59:40) cron2: you meet up with plaisthos to do a development session
(12:59:49) cron2: you two agree that "what is in git tree X" is good
(12:59:52) cron2: plaisthos submits to the list
(12:59:58) cron2: dazo ACKs on the list
(13:00:01) cron2: cron2 merges from the list
(13:00:21) cron2: nobody needs or wants to know "I reviewed these commits=
 in this secret repo"
(13:01:11) dazo: And that's the crux of it ... the git pull-request cover=
-mail unreveals "this secret repo" ... and by identifying "these commit r=
efs from this repo was reviewed", then you have the proper documentation
(13:01:21) cron2: no
(13:01:30) cron2: it is irrelevant where this came from
(13:01:50) cron2: it is relevant that "this patch, which is in the open, =
and will stay there forever because publically archived" has an ACK
(13:02:33) dazo: But the patch from that pull-request cover-mail will als=
o be there on the list already ...=20
(13:02:54) dazo: it is just that the rebase against target branch was don=
e in between
(13:04:35) cron2: I do not understand what you are trying to achieve.  Th=
e process I suggested solves the wish to do a review on a private branch =
beforehand, and we still get the public archive of the patch plus the pub=
lic ACK.
(13:04:44) cron2: Is the "I need to send mail for each patch" too much ef=
fort?
(13:06:55) dazo: When you have completed review, testing and everything i=
s good ... then getting the developer to resend all rebased patches and t=
hen send individual acks ... yes, that is a bit tedious - because if the =
reviewer then starts doing something else in between, git master moves fo=
rward again and patches does not apply ... yes, that is getting annoying
(13:07:59) cron2: if a developer cannot be bothered to run a "git send-em=
ail" after you tell him "yes, this is all good, please send it and I'll A=
CK it right away" - this sounds like a fixable human problem, no?
(13:08:19) cron2: of course this needs to be closely coordinated
(13:08:27) lev_ ha abbandonato la stanza (quit: Ping timeout: 258 seconds=
).
(13:08:37) dazo: Yes ... and then you have sf.net mailing lists which som=
etimes takes hours to deliver mails
(13:08:37) cron2: but a merge request based on a large branch that is not=
 rebased and might actually have conflicts on rebase isn't going to fix t=
hat either
(13:10:10) dazo: And that's the fine detail ... often 'git merge' will be=
 able to sort out some of those trivial merge conflicts on-the-fly, as th=
e source branch doesn't necessarily always need to be based on top of the=
 latest target branch  (if there are massive changes, it will conflict of=
 course, but trivial offsets are often resolved automaticall)
(13:10:34) cron2: and sometimes it will make mistakes and produce code th=
at is broken
(13:10:40) cron2: do we want to rely on that?
(13:11:23) dazo: master is a development branch ... not stable branch.  Y=
es, master will be broken from time to time
(13:11:34) dazo: it also has been broken from time to time
(13:12:24) cron2: we (at least I) have taken great care to ensure that co=
mmits, and each *individual* commit, do not break basic functionality and=
 compilation across all platforms
(13:12:40) cron2: I've failed on the last part sometimes
(13:13:02) cron2: but I still think that this is the goal to strive for, =
not "just lump in things, and sort it out eventually when we think it's t=
ime to fork a stable branch"
(13:13:51) dazo: And this should not be needed to be done manually.  That=
 should be automated.  Because that also takes away your valuable time as=
 well
(13:13:56) lev_ [~lev@...2550...] =C3=A8 entrato nella stanza.
(13:14:29) cron2: dazo: you're welcome to improve our testing infrastruct=
ure... the work on that has been mostly done by mattock and me so far
(13:14:45) cron2: and it is not easy work
(13:15:31) cron2: but if you think that we can cover this all by testing,=
 then let's just do away with the review/ACK thing, and let "core devs" j=
ust push to master
(13:15:57) plaisthos: sorry for missing the meeting :(
(13:16:13) mattock: you still have 14 minutes for chiming in :D
(13:16:19) cron2: plaisthos: hey :-) - you just arrived in time to chime =
in with a third opinion
(13:16:19) plaisthos: somehow the meeting is no longer in the calendar fo=
r core team at @openvpn
(13:18:27) plaisthos: I think patches on the mailinglist should be review=
ed is the right thing
(13:18:47) plaisthos: but some of my patches linger too long on the maili=
ng list, so they get out of date
(13:19:14) plaisthos: I do periodically rebase them in my own repo
(13:19:53) plaisthos: and if someone wants to really review that can also=
 start from the private repo, then I can resend that version as patch mai=
l to the mailing list
(13:19:57) dazo: First of all we need to see what the current buildbot do=
es not do correctly, according to your standards, cron2 ... then we look =
at what buildbot can be learnt to do, to get closer to those goals.  And =
that will mean that before a git merge operation, we do a buildbot *befor=
e* the merge hits the target branch
(13:22:35) mattock: target branch being "master" or a feature branch?
(13:22:36) cron2: dazo: buildbot can just not cover all of our code base =
in finite time, because there's too many options and combinations of opti=
ons.  We do add test cases when we notice regressions, but for "new code"=
, there might not be a case that excercises the particular code paths aff=
ected
(13:23:11) dazo: "because there's too many options and combinations of op=
tions" .... I don't buy that argument.  Do you have the time and ability =
to test those combinations manually?
(13:23:32) plaisthos: no we don't really have that either
(13:23:46) cron2: if I see a patch affecting, say, "--show-tls-ciphers" t=
hen I will do a build with openssl 1.0, 1.1, mbedtls and see that the res=
ult matches - yes
(13:23:55) plaisthos: but with manually you are most times better at educ=
ated guesses and testing the right combinations for a specifi patch
(13:24:39) cron2: or with the IV_NCP patch - play with options on the cli=
ent side, and see how the results on the server change.  This is not only=
 "will it connect and ping" but also "will the negotiated cipher be what =
I expect to see?"
(13:24:53) dazo: that means that we should extend buildbot to test more o=
penssl versions (and we kinda do that already, as we test a broader range=
 of distros of different versions) ... and we do test mbedtls builds
(13:25:19) cron2: we do, but we do not test "does the output of --show-tl=
s-ciphers look like we expect it to be?"
(13:25:27) cron2: (to give a somewhat trivial example)
(13:26:08) dazo: cron2 you are actually pulling QA tasks into the commit =
task ... and that is just wrong.  QA normally happens afterwards
(13:26:50) cron2: QA happens between "developer says this is good" and "r=
eleased to the public"
(13:26:58) cron2: and this right at review/ACK/merge time
(13:27:00) plaisthos: dazo: depends on your development model
(13:27:00) cron2: today
(13:29:13) dazo: Fair enough, that is development model related.  I still=
 think it is better to ease the whole process from a patch set submission=
 into actually hitting the git tree as fast as possible with as little ef=
forts as possible while maintaining a reasonable review process.  And the=
n a QA step takes care of ensuring we don't regress.  Whether that happen=
s before target branch merge or after, is less important
(13:29:48) dazo: Which is why I'm trying to look at other ways we can do =
things
(13:29:51) cron2: I suggested a process that will help with the usual sus=
pects :-)
(13:30:12) cron2: *without* endangering our existing (very high) standard=
s
(13:30:29) dazo: =3D=3D status quo
(13:30:55) cron2: status quo for the "merge, push to public repo" part, b=
ut improving on the "review of outdated patches on the ML" side
(13:32:43) plaisthos: I think the discussion is not going anyway
(13:32:50) plaisthos: we need to spend more time on openvpn2
(13:32:56) plaisthos: then things will improve
(13:33:33) plaisthos: chaging the way we do things to fix things is only =
trying to cure the symptons and not the problem of not enough time invest=
ed in openvpn2
(13:36:00) cron2: which would actually start with having more paid develo=
pers show up to the meeting :-(
(13:36:03) lev_ ha abbandonato la stanza (quit: Ping timeout: 256 seconds=
).
(13:36:19) dazo: but when overall process feels a bit tedious and slow mo=
ving, it isn't also that motivating to start spending time on that compar=
ed to the boatload of other tasks which will be resolved much quicker.  I=
'm not saying openvpn2 is unimportant, it is just that submitting patches=
 and getting them reviewed is more painful than it should be.
(13:37:02) plaisthos: dazo: openvpn3 would be the same if we weren't forc=
ing ourselves to reviews
(13:39:15) dazo: true ... but also consider that there we have the 2 ACK =
rule .... in openvpn2 1 ACK is enough ... and I mostly do openvpn3 review=
s using git command line there too.  Yes, it is also related to time spen=
d on it.  But the overall process is smooth and easy.
(13:39:51) lev_ [~lev@...2550...] =C3=A8 entrato nella stanza.
(13:40:00) cron2: if each of the paid developers would actually *spend* h=
alf a day on reviews, we would be down to very few patches in our queue i=
n a few weeks
(13:40:35) cron2: I've heard promises about time dedicated to openvpn2 ag=
ain and again, but the outcome is not very consistent
(13:41:06) cron2: if nobody reviews, patches get stale, and then we get c=
omplaints that "reviewing stale patches is cumbersome" - yes
(13:41:14) dazo: perhaps that aligns with the review process being tediou=
s?
(13:42:01) cron2: dazo: you're the boss.  If you say "you go review for 4=
 hours now", the tediousness of the process might make a difference on wh=
ether 1 or 5 patches can be reviewed.  But "people do not spend time on r=
eviews at all" is something you can directly influence.
(13:43:12) plaisthos: dazo: is that that tedious?
(13:44:29) plaisthos: you can download the patches/patchset from pathwork=
 or just copy&paste the mail into git am
(13:44:36) dazo: To dig up patches on a mailing list, fetch them one-by-o=
ne, review and compile test ... when you do that 10 times in a single pat=
ch set and they don't apply because the target branch has moved forward .=
=2E. yes, it is
(13:44:39) plaisthos: and then work with your local git tools
(13:44:40) cron2: there is a patchwork git module to apply a patchwork pa=
tch
(13:45:13) cron2: so the "download, apply" can be really helped by patchw=
ork
(13:45:25) plaisthos: and for patchsets that come from other core openvpn=
 developers there is often a copy of that patch in a private git
(13:45:42) dazo: but you still need to dig up which "patchwork patch ID" =
to pull down
(13:45:46) dazo: for each commit
(13:46:40) dazo: instead of just do:  git fetch $REMOTE ; git log / git s=
how for the review ... git merge into a master branch copy and test ... a=
nd even run some scripts to test commit by commit builds
(13:47:44) dazo: I'm often spending more time *finding* and *fetching* si=
ngle commits than reviewing many of commits
(13:48:03) cron2: patchwork overview page has the commit IDs
(13:48:16) dazo: which you need to dig up, one-by-one
(13:48:26) cron2: basically, there's two scenarios here
(13:48:32) cron2:  - large patch set from a core developer
(13:48:42) cron2: - random ML patch from a "non-regular" developer
(13:49:02) dazo: For single commits ... our current approach is fine ....=
 for larger patch sets it gets tedious
(13:49:16) cron2: for the first patch set, I still do not understand why =
you can't do the proposed process, which is really what you want ("review=
 in someone's git tree"), and then send-mail + ACK on the list
(13:49:38) dazo: I did that ... and you complained the patch didn't apply=

(13:49:39) cron2: even if sf.net takes 4 hours, our development velocity =
is not so high that this will cause conflicts in the normal case
(13:49:49) cron2: dazo: yes, because you did not follow this process
(13:50:09) cron2: the "send to list and ACK" needs to come *after* review=

(13:50:10) lev_ ha abbandonato la stanza (quit: Quit: leaving).
(13:50:12) dazo: But in those hours, I've started doing something else ..=
=2E and those Acked-by mails are forgotten
(13:50:26) cron2: not "look at patch, review something else, ACK another =
something else and expect me to sort this out"
(13:50:38) cron2: can we please get a secretary for dazo?
(13:51:18) dazo: if that's easier than to consider alternatives to our pr=
ocess, feel free
(13:51:18) plaisthos: I think this case was more of a misunderstand than =
anything else
(13:52:17) plaisthos: current patch !=3D latest patch on the mailing list=

(13:52:27) cron2: dazo: well, you ACKed something, in public, that was no=
t what you reviewed.  This is problematic.  So the order needs to be diff=
erent - review, then send to list, then ACK - and if people send often en=
ough (which is expected from core devs) sf.net is actually quite fast
(13:52:41) lev__ ha abbandonato la stanza (quit: Killed (barjavel.freenod=
e.net (Nickname regained by services))).
(13:52:41) cron2: I received a copy of the mail I just sent in about 90 s=
econds
(13:52:49) lev___ [~lev__@...2551...:b0c0:2:d0::20a:7001] =C3=A8 entrato nella =
stanza.
(13:52:52) dazo: It *was* the same (I verified that) ... it just didn't a=
pply to git master which was newer
(13:53:07) cron2: but you must review a branch that *is* based on current=
 master
(13:53:08) plaisthos: I also got my tls-groups patch set after 10 minutes=

(13:53:24) mattock: I need to split soon and we're 23 minutes overtime
(13:53:28) cron2: you can't review patches based on just about any random=
 branch, because that will cause merge risks
(13:54:37) cron2: (well, you can, of course, for initial feedback, but fo=
r "send to list and ACK", this must be master)
(13:55:17) lev___ ha abbandonato la stanza (quit: Changing host).
(13:55:17) lev___ [~lev__@...1423.../corp/lev] =C3=A8 entrato nella stanza.
(13:55:17) lev___ =C3=A8 ora conosciuto come lev__
(13:55:32) mattock: ok, so
(13:55:40) dazo: Which is why I suggested using an improved process using=
 git merge from external git repos ... to help reducing the review and co=
mmit process efforts and make that more streamlined and simpler; at least=
 when the source of the git repos are from trusted developers
(13:56:39) plaisthos: Well you can still the review on the external repo
(13:56:39) cron2: nothing wrong with that - when you're done with the rev=
iew (*and* the patch set is based on master), send to list, send ACKs to =
list.  We'll find a secretary to remind you to do the ACKing if the devel=
oper wonders where the ACK is.
(13:57:09) cron2: especially in the context here, the developer will know=
 who did the review and poke the reviewer for the ACKs
(13:57:10) mattock: I need to split, but I hope you can agree to the two =
above comments :)
(13:57:13) mattock: three
(13:57:18) mattock: need to take $child out
(13:57:23) plaisthos: and if it is one of our core member I think you cou=
ld trust them enough to send a version of that patchset to the mailing so=
 you can ack that excat copy
(13:57:40) dazo: mattock: which 2 comments?
(13:58:26) plaisthos: BUt honestly it is mostly me and lev reviewing patc=
hes on the mailing list
(13:58:54) mattock: dazo: review in external branch is fine -> make sure =
external branch is rebased on "master" -> send to ml -> formal ACK -> mer=
ge
(13:58:56) cron2: right (and I'm happy about you two really getting stuff=
 done)
(13:59:21) mattock: anyways, bb in half an hour if you guys are still deb=
ating this (I sure hope not)
(13:59:33) ***cron2 needs to eat, as $wife has music lesson in 15 minutes=

(13:59:44) dazo: plaisthos: what I suggested initially was to do remote r=
epo review, which was triggered based on a git pull-request cover mail (i=
ncluding patches) ... reviewer then replies to that cover-mail enlisting =
commit refs and an statement of ACKing those commits ... then committer j=
ust do a "git merge" from that remote repo, based on verifying the commit=
 IDs matches
(14:01:21) dazo: If there would be remarks to the commits, needing improv=
ements ... that would happen on the patch mail directly as today
(14:07:03) plaisthos: I am sorry but I don't really the get problem you a=
re having.=20
(14:07:52) plaisthos: my process is:
(14:08:21) plaisthos: git checkout -b branch review/something -> click on=
 email -> CMD+U to show shource -> CMD+A CMD+C -> git am -> CMD+V=20
(14:08:27) plaisthos: that takes about 10s per patch
(14:08:51) plaisthos: and that is very small time compared to what actual=
ly reviewing the process takes
(14:09:38) lev__: or you can click on "mbox" button in patchwork and then=
 "git am < xxx.patch" on downloaded file
(14:10:45) dazo: that works fine *when* the patch applies on top of the c=
urrent public target branch
(14:11:07) plaisthos: if it doesn't, send email/private message and ask t=
o rebase
(14:11:18) plaisthos: the patches need to be applied on master anyway
(14:11:49) dazo: and if it doesn't a new patch thread needs to be submitt=
ed ... in the mean time I've started doing something else, and next time =
I do the review git target branch may have moved again, and the circle is=
 complete without having accomplished anything
(14:12:39) dazo: and since sf.net mailing list is quite slow ... that add=
s additional latencies, while a git push somewhere just eases the whole p=
rocess and does not require re-sending patches to the ML
(14:13:11) dazo: (when the rebasing is just a rebase against master - not=
 modifying patches, that is)
(14:13:32) plaisthos: dazo: but what is the alternative?
(14:14:15) plaisthos: if the patch does not apply to master, do you want =
to review an  old version that gets then updated to work on master and th=
en review it again?
(14:14:28) lev__: I personally don't see a problem here, I can count by f=
ingers cases when patch doesn't appy on master, if it doesn't -> notify s=
ubmitter and review another one
(14:15:17) plaisthos: and also git am --3way is often clever to get it ap=
plied to master anyway
(14:15:29) dazo: And you don't think our current process is contributing =
to (not being the main cause) patch review happen slower on the ML?
(14:15:55) plaisthos: dazo: I personally do not feel the burden of the pr=
ocess
(14:16:04) plaisthos: for me the main burden is the actual review
(14:16:37) plaisthos: and patches that are in the kind of okay not really=
 zone where I am not sure if we want to pull them in or not
(14:18:22) dazo: And my burden is that when I set aside time for review .=
=2E. many of the patches don't apply properly so I can't test it properly=
 ... so I give that feedback, asking for rebased patches and go working o=
n something else in the mean time.  Sometimes it takes a considerable amo=
unt of time before the updated patches hits the ML, and then I might be d=
eep into something else resulting in the patch review getting even more d=
elayed
(14:18:49) plaisthos: that is a symptom currently
(14:19:03) plaisthos: we wait so long for patches to review them that the=
y don't apply anymore
(14:19:20) plaisthos: quicker turnaround time on patch review would fix t=
hat problem
(14:19:32) dazo: So how do we fix that?
(14:19:52) dazo: We have a long enough backlog on the ML already
(14:22:32) plaisthos: spend more time on patches and go through the annoy=
ing process of rebasing ourselves while we get rid of the backlog
(14:23:18) plaisthos: yes having the prs in github would allow you to see=
 it easier if they need to be rebased or not=20
(14:23:48) dazo: So ... basically set aside 100% time for 3-4 days where =
we all have a virtual hackathon or something like that?  Because if we do=
n't really isolate ourselves for doing that, nothing will happen
(14:25:22) dazo: Doesn't need to be 3-4 days in the same week ... but I t=
hink it needs to be more than just "we'll meet on IRC" ... because that r=
eally hasn't worked well for the "friday mini-hackathons"
(14:27:03) dazo: On the other hand, if there are too long time in between=
 ... git branches may move forward in between
(14:28:38) plaisthos: dazo: the list of patches is actually not that bad.=
=20
(14:30:12) dazo: Tbh ... I've lost overview, my openvpn-devel inbox is fi=
lled with larger patch-sets, some needing review, some acked and applied
(14:30:47) plaisthos: dazo: use patchwork.openpvn.net as overview
(14:33:31) cron2: we're at 105 patches, of which the oldest 50 are in the=
 "do we really want that? someone needs to make a decision (feature-ack/n=
ak) and then restart them" zone
(14:33:41) cron2: top 30 should apply to git master perfectly
(14:33:49) cron2: most of them touch unrelated files
(14:34:14) plaisthos: and a 1/3 of the patches have me or ordex as author=

(14:34:29) plaisthos: more 1/2 of them actually
(14:34:33) cron2: since I got most of Simon's out of the way, yes :-)
(14:35:38) cron2: which reminds me to actually set #1035 to accepted.  Do=
ne.
(14:36:21) plaisthos: I don't do that normally because I like to have the=
m show up in the overview until they are actually commited
(14:36:54) cron2: it is
(14:36:59) cron2: just
(14:37:03) plaisthos: ah then, nothing to see here
(14:37:05) plaisthos: move on
(14:37:33) cron2: my workflow is "merge, test (if relevant, like 'windows=
 building'), send to list, wait for that to show up, then close patchwork=
"
(14:37:49) cron2: and push in between "send to list" and "close patchwork=
"
(14:40:53) plaisthos: I only set accepted on old patches that I know have=
 been merged but somehow didn't update because of old version etc
(14:41:12) mattock: back
(14:41:35) plaisthos: legs
(14:41:49) cron2: sf.net on the "merged!" mail turnaround time was 12 sec=
onds
(14:42:46) plaisthos: I also have two new acks for you :P
(14:42:54) cron2: working on whg already
(14:47:07) cron2: oh, the mbedtls patch
(14:47:08) cron2: nice
(14:47:26) cron2: (I can review network and os related stuff, but these c=
rypto api intricacies really escape me)
(14:50:07) plaisthos: that one was actually easy
(14:50:17) cron2: plaisthos: is this relevant for 2.4?  it seems to be
(14:50:21) plaisthos: yes it is=20
(14:50:54) plaisthos: not sure if it applies
(14:50:59) cron2: let me ssee
(14:52:17) plaisthos: now let's reimplement generating tls-crypt v2 keys =
for AS, yay
(14:53:15) cron2: it needs a bit massaging becaues the context has ekm in=
 master
(14:56:25) mattock: I will summarize this somehow soon
(14:57:38) cron2: that is easy
(14:57:51) cron2: "dazo is full of exciting ideas, and cron is the stubbo=
rn old man, as usual, blocking all progress"
(14:58:27) dazo: :-D
(14:58:28) cron2: mattock: your windows buildbot explodes in 2.4
(14:58:48) cron2: Buildslave for this Build: slave-builder
(14:58:51) cron2: BUILD FAILED: failed shell_3 shell_7 shell_8 shell_9
(14:59:05) cron2: FATAL: Cannot download https://www.openssl.org/source/o=
penssl-1.1.0l.tar.gz
(15:01:13) plaisthos: yeah
(15:01:18) plaisthos: the old versions are no longer supported
(15:02:18) plaisthos: I can send a patch to fix that
(15:03:10) cron2: not sure what is feeding this buildslave, "naked openvp=
n-build" or "some local config"
(15:03:13) cron2: mattock: ?
(15:05:50) mattock: yeah, it very well might
(15:05:54) mattock: explode
(15:05:59) plaisthos: hmpf
(15:06:08) plaisthos: shell =3D> how to get from 1.1.1e to 1.1.1
(15:06:09) mattock: I don't think it was never intended to work on anythi=
ng besides Git master
(15:07:18) mattock: I can check if fixing that would be trivial, but I do=
ubt it
(15:07:19) cron2: please make it work on 2.4 :-) - we want to know that 2=
=2E4 is good on master, before trying a release and then noticing at "bui=
ld official installers" time
(15:10:22) plaisthos: cron2: https://github.com/schwabe/openvpn/commit/5f=
a752b445c64fc9bdf001545f50918eac5e8fb8
(15:10:23) vpnHelper: Title: Fetch OpenSSL versions via source/old links =
=C2=B7 schwabe/openvpn@...2552... =C2=B7 GitHub (at github.com)
(15:10:43) plaisthos: If this fixes travis, I wills send a patch to the m=
l
(15:11:05) cron2: I did not notice travis, I only noted buildbot
(15:11:22) plaisthos: how does buildbot build?
(15:11:34) cron2: mattock knows :)
(15:11:40) cron2: where can I see if travis died?
(15:11:40) plaisthos: what script does it execute
(15:12:14) plaisthos: https://travis-ci.org/github/OpenVPN/openvpn
(15:12:15) vpnHelper: Title: Travis CI - Test and Deploy Your Code with C=
onfidence (at travis-ci.org)
(15:12:20) plaisthos: I am getting mails when it fails
(15:12:37) cron2: I get mails for master, but not 2.4, it seems
(15:12:51) plaisthos: anyway. I am fixing travis :P
(15:13:37) cron2: do we want to fix by pulling openssl from old locations=
, or do we want to fix by upgrading openssl?
(15:13:57) plaisthos: cron2: that would mean dropping all builds but open=
ssl 1.1.1
(15:14:28) cron2: mmmh, ok.  2.4 is supposed to stay compatible
(15:14:55) plaisthos: yes
(15:15:13) plaisthos: and we still distros that patch/support older opens=
sl version
(15:15:21) plaisthos: so I would like to still build test them
(15:15:43) plaisthos: and I wrote OPENVPN_VERSION isntead OPENSSL_VERSION=
 in my commit
(15:15:44) plaisthos: damn
(15:15:54) cron2: oopsie

--------------EE67FBF6E2961F1DECB00928--

--laPnDphWN2yIxons7OxMZnc04GVypGau3--

--SqYlXGcQBFaKNL5ffv028WS2Fwfvn78IF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAl6EmCcACgkQKVhNn0CG
RXgezwf/brlZ7CHuZvcGNMWRQkAydhaVtZRTJ1uj+gy9q4umj/zyBfq9Rl8j2eoY
VIyaf9FsYup5/kZ4MdO1OTo5N91F7Ok+XlArfzxo4BLsi0ZxDSYoGUo5lKFKJ9bz
rYEsA0HyXInvqXWRx+dQNLERDhRHNH+qVTqELHaaLSDISUUPPknrGUjCZkBcMIrv
z9pmyd4T6WBnMln82i/hACW2sB6xVLpwRqOJnvCN2Xd4y9GXjoqJ3WQrKKFu3x+P
Gw0uKxjPchQEdhKTM7Z2AgNXldzLia1ub2y0gNp+bBplPR5xvvW4INr/aLcL4Ocf
5LJaea5uTKjvsui+qxaWb4C2On/7wA==
=Wyxv
-----END PGP SIGNATURE-----

--SqYlXGcQBFaKNL5ffv028WS2Fwfvn78IF--

