From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <316dbdbb-5a21-1a08-9369-26010b106b18@...515...>
Message-ID: <ca55ec32-0620-78aa-d928-3b0f899768ea@...515...>
Date: Wed, 17 Feb 2021 14:09:21 +0200
MIME-Version: 1.0
In-Reply-To: <316dbdbb-5a21-1a08-9369-26010b106b18@...515...>
Content-Type: multipart/mixed; boundary="------------67D85EC29423F90DCE4D7E8F"
Content-Language: en-US
Subject: [Openvpn-devel] Summary of the community meeting (17th February
 2021)
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
--------------67D85EC29423F90DCE4D7E8F
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit



Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Wed 17th February 2021
Time: 11:30 CET (10:30 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2021-02-17>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, dazo, lev, mattock, novaflash, ordex, plaisthos and Pippin
participated in this meeting.

---

Noted that mattock will containerize the to-be upgraded buildmaster and
his own buildslaves. This helps cut through the (generally) crappy OS
packaging that needs to be dealt with on real VMs. [OpenVPN connectivity
tests (t_client) could complicate this on Docker, though].

---

Talked about potentially becoming a Linux Foundation project. This would
give us a number of benefits:

<https://www.linuxfoundation.org/en/projects/support-programs/>

However, this seems to be "all or nothing" package. In our (OpenVPN Inc)
case trademarks is the big question. Other requirements look quite
reasonable.

This needs to be discussed in more detail later.

---

Agreed to release 2.5.1 next Tuesday (23rd Feb).

---

Noted that there is a new shared trac/forums account "openvpn_inc".
Novaflash will reassign tickets from "denys" (an old support guy) to
this new account which will be manned by four people.

---

Talked about the current layout on the community forums:

<https://forums.openvpn.net>

Agreed that it is confusing and that it should be improved. Completely
archiving the old forums is an option, but (important) articles would
need to migrated and traffic redirected to the new URLs. So just
improving what we have would be easiest and safest. This needs to be
discussed in more detail later.

There are also plans to setup a GDPR plugin to the forums.

Also noted that PhpBB is behind three versions and should be upgraded.

---

Lev will take over the "Bridged Windows 10 Causes Sporadic Crashes" issue:

<https://community.openvpn.net/openvpn/ticket/1385>

It would still be good to know if this is a tap driver bug, or general
windows fubar.

---

Lev has been working on Windows version of OpenVPN-DCO recently. It is
WDF and NetAdapterCx based so no more NDIS. Results are promising.

Lev and d12fk will start working together on getting the OpenVPN 3
reference client up-to-shape for this new DCO driver on Windows.

---

Plaistos' Linux OpenVPN + DCO seems to be quite stable now. He is also
doing the openvpn2 side of things for ovpn-dco on Linux, including
server support.

---

Full chatlog attached


--------------67D85EC29423F90DCE4D7E8F
Content-Type: text/plain; charset="utf-8"; name="openvpn_irc_meeting_chatlog_2021-02-17.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2021-02-17.txt"

(13:03:09) mattock: hi
(13:04:11) mattock: cron2: you here already?
(13:04:13) cron2_: soon
(13:06:29) mattock: ok
(13:06:34) dazo: hey!
(13:07:28) cron2_: nearly there
(13:08:23) cron2_: so!
(13:09:13) cron2_: sorry for messing up your scheduling... the 11:30-12:30 time slot is very conflict prone if I get to do some actual work (as opposed to "sitting on IRC and ranting all day")
(13:09:33) cron2_: where's ordex and plaisthos and lev? :)
(13:09:54) mattock: hi!
(13:10:07) ordex: hi!
(13:10:50) lev__: guten tag
(13:10:51) novaflash [b9e34bf1@...2592...] è entrato nella stanza.
(13:11:02) cron2_: oh, nice, lots of updates in the agenda page already :)
(13:11:20) cron2_: hi lev, novaflash
(13:11:25) mattock: https://community.openvpn.net/openvpn/wiki/Topics-2021-02-17
(13:11:34) novaflash: i bring news
(13:11:49) mattock: tell the quickly
(13:11:52) mattock: we have 19 minutes
(13:11:55) novaflash: oh. it's in the meeting notes already. damnit.
(13:11:56) mattock: total :D
(13:12:03) novaflash: okay go go hurry hurry
(13:12:10) mattock: may I start with some quick updates
(13:13:05) cron2_: go
(13:13:07) mattock: "Containerized buildmaster and mattock's buildslaves": buildbot and the slaves are easiest to manage as containers, so that's my plan when going about upgrading them - this will not have any effect on any other buildslave providers
(13:13:18) mattock: cuts through the poor OS packaging
(13:13:47) mattock: then something I did not actually put on the topic list: I looked a Linux Foundation project support thingies (hinted by dazo)
(13:13:51) cron2_: won't help me much on non-linux, but as I only have one buildslave per VM, "the VM is the container".  So you just tell me what I want
(13:14:30) mattock: it seems like we could not in practice become a linux foundation project because of trademarks (we want to keep them), but otherwise there were no really major blockers
(13:15:02) mattock: that said, the Linux Foundation Project approach seems to be suited better for large projects with multiple (large) vendors co-operating on the same piece of software
(13:15:04) cron2_: what was the intention?  funding, or prestige?
(13:15:05) mattock: openstack or such
(13:15:17) mattock: just to research if we could  benefit from their programs
(13:15:19) cron2_: or manpower / project management?
(13:15:22) cron2_: ah
(13:15:28) mattock: https://www.linuxfoundation.org/en/projects/support-programs/
(13:15:30) vpnHelper: Title: Project Support Programs - Linux Foundation (at www.linuxfoundation.org)
(13:15:31) mattock: they have several
(13:15:41) mattock: but it seems to be "take all or take none" kind of deal
(13:16:01) mattock: which will not be an easy pill to swallow for OpenVPN Inc management
(13:16:03) mattock: :P
(13:16:22) mattock: anyhow, that's all from me afaicr
(13:16:24) cron2_: I think that warrants its own discussion on merits and costs, with more time
(13:16:30) mattock: yep
(13:16:40) cron2_: okay
(13:16:43) cron2_: 2.5.1 release
(13:17:48) cron2_: two weeks ago we discussed "do it soon" or "fix the renegotion / kick-out aspects first".  Since nothing has happened on the second part (syzzer is still missing in action...) I'd say we do a 2.5.1 soonish.  There's a bit of client side and packaging / plugin goodness in which we want to get out, plus windows gui goodness
(13:18:01) cron2_: mattock: what time would be good next week for a release?
(13:18:20) cron2_: (or week after that, if inconvenient)
(13:18:26) mattock: I don't have any strong opinions
(13:18:33) mattock: next week at any time is good
(13:19:10) plaisthos: hey
(13:19:19) ***cron2_ randomly picks "tuesday" (my customers do not seem to want that day) :-)
(13:19:28) mattock: +1
(13:19:34) mattock: hi plaisthos and welcome!
(13:19:43) cron2_: hi plaisthos :)
(13:20:26) dazo: next Tuesdays sounds good
(13:20:38) cron2_: :)
(13:20:39) mattock: next topic?
(13:20:43) mattock: 10 minutes left
(13:20:48) mattock: "New forums shared account "openvpn_inc"
(13:21:03) novaflash: cool.
(13:21:10) novaflash: yeah so i am currently the only one contributing on that
(13:21:11) cron2_: can you auto-assign denys/yuriy -> openvpn_inc?
(13:21:17) novaflash: i am putting together a training program right now to train our guys
(13:21:21) cron2_: novaflash: ah, great, thanks :)
(13:21:23) novaflash: we will have something like 4 guys in total on this
(13:21:36) novaflash: and yes a next step for me is to go into denys' account and go into trac
(13:21:46) novaflash: and then figure out the mess that was left there because i suspect denys did not do very much there
(13:22:02) novaflash: and then i will likely have to reassign some things to openvpn_inc account
(13:22:11) cron2_: I think the most important thing *I* would want is a clear message in reasonable time towards the reporter, along the lines of "hey, this is a commercial product, our support pages are --> over there, I have opened a ticket there for you (or maybe not)"
(13:22:17) novaflash: i expect that to happen somewhere next week
(13:22:25) novaflash: for sure, that's the main goal of being on forums/trac
(13:22:28) cron2_: novaflash: maybe mattock can bulk-assign "open && owned-by denys"
(13:22:34) novaflash: and also to provide answers to 'generic' questions
(13:23:05) novaflash: yeah that's a possibility - it would temporary flood us with a shitload of notifications but that is fine. in fact, let's decide to just do that, if samuli is able to do that.
(13:23:18) cron2_: novaflash: *like*  - until today, "Connect" questions pretty much got left in the sun to dry out...
(13:23:33) novaflash: i will weather the storm of messages here on our end from that action
(13:24:04) cron2_: just remove the mail address from trac before doing so, and there will be no mails...
(13:24:10) novaflash: so yeah, over the next days/weeks, our presence will be felt. like a million voices crying out at once and being suddenly extinguished.
(13:24:33) cron2_: uh, oh, that sounds like the new AS release "death star" is coming...
(13:24:35) novaflash: we kind of do want the notifications if people contribute something on those trac tickets otherwise we get no notifications :-D
(13:24:36) mattock: I'd expect there to be only a handful of denys tickets, so searching for those an manually reassigning is probably quite easy
(13:24:55) novaflash: okay well if i need your help mattock i will just call you in, how about that
(13:25:05) mattock: novaflash: sounds reasonable
(13:25:15) novaflash: awesome. pew pew.
(13:25:21) cron2_: :)
(13:25:43) mattock: ok so what is "Propose new, more sensible layed out Community forum (and archive the current one?)." about?
(13:25:56) mattock: feels like an explosion or an implosion
(13:26:03) mattock: novaflash probably knows more
(13:26:09) novaflash: i did not add that topic
(13:26:20) novaflash: but i did reorganize the section where openvpn inc enterprise products are on the forums
(13:26:23) ***cron2_ neither
(13:26:38) novaflash: it had a section like 'openvpn access server' with sub forums like 'how to' and 'troubleshooting' and so on and NOBODY ever looked there
(13:27:04) novaflash: so i just removed those subforums and collapsed them into just the main "openvpn access server" forum. and moved the forums posts from those subforums into that main forum.
(13:27:09) cron2_: oh, that came from "Pippin".  But he's not here right now
(13:27:35) novaflash: i do personally find it kind of hard to understand where i should move tickets that are posted in access server that deal with connection problems. i don't really know which community forum or subforum i need to move that to.
(13:27:46) novaflash: * on open source setups ^^
(13:28:17) novaflash: i mean, does it go under "Installation help" ?
(13:28:33) novaflash: or "Configuration" ? or "Server administration" ?
(13:28:33) Pippin_: ah, in time :)
(13:28:35) mattock: ah, the good old confusing subforums
(13:28:41) cron2_: Pippin_> ah, in time :)
(13:28:45) cron2_: oops
(13:28:46) novaflash: yeah so i can see the confusion and why pippin would want to bring this up
(13:29:09) cron2_: Pippin_: I think you got timezone challenged, formal start was 58 minutes ago (except that I couldn't make it today, on time)
(13:29:25) Pippin_: i think the forum could need a overhaul
(13:29:26) cron2_: so, who will die of hunger if we overrun a few minutes?
(13:29:36) Pippin_: ok :)
(13:29:43) novaflash: i'm already dead inside
(13:30:11) Pippin_: ecrist and i already talked about integrating gdpr compliance
(13:30:12) cron2_: I have enough tea, so all is well :-) - go, reorganize, make it great again :-))
(13:30:21) Pippin_: there is a phpbb plugin for that
(13:30:58) mattock: any GDPR requests so far?
(13:31:05) Pippin_: yes
(13:31:13) ***dazo throws in a burning torch ... ditch forums and move to Reddit  
(13:31:15) ***dazo ducks
(13:31:37) cron2_: dazo: is openvpn inc publically traded?
(13:31:44) dazo: :-D
(13:31:48) novaflash: that's too social dazo. socialist!
(13:31:59) dazo: cron2_: No ... not yet, afaik :-P
(13:32:12) cron2_: I have no formal opinion on this - I'm not into forums or reddit
(13:32:14) cron2_: old fart
(13:32:29) novaflash: phpbb is about as old fart as you can get tho
(13:32:43) mattock: newsgroups?
(13:32:47) dazo: novaflash: hehehe .... well, from a US perspective, we Europeans are all socialists on the path of doom and destruction :-P
(13:32:51) mattock: that's from the sixties, right?
(13:33:09) Pippin_: wrt layout i made an example: 31.151.32.90:10080
(13:33:22) cron2_: novaflash: newfangled stuff...!
(13:33:26) novaflash: so the forums, i like the idea of a GDPR plugin - what's the main problem it tries to solve actually? i'm curious. the ability to delete all posts from a user on request? i think we have that
(13:33:35) Pippin_: categories can off course be removed/added
(13:34:02) novaflash: 31.151.32.90:10080 <- blank page?
(13:34:05) cron2_: I do not get anything
(13:34:09) cron2_: yes, blank
(13:34:20) cron2_: looks very tidy
(13:34:21) Pippin_: novaflash: yes kind off, it has the ability to replace the username with f.e. Geustxxx
(13:34:26) novaflash: http://31.151.32.90:10080/phpbb/phpBB3
(13:34:28) vpnHelper: Title: OpenVPN Support Forum - Index page (at 31.151.32.90:10080)
(13:34:28) novaflash: try that one
(13:34:50) Pippin_: ah yes 10080 is internal port :)
(13:35:22) dazo: novaflash: the GDPR stuff is probably also related to the proper legal alerts ("yes, we're evil, we have cookies")
(13:35:24) cron2_: we really shouldn't encourage "Windows / Server configuration" :-) - but besides this, it looks good to me
(13:36:03) novaflash: agreed on the windows encouragement cron2_
(13:36:06) Pippin_: well i added it because those questions are being asked
(13:36:06) cron2_: novaflash brought up a "Connectivity issues" forum / area
(13:36:25) dazo: Perhaps we should also skip the subforums?  server/client config subforums sounds like adding more confusion .... because they're all tied together
(13:36:28) cron2_: pippin_: I was joking.  I am aware that people do this, and it will usually work.
(13:36:30) novaflash: pippin let's say i get a post about open source client connection problem. where do i send that? general questions? installation? certificate and client maangement?
(13:36:57) Pippin_: :0
(13:37:22) cron2_: "I try to connect to $vpn and I get this funky error message that I do not understand"
(13:37:31) novaflash: yeah exactly
(13:37:41) novaflash: i'll just send it in a PM to pippin_
(13:37:55) novaflash: anyway, this stuff doesn't have to be decided here i guess or we'll be here forever
(13:38:18) Pippin_: it's just an idea....
(13:38:37) novaflash: personally i'd recommend ditching subforums altogether and just have a handful of 'main' forums - much easier to understand and navigate. often i only see the overview of subforums when i am moving a ticket to some subforum. otherwise it's hard to see that overview.
(13:38:55) Pippin_: adding categories makes it easier for me to shove topic/posts around
(13:39:32) dazo: novaflahs++
(13:39:42) Pippin_: wouldn't that become difficult to searchable?
(13:40:05) Pippin_: *phrasing :)
(13:40:28) dazo: Do forum users really use the search feature in our forum? ... or do the just open a new thread/question directly?
(13:40:34) novaflash: ease of navigation >> ease of searching for relevant items?
(13:40:44) Pippin_: search doesn't work that well
(13:40:56) novaflash: anyway i have a call in 5 minutes
(13:41:13) novaflash: but i think the idea of reorganizing and the GDPR plugins are both great ideas
(13:41:19) novaflash: i also think phpbb is 3 versions behind on updates
(13:41:36) novaflash: perhaps this can be discussed further outside of this meeting
(13:41:39) mattock: yes
(13:41:40) mattock: agreed
(13:41:49) Pippin_: ecrist would do an update, some weeks ago, don't know if he did
(13:41:58) Pippin_: ok
(13:41:59) novaflash: i checked yesterday, it's 3 versions behind i think
(13:42:27) Pippin_: last question, archive current is out of question?
(13:42:51) mattock: links would break
(13:43:05) mattock: unless we add redirects
(13:44:32) mattock: one quick topic, then I need to wrap this up on my part
(13:44:35) mattock: Bridged Windows 10 Causes Sporadic Crashes
(13:44:35) cron2_: so *I* have to be out now.  $kid is hungry
(13:44:40) mattock: https://community.openvpn.net/openvpn/ticket/1385
(13:44:44) novaflash: take care cron2_
(13:44:47) mattock: bye!
(13:44:50) Pippin_: bye
(13:44:54) cron2_: yeah.  I've seen that.  No idea what to do about it, tbh...
(13:45:04) mattock: lev: maybe this is something you could look into, or d12fk?
(13:45:25) mattock: provided you get the debugging info and/or access to the offending servers/desktops
(13:45:39) dazo: "Don't do bridging"? :-P
(13:45:54) lev__: yeah
(13:46:07) mattock: asking "why" might make sense
(13:46:12) cron2_: that's what I said in the ticket ("don't bridge, don't tap") but it would still be good to know if this is a tap driver bug, or general windows fubar
(13:46:17) mattock: people have interesting use-cases
(13:46:26) mattock: agreed with cron2
(13:46:44) cron2_: "because windwows networking", which actually is not a legitimate use-case anymore ("netbios name resolution based on broadcast packets")
(13:46:46) mattock: it could be a security issue as well, we don't know
(13:46:48) lev__: would be nice to see stracktrace from windbg
(13:46:59) cron2_: there is debug info in the ticket
(13:47:12) cron2_: ticket(s), actually, we have like 3, but they are interlinked
(13:47:13) mattock: lev: can you take over this, at least to ask for more info?
(13:47:17) lev__: I checked attachments but I haven't seen stacktraces
(13:47:28) lev__: I can try
(13:47:31) mattock: ok, thanks!
(13:47:51) mattock: I'll start writing the summary now so I don't miss my appointment
(13:48:07) lev__: but I must say I never done TAP/bridging
(13:48:16) lev__: btw
(13:48:40) lev__: I have been working on Windows version of ovpn-dco for a last few month
(13:48:50) mattock: oh and that one
(13:48:55) mattock: I need to append this to the summary
(13:49:08) lev__: which is WDF and NetAdapterCx based, bye bye NDIS
(13:49:46) lev__: I have PoC with supports IPv4/UDP transport and AES-GCM crypto
(13:50:20) novaflash: cool. DCO is spreading its tendrils.
(13:50:55) mattock: lev: does this help at all with driver signing btw?
(13:51:00) lev__: I won't disclosure yet any performance numbers but let's say it looks very promising
(13:51:54) plaisthos: my linux openvpn + dco seems is quite stable now
(13:52:28) plaisthos: probably going to post on the mailing list soon for broader testing
(13:52:30) lev__: I haven't looked into signing yet, but I wouldn't expect any issues with attestation signing
(13:53:00) lev__: at the moment it doesn't work _yet_ on 2019 server because it requires newer kernel
(13:53:38) dazo: So lev__ and d12fk will start working together on getting the OpenVPN 3 reference client up-to-shape for this new DCO driver on Windows ... that's when we things are ready for more widespread development testing ... and then plaisthos is doing the openvpn2 side of things for ovpn-dco on Linux, including server support
(13:53:43) novaflash: do we have any clue as to when new kernel gets to 2019? just curious
(13:54:30) lev__: maybe 6 more months, just a guess. server is lagging behind a bit
(13:55:43) lev__: at the moment I am stabilizing the driver - adding missing locks etc, next will add missing functionality like ipv6 and then tcp
(13:56:03) lev__: so I want it to be part of 2.6
(13:57:37) dazo: that's a good plan
(13:57:38) lev__: and yeah my hacky ovpn3 reference client with ovpn-dco-win support connects to plaisthos's ovpn-dco server
(13:59:13) dazo: It's all moving steadily forward, which is very nice :)
(14:01:05) lev__: ok, lunch time

--------------67D85EC29423F90DCE4D7E8F--

