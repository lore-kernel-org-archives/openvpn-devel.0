From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <9cbe2737-df06-c921-1052-3dabe3fb4141@...515...>
Message-ID: <c7d8d211-9b32-085c-2a28-144faef03eeb@...515...>
Date: Thu, 17 Dec 2020 22:27:50 +0200
MIME-Version: 1.0
In-Reply-To: <9cbe2737-df06-c921-1052-3dabe3fb4141@...515...>
Content-Type: multipart/mixed; boundary="------------D5999CD1143F7DC5DB1B5FCD"
Content-Language: en-US
Subject: [Openvpn-devel] Summary of the community meeting (17th Dec 2020)
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
--------------D5999CD1143F7DC5DB1B5FCD
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Thu 17th December 2020
Time: 20:00 CET (19:00 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2020-12-17>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

becm, cron2, dazo, lev, mattock, plaisthos and Pippin participated in
this meeting.

---

We have received some bug reports and patches related to OpenVPN 2.5.
Some of them are minor, some are "strange corner cases", a few are "the
default is no longer iproute2, so my --iproute $script setup fails" and
"and all my systemd unit files look different". The
windows-register-dns-crash looks bad, but it only happens if you're not
using the iservice.

So nothing major or urgent has surfaced yet.

---

Noted that OpenVPN 2.4.10 release has been solid. Nothing to report.

---

For 2.6/master we have quite a few patches from plaisthos in patchwork
(#1549/1550, #1545/1544/1546). We also have the "pending authentication
improvements patchset:

<https://patchwork.openvpn.net/project/openvpn2/list/?series=962>

These would need review from someone who understands crypto.

---

Noted that it would be good to have community download numbers viewable
by community members. Mattock will relocate the page and see if the
metrics could be exposed publicly.

---

Talked about openvpn3-linux client. While it would be possible to port
it to FreeBSD most of those are servers, and openvpn3-linux really
targets the client (GUI) experience. So, the network-manager
improvements that are being worked on will make more people happy that a
FreeBSD port.

---

Cron2 announced a bounty of a "few pounds of chocolate" for having a
working NM OpenVPN client with tokens that survive suspend/resume and
network changes.

---

Planned the 2.5.1 release. There are a few bugfixes wrt auth-token and
TLS session handling that needs to go into 2.5.

A release in mid-January seems reasonable.

---

Talked about migrating to the new Wintun API. That is perfect material
for OpenVPN 2.6. If we're not forced by, say, a Wintun 0.8 security
issue, we should keep OpenVPN 2.5 at Wintun 0.8 to ensure stability.

That said, Lev will check if we could use WinTun 0.10 in OpenVPN 2.5
without changing the API.

---

Talked about officially deprecating OpenVPNServiceLegacy. We dropped it
silently in OpenVPN 2.5 and then somebody noticed:

<https://community.openvpn.net/openvpn/ticket/1344>

There is no reason (as far as we know) for using OpenVPNServiceLegacy in
this day and age. However, we should clearly document that it is gone
and will never come back. This documentation effort would include

- The Windows README that gets installed by the MSI
- Changes.rst
- Some articles in Trac

These should be done by OpenVPN 2.5.1 release time.

---

Noted that OpenVPN Connect tickets in Trac have been assigned to "yuriy"
but there has not been any visible movement there. Somebody will poke
him internally and ask what's up. In the worst case we can automatically
close OpenVPN Connect tickets with a message like "Open tickets for
OpenVPNConnect here: $URL".

---

Talked about OpenVPN exploding with "unknown option" if it encounters
an option in the configuration file that is not supported by the
platform (Windows, Linux, etc). We need to think about how to solve this
nicely.

---

Noted that

https://community.openvpn.net/openvpn/ticket/1345

requires a test installer. Potentially one of the NSIS-based 2.6
installers could be used:

<https://build.openvpn.net/downloads/snapshots/>

If not, lev or mattock can do a custom build.

We don't yet have MSI snapshot automation.

---

Next neeting is scheduled for January 6th 2021 (Wed) at the usual time.

---

Happy Holidays everyone!

--

Full chatlog attached



--------------D5999CD1143F7DC5DB1B5FCD
Content-Type: text/plain; charset="utf-8"; name="openvpn_irc_meeting_chatlog_2020-12-17.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2020-12-17.txt"

(20:59:28) mattock: hi
(20:59:36) cron2: ho!
(20:59:37) mattock: not me
(21:00:15) dazo: Blame me!
(21:00:28) cron2: !blame
(21:00:43) cron2: (this certainly needs updating, over in the other channel)
(21:02:51) dazo: hehe
(21:04:22) cron2: are lev__ and ordex somewhere around?
(21:04:30) cron2: plaisthos already said he couldn't make it
(21:05:43) mattock: internal meeting ended, now I'm really here
(21:06:10) cron2: I've used the time to add stuff to the agenda :)
(21:06:28) mattock: shall we start?
(21:06:29) dazo: I'll ping them
(21:07:40) plaisthos: i am semi around actually
(21:08:15) dazo: Nice! I've pinged lev__ and ordex in our internal chat and privately .... warning them cron2 is looking for them :-P
(21:08:32) cron2: with every minute they are late, I will assign a trac ticket!
(21:08:59) mattock: you're making them an offer they can't refuse, basically :D
(21:09:08) cron2: which is actually somewhat starting the "updates on 2.5" section :-)
(21:09:46) dazo: hahaha
(21:10:07) cron2: so, people *are* using this, and we are receiving bug reports (and patches!).  Some of these are minor, some are "some strange corner cases", a few are "the default is no longer iproute2, so my --iproute $script setup fails" and "and all my systemd unit files look different"
(21:10:20) cron2: but so far I haven't seen anything truly catastrophic
(21:10:47) cron2: the windows-register-dns-crash looks bad, but it only happens if you're not using the iservice, so "not really urgent"
(21:11:52) cron2: so, I'm not unhappy.  Interest, and no catastrophes yet :-)
(21:12:10) dazo: Yeah, just skimmed through the tickets listed in the agenda .... all related to new code, so this is valuable, and we're seeing more corner cases - so nothing really surprising
(21:12:11) cron2: On the 2.4.10 front, I have not seen or heard anything (we did the release a week ago, IIRC).
(21:13:20) dazo: The 2.4.10 should be in the mail Fedora/EPEL repos for F32+33 and EPEL 7+8 (Fedora 34 got 2.5, which is still in development)
(21:13:33) cron2: nice
(21:13:55) cron2: FreeBSD and gentoo jumped from 2.4.9 to 2.5.0 :-)
(21:14:24) cron2: (so did NetBSD and "all the rest that uses pkgsrc")
(21:15:11) dazo: There are some repo downloads for the 2.5 release in Fedora Copr (for Feodra 32+33, EPEL 7+8) ... but just some hundreds per repo in average
(21:16:29) dazo: mattock: which brings back a question which re-surfaces from time to time .... download stats from the s3 buckets ... do we have that?  To see Deb/Ubu downloads
(21:16:48) cron2: on the master->2.6 side of things, we have quite a few patches from plaisthos in patchwork, so some help from "someone who understands crypto" on #1549/1550, #1545/1544/1546 would be welcome...
(21:17:20) cron2: and the whole "pending authentication improvements" patchset (11 patches) starting here: https://patchwork.openvpn.net/project/openvpn2/list/?series=962
(21:17:21) vpnHelper: Title: OpenVPN 2 - Patchwork (at patchwork.openvpn.net)
(21:17:25) pippin__ [Pippin_@...2315.../vpn/protonvpn/pippin/x-75792076] è entrato nella stanza.
(21:17:25) Pippin_ ha abbandonato la stanza (quit: Killed (rothfuss.freenode.net (Nickname regained by services))).
(21:17:25) pippin__ è ora conosciuto come Pippin_
(21:17:40) mattock: dazo: yes we do, but I can't remember the URL
(21:17:44) cron2: syzzer wanted to look at that, but I think he's busy with work and family :-)
(21:18:00) mattock: we did check the swupdate numbers during 2.5 rc stage
(21:18:28) mattock: I'll have to ask for the URL again
(21:18:30) dazo: nice ... well, would be good to massage them and make them available for the community
(21:18:49) cron2: +1
(21:18:56) ***dazo likes https://patchwork.openvpn.net/patch/1487/
(21:19:19) cron2: nah, that's python
(21:19:32) cron2: (but besides this, yes, documentation and sample scripts are always great :-) )
(21:20:18) dazo: I see I need to try to port openvpn3-linux to FreeBSD and port the Python code to Perl code to get cron2's attention :-P
(21:20:37) cron2: haha :-)
(21:20:52) mattock: freebsd has dbus
(21:20:52) cron2: something simpler would also get my attention, like a perl module driving openvpn2 via the management API
(21:20:56) mattock: as an option at least
(21:21:17) cron2: mainly to test the API (which we don't do today)...
(21:21:23) dazo: yeah
(21:22:15) dazo: mattock: yeah, and D-Bus is the most important system dependency of the openvpn3-linux project ... the rest shouldn't be that tricky
(21:22:42) mattock: I'm sure openvpn3-linux would break in interested ways when ported to FreeBSD
(21:22:45) mattock: interesting
(21:22:59) cron2: FreeBSD has python as well, which is one of the reasons why it annoys me... it's so much work to maintain with their py2/py3 incompatibilities and packages depending on one or the other only
(21:23:05) mattock: but a port would probably within the realm of possibility
(21:23:14) dazo: You believe my code got bugs, mattock !?! blasphemy! :-D
(21:23:36) cron2: dazo: penguins, more likely
(21:23:37) mattock: dazo: everyone's code has  bugs, one per line on average
(21:24:08) dazo: :-P
(21:24:27) mattock: I suppose a FreeBSD port is not even looming in the horizon or is it?
(21:25:25) dazo: No, I want to get NM integration in place, and preferably replace the glib2 gdbus implementation with something more C++-ish
(21:25:26) cron2: not sure there is much interest.  I think openvpn3-linux really targets "the GUI user experience", while most FreeBSD systems I'm aware of are "server style"
(21:25:44) cron2: yep, good NM integration would make many more people happy than a FreeBSD port
(21:26:40) cron2: ohyes.  Having a working NM client with tokens that survive suspend/resume and network changes would certainly be worth a few pounds of chocolate
(21:26:53) ***cron2 hereby declares this a bounty
(21:27:11) dazo: well, openvpn3-linux got some advantages for servers connecting to other VPN servers ... it's quite a bit harder to tilt over and disconnect than openvpn 2 - at least in some configs/setups I've seen
(21:27:44) dazo: connecting as client to other VPN servers
(21:27:52) cron2: I only get to see the bugs when it falls over and screams when fed a normal .ovpn config :-)
(21:28:20) dazo: hehe :)
(21:29:26) cron2: so, is there an upper limit how many tickets to assign to lev__ and ordex?
(21:29:42) dazo: I'd say, "the sky is the limit" *ducks*
(21:30:21) cron2: we do have 445 open tickets in the system... so, 222 each (and I keep one of mine)
(21:30:55) cron2: fun aside - shall we have a look at the next agenda points?  (unless there's more updates on 2.4/2.5/2.6)
(21:31:03) cron2: ah, maybe one thing
(21:31:09) cron2: 2.5.1 planning
(21:31:54) mattock: 2.5.1 sounds good
(21:31:59) cron2: there are a few bugfixes wrt auth-token and TLS session handling and this that are current in master, and that really should go into 2.5 as well - we do not have them yet (plaisthos is working on that area) but we could do a releas like "mid january"
(21:32:07) cron2: ish
(21:33:07) dazo: that makes sense ... the auth-token stuff isn't worse than it's been before, and is more annoying than really critical ... so that makes sense
(21:33:34) cron2: right, this is not "new bugs" but "we just didn't manage to finish them before 2.5.0"
(21:34:36) dazo: exactly
(21:35:06) cron2: mattock: what do you think?
(21:35:32) mattock: mid-January = good
(21:35:41) cron2: good :-)
(21:36:11) mattock: any other OpenVPN x.x updates?
(21:36:40) becm: adaption to new Wintun API, more a 2.6 or 2.5.x thing?
(21:37:02) dazo: becm: that's more a 2.6 thing, how I see it
(21:37:21) dazo: we try to keep 2.5 as stable as possible
(21:37:32) plaisthos: I am not really happy to deviate from our 'we build all from source' concept
(21:37:39) cron2: it's not a 2.5.1 thing, I think
(21:37:53) plaisthos: the new api sounds like we need to include 3rd party binary libraries from Wireguard
(21:37:55) cron2: so we need to look long and hard and then plan
(21:38:21) plaisthos: and I haven't had time to have a real look at the license
(21:38:24) dazo: agreed
(21:38:35) becm: and hope nothing forces our hand with a critical 0.8-bug
(21:38:41) cron2: we need to have a plan, though... - exactly
(21:39:11) dazo: yeah, if anything really critical appears in 0.8, we'll reconsider ... but that's a different scenario
(21:40:05) becm: from a "sane" approach, I'd have also categorized this as "2.6". but it's still 2020 :)
(21:40:06) dazo: as long as the current code works stable, safe and secure ... there's not much to gain from adding new code into a stable branch now
(21:40:37) lev__: I will check if it currently works with 0.10 without changing API
(21:41:01) dazo: thx!
(21:41:19) dazo: That's a reasonable middle-ground for 2.5 at least
(21:41:56) cron2: lev__: ah, just in time, so you only earned 35 bonus tickets
(21:42:15) mattock: lev: see the beginning of the meeting
(21:42:21) mattock: :)
(21:42:34) cron2: but let's spend the last minutes on these tickets, shall we?
(21:42:38) mattock: but you can earn "some pounds of chocolate" if you pay your cards right
(21:42:44) cron2: indeed!
(21:43:03) mattock: what about the openvpnservicelegacy deprecation?
(21:43:08) mattock: did we do it officially already?
(21:43:14) cron2: de-facto
(21:43:23) cron2: the msi installer does not install the service anymore
(21:43:26) mattock: do we have it in Changes.rst?
(21:43:37) cron2: (the *binary* is there, as it's in openvpnserv.exe, but it is not "installed")
(21:43:37) mattock: and/or trac
(21:43:43) mattock: yeah
(21:43:44) cron2: no, and sort-of
(21:44:01) mattock: maybe put it into Changes.rst so that people may accidentally find it?
(21:44:09) cron2: so, the ticket complains about "IT IS GOOONE!", I said "yeah, this is what it is, we just forgot to document it", and got yelled at :-)
(21:44:45) cron2: so maybe we should put it in that README which the windows version presents after installing... (I have no idea what is in there)
(21:44:58) mattock: ok, yeah, that is reasonable
(21:45:14) mattock: I can add that to my 2.5.1 release ticket
(21:45:19) mattock: which I shall create now
(21:45:36) cron2: plus changes.rst :-) - and I think the wiki should have some documentation about "what if I use the legacy service now, how can I use the openvpnsrv2 instead?"
(21:45:46) cron2: do we have something for that already?
(21:46:05) mattock: probably not, because we assumed nobody would be using OpenVPNServiceLegacy at this point
(21:46:13) mattock: I mean, it is _Legacy_
(21:46:29) mattock: and has been so since 2.4 (or earlier?)
(21:46:33) mattock: for some years
(21:46:46) mattock: I think Changes.rst and the Windows readme would be enough
(21:48:40) mattock: done
(21:48:44) mattock: the ticket, that is :D
(21:49:01) dazo: agreed
(21:49:03) cron2: I think we want to at least look at where our trac mentions the service, and update :-) - I'll put that in the ticket, as "this is what we want" (and no, you won#t get it back)
(21:49:43) cron2: done
(21:49:49) dazo: and when people complain about it, we really need to get them to explain why the legacy way was better (except "I don't need to change anything")
(21:50:07) cron2: right, mattock already asked for that in the ticket
(21:50:31) mattock: no response -> no reason
(21:50:42) mattock: I really don't think there is a single valid reason for it
(21:50:44) cron2: as well :-) - "publically documented"
(21:50:58) dazo: yupp
(21:50:59) mattock: OpenVPNService is way superior
(21:51:05) cron2: I have no idea
(21:51:39) dazo: just like systemd is way superior over init.d + scripts + scripts + scripts + scripts + scripts + scripts :-P
(21:52:06) dazo: (sorry, I just had to!
(21:52:09) cron2: yeah, systemd is totally like windows, just less documentation
(21:52:20) Pippin_: :)
(21:52:43) dazo: huh!? You haven't found the systemd man pages?
(21:52:44) cron2: and I've heard it's actually much harder to build
(21:53:07) dazo: you don't need to build it (unless you want to develop it) ... it comes prebuilt ;-)
(21:53:12) dazo: by default!
(21:53:15) dazo: ;-)
(21:53:16) cron2: (a colleague was hacking stuff into systemd-networkd, and was cursing like days in a row...)
(21:53:36) dazo: ahh, well, that's development .... we also curse a lot when hacking openvpn :-P
(21:53:49) cron2: ah, yes :-)
(21:53:53) cron2: so, next: yuriy
(21:54:33) cron2: I see some activity in trac on "yuriy assigned" tickets, but also new "OpenVPN Connect" related stuff which isn't seeing attention...  (well, our tickets are not either, but Connect is someone else's problem)
(21:54:43) cron2: so what's the current method of operation with Connect tickets?
(21:55:06) lev__: didn't we have dedicated guy from Connect team to handle those
(21:55:07) dazo: I can try to follow up internally, so that the guy who should follow up knows what to do
(21:55:12) cron2: I assign them to "yuriy" as I haven't heard anything else
(21:55:33) dazo: as long as we do that, we should consider our task done
(21:55:54) dazo: we could probably update our trac reports to exclude tickets assigned to yuriy
(21:56:04) mattock: maybe we could poke "yuriy" about those tickets
(21:56:10) mattock: maybe he does not know what to do with them
(21:56:12) cron2: I actually want them to be worked-on and closed :)
(21:56:14) mattock: maybe they're even resolved
(21:56:16) mattock: +1
(21:56:21) dazo: yeah, agreed
(21:56:54) cron2: if the canned answer is "this is the wrong ticket system, I have copied over the ticket to $corpbugzilla" that would be perfectly fine
(21:57:22) dazo: otherwise we could apply some automation if nothing improves .... automatically close tickets related to OpenVPN Connect with a message in the ticket "Open tickets for OpenVPNConnect here: $URL"
(21:58:00) mattock: dazo: yeah, that could serve as a fallback
(21:58:02) cron2: or that.  If we have said URL :-)
(21:58:32) cron2: so, time is running short... #1342 need a reply from lev__
(21:59:19) lev__: yeah sounds doable for 2.5.1
(21:59:31) cron2: this is about people creating .ovpn configs for their users, including "--windows-driver wintun", and then some users import those to linux or tunnelblick and it dies with "unknown option"
(22:00:05) cron2: we generally do not ignore "windows-only" options on other platforms, but generally those options are *pushed*, and then openvpn ignores unknown options anyway
(22:00:15) lev__: I didn't think that --windows-driver could be pushable
(22:00:22) cron2: it isn't
(22:00:40) cron2: (well, it could be, but I'm not sure that makes much sense)
(22:00:45) cron2: mmmh
(22:00:54) mattock: so basically ignore options non-windows can't handle?
(22:01:09) cron2: we did have a trick for "I want to put this option in my .ovpn, but openvpn should ignore it if it does not understand it"
(22:01:29) cron2: something with fancy setenv, I think...
(22:02:10) cron2: setenv FORWARD_COMPATIBLE 1
(22:03:19) cron2: yeah, but that wasn't what I had in mind (this will make openvpn turn *all* config errors into warnings)
(22:03:20) lev__: I need to look more closely, but initial idea was to process this option only under _win32 define
(22:03:47) cron2: lev__: yes, the original approach totally makes sense, but "people did other things"
(22:03:58) lev__: I will take care of it
(22:04:08) cron2: ah!
(22:04:25) cron2: setenv opt windows-driver wintun
(22:04:32) becm: lev__: the "people" or the "option handling"? :)
(22:04:50) cron2: becm: well, "people doing configs for their users"
(22:05:38) dazo: but it would be good if windows options would just become NOOP on non-windows builds
(22:08:03) cron2: at last those that are used in "distributed by admin" .ovpn files, yes... pushed stuff is ignored (with warning) anyway
(22:08:13) ***cron2 does like "setenv opt" :-)
(22:09:23) dazo: yeah, setenv opt is fine for pushed options ... and pushed options can be fixed easier with, well, setenv opt ...
(22:09:39) cron2: no :-)
(22:09:51) cron2: setenv opt is particularily *not* intended for pushed options
(22:10:12) cron2: in push context, msglevel is M_WARN anyway, so it does not do anything
(22:10:28) cron2: push "explode" or push "setenv opt explode" would both log the same warning
(22:10:37) cron2: but if you put it in .ovpn
(22:10:41) cron2: expode -> explodes
(22:10:47) cron2: setenv opt explode -> warning
(22:11:12) mattock: 11 minutes overtime
(22:11:22) cron2: (I couldn't remember, so I went into options.c, add_option(), right at the start)
(22:11:22) mattock: any agreement on the windows-specific options?
(22:11:33) dazo: ahh, I see ... thx, cron2!
(22:11:44) mattock: or "we will think about this a bit more"?
(22:11:55) cron2: I think we need to return to the larger issue... the ticket at hand can be solved two ways, let's see what the author says
(22:12:15) cron2: "we will think about this a bit more" (we have linux-specific options as well)
(22:12:40) cron2: so, two very short ones... #1345 -> mattock/lev__: do you build snapshot installers people can test with?
(22:13:33) cron2: and #1355 -> "ordex may want to look into this" (mmmh, since lev__ showed up, all 445 tickets for ordex, then!)
(22:13:43) cron2: next meeting?
(22:14:48) lev__: I can be mattock 's backup for building snapshot installer
(22:15:24) mattock: we do have https://build.openvpn.net/downloads/snapshots/ where I see 2.6 NSI snapshots from Nov 29th
(22:15:26) vpnHelper: Title: Index of /downloads/snapshots/ (at build.openvpn.net)
(22:16:02) mattock: next meeting hmm
(22:16:13) dazo: next year, I think we concluded last time
(22:16:14) mattock: 6th (Wed) Jan?
(22:16:33) mattock: that would be according to our normal schedule
(22:17:06) cron2: mattock: so NSI snapshots are regularily built, MSI not yet (or "impossible to do")?
(22:17:18) dazo: mattock: Don't recall, what does our previous meeting minutes say? ;-)
(22:17:33) mattock: MSI is not yet, until there is a Windows buildslave capable of building MSI
(22:18:30) cron2: https://community.openvpn.net/openvpn/ticket/1368 is actually a tap-driver-related-yuriy-ticket :)
(22:18:35) mattock: oh, mail-archive is up finally
(22:19:07) mattock: Agreed to not have meeting on Dec 23rd or 31st. The last meeting this month will be on 17th.
(22:19:26) mattock: no decision on a January meeting
(22:19:29) mattock: I say 6th
(22:19:30) mattock: ok?
(22:19:35) cron2: wfm
(22:20:00) dazo: okay, then its fine :)
(22:20:03) mattock: +1
(22:20:06) mattock: anything else?
(22:20:17) dazo: happy holiday?!? ;-)
(22:20:57) cron2: stay safe and healthy
(22:21:19) cron2: and do not go crazy about lockdown with kids at home, no way to go skiing or anything else besides "sit at home"...
(22:21:44) dazo: +1
(22:21:49) mattock: yes, let us sit at home and bark at our respective family members 
(22:21:56) mattock: that is a sure recipe for success :D
(22:22:18) dazo: Now it's not needed to argue what to watch on TV ... there's time to watch everything! :-P
(22:22:37) mattock: yep
(22:22:46) mattock: anyways, good night and happy holidays everyone!
(22:23:08) mattock: I will add that greeting to the summary as well
(22:25:19) dazo: thx!

--------------D5999CD1143F7DC5DB1B5FCD--

