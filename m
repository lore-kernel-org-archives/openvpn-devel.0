Message-ID: <4DA829E4.3040707@...515...>
Date: Fri, 15 Apr 2011 14:20:04 +0300
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030506080507020506070105"
Subject: [Openvpn-devel] Summary of the IRC meeting (14th Apr 2011)
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
--------------030506080507020506070105
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the previous community meeting.

---

COMMUNITY MEETING

Place: #openvpn-devel on irc.freenode.net
Date: Thursday, 14th Apr 2011
Time: 18:00 UTC

Planned meeting topics for this meeting were on this page:

<https://community.openvpn.net/openvpn/wiki/Topics-2011-04-14>

Next meeting will be announced in advance, but will be on the same
weekday and at the same time. Your local meeting time is easy to check
from services such as

<http://www.timeanddate.com/world clock>

or with

$ date -u


SUMMARY

cron2, dazo, krzee and mattock were present in this meeting.

--

Discussed the status of VLAN tagging patchset (in the feat_vlan_tagging
branch). Lack of test reports has prevented it from being merged into
the main development branches.

--

Discussed value of PRODUCT_TAP_RELDATE in win/settings.in. Agreed that
when it's changed, it's should be set to 24th March 2011, when
PRODUCT_TAP_WIN32_MIN_MINOR (in version.m4) was fixed. Also agreed that
it's probably best not to update PRODUCT_TAP_RELDATE until after 2.2
release: this avoids having to sign the TAP-drivers again due to such a
trivial change.

--

Discussed lack of anchors in the FAQ:

<http://openvpn.net/index.php/open-source/faq.html>

For example, this is broken:

<http://openvpn.net/faq.html#dhcpclientserv>

Mattock will take a look at these.

--

Discussed the "Removed Win2k from supported platforms list in INSTALL
and win/openvpn.nsi" patch:

<http://thread.gmane.org/gmane.network.openvpn.devel/4596>

Dazo gave this patch an ACK with a minor change.

Decided to list supported Windows versions for every release on the
downloads page and to add last Win2k-compliant version (2.1.3) to the
download listing.

--

Discussed the "Fixed copying of tapinstall.exe to dist/bin when using
prebuilt TAP-drivers" patch:

<http://thread.gmane.org/gmane.network.openvpn.devel/4597>

Dazo gave this patch an ACK.

--

Discussed the "Fix a bug in devcon source code handling" patch:

<http://thread.gmane.org/gmane.network.openvpn.devel/4595>

Dazo gave this patch an ACK.

--

Discussed the "Change the default --tmp-dir path to a more suitable
path" patch:

<http://thread.gmane.org/gmane.network.openvpn.devel/4593>

Cron2 gave this patch an ACK after minor modifications.

---

Full chatlog as an attachment

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


--------------030506080507020506070105
Content-Type: text/plain; charset="utf-8";
 name=openvpn_irc_meeting_chatlog_2011-04-14.txt
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="openvpn_irc_meeting_chatlog_2011-04-14.txt"

(21:06:35) mattock: https://community.openvpn.net/openvpn/wiki/Topics-2011-=
04-14
(21:06:37) vpnHelper: Title: Topics-2011-04-14 =EF=BF=BD=EF=BF=BD=EF=BF=BD =
OpenVPN Community (at community.openvpn.net)
(21:06:38) mattock: topic list ^^^
(21:06:51) mattock: is there anything to add to the agenda?
(21:07:23) dazo: --tmp-dir patch
(21:07:37) mattock: can you give a link to the latest version?
(21:08:17) dazo: http://thread.gmane.org/gmane.network.openvpn.devel/4593
(21:08:19) vpnHelper: Title: Gmane Loom (at thread.gmane.org)
(21:09:25) mattock: dazo: is that a standalone patch that applies on top of=
 latest beta2.2 branch?
(21:10:09) mattock: or does it depend on earlier --tmp-dir patches not yet =
in Git?
(21:10:12) dazo: that's a standalone patch, on top of latest beta2.2/master
(21:10:31) dazo: I merged all into one, as it began to be quite unclear
(21:10:46) mattock: ok
(21:10:58) mattock: cron2: are you there?
(21:11:27) mattock: or somebody else who knows the correct value for TAP_RE=
LDATE
(21:12:10) mattock: I think we could take care of this while waiting for Ja=
mes: http://thread.gmane.org/gmane.network.openvpn.devel/4596
(21:12:12) vpnHelper: Title: Gmane Loom (at thread.gmane.org)
(21:13:53) dazo: If nobody says anything about the TAP_RELDATE, I suggest s=
etting it to 2011-03-24, as that's the date when we modified the PRODUCT_TA=
P_WIN32_MIN_MINOR version
(21:15:20) mattock: good idea
(21:16:17) dazo: I can do that when we tag the final release version
(21:17:10) krzee: whats the status of that vlan tagging patch?
(21:17:14) dazo: that's not a change which is critical for review on the ML
(21:17:15) krzee: (out of curiosity)
(21:17:18) mattock: this brings in another point... if we change TAP_RELDAT=
E, the TAP-drivers have to be signed again
(21:17:20) dazo: krzee: nothing has happened there at all
(21:17:29) krzee: ok, thats what i thought
(21:17:31) dazo: mattock: that's correct
(21:18:09) krzee: dazo, does it need testing or it needs re-writing?
(21:18:11) mattock: I would prefer not changing TAP_RELDATE until after 2.2=
 because of that
(21:18:43) dazo: krzee: if there comes up some real testing .... we're read=
y to include it ... however, this depends on the pass-tos feature as well, =
I think this was the culprit=20
(21:18:59) dazo: mattock: is that signing something james needs to do?
(21:19:06) mattock: at the moment yes
(21:19:21) mattock: he was ok with me doing it in the future, but the switc=
h might take some time
(21:20:14) dazo: okay ... well, it's kind of dirty ... however the date fie=
ld it's not, to my knowledge, a critical thing
(21:20:30) mattock: afaik it's only cosmetic
(21:20:54) dazo: mm
(21:21:30) mattock: I mean, I don't think Windows uses that date for anythi=
ng (e.g. versioning)
(21:22:21) dazo: What about tap driver upgrades?  will that do some checks?
(21:22:37) mattock: it shouldn't, but I have not checked
(21:22:57) mattock: hopefully james could shed some light on this
(21:23:45) dazo: agreed
(21:24:06) mattock: dazo: ACK for the Win2k patch?
(21:24:24) ***dazo is looking at those patches now
(21:24:36) mattock: they are pretty trivial to be honest
(21:25:00) krzee: mattock, ever gunna get the anchors fixed on the FAQ?
(21:25:01) dazo: yeah, they are
(21:25:11) krzee: we currently have links in error messages that dont work
(21:25:40) mattock: krzee: I recall discussing that at some point with you.=
.. what link is broken?
(21:25:50) krzee: all of the FAQ's anchors
(21:26:03) mattock: krzee: lemme check
(21:26:21) krzee: look at the error message when people need to add route-m=
ethod exe in windows
(21:26:25) krzee: the DHCP error
(21:26:26) dazo: I'm ACKing the "Remove Win2k support" announcement patch .=
... if I can do one change on-the-fly ... you're saying one place (towards =
the end) "${PRODUCT_NAME} only runs on XP, or higher" ... I would like to s=
ee " only runs on Windows XP or higher"
(21:27:03) mattock: dazo: sounds good
(21:27:12) krzee: at that point, an old windows version should stay on the =
download page
(21:27:20) krzee: "last version that supports win2k"
(21:27:40) mattock: krzee: good idea
(21:28:41) dazo: do we really want to help users not upgrading away from wi=
n2k? ;-)
(21:28:59) mattock: did we decide that 2.1.x would support Win2k? or did su=
pport end with 2.1.4?
(21:29:11) krzee: lol, its hard enough to get them to upgrade past 2.1rc, i=
 surely cant handle telling them to go to xp or higher
(21:29:12) krzee: lol
(21:29:28) dazo: 2.1.3 was the last win2k, I believe
(21:29:37) dazo: 2.1.4 is built with the new DDK, iirc
(21:29:42) mattock: yes, that's true
(21:30:03) mattock: I'll make sure 2.1.3 gets added to the download page "a=
s the last version supporting win2k"
(21:30:07) krzee: that is interesting... in the release of dropping win2k s=
upport please do explain why
(21:30:16) dazo: krzee: I know :)  I just couldn't resist not saying it ;-)
(21:30:23) krzee: =3D]
(21:30:47) dazo: basically, the reason is that newer development tools from=
 Microsoft don't support Win2K
(21:31:10) krzee: i caught that when you said the new DDK
(21:31:34) krzee: but i was curios prior, im sure others will be
(21:31:36) mattock: krzee: another good reason is that Win2k has been EOL f=
or a while... even the extended support ended a while back
(21:31:48) dazo: yupp
(21:31:58) mattock: actually, we asked about win2k support on the openvpn-u=
sers mailing list, and nobody cared
(21:32:12) dazo: but sure, we can add that to the release notes=20
(21:32:18) mattock: one or two guys responded and said "well, I don't reall=
y care even though I got win2k running" :)
(21:32:21) krzee: oh ya i am certainly not saying that i expect some outcry
(21:32:21) dazo: or the announcement
(21:32:47) krzee: i mean, if they run win2k its safe to say they arent look=
ing for the latest openvpn upgrades ;]
(21:33:04) krzee: or the latest * really
(21:34:12) mattock: maybe we should add "Supported Windows platforms: WinXP=
 and higher" or something to the downloads page
(21:34:20) mattock: to make things clear
(21:34:38) dazo: good idea
(21:35:59) mattock: krzee: could tell me where you found the "route-method =
exe / dhcp" thingy you mentioned?
(21:36:03) mattock: I have trouble finding it
(21:36:25) krzee: whenever anyone has an error getting an IP in windows XP,=
 then i say !winroute
(21:36:30) krzee: lemme find it in google
(21:39:26) mattock: there's one potential bug I have to reproduce and fix..=
. namely "4 OpenVPN GUI icons on desktop after upgrade from 2.2-RC to 2.2-R=
C2"
(21:39:49) mattock: I assume same would happen with 2.2-RC2 -> 2.2
(21:40:07) dazo: ugh ... yeah jjk mentioned that as well
(21:40:32) dazo: could it be a NSIS bug? ... or that something goes in a lo=
op in the .nsi script?
(21:41:01) krzee: i ran into that the other day
(21:41:07) krzee: while testing that rc2 worked
(21:41:14) mattock: I'd guess it's got something to do with all users/this =
user variables in Windows
(21:41:22) mattock: the behavior changed between XP and Vista
(21:41:33) dazo: hmm
(21:41:45) mattock: krzee: what Windows version did you use?
(21:41:55) mattock: and how can I reproduce this?
(21:42:17) krzee: xp
(21:42:22) mattock: ok
(21:42:30) krzee: by simply installing RC, then RC2
(21:42:38) krzee: i would have selected all users
(21:43:02) mattock: did you have openvpn installed before 2.2-RC?
(21:43:14) mattock: before installing 2.2-RC I mean
(21:43:41) cron2: oh. missed meeting.  sorry.
(21:43:52) mattock: cron2: there's still time :)
(21:44:44) mattock: dazo: if the OpenVPN GUI icon count goes from 0 to 4 th=
en there's got to be some loop somewhere
(21:44:46) cron2: mattoch, dazo: regarding TAP_RELDATE - iff we want to cha=
nge it, I'm with dazo
(21:45:03) dazo: cron2: as I've committed your patch to the git tree ... it=
 would be good if you could ACK the tmp-dir patch ;-)   http://thread.gmane=
.org/gmane.network.openvpn.devel/4593
(21:45:04) mattock: ok
(21:45:04) vpnHelper: Title: Gmane Loom (at thread.gmane.org)
(21:45:19) cron2: dazo: right now trying to read up on my day's e-mail
(21:45:25) dazo: :)
(21:45:38) dazo: cron2: TAP_RELDATE ... that's just cosmetic, right?
(21:46:21) cron2: I think so
(21:46:34) mattock: dazo, cron2: I can test for that, too
(21:46:49) mattock: change the TAP_RELDATE to something really silly and/or=
 old, and see what happens when upgrading
(21:46:58) raidz [~raidz@...1423.../corp/admin/andrew] =EF=BF=BD=EF=BF=BD e=
ntrato nel canale.
(21:46:58) modalit=EF=BF=BD=EF=BF=BD (+o raidz) da ChanServ
(21:47:37) dazo: sounds good!
(21:47:53) krzee: test TAP_RELDATE for the y2k bug ;]
(21:47:57) krzee: 1900!
(21:48:01) dazo: lol
(21:48:10) mattock: krzee: I'm sure Windows would crash :)
(21:48:29) krzee: windows crashes if you do anything besides pulling the po=
wer cable ;]
(21:48:34) mattock: dazo: any comments on the python patches?
(21:48:59) mattock: I can explain them in more detail if they're not obvious
(21:49:17) cron2: krzee: it also crashes if you pull the power cable
(21:49:18) dazo: they just make sense to me ... commit log match the change=
 ...
(21:49:27) krzee: can we patch the users to accept the answers to their que=
stions?
(21:50:00) mattock: krzee: lol!
(21:50:07) dazo: krzee: however we make that patch, it's always incompatibl=
e :(
(21:50:13) krzee: lol
(21:50:20) mattock: "merge conflict"
(21:50:27) mattock: or whitespace errors
(21:50:51) dazo: probably the latter ... plenty of blank areas
(21:51:30) mattock: maybe a few extra words on my patches to encourage you =
to give an ACK :)=20
(21:51:30) mattock: http://thread.gmane.org/gmane.network.openvpn.devel/4597
(21:51:32) vpnHelper: Title: Gmane Loom (at thread.gmane.org)
(21:52:01) mattock: so, basically, when using prebuilt TAP-drivers make_dis=
t.py did not find tapinstall.exe from build dependencies
(21:52:19) mattock: because it was looking for devcon.exe that building dev=
con sources creates
(21:52:37) dazo: makes sense
(21:52:44) dazo: ACK
(21:52:59) mattock: then this one: http://thread.gmane.org/gmane.network.op=
envpn.devel/4595
(21:53:00) vpnHelper: Title: Gmane Loom (at thread.gmane.org)
(21:53:18) dazo: ACK
(21:53:25) mattock: thanks!
(21:53:48) mattock: cron2: do you want access to the new Win2008 r2 build V=
M?
(21:53:55) dazo: I'll apply them this evening
(21:54:00) ***cron2 doesn't want to touch windows
(21:54:08) mattock: cron2: but do you _need_ to? :P
(21:54:31) cron2: mattock: but seriously - I won't have time to do anything=
 windows-related in the next 3-4 weeks anyway.  Then I might come back :)
(21:54:37) mattock: I fact, building openvpn on Windows is now easier than =
on *NIX
(21:54:47) mattock: (once the one-day build environment setup is done)
(21:55:04) mattock: cd c:\users\username\openvpn-build\openvpn-testing\win
(21:55:18) mattock: python build_all.py -u
(21:56:22) cron2: so how's that easier than "cd openvpn-testing ; make"?
(21:56:44) dazo: touch=EF=BF=BD=EF=BF=BD!
(21:56:51) mattock: flamewar!
(21:56:57) mattock: I was just being sarcastic :)
(21:57:22) dazo: cron2: have you had time to (or when) to look at the rebas=
ing of your IPv6 patches?
(21:57:34) krzee: lol
(21:57:40) cron2: now that's more interesting than windows :)
(21:58:03) cron2: "soon"
(21:58:21) mattock: dazo, cron2: what's the status of jjo's patches?
(21:58:27) mattock: are they up-to-date and all?
(21:58:34) cron2: he wrote mail some weeks ago that he has rebased them alr=
eady
(21:58:42) mattock: oh, neat!
(21:58:47) dazo: jjo's patches are ready, but I haven't had time to look at=
 it yet .... waiting for 2.2 to settle first
(21:59:15) mattock: did --tmp-dir get an ACK already?
(21:59:31) cron2: not yet
(21:59:42) mattock: I think that's the last topic
(22:00:28) cron2: dazo sneaked in cosmetic changes
(22:00:32) cron2: +#endif /* USE_SSL */
(22:01:09) dazo: yeah ... I noticed ... I thought that was harmless though =
... the #ifdef's got a bit confusing=20
(22:01:24) cron2: it is
(22:01:34) dazo: it was quite nested
(22:02:03) cron2: dazo: you still have "char * tmpdir =3D buf" in there...
(22:02:05) cron2: why?
(22:02:13) dazo: duh!
(22:02:13) cron2: ah
(22:02:29) dazo: grrrrr ... I tested the wrong patch
(22:02:31) cron2: the patch has been changed to return NULL now, instead of=
 msg(M_FATAL)
(22:02:44) cron2: in that case, it's ok
(22:03:35) cron2: ACK
(22:03:37) cron2: sent
(22:03:40) dazo: thx!
(22:05:36) dazo: I'll apply this patch + the three from mattock ... anythin=
g else?
(22:05:42) mattock: don't think so
(22:05:50) dazo: I'll try to add those few man page updates which came afte=
r last meeting as well
(22:06:03) mattock: dazo: when the Git tree is updated I'll generate the 2.=
2-preview installer and announce it
(22:06:50) dazo: okay ... then I'll hold of the final tagging until it's ap=
proved
(22:07:30) dazo: mattock: when you create the installer .... please update =
version.m4 to say 2.2-preview in the version string
(22:07:34) dazo: just so we're sure
(22:07:50) mattock: ok, I'll do that
(22:08:21) mattock: any chance on getting the patches to git by tomorrow mo=
rning?
(22:08:35) mattock: or tomorrow in general :)
(22:08:43) dazo: I'm looking at it now ... so in a couple of hours, probably
(22:09:24) krzee: mattock, Initialization Sequence Completed With Errors [s=
ee http://openvpn.net/faq.html# dhcpclientserv ]
(22:09:27) vpnHelper: Title: FAQ Community (at openvpn.net)
(22:09:31) mattock: krzee: ok
(22:09:37) krzee: thats a single example
(22:09:41) krzee: they are ALL broken
(22:11:39) mattock: krzee: I have bad feeling this has to do with the Jooml=
a page layout
(22:11:56) mattock: but I'll check if I could add anchors
(22:12:09) cron2: looking at the .nsi diff...
(22:12:25) cron2: This wizard will guide you through the installation of ${=
PRODUCT_NAME}, an Open Source VPN package by James Yonan.
(22:12:41) mattock: krzee: and where do you find these links?
(22:12:55) mattock: I could perhaps fix the links themselves, instead of ad=
ding anchors
(22:12:58) krzee: i googled
(22:13:00) krzee: "initialization Sequence Completed with errors DHCP openv=
pn"
(22:13:04) krzee: oh the links
(22:13:09) krzee: they are in the code
(22:13:28) krzee: you gunna make the link:   http://openvpn.net/index.php/o=
pen-source/faq/79-client/259-tap-win32-adapter-is-not-coming-up-qinitializa=
tion-sequence-completed-with-errorsq.html
(22:13:31) krzee: in the error?
(22:13:32) krzee: lol
(22:14:00) krzee: personally i think fixing the FAQ would be better ;]
(22:15:21) mattock: krzee: I'll look into this tomorrow
(22:17:51) mattock: mkay, I think the meeting is over now
(22:17:56) mattock: too bad james couldn't make it today
(22:18:30) dazo: I'm pushing out the git tree now ... will look at man page=
 updates now
(22:18:40) dazo: but this is good enough to spin a preview, I'd say
(22:18:40) mattock: I'll write the summary tomorrow as usual
(22:18:45) mattock: dazo: agreed!
(22:18:54) mattock: and thanks for pushing the change to git so quickly! :)
(22:19:16) dazo: you're welcome :)

--------------030506080507020506070105--

