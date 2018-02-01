From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <6a3cabee-e9ea-bea6-cca7-d3f9672f292f@...515...>
Message-ID: <8da7b504-1018-10da-1c2c-e616998c1b3e@...515...>
Date: Thu, 1 Feb 2018 08:44:42 +0200
MIME-Version: 1.0
In-Reply-To: <6a3cabee-e9ea-bea6-cca7-d3f9672f292f@...515...>
Content-Type: multipart/mixed; boundary="------------67EE7AC6712B12D41B963DAD"
Content-Language: en-US
Subject: [Openvpn-devel] Summary of the community meeting (Wed,
 31st Jan 2018)
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
--------------67EE7AC6712B12D41B963DAD
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable



Hi,

Here's the summary of the IRC meeting.
---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Wednesday 31st Jan 2018
Time: 11:30 CET (10:30 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2018-01-31>

The next meeting has not been scheduled yet.

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

chipitsine, cron2, dazo, mattock, ordex and plaisthos participated in
this meeting.

--

Noted that the "mgmt version 2 / pk-sign and 2.4" topic was already
covered on the mailing list and does not need further discussion.

--

Discussed the OpenVPN 2.4.5 release. The release date was set to
Wednesday 7th February. Git tree will be tagged on Tuesday evening.

The "Ensure strings read from registry are null-terminated" patches are
still missing:

<https://patchwork.openvpn.net/project/openvpn2/list/?series=3D59>

The "Allow changing cipher from a ccd file" is also not merged:

<https://patchwork.openvpn.net/patch/92/>

The NSIS fix for OpenSSL 1.1 compatibility was merged during the meeting:

<https://github.com/OpenVPN/openvpn-build/pull/122>

Some OpenVPN-GUI localizations are still pending, but they're not a
blocker for the release.

It was agreed to make OpenSSL 1.1-based Windows NSIS installers the
default, but to have OpenSSL 1.0-based installers available as fallback.

Agreed that we also need to start pushing the MSI installer forward.

--

Discussed the "Update copyright notes" patch:

<https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg16393.=
html>

It was agreed that updating copyrights makes sense, even if only to show
that we're actively working on the files in question.

--

Discussed the "Supported Versions" page on Trac:

<https://community.openvpn.net/openvpn/wiki/SupportedVersions>

The page was improved during the meeting to a point where it was
acceptable to everyone. (It was later linked to from the Trac from page)

--

Agreed that making the OpenVPN 2 release procedures public makes sense,
insofar as possible. Mattock will add that documentation to Trac when he
makes the 2.4.5 release.

---

Full chatlog attached.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock




--------------67EE7AC6712B12D41B963DAD
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2018-01-31.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2018-01-31.txt"

(12:30:00) mattock: meeting time?
(12:31:08) ordex: in 15 secs
(12:31:17) mattock: can't wait that long
(12:31:20) ordex: meh
(12:31:21) ordex: :P
(12:31:43) cron2: meep
(12:31:47) ***dazo is here
(12:31:58) dazo: or at least tries to :-P
(12:32:12) ordex ha scelto come argomento: Agenda at https://community.op=
envpn.net/openvpn/wiki/Topics-2018-01-31
(12:33:16) cron2: dazo: good that you are here
(12:33:34) cron2: shall we start?  syzzer is snowboarding
(12:34:32) mattock: yes
(12:35:39) cron2: topic 2 has been answered by Selva on the list already =
- "our GUI does not care, and if it did, openvpn core would tell the gui =
what version it supports"
(12:36:07) cron2: topic 1 - release next week.  What is convenient for da=
zo and mattock?
(12:36:29) ***dazo looks at his calendar
(12:36:29) cron2: I can get the missing patches in this week, so we can d=
o anything after sunday
(12:38:25) mattock: I don't have anything in particular for next week
(12:38:26) dazo: eek ... next 2 weeks are ugly unpredictable :/ ... But I=
 think I can squeeze in something Thu or Wed
(12:39:41) cron2: so I'll aim for "tagging on tuesday evening"?
(12:39:52) dazo: goodie :)
(12:40:13) cron2: good (we shouldn't actually need you, unless something =
unexpected happens)
(12:40:42) dazo: fair enough ... I actually like that :)
(12:40:43) mattock: sounds good
(12:41:04) mattock: what about the two missing patches from Selva?
(12:41:15) mattock: let's see previous meeting's summary...
(12:41:22) cron2: going back...
(12:42:08) cron2: 195 and 202 are in
(12:42:29) cron2: "series=3D59" isn't -> thanks for the reminder
(12:42:50) cron2: https://patchwork.openvpn.net/patch/92/
(12:42:52) vpnHelper: Title: [v2] Allow changing cipher from a ccd file -=
 Patchwork (at patchwork.openvpn.net)
(12:42:55) cron2: is the other one that should go in
(12:43:19) cron2: so: series=3D59 and /92/ and then we're good to go (as =
far as I'm aware)
(12:43:44) mattock: uh, took a while but here: https://www.mail-archive.c=
om/openvpn-devel@lists.sourceforge.net/msg16344.html
(12:43:45) vpnHelper: Title: [Openvpn-devel] Summary of the community mee=
ting (Wed, 24th Jan 2018) (at www.mail-archive.com)
(12:46:00) mattock: the NSIS fix is still missing one small thing, but it=
 can be done by Tue/Wed
(12:46:04) cron2: cool
(12:46:16) mattock: localizations for openvpn-gui may or may not be ready=
, but that's not a blocker
(12:46:18) chipitsine: which small thing ?
(12:46:20) cron2: so we'll do "traditional .exe with openssl 1.0 and nsis=
 with 1.1"?
(12:46:38) mattock: chipitsine: the *.dll thing in uninstall
(12:47:14) chipitsine: https://github.com/OpenVPN/openvpn-build/pull/122
(12:47:15) vpnHelper: Title: make openvpn.nsi compatible with openssl-1.1=
=2E0 as well by chipitsine =C2=B7 Pull Request #122 =C2=B7 OpenVPN/openvp=
n-build =C2=B7 GitHub (at github.com)
(12:47:50) mattock: ah, good!
(12:48:30) mattock: I'll merge that
(12:49:04) mattock: done
(12:49:06) mattock: thanks!
(12:49:10) ordex: that was fast
(12:49:10) ordex: :)
(12:49:18) mattock: yep
(12:49:36) mattock: cron2: are asking if we should have 1.0.x -based inst=
allers in addition to the new 1.1.x-based ones?
(12:49:38) cron2: cool
(12:49:59) cron2: mattock: more like "asking what you(we) have planned to=
 provide"
(12:50:16) mattock: do we trust openssl 1.1 support in openvpn enough to =
make it the only choice?
(12:50:24) mattock: or should we make it optional for a while?
(12:50:45) mattock: or push out 1.1-based installer, then it fails horrib=
ly, then we backpedal? :P
(12:50:46) dazo: I'd trust 1.1, code wise
(12:51:04) dazo: whether it plays nicely on Windows with OpenVPN ... that=
 I dunno
(12:51:10) cron2: I'd offer 1.0 based .exe installers and 1.1 based .msi =
installers, if that can be done without too much extra work
(12:51:24) mattock: ah, I see
(12:51:34) mattock: we don't have .msi yet
(12:51:39) cron2: so "if all fails, go back to what we know works", and o=
therwise "here's the cool stuff for the future"
(12:51:42) cron2: ah
(12:51:48) cron2: I thought you had .msi working as well :)
(12:51:50) mattock: no
(12:52:09) mattock: I've postponed working on that because Simon was supp=
osed to bootstrap the msi project
(12:52:15) cron2: maybe then just 1.0 + 1.1 installers?  in case we run i=
nto something funky, like "tls 1.0 + x + y + windows only works with 1.0"=

(12:52:23) mattock: I can do that
(12:52:25) cron2: so: poke Simon :)
(12:52:28) mattock: yes
(12:52:32) mattock: it's about time I think
(12:52:59) mattock: then: should we offer 1.1 as the default, with 1.0 hi=
dden slightly better?
(12:53:57) cron2: I think that makes sense, otherwise people will not tes=
t :)
(12:54:03) mattock: my thoughts exactly
(12:54:12) mattock: let's do that unless someone objects
(12:54:22) mattock: are we done with 2.4.5?
(12:54:41) cron2: I'm good
(12:54:52) mattock: copyright notices next?
(12:54:56) cron2: yep
(12:55:07) ***cron2 has no opinion on that and defers to dazo
(12:55:19) mattock: I think copyright year does not matter much
(12:55:31) ordex: legally they should be updated
(12:55:34) cron2: https://www.mail-archive.com/openvpn-devel@...1659...=
forge.net/msg16393.html
(12:55:36) vpnHelper: Title: [Openvpn-devel] [PATCH 1/1] Update copyright=
 notes (at www.mail-archive.com)
(12:55:37) ordex: and it makes sense
(12:55:37) dazo: yeah
(12:55:45) dazo: I think it makes sense too
(12:55:53) ordex: because we are still honouring the authorship
(12:55:58) ordex: who makes the change does not matter
(12:56:06) dazo: but ... I dunno how these chances where done ... we adde=
d a update-copyright script for the 2.4 release
(12:56:14) cron2: the authorship does not expire, even if the year is not=
 updated (at least here in .de)
(12:56:16) dazo: which should do everything in a verifiable manner
(12:56:27) mattock: it should be necessary to update the year
(12:56:35) mattock: should _not_ be...
(12:56:36) ordex: cron2: yup, but just a s a reminder of "we are still wo=
rking on this" for the general public
(12:57:07) mattock: yeah
(12:57:08) dazo: for the code which OpenVPN Inc owns, it is more importan=
t to state the continued ownership
(12:57:09) cron2: anyway, I have no opinion, but we have this patch and n=
eed a decision :-) - so dazo and ordex think it should be done, that's wh=
at it is
(12:57:38) mattock: fine with me
(12:58:26) mattock: so merge and move on?
(12:58:42) dazo: review, merge and move on ;-)
(12:58:43) cron2: dazo: so can you have a look, and either ACK or run you=
r script?
(12:58:54) dazo: I'll have a look at it today
(12:58:58) cron2: thanks
(12:59:05) ordex:  Iwas reading up some stuff, and apparently, in line wi=
th what cron2 says, the "creation" year is the most important, to set on =
stone when the authorship started. but generally I think it;s a good idea=
 as of "we keep on working on this"
(12:59:23) ordex: ok
(13:00:40) ordex: next ?
(13:00:51) mattock: yes
(13:00:57) mattock: https://community.openvpn.net/openvpn/wiki/SupportedV=
ersions
(13:00:59) vpnHelper: Title: SupportedVersions =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)
(13:01:03) mattock: I found this one a bit by accident
(13:01:06) cron2: looks good to me
(13:01:10) mattock: I modified it to (hopefully) make it more clear
(13:01:55) cron2: maybe we need a heading befor the first table that spec=
ifies something like "Support categories"
(13:02:01) chipitsine: some access.log statistics like "how many there we=
re Vista on 31 jan 2018" would be really nice on that page
(13:02:16) cron2: or move the categories table below the "Current release=
" tables, so it's clear what these categories refer to
(13:02:22) plaisthos: we still support 2.1 *rubs eyes*
(13:02:30) mattock: yeah, what is our vista support policy?
(13:02:39) ordex: the first table is not entirely clear to me *grasp* *gr=
asp*
(13:02:41) cron2: plaisthos: in the CVE bugfest last year, I actually mer=
ged 2.1 fixes
(13:02:42) mattock: I can get some numbers from openvpn.net about Vista u=
sage if we want
(13:02:57) cron2: ordex: the first table is clear as soon as you look at =
the second table :-) - which is why I suggested reordering
(13:03:02) ordex: :D
(13:03:02) ordex: ah
(13:03:12) mattock: I'll move it and we can have a second look
(13:03:20) dazo: plaisthos: well, only git tree updates for 2.1 ... for t=
he really nasty CVEs which is possible to easily fix
(13:03:36) ordex: cron2: right :D
(13:03:54) dazo: but we're not obliged to ... git tree support is 12 mont=
hs after the last official release (Nov 4, 2010)
(13:04:05) mattock: done
(13:04:40) mattock: looks better now?
(13:04:43) ordex: a bit :D
(13:04:53) cron2: maybe add a blank line before "Support categories" and =
make the "Current releases ..." heading same level as "Support categories=
"
(13:05:07) ordex: imho we should have a first section describing the vari=
ous release levels one by one
(13:05:10) cron2: but then it's a good reference (and it matches what I r=
emember :) )
(13:05:11) ordex: as a brief intro
(13:05:28) ordex: because it is not clear, unless you read the table and =
then you infer by yourself, imho
(13:05:33) ordex: *tables*
(13:05:37) cron2: ordex: have you reloaded?
(13:05:41) mattock: fixed that
(13:05:50) cron2: better
(13:06:01) ordex: ah yeah
(13:06:03) ordex: better
(13:06:20) cron2: ordex: I think the first table is informative, and if y=
ou want to understand exactly what "full stable support" means, you look =
to table 2
(13:06:32) ordex: yeah
(13:06:33) ordex: makes sense
(13:06:47) dazo: mattock: you took out a sentence regarding "old stable s=
upport" when simplifying the description below the support categories tab=
le
(13:07:19) mattock: yes I did, because I did not understand it :)
(13:07:27) mattock: you can add it back
(13:07:36) mattock: oh
(13:07:37) mattock: typo
(13:07:40) dazo: yeah, the previous text might not be too clear
(13:07:48) mattock: fixing
(13:08:04) cron2: maybe as an introduction something like "This page docu=
ments our currently existing community OpenVPN versions and branches, and=
 our support plans for each" or so
(13:08:09) mattock: done
(13:08:17) dazo: ahh, better!
(13:08:20) dazo: thx!
(13:08:42) mattock: I had just typoed that particular line
(13:08:43) dazo: cron2++
(13:08:57) dazo: mattock: now it makes sense ... so all good :)
(13:09:04) mattock: adding cron2's suggested introduction
(13:09:22) ordex: sounds good
(13:09:28) mattock: done
(13:09:35) mattock: looking good now?
(13:09:48) cron2: works for me
(13:10:31) dazo: wfm2
(13:10:32) cron2: mattock: do you have a "how to make a release" check li=
st?  Updating "Version / Last release" on *this* page should go onto it
(13:10:48) mattock: I do, I will do
(13:11:23) dazo: that "how to make a release" should be on our public wik=
i too ... at least the steps which can be exposed to the public
(13:11:39) mattock: agreed
(13:12:11) mattock: I can actually document those steps prior to 2.4.5 in=
to Trac
(13:12:22) mattock: prior to release is the best time anyways
(13:12:37) mattock: I'd like to go get some lunch now
(13:12:38) dazo: perfect
(13:12:42) mattock: are we done?
(13:12:58) ordex: we have patches in pw to refresh maybe, but it's just r=
outine
(13:13:10) ordex: maybe after the release
(13:13:15) mattock: I won't be of much help anyways
(13:13:21) mattock: but feel free to go on
(13:13:21) dazo: just a quick note on the FIPS "on hold" item .... this m=
ight be interesting https://www.youtube.com/watch?v=3DarCBEgHo5dA
(13:13:54) cron2: ordex: just send reviews to the list :-) - I need to fi=
nd food now as well
(13:14:01) ordex: hehe
(13:14:02) cron2: but I'll pick it up from there
(13:14:05) mattock: let's conclude the meeting then
(13:14:12) mattock: I will try to get the summary out later today
(13:14:15) ordex: yup sounds good
(13:14:18) ***ordex goes for dinner as well
(13:14:24) cron2: enjoy
(13:14:30) mattock: ok bye guys!
(13:14:35) chipitsine ha abbandonato la stanza (quit: Quit: chipitsine).
(13:14:41) cron2: *wave*
(13:14:44) ordex: bye!
(13:14:48) ordex: dazo: is it really worth? :D
(13:17:39) dazo: ?
(13:17:53) dazo: ahh, the video
(13:30:40) ordex: yeah :D
(13:31:04) dazo: depends ;-)

--------------67EE7AC6712B12D41B963DAD--

