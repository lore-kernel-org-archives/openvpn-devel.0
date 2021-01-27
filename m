From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <5a59dba3-3244-c9e0-b2bf-9f05b1219bc7@...515...>
Message-ID: <915f3467-f099-e32f-49c8-389734c67a5e@...515...>
Date: Wed, 27 Jan 2021 14:05:05 +0200
MIME-Version: 1.0
In-Reply-To: <5a59dba3-3244-c9e0-b2bf-9f05b1219bc7@...515...>
Content-Type: multipart/mixed; boundary="------------F1363EE6C24143341CFD774B"
Content-Language: en-US
Subject: [Openvpn-devel] Summary of the community meeting (27th January 2021)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------F1363EE6C24143341CFD774B
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit



Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Wed 27th January 2021
Time: 11:30 CET (10:30 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2021-01-27>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, mattock, novaflash, ordex and plaisthos participated in this meeting.

---

Noted that the patch that rips away --inetd is on the list and will be
merged soon to "master". It will not be removed from 2.5 as --inetd
support is not actively broken.

---

Noted that some weeks ago FreeBSD and Pfsense were given green light to
use the OpenVPN DCO (Data Channel Offload) code. Nothing has happened on
that front apparently.

---

Noted that the current way of managing Changes.rst across different
branches is cumbersome. Agreed that it would be better to add the
changes to commit messages and add them to Changes.rst at release time.

---

Talked about upgrading Trac and Buildbot. These are among the first
things for mattock once he clears his [operations] backlog [and is able
to focus on community work].

---

Full chatlog attached



--------------F1363EE6C24143341CFD774B
Content-Type: text/plain; charset="utf-8"; name="openvpn_irc_meeting_chatlog_2021-01-27.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2021-01-27.txt"

(12:31:21) mattock: hello
(12:31:23) cron2: good morning
(12:32:07) cron2 ha scelto come argomento: Agenda https://community.openvpn.net/openvpn/wiki/Topics-2021-01-27
(12:32:28) cron2: I have put a bit of stuff on the agenda :-)
(12:33:26) ***cron2 rings the bell
(12:34:15) ordex: aloha
(12:35:56) cron2: mattock, ordex: can you ring the internal corp bell, please?
(12:36:47) mattock: yes
(12:37:03) mattock: did so
(12:37:52) mattock: let's see if the rest of the good folks there wake up
(12:38:07) plaisthos: no I am still asleep
(12:38:11) ordex: :D
(12:38:12) ordex: good
(12:38:29) cron2: plaisthos: haha, I was just typing "plaisthos is busy updating sudo" :-)
(12:39:15) ordex: :D
(12:39:35) novaflash [b9e34bf1@...2592...] è entrato nella stanza.
(12:39:52) cron2: hey novaflash :-) - long time no see
(12:40:10) novaflash: i know right! it's been so long my registration on nickserv expired and i lost my privileges. boohoo.
(12:40:41) mattock: oh wow
(12:40:45) ordex: :D
(12:40:48) novaflash: yeah didn't know that could happen
(12:40:51) ordex: is that even possible?
(12:40:52) ordex: yeah
(12:40:56) novaflash: apparently so!
(12:40:58) ordex: but you hadn;t been offline for so long
(12:41:01) ordex: anyway
(12:41:01) mattock: in a flash he went, in a flash he returned
(12:41:18) ordex: we don't wanna know where, though
(12:41:20) ordex: so topic #1 ?
(12:41:36) mattock: let's start with something, and #1 is always a good first guess
(12:41:47) ordex: yap
(12:41:49) mattock: "Sync up on OpenVPN 2.5 and 2.6"
(12:42:03) ordex: does it mean "master and release/2.5"?
(12:43:09) cron2: yes
(12:43:26) cron2: and "can we keep the 2.6 release date dazo has asked for" :-)
(12:43:26) ordex: what are we exactly missing?
(12:43:40) cron2: for 2.6? dco :-)
(12:44:00) ordex: no, I mean, about the sync up
(12:44:12) ordex: ah, it's all about us syncing up
(12:44:13) ***plaisthos looks at his tree, 50 commits ahead of openvpn/master
(12:44:14) ***ordex hides
(12:44:28) ordex: corp has allocated one day to do more patch review
(12:44:30) ordex: like last week
(12:44:36) cron2: well, the intention of #1 is "find out who is working on what, what are timelines, what is noteable to report"
(12:44:41) ordex: ideally we will find ways to reject all plaisthos' patches
(12:45:15) ordex: it's happening this friday
(12:45:19) cron2: nah, ideally you all do code that is so great that plaisthos never has to refactor it :-))
(12:45:26) ordex: so hopefully more progress on plaisthos' patches will happen then
(12:45:32) ordex: :-)
(12:45:33) cron2: that is great
(12:45:51) cron2: I'm happy to merge, but on some features I do not have a use case = no test bed = hard to test
(12:46:20) ordex: yap
(12:46:28) cron2: how's DCO coming along?
(12:46:30) ordex: at the same time plaisthos is making progress with dco support
(12:46:44) cron2: cool
(12:46:58) cron2: and kernel side? any feedback from "the linux community"?
(12:47:24) plaisthos: heard anything about from the FreeBSD guys?
(12:47:29) cron2: not me
(12:47:51) cron2: but I'll send a mail and ask
(12:48:42) cron2: so where's dazo hiding?
(12:49:13) plaisthos: maintaining kids since the kid maintaining factory (kindergarten) has closed in .no
(12:49:18) plaisthos: I guess
(12:50:28) mattock: here that factory is still producing childcare services
(12:50:31) cron2: yeah, tell me about the juggling of laptops & rooms to get 3 concurrent teams / zoom meeting sorted out
(12:50:33) mattock: which is very good
(12:52:45) cron2: anyway. I think #1 is covered on status and updates - #2, #3 are quick updates with your chance to shout "NO!! I WANT THIS!" now
(12:52:50) cron2: #2 -> --inetd
(12:53:15) cron2: we think this is really not used anymore, anywhere, and plaisthos has sent a patch. *No* response to my inquiry on openvpn-devel + openvpn-users
(12:53:50) cron2: so, I intend to merge the rip-out-inetd patch to "master" soonish. 2.5 can keep it, as it is not actively broken.
(12:53:51) novaflash: last i heard from the freebsd and pfsense guys was that they found each other, were given express permissions to use code from DCO project, and were happily continuing - that was weeks ago though. i assume they're getting on
(12:54:22) ordex: cron2: no feedback from the kernel community because the code hasn't been submitted yet - roadmap requires more steps
(12:55:01) cron2: ordex: well, maybe wrong question. You did publish it, and some people had a look at, maybe not "The Kernel Authorities" :-)
(12:55:17) ordex: ah ok :) yeah, no additional feedback received so far
(12:55:29) plaisthos: probably gets a lot more traction when we publish the openvpn2 server code
(12:55:38) ordex: regarding freebsd: I think the last thing we know is what novaflash said. it was about the email where they were happy to move on
(12:55:42) ordex: but probably nothing happened
(12:55:44) ordex: should we ping them ?
(12:55:53) cron2: I'll mail Bjoern
(12:55:57) ordex: k
(12:56:23) cron2: #2: --inetd -> any comments?
(12:56:47) plaisthos: no
(12:56:51) plaisthos: I don't like --inetd :P
(12:56:55) ***ordex neither
(12:56:59) ordex: rip it out
(12:57:09) cron2: consider it done :)
(12:57:24) cron2: (might take a few days, quite busy for the rest of the week)
(12:57:29) cron2: #3: pf
(12:58:04) plaisthos: I don't like pf either ;D
(12:58:07) cron2: I asked on the -devel and -users list a week ago. Got one private reply "rip it out", and tincantech said in public "I use it but won't miss it, feel free to kill it" (or something like that)
(12:58:32) ordex: then, wipe it !
(12:58:40) ordex: let's make openvpn thin again !
(12:58:41) cron2: I suggest to disable the code by default for 2.5 (change the default for configure or even remove the configure option at all) and remove it for 2.6
(12:58:59) ordex: +1
(12:59:01) cron2: and then we can close the pf related trac tickets and patches in patchwork \o/
(12:59:12) cron2: (sorry ordex, you put lots of work in there, and nobody really cared :-/ )
(12:59:20) ordex: it was good to get started :)
(12:59:57) plaisthos: my first patch for openvpn was also pf related ;P
(13:00:00) cron2: who volunteers to rip it out? or shall I just open a bug with milestone 2.6.0 for that?
(13:00:05) plaisthos: and got never merged iirc
(13:00:13) cron2: plaisthos: ewww...
(13:00:25) ordex: I can do the ripping
(13:00:27) ordex: I like that
(13:00:34) cron2: *like*
(13:00:41) plaisthos: my 2nd patch got a very angry reply mail from Alon
(13:00:46) cron2: haha
(13:01:21) ordex: :D
(13:01:29) ordex: I am sure whitespaces were off
(13:01:45) plaisthos: No I think it was "all wrong"
(13:01:58) ordex: :D
(13:02:06) ordex: we've all been there
(13:02:14) ordex: all set for pf then ?
(13:02:16) cron2: Alon does not care for whitespace
(13:02:21) cron2: yes, #1379, assigned to ordex
(13:02:25) ordex: thanks
(13:02:31) cron2: #4, Changes.rst
(13:02:51) cron2: merging patches with changes to Changes.rst is always a nuisance, because we never manged to merge stuff in the proper order
(13:03:07) cron2: and even if we do, the Changes.rst context is so different between branches that it does not work
(13:03:32) cron2: so I propose to leave off the "Changes.rst" part from patches, to be replaced by a comment in the commit message instead
(13:03:35) cron2: maybe
(13:03:42) cron2: Changes.rst: <text>
(13:03:45) cron2: as simple as that
(13:03:52) plaisthos: I can do that
(13:03:59) cron2: and whoever merges the patch will change Changes.rst accordingly
(13:04:03) plaisthos: for later :D
(13:04:17) ordex: sounds good
(13:04:21) plaisthos: not resending the patches for that
(13:04:23) ordex: the alternative is to compile a wikipage
(13:04:36) ordex: and then we copy that in Changes.rst in one go
(13:04:38) cron2: it's a bit sad that dazo is not here, because it would change "documented process for merging things", and I want him to be OK with it
(13:04:56) ordex: cron2: we can leave the topic open for him to confirm offline
(13:04:58) cron2: ordex: yeah, but having the Changes.rst change close to the actual commit is beneficial
(13:05:05) cron2: ordex: (dazo) yes
(13:05:31) cron2: plaisthos: this is not for the current patch set, but for "reduce future work" - your rebases are affected most by this :)
(13:05:39) ordex: cron2: ok - ok
(13:06:50) cron2: since nobody is screaming "we must not do that", I consider this as positive feedback :-)
(13:07:08) ordex: guess so
(13:07:08) cron2: and since dazo is not here, I can't throw patch 1566 at him :-(
(13:07:18) cron2: (that is "plugin documentation", which he knows best)
(13:07:35) ordex: cron2: I received no email about #1379 - is that expected?
(13:08:08) cron2: ordex: dunno. I got an e-mail, and trac seems to be sometimes weird... do you receive trac mails normally?
(13:08:13) ordex: ah owned by Antonio - ordex here
(13:08:49) ordex: fixed that
(13:08:56) cron2: I put "ordex" in the field, but if a realname is set up, it displays that
(13:09:09) ordex: oh ok
(13:09:11) ordex: weird
(13:09:12) ordex: anyway
(13:09:14) ordex: not a biggie
(13:09:15) cron2: mattock: I seem to remember that we were talking about a trac update...?
(13:09:18) ordex: normally I get them, but not this time
(13:10:24) mattock: managed to somehow destroy my IRC tab
(13:10:34) novaflash: excellent evasive strategy
(13:10:43) ordex: :D
(13:10:52) cron2: shall I ask again and see if it happens again? :-)
(13:10:54) mattock: but yes, I shall upgrade trac in the near future, when I've cleaned up my work backlog
(13:11:05) cron2: ah, nice :-)
(13:11:14) cron2: (and then we need to tackle the buildbot python 2.7 thing)
(13:11:18) mattock: yep
(13:12:11) ordex: cool
(13:12:18) ordex: anything else that needs discussion?
(13:13:12) cron2: not from me... I'm good
(13:13:28) ordex: anybody else ?
(13:13:34) ordex: we can call it a lunch
(13:13:38) ordex: :Q_
(13:14:39) ***cron2 goes and feeds kid[1] and wife[0]... kid[0].lunchbreak conflicts with wife[0].cello_lesson...
(13:14:52) novaflash: i just thought i'd bring this up since you asked;
(13:14:56) novaflash: we had some attempt started up in the company to include forums and trac into company support, to keep an eye on those
(13:14:59) novaflash ha abbandonato la stanza (quit: Quit: Ping timeout (120 seconds)).
(13:15:05) cron2: hah
(13:15:21) cron2: mentioning "trac" really destroys IRC sessions today
(13:15:48) ordex: XD
(13:16:39) ordex: novaflash said to nevermind
(13:16:43) ordex: will bring it up another time
(13:16:55) ordex: faith had other plans for today
(13:17:42) cron2: good enough :-)
(13:17:49) cron2: so, lunch time... *wave*
(13:19:31) ordex: bye!
(13:21:23) mattock: I was apparently distracted at the perfect moment
(13:21:32) mattock: meeting over then

--------------F1363EE6C24143341CFD774B--

