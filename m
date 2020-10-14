From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <4bf0a788-1a6a-34a8-7ecf-587d23c3eb6b@...515...>
Message-ID: <3c789b24-f957-71e1-fac8-f9ae6d3846f1@...515...>
Date: Wed, 14 Oct 2020 13:20:39 +0300
MIME-Version: 1.0
In-Reply-To: <4bf0a788-1a6a-34a8-7ecf-587d23c3eb6b@...515...>
Content-Type: multipart/mixed; boundary="------------A2CB053BB06147C0F7CE9081"
Content-Language: en-US
Subject: [Openvpn-devel] Summary of the community meeting (14th Oct 2020)
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
--------------A2CB053BB06147C0F7CE9081
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Wed 14th October 2020
Time: 11:30 CEST (9:30 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2020-10-14>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

becm, cron2, dazo, lev, mattock and ordex participated in this meeting.

---

The OpenVPN website is under maintenance now. This has prevented us from 
releasing 2.5-rc3. The maintenance should be finished today California time.

--

Agreed that we tag 2.5-rc3 today and release it tomorrow, if possible. 
Then in the next community meeting (Thu 22nd) we decide when to push out 
2.5.0.

--

Noted that some pages on https://openvpn.net are empty and look silly:

<https://openvpn.net/download/openvpn-2-5-rc2/>

There is an internal OpenVPN Inc. ticket for this issue already.

--

Noted that OpenVPN 3 Linux client 11 beta will be out this week. Its 
main feature is the inclusion of kernel acceleration (DCO). A recent OS 
like Ubuntu 20.04 or Fedora 32 is required to use it.

Also noted that the DCO API is not yet properly documented and that it 
should be. That way kernel acceleration could be implemented more easily 
on non-Linux kernels.

--

Noted that IPv6 is still not enabled on the openvpn.net domain in 
Cloudflare. Mattock and ordex will keep pressure on the correct people 
at OpenVPN Inc. to get this fixed.

--

Full chatlog attached


--------------A2CB053BB06147C0F7CE9081
Content-Type: text/plain; charset="utf-8"; name="openvpn_irc_meeting_chatlog_2020-10-14.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2020-10-14.txt"

(12:30:33) cron2: hullo!
(12:32:24) ordex: hillo!
(12:34:16) lev__: hello
(12:35:28) dazo: yay!
(12:37:07) cron2: so
(12:37:18) cron2: where is mattock?
(12:38:18) cron2: it#s not a "shit meeting", we're not corp :-)
(12:39:07) ordex: :p
(12:39:08) dazo: :-P
(12:39:14) ordex: he must be hiding
(12:39:16) ordex: mattock: !!
(12:39:32) dazo: he appeared in the wrong channel :-P
(12:39:45) cron2: he is in here, he's just ignoring us
(12:39:54) cron2: 11:39 -!-  ircname  : Samuli Sepp\u00e4nen
(12:39:54) cron2: 11:39 -!-  channels : @#openvpn-meeting @#openvpn-devel
(12:40:07) cron2: anyway
(12:40:15) cron2: this is either a short or a very long meeting...
(12:40:23) mattock: hello
(12:40:35) dazo: 2.5 status
(12:40:39) mattock: sorry, was distracted by "real work" :D
(12:40:44) cron2: from the "openvpn repo" side of things, RC3 looks good - there is a few bugfixes in, so "having RC3 this week, 2.5.0 next week" sounds reasonable
(12:41:00) cron2: I am not sure about the windows installer / TAP driver status
(12:41:04) dazo: mattock: nono ... you got it reversed .... *this* is _real_ work ;-)
(12:41:27) mattock: the main blocker is that the website is being updated, so it does not make sense to release anything until that is done
(12:41:45) dazo: cron2: I'll have a look at your argv patch .... quick glance looks good, just want to stare a bit more on the code
(12:41:49) mattock: because the download page would get wipe and things would probably end up in 404 hell with cloudflare etc
(12:42:10) mattock: hopefully the rc3 release can be made tomorrow so that it sticks on the dl page
(12:42:48) lev__: mattock: can you make sure those page are removed or filled with content https://openvpn.net/download/openvpn-2-5-rc2/
(12:42:49) vpnHelper: Title: OpenVPN 2.5-rc2 | OpenVPN (at openvpn.net)
(12:42:55) dazo: mattock: krzee has been pretty good at beating up the cloudflare/aws cloudfront caching .... he's done wonders with some scripts
(12:43:27) mattock: lev: sure, I can scrap the betas and older rc releases when making rc3 release
(12:43:30) dazo: lev__: I believe they're looking at doing a 304 redirect or so
(12:43:52) mattock: lev: oh, I misunderstood
(12:44:02) mattock: I believe there is a ticket about those "empty pages"
(12:44:04) mattock: let me check
(12:44:52) eworm [~eworm@...2498.../developer/eworm] è entrato nella stanza.
(12:45:08) mattock: lev: you created a ticket: https://openvpn.atlassian.net/browse/OW-382
(12:45:09) vpnHelper: Title: Log in with Atlassian account (at openvpn.atlassian.net)
(12:46:30) lev__: yes, but it has been 3 weeks and pages are still there
(12:47:06) mattock: I don't have a magic bullet
(12:47:39) mattock: one way to convince them to fix it is to show that google spits those stupid URLs to people
(12:47:40) dazo: lev__: Matt and Doug are on it ... so lets they tackle that
(12:47:54) mattock: I was unable to get a link from Google to those broken pages
(12:47:56) dazo: "We will also no-index these pages and inform Search Console about this as well. "
(12:48:08) dazo: back to 2.5 release, shall we?
(12:48:13) mattock: yes
(12:50:14) cron2: so, how's the windows installer/tap side looking?
(12:50:27) mattock: well, I don't see any blockers there
(12:50:39) mattock: I did not start the process yet as this website thing made it kind of unnecessary
(12:50:57) mattock: I built new tap-windows6 some days ago
(12:51:04) cron2: so... if we get out RC3 tomorrow, and nothing unexpected comes up - 2.5.0 release when?
(12:51:09) mattock: so it is just "package as MSM" then build OpenVPN installers
(12:51:18) mattock: let's give it a week?
(12:51:26) lev__: latest fix was few weeks ago, which improved housekeeping on upgrade
(12:51:34) dazo: So ... lets aim for tagging rc3 today, release tomorrow .... and 2.5.0 go/nogo decision on Thursday (next meeting)?
(12:51:44) mattock: +1
(12:51:44) cron2: +1
(12:52:14) mattock: anything else or are we done? :)
(12:52:57) becm: someone want to contact Wintun guys for the MSM fix, or just "wait till it blows up on 0.9"?
(12:52:59) cron2: I'm good.  There is a "NULL pointer in the (unlikely) error case" patch out that dazo is reviewing
(12:53:12) dazo: yeah, I'm good too
(12:53:46) cron2: becm: hi.  And yeah, good question.  Is this crucial to have "just now" or is it crucial on the next driver update?
(12:54:01) becm: cron2: next driver update.
(12:54:15) dazo: btw ... This week I'm wrapping up deb/rpm packages for ovpn-dco ... and will release openvpn3-linux-11_beta - with DCO as the main feature.  This release will primarily target Fedora 32/33 and Ubuntu 20.04 - as ovpn-dco currently requires a fairly new kernel
(12:54:59) becm: but they do not necessarily bump driver versions on installer releases.
(12:55:08) dazo: (DCO - Data Channel Offload - kernel module for OpenVPN)
(12:55:10) lev__: dazo: 5.4 should be enough
(12:55:15) becm: 0.8.1 MSM ships 0.8 driver
(12:55:28) dazo: lev__: that's basically Ubuntu 20.04 and Fedora 32+ :-P
(12:55:52) dazo: (Debian 10 and CentOS 8 are currently too old for ovpn-dco)
(12:56:19) lev__: it also used to work with ubuntu 18 with 5.3
(12:57:07) cron2: dazo: nice.  Is the DCO API for Linux the same for "old" and "new" kernel module, or is this all totally new?
(12:57:11) cron2: is the API considered "stable"?
(12:57:37) dazo: lev__: well, since 20.04 is an LTS, I don't care that much about 18.04 now .... I'll enable the DCO features in openvpn-linux on as many platforms as possible, but it will require ovpn-dco to function
(12:58:28) lev__: it is totally new, we had to switch to netlink from ioclt
(12:58:36) dazo: ordex: should probably answer that ... but ovpn-dco uses a netlink API to the kernel to do all setup and key passing, I believe the ovpn-dco API itself is fairly stable now
(12:58:44) ordex: yeah, totally different
(12:58:44) cron2: oh, so it's all netlink now?
(12:58:57) ordex: kovpn (old module) uses an approach considered deprecated
(12:58:58) dazo: yeah
(12:59:05) ordex: yap
(12:59:27) dazo: we would never stand a chance to get ovpn-dco upstream ioctl
(12:59:38) dazo: *with* ioctl
(13:00:13) ordex: cron2: and no, the API is not considered stable
(13:00:34) ordex: even though we have no plans for big changes, but we're still in the experimental phase
(13:00:38) ordex: and will probably be for a bit
(13:01:09) cron2: dazo: how's your RFC?  Is there a draft I could show someone who asks "how does this work"?
(13:01:20) cron2: a FreeBSD kernel developer showed interest in DCO...
(13:01:43) dazo: cron2: it's far down in a box filled with dust .... I need to resurrect it
(13:01:46) cron2: and before I explain the packet format with data/control and opcode and everything... if we have a better document...
(13:02:26) dazo: cron2: that'd be cool .... I think the first natural step would be to see if there is a netlink API for ip/route setup on FreeBSD, so we can build on similar mechanisms in regards to porting ovpn-dco to BSD
(13:03:34) cron2: there is a route socket - see "route.c" in our sources :-)
(13:03:36) dazo: cron2: I can probably extract much of the RFC styled things into a .rst file which at least gives a better overview of the protocol.  AFAIR, the current RFC draft has lots of open gaps
(13:03:51) cron2: dazo: that would be very welcome
(13:05:23) cron2: ordex: and if you have something "what does the userland need to do, when, to make DCO fly?" that would also be very nice :-)
(13:06:00) dazo: there's a simple p2p test case in the ovpn-dco project, iirc
(13:06:13) ordex: cron2: you mean to make the linux ovpn-dco fly ?
(13:06:30) ordex: in that case, yeah, there is a small tool (ovpn-cli.c) in the ovpn-dco's tests folder
(13:06:34) lev__: https://github.com/OpenVPN/ovpn-dco/blob/master/tests/ovpn-cli.c
(13:06:34) dazo: cron2: https://gitlab.com/openvpn/ovpn-dco/-/blob/master/tests/ovpn-cli.c
(13:06:36) vpnHelper: Title: ovpn-dco/ovpn-cli.c at master · OpenVPN/ovpn-dco · GitHub (at github.com)
(13:06:37) vpnHelper: Title: tests/ovpn-cli.c · master · OpenVPN / OpenVPN DCO · GitLab (at gitlab.com)
(13:06:40) ordex: which can be used almost ad if it was ip
(13:06:44) ordex: *as
(13:06:54) ordex: :D
(13:07:01) ordex: yeah!
(13:07:08) cron2: ordex: more like "documentation that is *not* code"
(13:07:57) ordex: cron2: what exactly are you after? how to *use* it with one of our clients? or how to *implement* a userspace daemon that works with ovpn-dco ?
(13:08:22) cron2: "how does the API work" => "what is needed to implement userland?"
(13:08:48) ordex: ok. no I don't have extensive doc yet
(13:09:02) cron2: you'll send a patchset to 2.x one day, and to review this, documentation is helpful
(13:09:11) cron2: "is it doing what the docs say it should be doing?"
(13:10:02) ordex: yeah
(13:10:41) dazo: ordex has made the module so that if the implementation is incorrect, your computer will crash'n'burn .... so if it works, it's correct :-P
(13:12:12) ordex: :p
(13:12:17) ordex: well, it won't work :)
(13:12:23) mattock: anything else on DCO or other topics?
(13:12:39) mattock: my hand is itching to press the "Send" button D:
(13:12:40) mattock: :D
(13:13:03) dazo: I'm fine :)
(13:13:40) ordex: mattock: any news on IPv6 ?
(13:13:47) ordex: or we stand where we were before ?
(13:13:50) mattock: no, but I will bring it up again tomorrow
(13:13:53) cron2: thanks
(13:14:08) mattock: ordex et al: you could also bug andrew about it
(13:14:17) mattock: more noise => more chances of getting it fixed
(13:14:41) ordex: ok
(13:14:43) ***ordex engages
(13:14:48) mattock: (in a reasonable time, at least)
(13:14:48) ordex: I Wasn't sure who was supposed to be bugged
(13:15:00) mattock: now you know :)
(13:15:17) mattock: anyhow, I will head to lunch unless there's something else
(13:15:24) dazo: ordex: do it in the open ops channel .... so the whole Core team can publicly rant about it! :-P
(13:15:26) ordex: cron2: does this lack of IPv6 create issues somewhere ?
(13:15:50) cron2: it irks me
(13:16:03) cron2: and that makes me speak badly about openvpn inc
(13:16:06) mattock: yeah, and also we should have IPv6
(13:16:26) cron2: and if that goes on, I'll start using IPSEC instead!
(13:16:37) dazo: cron2: wireguard!  that'll kick them off!
(13:16:46) mattock: I mean, it was probably disabled for no particular reason
(13:16:54) mattock: originally
(13:17:03) cron2: dazo: I didn't say that because Jason would see it as offensive joke again, and I did not want that
(13:17:26) ***ordex hides
(13:17:27) dazo: oh well ...
(13:17:31) ordex: but yeah
(13:17:32) ordex: sounds good
(13:17:33) ordex: thanks
(13:17:40) mattock: yes, let's end this thing
(13:17:41) ordex: anyway, I don't have anything else either :)

--------------A2CB053BB06147C0F7CE9081--

