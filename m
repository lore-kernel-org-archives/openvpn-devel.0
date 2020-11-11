From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <d30b8aa4-30c5-4bfe-eba4-a78172686528@...515...>
Message-ID: <a94ab274-995e-7574-88b0-4d0e84ec0b41@...515...>
Date: Wed, 11 Nov 2020 14:00:05 +0200
MIME-Version: 1.0
In-Reply-To: <d30b8aa4-30c5-4bfe-eba4-a78172686528@...515...>
Content-Type: multipart/mixed; boundary="------------A4C5A6D0706915CBE73DF0BE"
Content-Language: en-US
Subject: [Openvpn-devel] Summary of the community meeting (11th Nov 2020)
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
--------------A4C5A6D0706915CBE73DF0BE
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Wed 11th November 2020
Time: 11:30 CET (10:30 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2020-11-11>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

becm, cron2, dazo, lev, mattock, ordex, plaisthos and zx2c4 participated 
in this meeting.

---

Talked about updating the Wintun driver (0.8.1) we bundle in OpenVPN 2.5 
installers to something more recent. Lev will take care of updating 
openvpn2 code to use userspace API. Zx2c4 will assist if lev hits any 
snags with the API.

---

Discussed a potential Wintun GPLv2 violation in OpenVPN Connect: it 
turns out that the Wintun MSM is embedded into OpenVPN Connect MSI.

Due to this zx2c4 is requesting OpenVPN Inc. to release the source code 
of OpenVPN Connect. We need to investigate this and do whatever actions 
are needed to ensure GPLv2 compliance.

Zc2c4 is also open to relicensing Wintun at some point.

-- 

Full chatlog attached


--------------A4C5A6D0706915CBE73DF0BE
Content-Type: text/plain; charset="utf-8"; name="openvpn_irc_meeting_chatlog_2020-11-11.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2020-11-11.txt"

(12:29:11) mattock: hello
(12:32:00) plaisthos: hey
(12:32:13) mattock: hi!
(12:33:39) ordex: hi!
(12:34:29) lev__: hello
(12:34:43) mattock: cron2, dazo?
(12:35:10) dazo: hey!
(12:35:38) becm: hi
(12:36:42) mattock: shall we?
(12:37:26) plaisthos: yes
(12:37:31) plaisthos: before I need to run for lunch
(12:37:33) mattock: https://community.openvpn.net/openvpn/wiki/Topics-2020-11-11
(12:37:37) mattock: the agenda is quite boring
(12:37:43) mattock: anything on 2.5 or 2.6?
(12:37:52) mattock: any other topics to bring up?
(12:38:28) plaisthos: WolfSSL still has not gotten us a version that actually works
(12:39:07) mattock: looks like it will get buried before 2.6 then
(12:39:19) plaisthos: yeah
(12:39:19) becm: possible WINTUN driver update?
(12:39:21) dazo: well, that was exactly our concern when they first approached us
(12:40:09) eworm [~eworm@...2498.../developer/eworm] è entrato nella stanza.
(12:40:55) mattock: becm: any particular issues that wintun update would address?
(12:41:35) plaisthos: well if we release a 2.5.1 it would be good to have the newest driver included
(12:41:42) cron2: uh
(12:41:44) becm: mattock: not to my knowledge.
(12:41:49) cron2: I'm stuck in a phone call, will be with you soon
(12:41:53) dazo: mattock: which version do we ship?
(12:41:57) mattock: plaisthos: agreed, that is not a problem
(12:42:04) lev__: 0.8.1 IIRC
(12:42:28) mattock: https://github.com/OpenVPN/openvpn-build/blob/master/windows-msi/version.m4
(12:42:37) mattock: lev is correct
(12:42:44) becm: effectively 0.8 (0.8.1 was installer-only update)
(12:43:27) cron2: now
(12:43:51) becm: this will be the first *update* of Wintun shipped with OpenVPN
(12:43:53) lev__: there is now 0.9 with at least  userspace API
(12:43:55) dazo: I see that there's some API changes by simon .... seems to be lots of clean-up and minor fixes, but we should ensure our implementation is up-to-date
(12:44:07) cron2: what is a "userspace API"?
(12:44:41) lev__: instead of use Device IOControl calls, there is now wintun.dll with exported functions like CreateDevice, RegisterBuffer etc
(12:45:15) becm: the whole installation process seems to have changed as well.
(12:45:19) lev__: https://git.zx2c4.com/wintun/about/
(12:45:20) vpnHelper: Title: wintun - Layer 3 TUN Driver for Windows (at git.zx2c4.com)
(12:45:57) zx2c4: dazo: "some api changes by simon"?
(12:46:14) zx2c4: from the perspective of kernel api, those changes are mine
(12:46:20) zx2c4: and it's also not just "someapi changes"
(12:46:36) dazo: zx2c4: I just skimmed the first commit page https://git.zx2c4.com/wintun/log/ .... and I see that it was far more comprehensive
(12:46:37) vpnHelper: Title: wintun - Layer 3 TUN Driver for Windows (at git.zx2c4.com)
(12:46:38) zx2c4: wintun.dll from simon and i is totally different
(12:46:47) dazo: I didn't mean to be condescending
(12:46:49) lev__: zx2c4: will DeviceIOControl approach still work?
(12:47:26) zx2c4: dazo: even skimming, thats ridiculous. you're a well known asshole when it comes to this stuff. i'd appreciate it if you stay out of this, if you want there to be any cooperation at all.
(12:47:49) zx2c4: lev__: maybe. but we're not going to guarantee it
(12:48:10) zx2c4: the interface now has moved to the userspace dll
(12:48:12) ordex: language please
(12:48:26) zx2c4: ordex: fuck off
(12:48:40) ordex: zx2c4: we are having an open meeting, what's wrong with you?
(12:48:52) zx2c4: ordex: you want my help or not? if so, please fuck off
(12:48:58) zx2c4: lev__: so the way forward is to migrate to wintun.dll
(12:49:09) zx2c4: there's a hook for the uninstaller to hit that should be pretty basic
(12:49:14) zx2c4: and overall deployment should be simplified
(12:49:24) zx2c4: also -- this will allow openvpn to work in "administrator mode" with wintun
(12:49:28) plaisthos: zx2c4: hm, what is the license on wintun.dll?
(12:49:29) dazo: zx2c4: I have no issues with Simon.  And it is wonderful wintun evolves.  Don't take everything we do here as an attack against you.  We DO try to cooperate.
(12:49:51) zx2c4: dazo: by publishing disinformation and hit pieces against wireguard?
(12:49:59) zx2c4: dazo: by sending me rude emails?
(12:50:05) zx2c4: dazo: you've done nothing to rectify your wrongs
(12:50:19) zx2c4: dazo: until you do, stay away.
(12:50:32) zx2c4: lev__: instead of just service-based mode, i mean, you can now run wintun.dll as normal admin
(12:50:32) ordex: zx2c4: how about you stay away from us?
(12:50:38) zx2c4: plaisthos: same as before
(12:50:49) zx2c4: ordex: i guess you don't want my help here
(12:50:53) zx2c4: see you later then
(12:51:03) ordex: I am speaking for myself
(12:51:04) dazo: zx2c4: In my last mail, which you never replied to, I invited you to have a meeting so we could sort things out.  I never heard anything back from you since that mail.  So I took that as you were not interested.
(12:51:23) plaisthos: zx2c4: well before you need just kernel calls, so the userspace did not need to link/include some other library
(12:51:28) zx2c4: ordex: then please fuck off too
(12:51:30) zx2c4: dazo: maybe i didnt get that? every email you've sent me has been more offensive than the past
(12:51:33) plaisthos: now it seems the wintun.ddl is GPL2 only
(12:51:42) zx2c4: dazo: if you'd like to improve relations, send me a new email epxlaining your perspective
(12:51:46) zx2c4: dazo: until then stay away from me
(12:51:51) zx2c4: plaisthos: its always been GPL2
(12:51:53) plaisthos: which even excluded the opensource OpenVPN3 AGPL3 from using it
(12:52:03) zx2c4: when has there ever been a syscall exception?
(12:52:17) dazo: zx2c4: okay, I'll follow up.  I do want us to have a reasonable cooperation.  We all benefit from it.
(12:52:39) zx2c4: syscall exception is a linux-variation of the GPL2
(12:52:44) zx2c4: we've never done that
(12:53:33) zx2c4: plaisthos: if you want to talk about us _relicensing_ wintun, that'd be a discussion to have. but nothing about the license status of wintun has changed since the project was announced, and the userspace dll doesnt change that
(12:53:43) plaisthos: okay let me rephrase that question
(12:54:06) plaisthos: Is it still possible to have a program that is not GPL2 to talk to wintun?
(12:54:15) zx2c4: it was never possible
(12:54:36) zx2c4: syscalls are included by the GPL2. tihs is why the linux kernel is released not under GPL2 but by "GPL2 with syscall exception"
(12:55:14) zx2c4: if anything we'd move wintun to LGPL instead of GPL
(12:56:30) zx2c4: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/COPYING
(12:56:32) vpnHelper: Title: COPYING - kernel/git/torvalds/linux.git - Linux kernel source tree (at git.kernel.org)
(12:57:06) zx2c4: plaisthos: so to the extent that openvpn3 has ever done something wintun, it's out of compliance with gpl2 and needs to C&D immediately
(12:57:30) zx2c4: but, if you'd like to have a licensing discussion on relicensing wintun to something more permissive, i wouldn't be opposed to discussing that.
(13:01:43) plaisthos: zx2c4: this not in bad faith or anything and I no license expert at all. For our old driver (which also GPL2) we never considered calling the driver via syscalls to be derivative work and also licensed the user space headers BSD to allow non GPL programs to use them
(13:02:02) plaisthos: so that is basically why I am surprised now
(13:02:24) zx2c4: sounds like simple ignorance. there's a reason why the Linux kernel has that exception
(13:04:17) plaisthos: the linux kernel is a whole kernel, so there is a very easy argument to make that any program you program against it, is considered derivative, e.g. the glibc.
(13:05:19) zx2c4: the exception is explicitly for syscalls.
(13:05:45) zx2c4: LGPL has exception for "linkage"
(13:05:46) zx2c4: etc
(13:06:02) zx2c4: I can write an exception into Wintun's licensing, needbe
(13:06:49) zx2c4: anyway, this is neither here nor there: we dont want to commit to that kernel interface longterm
(13:07:00) zx2c4: and so everything needs to go through the userspace library now
(13:07:35) zx2c4: that will let things gracefully upgrade as Microsoft adds additional functionality to the operating system, as well
(13:07:48) plaisthos: yeah. But I think we going nowhere with this disucssion over fine details that approach lawyer territory with exact definition of calling a GPL program vs calling a program via a non GPL kernel etc.
(13:08:47) plaisthos: The fact is that we want to mid to long term move away from TAP6 to Wintun as it is the supurior product
(13:08:50) zx2c4: plaisthos: you're just wrong about, and you can speak to a lawyer or read the internet if you need more assurance. but i'm not sure i have much to say
(13:09:23) zx2c4: yea, moving from tap6 to wintun seems like a good idea
(13:09:30) zx2c4: i can help facilitate that and deal with license stuff
(13:09:51) lev__: I can take the action point of updating openvpn2 code to use userspace API
(13:10:04) zx2c4: lev__: let me know if you need help or if you hit snags with the API
(13:10:10) lev__: yep
(13:10:11) plaisthos: but to be able to do that all the products needs to be able to use that wintun driver, including non-GPL ones
(13:10:14) zx2c4: lev__: I'm open to augmenting those APIs if you encounter weird things i didnt think of
(13:13:03) zx2c4: plaisthos: you are aware, also, that the tap6 installer code you took from me is also gpl2
(13:13:24) zx2c4: so if that code is being added to non free software, there's also a problem
(13:13:42) plaisthos: It is included in openvpn2 installer.
(13:14:01) zx2c4: https://github.com/OpenVPN/tap-windows6/blob/master/msm/installation.c this code, i mean
(13:14:18) mattock: that is only included in OpenVPN 2.x releases, that is, GPLv2 code
(13:14:22) mattock: 2.5
(13:14:26) zx2c4: if that's included in whatever "non-GPL" software youre referring to,thats a problem
(13:14:26) zx2c4: ah
(13:14:45) zx2c4: by the way, that reminds me
(13:15:13) plaisthos: I am sorry to leave now but I got to go to lunch, didn't expect this meeting to be that long
(13:15:24) mattock: plaisthos: have fun!
(13:15:28) plaisthos: hanks
(13:15:40) zx2c4: i saw in openvpn connect release notes
(13:15:44) zx2c4: a mention about detecting KB2921916
(13:15:52) zx2c4: https://openvpn.net/vpn-server-resources/openvpn-connect-for-windows-change-log/
(13:15:53) vpnHelper: Title: OpenVPN Connect for Windows change log | OpenVPN (at openvpn.net)
(13:15:55) zx2c4: "Added installer routine that ensures presence of a particular Windows hotfix on Windows 7 machines (KB2921916)."
(13:16:14) zx2c4: i looked everywhere for the source code of this detection but i couldnt find it
(13:16:19) zx2c4: is this part of the proprietary software?
(13:17:21) mattock: I have no clue where the installer code for OpenVPN Connect is, but OpenVPN Connect is closed-source on most platforms
(13:17:29) zx2c4: ahh
(13:17:46) mattock: the core is open source (openvpn3), but the GUI etc. around it is closed
(13:18:10) mattock: I don't know the exact details though, have not been involved with OpenVPN Connect ever
(13:18:52) plaisthos: zx2c4: We can probably get you a copy of that code if that is something you need for the wintun installer
(13:19:33) zx2c4: plaisthos: it looks like OpenVPN Connect uses https://github.com/OpenVPN/tap-windows6/blob/master/msm/installation.c
(13:19:48) zx2c4: so i guess i'd like to have the sourcecode of OpenVPN Connect under the GPL2
(13:20:10) zx2c4: plaisthos: i found a method of my own. i was just kinda curious to see what you did there, but then i couldnt find it
(13:20:46) zx2c4: looks like OpenVPN Connect also ships wintun
(13:21:09) zx2c4: (im looking at the msi right now)
(13:24:31) lev__: according to our Connect guys, that code is not used in Connect clients
(13:24:46) lev__: (just asked)
(13:24:52) zx2c4: looks like it's actually using installer.dll from wintun 0.8.1
(13:25:00) zx2c4: which is virtually the same code
(13:25:11) zx2c4: https://git.zx2c4.com/wintun/tree/installer/installation.c?h=0.8.1
(13:25:12) vpnHelper: Title: installation.c « installer - wintun - Layer 3 TUN Driver for Windows (at git.zx2c4.com)
(13:25:41) zx2c4: anyway, as pointed out by plaisthos, Wintun has never been compatible with non-free software
(13:26:27) zx2c4: so I'd like to you provide me with the source code of OpenVPN Connect for Windows, and also immediately cease and desist using the GPL code
(13:26:47) zx2c4: separately, we can talk about me relicensing wintun, since i'd definitely like for it to be maximally useful to people
(13:27:48) zx2c4: i'm not opposed to relicensing under something more permissive!
(13:29:04) mattock: regarding wintun + openvpn connect - who is actually responsible for it?
(13:29:17) lev__: zx2c4: Connect doesn't use wintun installer code
(13:29:37) zx2c4: lev__: sure looks that way to me...
(13:29:51) zx2c4: it's embedded the msm
(13:29:53) zx2c4: no?
(13:30:01) zx2c4: and anyway, there's still the syscall interface
(13:30:13) mattock: zc2c4: what is the file you've dissected?
(13:30:15) lev__: yes, msm's are used
(13:30:45) lev__: are you saying that MSMs cannot be used in proprietary products ?
(13:31:25) mattock: I would suppose that MSM extends the MSI, thus "tainting" it if MSM has GPLv2 code
(13:32:16) mattock: that said, I have no clue what the OpenVPN Connect MSI contains
(13:33:14) mattock: anyhow, I propose we investigate this thing properly and take any action that is needed
(13:33:44) becm: for OpenVPN2; shipping WINTUN 0.9 MAY run into https://github.com/OpenVPN/tap-windows6/issues/129
(13:33:50) lev__: yes, Connect installed indeed embeds wintun msm
(13:34:38) zx2c4: lev__: in fact, installer.dll still has my original signature on it
(13:34:59) zx2c4: becm: wintun 0.9 takes care of that i think
(13:37:35) becm: zx2c4: I saw some changes but was unable to follow the restructure. The forced deletion was removed in one place (only)
(13:37:46) zx2c4: becm: right
(13:37:52) zx2c4: so here's how it works:
(13:38:08) zx2c4: forced deletion is only used when we're 100% that the driver is no longer loaded in memory
(13:38:18) zx2c4: the one place it's removed is the place that uninstallers are supposed to call
(13:38:38) zx2c4: and we dont use force there
(13:38:46) zx2c4: in case other users of wintun still have it activev
(13:40:13) mattock: lev: can you bring the OpenVPN Connect MSI + Wintun MSM GPLv2 thing up with the OpenVPN Connect team?
(13:40:24) mattock: it can be escalated as needed from there
(13:40:37) zx2c4: mattock: it's not only the MSM
(13:40:44) zx2c4: the driver itself is offlimits for non GPL
(13:40:59) mattock: I'll add that to the summary and we'll escalate it properly
(13:41:22) zx2c4: thanks. i'd also like to formally request all of the openvpn connect source code
(13:41:38) lev__: mattock: yes I am discussing it with Connect team
(13:41:46) zx2c4: (i've downloaded it from the webpage, and therefore it's been distributed to me)
(13:42:10) zx2c4: lev__: mattock: I urge you guys to open up a discussion with me about *relicensing* wintun, at some point
(13:42:16) zx2c4: because allof this is pretty easily fixable
(13:44:03) mattock: +1
(13:44:19) mattock: lev: keep me posted on progress, we may need to escalate this
(13:44:25) mattock: may/will :D
(13:45:17) lev__: join internal channel :)
(13:45:20) mattock: ah
(13:45:20) mattock: ok
(13:45:37) mattock: I probably dropped out from there because of "too many channels, won't follow any of the anyways"
(13:45:38) mattock: :)
(13:47:43) mattock: anyways, I'll write all of this to the summary
(13:53:05) becm: zx2c4: I'm just confused about SelectDriver() code: Trying to disable an adapter would indicate there ARE still adapters and disabling them (at least in the old version) was not enough to allow clean driver removal.
(13:54:08) zx2c4: becm: disabled drivers unload the kernel module
(13:54:20) zx2c4: erm, thats gibberish let me try again
(13:54:25) zx2c4: disabled adapters unload the kernel driver

--------------A4C5A6D0706915CBE73DF0BE--

