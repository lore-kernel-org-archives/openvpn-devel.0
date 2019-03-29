From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <d54b01ca-1001-ccfc-cb97-1e1a826a5f94@...515...>
Message-ID: <d650850a-eefd-c02b-b3c9-bcad19b1bd0a@...515...>
Date: Fri, 29 Mar 2019 10:06:12 +0200
MIME-Version: 1.0
In-Reply-To: <d54b01ca-1001-ccfc-cb97-1e1a826a5f94@...515...>
Content-Type: multipart/mixed; boundary="------------0BC0E8FD8EEFC74B4703C233"
Content-Language: en-US
Subject: [Openvpn-devel] Summary of the community meeting (27th Mar 2019)
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
--------------0BC0E8FD8EEFC74B4703C233
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit

...resending as I apparently tried to send this from my personal email
account.

---

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Wednesday 27th March 2019
Time: 11:30 CET (10:30 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2019-03-27>

The next meeting is scheduled to 3rd April 11:30 CEST.

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, dazo, mattock, ordex, plaisthos and syzzer participated
in this meeting.

--

Discussed future meeting schedule:

https://doodle.com/poll/qbnsw7d4mvb5iysn#table

It was agreed to have weekly meetings which alternate between

- Wed 11:30 CET/CEST
- Thu 20:00 CET/CEST

This enables most developers, even those in the U.S., to participate in
the meetings every other week.

Next week's meeting will be on Wed at 11:30 CET/CEST. The meeting one
week from that will be on Thu at 20:00 CET/CEST.

--

Talked about OpenVPN's INSTALL file. Dazo will overhaul it as it
contains quite a bit of obsolete information.

--

Talked about OpenVPN's ChangeLog file in the "master" branch. It
contains essentially the same information as "git shortlog" but has not
been updated in two years and nobody had complained until now. Agreed to
remove that file from Git "master" as useless. It will still be present
in release branches where it is actually recreated at release time.

--

Discussed the OpenVPN T-shirts. Mattock sent T-shirts to most already.
Cron2, janjust and ecrist please (re?)send your postal address to
mattock and you will receive T-shirts as well.

--

Discussed tap-windows6 HLK testing. Fixing the HLK tests should be
"ready" and the work is in here:

https://github.com/sgstair/tap-windows6/tree/hlkwork
https://github.com/sgstair/tapdiag

We also have basic instructions from Stephen on how to run the HLK tests
(the tap-windows6-specific part, plus openvpn configs). So the plan now
is to start merging his work patch by patch and simultaneously start (or
rather, resume) setting up the HLK environment.

Mattock is fighting to get a real, physical Windows Server 2016 box for
running the WHQL compliance HLK tests, as a VM won't cut it for Microsoft.

--

Full chatlog attached.


--------------0BC0E8FD8EEFC74B4703C233
Content-Type: text/plain; charset="utf-8"; name="openvpn_irc_meeting_chatlog_2019-03-27.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2019-03-27.txt"

(12:30:25) mattock2: hi
(12:30:47) dazo: hey!
(12:31:10) syzzer: hi!
(12:31:54) ordex: hi!
(12:31:58) ordex: plaisthos: !!
(12:32:55) cron2_: wooh!
(12:33:51) plaisthos: hey
(12:33:54) dazo: ordex got a strange way to say "hi" :-P
(12:34:30) cron2_: you can never have enough exclamation marks
(12:34:37) ordex: hehe
(12:34:45) dazo: !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
(12:34:53) ordex: :D
(12:35:02) ordex: you're good for a couple of weeks now
(12:35:06) dazo: :-D
(12:35:24) cron2_: perfect.  Anything else on the agenda? :)
(12:36:00) dazo: https://www.compart.com/en/unicode/U+037E .... this can be fun to inject into some code .... april 1st coming soon!
(12:36:53) ordex: I don't have anything on my plate worth mentioning (no change since last week)
(12:37:40) mattock: so we have plenty of people here
(12:37:46) cron2_: so, meeting schedule... can we agree on biweekly alternating wed 11:30 / thu 21:00 ?
(12:38:02) mattock: hmm thu 21 CET/CEST?
(12:38:15) cron2_: ordex: was that 21:00 or 20:00?
(12:38:23) mattock: 21 CEST is too late for me
(12:38:32) mattock: 20:00 is ok-ish
(12:39:02) ordex: 8PM
(12:39:03) ordex: 20:00
(12:39:07) ordex: 8pm-9pm
(12:39:26) cron2_: ah, indeed, that was the problem with tuesday (that I'm just not here at tue 8pm) - good, 8pm
(12:39:39) ordex: I am checking
(12:40:06) ordex: yeah Thu 8PM
(12:40:40) syzzer: works for me :)
(12:40:55) cron2_: works for me
(12:41:14) ordex: cool
(12:41:17) mattock: ok good
(12:41:25) ordex: mattock1: was the only red tick, but he said it may be ok-ish
(12:41:28) mattock: that is fairly reasonable
(12:41:54) ordex: oky
(12:41:56) mattock: if we keep the meeting within 1 hour
(12:42:00) mattock: and I think we can
(12:42:04) ordex: I think we should stick to that
(12:42:14) ordex: if we keep this happening every week, 1h should be ok
(12:42:18) mattock: agreed
(12:42:21) ordex: as done so far
(12:42:35) dazo: agreed
(12:43:06) mattock: I'll will retroactively add this as a topic to https://community.openvpn.net/openvpn/wiki/Topics-2019-03-27
(12:43:08) vpnHelper: Title: Topics-2019-03-27 – OpenVPN Community (at community.openvpn.net)
(12:43:53) mattock: done
(12:44:03) mattock: wed 11:30, thu 20:00 CET/CEST
(12:44:13) syzzer: cool
(12:44:23) cron2_: good.  So, next week, still Wednesday 11:30 (because it was already announced) and then April 11 (Thu) 20:00?
(12:44:29) mattock: sounds good
(12:44:39) ordex: yap
(12:44:40) mattock: easy topics next? (4-5 in the updated topic list)
(12:45:00) ordex: next week me, dazo and plaisthos will be in the OpenvPN office in Ukraine, so I am not sure we'll have time to join
(12:45:27) ordex: it seems our agenda is pretty packed already ...
(12:45:34) cron2_: we do the 11:30 schedule so you office folks can make it... "just sayin"
(12:45:41) mattock: there's always room for multitasking? :P
(12:45:52) ordex: :D
(12:45:53) cron2_: anyway, we'll see who shows up
(12:45:56) ordex: yeah
(12:45:58) mattock: yup
(12:46:12) mattock: maybe Jon and perhaps Stephen could also join those Thursday meetings
(12:46:14) cron2_: regarding 4.+5. - yes, INSTALL certainly could see a rewrite
(12:46:18) ordex: it may be we have already saved the world by 11:27, and then we can easily join
(12:46:43) mattock: https://github.com/OpenVPN/openvpn/pull/110/files is a clear bugfix
(12:46:45) vpnHelper: Title: Update INSTALL by gowthambalusamy · Pull Request #110 · OpenVPN/openvpn · GitHub (at github.com)
(12:46:52) cron2_: but since we do not do PRs, "patch on the list or it will not happen"... any volunteers to look through INSTALL and send a patch?
(12:47:38) ordex: does this guy have a name/email ?
(12:47:41) ordex: I can do the sending
(12:47:56) ordex: because I'd have to sign his patch
(12:48:58) mattock: can't find one from https://github.com/gowthambalusamy or the page that page links to
(12:48:59) vpnHelper: Title: gowthambalusamy (Gowtham Balusamy) · GitHub (at github.com)
(12:49:00) mattock: maybe just ask
(12:49:01) mattock: ?
(12:49:08) cron2_: I'd decouple this - the effort to chase nameless submitters for a one-word fix is just not something we should spend time on
(12:49:36) ordex: agreed
(12:49:44) dazo: +1
(12:49:45) cron2_: just go through INSTALL and make a new patch, and give courtesy to "Gowtham Balusamy" for bringing up the topic
(12:49:45) ordex: so we fix on our own and mention his name in the commitmessage?
(12:49:50) ordex: ok
(12:49:51) cron2_: yes :)
(12:49:53) ordex: cool
(12:49:54) ordex: will do
(12:50:36) dazo: I'm not even sure it's worth mentioning his name ... the PR even says clearly how the patch should be sent ....
(12:50:43) ordex: :D
(12:50:44) ordex: yeah
(12:50:58) dazo: "Please send your patch using git-send-email."
(12:51:01) mattock: besides the "make-install" bug the INSTALL file seems fairly good
(12:51:11) mattock: I did not check all the links, though
(12:51:37) dazo: it's a typo, going back to 2008
(12:51:38) mattock: the ./configure options _may_ be outdated, not sure
(12:51:52) dazo: yeah, I'd say ditch this and rather do a full overhaul
(12:52:12) dazo: (commit f02576fa8b181 for those being curious)
(12:52:26) ordex: I lost the conclusion: should I still fix this make-install thing ?
(12:52:33) plaisthos: dazo: but it does not hurt anyone so adding him is nice
(12:52:36) mattock: dazo: ditch the whole INSTALL file?
(12:52:55) dazo: ditch this PR ... and do a full overhaul, it's a lot to fix anyway
(12:53:00) dazo: this is just a tiny nitpick
(12:53:24) mattock: dazo: I don't think INSTALL is _that_ bad
(12:53:39) dazo: " git checkout -b 2.2 remotes/origin/release/2.2" :-P
(12:53:48) mattock: well, replace 2.2 with 2.4 and you're good
(12:54:01) dazo: there's lots of such things
(12:54:06) ordex: ah
(12:54:10) dazo: I can try to take a stab at that file
(12:54:16) mattock: I was about to ask dazo :)
(12:54:26) ordex: ok, I don't do the single change then
(12:54:30) cron2_: topic 5. says "enable-lzo-stub", so possible configure options that got kicked out should also be checked
(12:54:30) ordex: and we kill the PR on GH ?
(12:54:36) cron2_: yes
(12:54:50) mattock: with a mention that the INSTALL file will be see a more thorough fix
(12:54:51) dazo: yeah, I think that has changed to --enable-comp-stub, though
(12:55:37) cron2_: *and* that we don't do PRs
(12:55:52) dazo: yeah
(12:56:42) ordex: mattock1: can you take care of the PR ?
(12:56:52) mattock: yeah
(12:57:31) ordex: thanks
(12:59:54) mattock: closed
(13:00:10) mattock: outdated changelog? https://github.com/OpenVPN/openvpn/blob/master/ChangeLog
(13:00:12) vpnHelper: Title: openvpn/ChangeLog at master · OpenVPN/openvpn · GitHub (at github.com)
(13:00:34) mattock: it indeed looks quite outdated
(13:00:46) mattock: 2016.12.16 -- Version 2.4_rc2
(13:01:23) mattock: scrap or fix, or fix for good?
(13:01:40) dazo: I think we're just experimenting here, to see who notices it .... to see if we can ditch that file all together :-P
(13:01:46) syzzer: or just fix on the first release of that barnch?
(13:02:13) syzzer: but yeah, ditching should be fine too
(13:02:27) mattock: if nobody cares about the changelog let's remove it
(13:02:37) mattock: I mean, you can check the commit history from Git
(13:02:43) syzzer: I'd say ditch (it's in git anyway), or auto-generate when creating a tarball.
(13:02:53) mattock: +1
(13:02:59) mattock: to either approach
(13:03:03) mattock: first is easier :P
(13:03:08) dazo: yeah, I'd say that's reasonable .... nobody complained (to my knowledge) in over 2y
(13:03:29) syzzer: yeah, and we have Changes.rst nowaways, which contains better parseable information
(13:03:49) dazo: parseable or human readable? ;-)
(13:06:00) syzzer: human-parseable
(13:06:18) mattock: lol
(13:06:22) dazo: hehehe
(13:06:33) mattock: Changes.rst is sufficient imho
(13:06:43) mattock: consensus: kill ChangeLog?
(13:06:48) dazo: +1
(13:08:14) mattock: ok move on? maybe T-shirts next?
(13:08:50) mattock: I have a quick update on those
(13:10:40) mattock: because nobody is talking I'll give that update: all those devs who are employed by OpenVPN Inc will receive their T-shirts in Lviv next week - Lev will bring them
(13:10:53) mattock: I also sent individual T-shirts to all people for whom I have an address
(13:11:15) mattock: of the people present I'm lacking an address from cron2
(13:11:37) dazo: mattock1: send it to his space.net office address :-P
(13:12:06) mattock: well that's one option of course :)
(13:12:19) syzzer: t-shirt \o/
(13:12:32) mattock: yes you should receive it shortly
(13:13:07) mattock: next topic? we have 17 mins
(13:13:18) mattock: tap-windows6 maybe? we do have update
(13:13:19) mattock: s
(13:13:46) dazo: please, updates are nice!
(13:14:04) dazo: and lets also quickly dive into the latest news with wintun afterwards
(13:15:10) cron2_: oh
(13:15:10) cron2_: sorry
(13:15:27) cron2_: ChangeLog.  We maintain this in the release/ branches, but it is basically unmaintained in the master/ branch
(13:15:47) cron2_: so I think it is useful in release/2.4 but could go in master/ - and who uses master can do "git log" anyway
(13:16:22) cron2_: return from interrupt
(13:16:25) mattock: I'm not opposed
(13:17:10) mattock: ok
(13:17:15) dazo: lets kick it out of master then, and keep it in release branches ... we we can do a fresh file on each release/2.x branching
(13:17:36) cron2_: +1
(13:17:37) mattock: also do we want to version the file in Git, or just generate the changelog when building the tarball?
(13:17:41) dazo: not sure there's much value of having the complete history back to v0.90 :-P
(13:18:08) cron2_: mattock1: let's have it in git as it is now, for the time being (it is part of my tagging process - version.m4, ChangeLog, commit, tag)
(13:18:17) mattock: ok
(13:18:32) mattock: ready for tap-windows6?
(13:18:42) dazo: we can start by adding a script which eases the update of that file, but not a high priority ticket
(13:19:04) cron2_: yep, on both
(13:19:45) mattock: so
(13:20:26) mattock: tap-windows6 HLK test fixing should be "ready", the work is in here:
(13:20:26) mattock: https://github.com/sgstair/tap-windows6/tree/hlkwork
(13:20:26) mattock: https://github.com/sgstair/tapdiag
(13:20:28) vpnHelper: Title: GitHub - sgstair/tap-windows6 at hlkwork (at github.com)
(13:20:29) vpnHelper: Title: GitHub - sgstair/tapdiag (at github.com)
(13:20:52) mattock: we have basic instructions from Stephen on how to run the HLK tests (the tap-windows6-specific part, plus openvpn configs)
(13:21:23) mattock: so the plan now is to start merging his work patch by patch and simultaneously start (or resume) setting up the HLK environment
(13:21:45) syzzer: good news, nice :)
(13:22:38) mattock: I'm also fighting to get a real, physical Windows Server 2016 box for running the WHQL compliance HLK tests
(13:22:45) mattock: because a VM won't cut it for Microsoft
(13:23:51) mattock: so that's most of it
(13:24:25) mattock: still a bit of time for openvpn 2.5
(13:27:22) mattock: I can sense the enthusiasm :D
(13:28:05) cron2_: we're waiting for lunch!  (you already had :) )
(13:28:22) cron2_: well... I'm still hoping to see ACKs, or discussion of patches, or v2 of patch sets...
(13:28:23) mattock: yeah I did
(13:28:49) mattock: let's try to come up with something next week then
(13:28:53) mattock: you guys go to lunch
(13:29:04) cron2_: :)
(13:29:40) plaisthos: mattock1: might be easiest to give me cron2_'s shirt
(13:29:53) plaisthos: then I can send it over
(13:30:00) plaisthos: and we save like 4 EUR of shipping :P
(13:30:04) cron2_: \o/
(13:30:09) mattock: plaisthos: it's only 4,60€ anyways
(13:30:16) plaisthos: what?
(13:30:22) ordex: :D
(13:30:22) mattock: postage fees to Europe from here
(13:30:34) mattock: OpenVPN Inc. has money :D
(13:30:35) cron2_: that's actually cheaper than a parcel inside germany
(13:30:42) plaisthos: yeah
(13:30:44) mattock: it's technically a letter
(13:30:50) mattock: hence the relatively cheap price
(13:31:01) plaisthos: you cannot do that in Germany
(13:31:06) mattock: interesting
(13:31:38) plaisthos: mattock1: just ordering Gert's T-shirt for him directly from spreadshirt and sending to his address is probably the best if you haven't it at your place already
(13:31:50) mattock: I already have all the T-shirts
(13:32:11) mattock: you get pretty decent volume discounts when you order more than a dozen T-shirts
(13:32:42) mattock: there are some deals like "free shipping" occasionally, and in those cases having each person order their own (with the same design) might make sense
(13:33:22) mattock: but we're past that point now - I just need a few more addresses and we're done
(13:33:23) mattock: :)
(13:33:50) mattock: ok meeting concluded?
(13:35:22) syzzer: lunch! :D
(13:37:18) mattock: I take that as a yes! :D


--------------0BC0E8FD8EEFC74B4703C233--

