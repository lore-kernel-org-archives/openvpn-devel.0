From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <a0f3334f-fd8f-4998-4935-274b1f9dc64b@...515...>
Message-ID: <b114818d-81e6-0bdb-453c-219a9859ca6f@...515...>
Date: Wed, 13 Dec 2017 17:13:56 +0200
MIME-Version: 1.0
In-Reply-To: <a0f3334f-fd8f-4998-4935-274b1f9dc64b@...515...>
Content-Type: multipart/mixed; boundary="------------987B427684335353AC8EEFDB"
Content-Language: en-US
Subject: [Openvpn-devel] Summary of the community meeting (Wed,
 13th Dec 2017)
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
--------------987B427684335353AC8EEFDB
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Wednesday 13th Dec 2017
Time: 11:30 CET (10:30 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2017-12-13>

The next meeting has not been scheduled yet.

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, janjust, mattock, ordex and syzzer participated in this meeting.

--

Discussed "VLAN patchset v2":

<https://github.com/OpenVPN/openvpn/pull/76>

Ordex has reviewed the patchset. However, we don't have a maintainer for
the patches and current developers are not very keen on taking over that
responsibility.

--

Discussed status of LibreSSL support in OpenVPN.

Our official stance is that we do not support LibreSSL. However,
LibreSSL is still fairly compatible with OpenSSL 1.0 which it is based
on, and which OpenVPN supports for the time being. At some point we will
be dropping OpenSSL 1.0 support though. LibreSSL is also becoming more
and more incompatible with OpenSSL 1.0 as it continues to accumulate
backported features from OpenSSL 1.1. This will complicate things for us
as we need manage those incompatibilities somehow.

We would not have to care about LibreSSL except that MacOS X and OpenBSD
now ship with LibreSSL instead of OpenSSL and we do want to support
those platforms.

For the above reasons we decided to keep LibreSSL and OpenSSL 1.0
support in OpenVPN 2.5 but drop it in OpenVPN 2.6 unless somebody
volunteers to maintain it. We also decided to issue log warnings to
users who are using LibreSSL.

--

Full chatlog attached.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

--------------987B427684335353AC8EEFDB
Content-Type: text/plain; charset="utf-8"; name="openvpn_irc_meeting_chatlog_2017-12-13.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2017-12-13.txt"


(12:29:18) ordex: meeting time ?
(12:29:21) ordex: almost !
(12:33:11) mattock: yeah
(12:33:19) mattock: who else is here?
(12:34:59) mattock: I believe cron2 and syzzer are joining
(12:37:02) janjust [~janjust@...1423.../community/support/janjust] è entrato nella stanza.
(12:38:00) mattock: hi janjust!
(12:38:14) mattock: Mike Auty wanted to bring up https://github.com/OpenVPN/openvpn/pull/76
(12:38:19) vpnHelper: Title: Vlan patches v2 by ikelos · Pull Request #76 · OpenVPN/openvpn · GitHub (at github.com)
(12:38:21) mattock: I see he only sent email to me
(12:38:33) janjust: Hi all
(12:39:11) mattock: we're waiting for cron2 and syzzer - both should be joining
(12:39:45) mattock: topics here: https://community.openvpn.net/openvpn/wiki/Topics-2017-12-13
(12:39:47) vpnHelper: Title: Topics-2017-12-13 – OpenVPN Community (at community.openvpn.net)
(12:42:28) ***janjust is still very happy with his OpenVPN-hackathon shirt :)
(12:42:45) mattock: janjust: good to hear! :)
(12:42:53) mattock: didn't you have one previously btw?
(12:43:13) janjust: I had the first one, but this second one with all the dates gives me more of a rockstar feeling ;)
(12:43:19) mattock: oh yes :)
(12:43:44) mattock: I will have to order some more for the next hackathon
(12:44:07) janjust: with updated dates, of course
(12:44:09) mattock: yep
(12:45:21) ***ordex is here too
(12:45:46) mattock: I emailed syzzer and cron2 just in case
(12:45:59) ordex: about the vlan patches: I wanted to help more there, but I don't have much time :(
(12:46:05) mattock: yeah, I recall that
(12:46:14) ordex: but maybe once I am done with some of the current work I can try to do some coding
(12:46:26) ordex: so far I have helped by reviewing, but not much has happened after that
(12:46:33) mattock: the problem with the patches has always been that we don't have a developer who would take responsibility of them
(12:46:34) ordex: because the most active guy is not a developer for real
(12:46:54) mattock: yep
(12:47:03) ordex: well, I offered my help in that sense, but in this case they need somebody to do actual coding as they still need some refactoring
(12:47:22) mattock: do you know if the original author (Fabian?) is still actively maintaining the patchset?
(12:47:29) mattock: or did he lose interest in them?
(12:47:40) ordex: he replied once on github, but he said he is busy with other things too for now
(12:48:00) mattock: ok
(12:48:09) syzzer: oops
(12:48:10) syzzer: hi :)
(12:48:13) mattock: hi syzzer!
(12:48:16) mattock: forgot about the meeting? :P
(12:48:23) janjust: hi syzzer 
(12:48:29) ordex: hi :)
(12:48:47) syzzer: mattock: yeah - distracted by other stuff at work
(12:49:03) mattock: I think we could start now while waiting for cron2
(12:49:13) mattock: the big topic is "LibreSSL"
(12:49:21) mattock: what to do with it
(12:50:25) ordex: why is it "the big" topic? are we receiving pressure from outside for "better support" ?
(12:50:41) mattock: openbsd only has libressl
(12:50:48) ordex: what is wrong with the current libressl status ?
(12:50:50) syzzer: ordex: we received patches, and those are good from the libressl perspective, but I don
(12:50:52) mattock: and tunnelblick apparently uses that also
(12:51:01) syzzer: don't like them much from the openvpn/openssl perspective
(12:51:40) ordex: syzzer: oh ok. you don't like them because of the way they are engineered/integrated into the current code? or because they introduce some SSL settings which you don't like?
(12:51:42) syzzer: and the current status of libressl support is "we don't break it on purpose, but do not support it'
(12:52:09) ***ordex should probably read some mail about that
(12:52:35) janjust: syzzer, are those patches meant to be applied to "our" openssl stuff?   or is it applied as a separate crypto lib (comparable to mbedtls vs openssl) ?
(12:52:35) syzzer: ordex: for example this one: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg15903.html
(12:52:36) vpnHelper: Title: Re: [Openvpn-devel] [PATCH applied] Re: Add --tls-cert-profile option for mbedtls builds (at www.mail-archive.com)
(12:53:50) syzzer: libressl fucked up their OPENSSL_VERION_NUMBER approach, which means we can't simply check for that anymore
(12:53:57) ordex: this feels dirty. sound slike we need yet another crypto-library
(12:54:28) syzzer: I think this summarizes it: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg15905.html
(12:54:29) vpnHelper: Title: Re: [Openvpn-devel] [PATCH applied] Re: Add --tls-cert-profile option for mbedtls builds (at www.mail-archive.com)
(12:54:53) syzzer: ordex: exactly :)
(12:55:21) ***syzzer silently hopes that libressl will just slowly die
(12:55:27) syzzer: but I'm afraid it won't
(12:55:37) ordex: if we don't do that, we'll end up with the openssl code being full of ifdefs all over the place
(12:55:41) ordex: not anytime soon I think :P
(12:56:38) ordex: having it in a searate cryptolib should hopefully put us in a better position: we do things in mbedtls/openssl and when actual libressl users find out that something is wrong (like in this case) they can fix the libressl part without touching openssl/mbedtls at all
(12:57:42) mattock: how much maintenance overhead would there be in supporting LibreSSL as a separate crypto backend?
(12:57:47) janjust: downside is that the libressl version (and thus the mac os x version?) might/will trail behind the other versions in terms of functionality
(12:57:55) syzzer: ordex: yeah, but then we'd need to be really clear about the state of the libressl backend
(12:58:52) syzzer: mattock: quite a bit - buildbots for a start, but also any API changes need to be ported to the libressl backend too
(12:58:55) ordex: janjust: right, but in theory whoever builds openvpn using libressl should somehow feel responsible for fixing stuff..othrerwise he can still decide to switch to mbedtls/openssl again
(12:59:22) ordex: yeah, sounds like quite some effort :/
(13:00:19) syzzer: so now you are where I am: unsure what to do with this mess :p
(13:00:43) janjust: still, having libressl as a separate crypto lib sounds a lot cleaner then having i=#IFDEFs all over the place in the openssl code
(13:00:52) ordex: +1
(13:01:12) ordex: that's the reasonable way to go imho. but requires somebody with motivation and time to stay behind it
(13:01:12) syzzer: janjust: yeah, I already objected to that, and will object if any more are added
(13:02:07) syzzer: so the choice basically is to either officially state that openvpn will no longer work with libressl or add a libressl backend, I guess
(13:02:16) janjust: yup
(13:02:20) ordex: seems so
(13:03:02) janjust: I'd prefer adding libressl as a separate backend *BUT* we need to appoint a maintainer for it as well. I'd be willing to do the initial setup of the backend but I'm definitely not available as a maintainer
(13:03:40) syzzer: I'm refusing to maintain it, because I believe it should just die :p
(13:03:42) janjust: what is jonathan bullard's position on this?   (
(13:04:11) ordex: once we remove openbsd and tunnelblick, who is actually using libressl?
(13:04:18) syzzer: openbsd
(13:04:34) ordex: yeah, forget about openbsd and tunneblick for a second...is there anybody else?
(13:04:45) syzzer: ah, right.
(13:04:52) janjust: does openssl not build on openbsd at all?
(13:05:10) janjust: (that way we could forcefeed the openbsd maintainers the openssl backend)
(13:05:12) syzzer: janjust: it does, but the wise man decided to fork openssl instead of fixing it
(13:05:27) syzzer: so now they only recognize libressl as The True Crypto Lib
(13:05:43) mattock: openvpn is not available in the base system of openbsd, right?
(13:05:57) syzzer: I have no clue
(13:06:04) mattock: I'll check
(13:06:18) mattock: if it is a port/package we can make the maintainers add a dependency to openssl
(13:06:53) ordex: or we can force the package maintainer to "patch" openvpn in their building process so it can work with libressl :P
(13:07:09) mattock: http://ports.su/net/openvpn
(13:07:11) vpnHelper: Title: OpenBSD ports net/openvpn (at ports.su)
(13:07:15) cron2: eek
(13:07:20) ***cron2 forgot about you, apologies
(13:07:21) mattock: ordex: yeah, that one also
(13:07:36) mattock: cron2: good you could make it eventually :)
(13:08:03) janjust: either ports or from their "main" repo. If I read http://www.openbsdsupport.org/openvpn-on-openbsd.html I see that you can do 'pkg_add openvpn' on openbsd 6.1
(13:08:04) vpnHelper: Title: 10openvpn (at www.openbsdsupport.org)
(13:08:06) ordex: hi cron2 :)
(13:08:18) janjust: hi cron2, how can you forget about us :) ?
(13:08:40) ordex: I vote for setting cron2 as libresslmaintainer, simply because he forgot about us :P
(13:08:46) mattock: :D
(13:09:23) mattock: is the consensus that we should let LibreSSL-enthusiasts (i.e. OpenBSD) handle their own mess?
(13:09:51) cron2: that would mean "we discontinue OpenBSD and MacOS as a supported platform"
(13:09:56) cron2: is that what we want to do?
(13:10:13) janjust: why MacOS ?  is there no openssl or mbedtls for MacOS?
(13:10:15) ordex: cron2: are you assuming nobody in those communities will help us maintaining their own ssl library?
(13:10:17) mattock: cron2: by macos you're referring to tunnelblick?
(13:10:24) cron2: janjust: there is no openssl on macos anymore
(13:10:41) ordex: mbedtls builds on macos, I use it there to build ovpn3
(13:10:57) cron2: ordex: "help maintaining" is what they do now: send patches if things break.  But they will not do a full library backend maintenance thing
(13:10:59) ordex: (I build mbedtls from source)
(13:11:17) cron2: (also, I think that this is way overkill, having a separate backend for roughly 10 lines of difference, no?)
(13:11:46) ordex: apparently the line difference is growing from time to time (+ consider all the ifdefs we are introducing)
(13:11:57) janjust: currently 10 lines, but at what point will libressl and openssl diverge further?
(13:12:24) cron2: we have all the ifdefs, the main difference today is "#if OPENSSL_VERSION ..." vs. "#if OPENSSL_VERSION || LIBRESSL" in very few places
(13:12:41) syzzer: cron2: no, not just that
(13:12:53) cron2: plus one configure check
(13:13:02) cron2: syzzer: what else is there?
(13:13:04) syzzer: because libressl is selectively backporting "good" API additions from newer openssl too
(13:13:32) syzzer: so that would mean adding all those HAVE_OPENSSL_XXX configure checks and defines
(13:13:55) ordex: what if we create a "sub"-cryptomodule inside openssl, where the libressl-specific functionalities are re-implemented, while keeping all the common code in one place ?
(13:13:57) cron2: if we start using them by means of #if OPENSS_VERSION > great_enough, then, yes
(13:14:04) ordex: similar to have a mini crypto backend
(13:14:40) cron2: ordex: that is not so much the point - I would be happy to state "if you want full functionality, go for openssl 1.1 - libressl and openssl 1.0 are stuck with limited functionality"
(13:14:51) cron2: the interesting bit happens when we decide to drop openssl 1.0, I'd say
(13:15:03) syzzer: correct
(13:15:07) ordex: mh ok
(13:15:49) syzzer: I would really like to be able to purge all the old code when dropping openssl 1.0 support
(13:16:18) syzzer: having both libressl and openssl in one backend will make that hard at best - maybe even prevent us from doing so
(13:16:25) janjust: RHEL/CentOS 7 uses openssl 1.0 and their EOL is ~2024 ... I don't think they'll update to Openssl 1.1 
(13:17:10) chipitsine [~ilia@...2369...] è entrato nella stanza.
(13:17:11) cron2: so that's another twist to it - do we want to support openssl 1.0 until 2024, or just declare "if you want 2.6 on RHEL7, install openssl 1.1"?
(13:17:49) syzzer: yeah, that discussion has never seen a real conclusion either
(13:17:57) janjust: hmmm or - when it comes to that - we at that moment create a new crypto backend with openssl 1.0+libressl support
(13:19:27) cron2: so maybe that is the answer?  keep libressl and 1.0 support in 2.5(?), drop 1.0 and libressl support in 2.6, and if someone wants it, they can come and maintain a ssl_cruft.c backend?
(13:20:01) janjust: I like that: ./configure --with-crypto=cruft
(13:20:09) ordex: without creating another backend in the meantime, right ?
(13:20:11) syzzer: yeah, I guess
(13:20:29) janjust: and yes, I'd propose to keep 1.0+libressl support in 2.5 
(13:20:55) cron2: and when we accept patches for LibreSSL support, we tag the corresponding source line with "/** LibreSSL and OpenSSL 1.0 workaround */" or something standardized?
(13:21:10) syzzer: so we'll accept patches like Jeremy's here for now? https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg15903.html
(13:21:26) cron2: (because the moment we use configure to find functions, "staring at the source" is suddenly non-obvious wrt "is this for 1.0? libressl? both" anymore)
(13:21:40) ordex: syzzer: in this mess, that is probably the cleanest approach, no ?
(13:21:50) cron2: syzzer: I would say "yes, but with an additional comment in the source, to tag for removal in 2.6"
(13:21:51) ordex: cron2: right
(13:21:53) syzzer: okay, let's do it that way
(13:22:11) ordex: :)
(13:22:28) ordex: syzzer: will you reply and provide this feedback to him ?
(13:22:36) syzzer: ordex: yeah, I will
(13:22:41) ordex: cool, thanks
(13:23:18) mattock: we're ~1 hour in
(13:23:41) mattock: I'd need to get some lunch - anything else we should discuss today? (we won't run out of patches I think)
(13:24:01) syzzer: we might want to make the libressl support status explicit by adding a #ifdef LIBRESSL_VERSION  msg(M_INFO, "You are using a LibreSSL backend, which is not officially supported.  It might work, it might be broken, no guarantees for you my friend") ?
(13:24:02) janjust: BTW syzzer: I'm still staring at that crypto bug that we ran into at the hackathon. 
(13:24:23) cron2: syzzer: ok for me
(13:24:33) syzzer: janjust: poke plaisthos, he had an idea about what is could be
(13:24:34) janjust:  msg(M_INFO, "You are using a LibreSSL backend and will burn in hell")
(13:24:49) janjust: syzzer, thx, will do
(13:25:00) ordex: lol +1 for the message, maybe stating also that it will be removed (?)
(13:25:36) syzzer: ordex: yeah.  "Unless a maintainer volunteers, this will be removed in 2.6"
(13:25:45) ordex: sounds good
(13:26:09) syzzer: ok, I'll take care of that
(13:26:36) chipitsine: tunnelblick is shipped with several openvpn binaries, default one is libressl
(13:27:02) syzzer: well, then they should be advised to use openssl as default instead
(13:28:08) syzzer: but Jonathan is usually quite active with following the list, and quite well understands what he's doing.  So I guess he can decide that for himself too.
(13:28:42) syzzer: anyway, that's it for today?
(13:28:46) ***syzzer getting hungry
(13:28:48) janjust: I think so
(13:29:03) ***janjust throws syzzer a 600 gr schnitzel
(13:29:14) syzzer: heh, well, not that hungry :p
(13:30:20) mattock: I'm trying to formulate a summary of the discussion
(13:30:28) ordex: :D
(13:30:33) janjust: "if you use libressl you will burn in hell" ?
(13:30:35) ordex: mattock: don't formulate too much or you may starve :P
(13:30:58) janjust: or better yet: consensus is that if you use .... bla bla
(13:31:45) syzzer: okay, I'm out for lunch then, before all the good stuff is gone ;)
(13:32:01) janjust: see you later syzzer, enjoy your lunch
(13:32:05) ordex: :P enjoy !
(13:32:22) mattock: laters!
(13:33:23) ordex: btw some patches on the ml have gotten ack/review/tested/blabla .. :]
(13:33:58) janjust: more seriously mattock on the summary:   after discussion it was agreed that Openssl 1.0 (and thus libressl) support will be dropped in OpenVPN 2.6. For OpenVPN 2.5, Openssl 1.1, 1.0 and libressl will be supported. If libressl support is deemed useful/necessary in OpenVPN 2.6+ then an active maintainer needs to stand up
(13:35:08) mattock: janjust: I think mine is roughly the same:
(13:35:08) mattock: Discussed status of LibreSSL support in OpenVPN. MacOS X and OpenBSD ship LibreSSL intead of OpenSSL and we want to support those platforms. However, LibreSSL is based on OpenSSL 1.0 which we don't want to support in the long term. Also, LibreSSL is becoming more and more incompatible with OpenSSL 1.0 as they keep backporting features from OpenSSL 1.1. This will complicate things for us as we need manage these incompatibilities somehow.
(13:35:08) mattock: For the above reasons we decided to keep LibreSSL and OpenSSL 1.0 support in OpenVPN 2.5 but drop it in OpenVPN 2.6 unless somebody volunteers to maintain it. We also decided to issue log warnings to users who are using LibreSSL.
(13:35:37) janjust: yours is much better , mattock :)
(13:35:43) mattock: thanks! :)
(13:35:55) mattock: I will send it after lunch
(13:36:10) ***janjust thinks mattock is the better bullshit artist  :p
(13:36:34) mattock: this is serious text janjust :)
(13:36:42) janjust: hehe I know
(13:36:51) ***janjust is out for some serious lunch
(13:37:01) mattock: have fun!


--------------987B427684335353AC8EEFDB--

