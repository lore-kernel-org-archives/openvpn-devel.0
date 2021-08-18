From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <420f8ab2-24ed-e57d-cc83-1c3b4beaea92@...515...>
Message-ID: <590a405b-436c-077d-6390-1e852a820244@...515...>
Date: Wed, 18 Aug 2021 15:41:57 +0300
MIME-Version: 1.0
In-Reply-To: <420f8ab2-24ed-e57d-cc83-1c3b4beaea92@...515...>
Content-Type: multipart/mixed; boundary="------------80FC28472D873A0ACC4E2762"
Content-Language: en-US
Subject: [Openvpn-devel] Summary of the community meeting (18th August 2021)
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
--------------80FC28472D873A0ACC4E2762
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on libera.chat
Date: Wed 18th August 2021
Time: 14:00 CET (12:00 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2021-08-18>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

dazo, d12fk, lev, mattock, MaxF and plaisthos participated in this meeting.

---

Noted that lev merged the reproducible-build commits in ovpn-dco-win. He 
is also working on eliminating excessive copying in ovpn-dco-win, which 
should make performance even better.

---

Mattock is progressively changing the Windows MSI installer (WiX) code 
to use files from the new OpenVPN msbuild build process:

<https://github.com/OpenVPN/openvpn-build/pull/224>

It should not take many hours to complete the transition as it is moving 
forward nicely.

---

Plaisthos wants to add chachapoly to data-ciphers by default if it is 
available as lowest priority algorithm. So, clients will just report one 
more cipher in data-ciphers and the server will accept clients that only 
offer chacha but not aes instead of rejecting them.

Agreed that this approach makes sense.

---

Mattock is still waiting access to a (Terraform) repository which would 
enable him to create the new production buildmaster.

---

Talked about IPv6 support for community.openvpn.net. Dazo had raised the 
issue in an internal meeting. No visible progress on that front.

---

Talked about moving OpenVPN 2.4 to "oldstable" support:

<https://community.openvpn.net/openvpn/wiki/SupportedVersions>

Right now we're collecting patches for the final (2.4.12) release.

-- 

Full chatlog attached

--------------80FC28472D873A0ACC4E2762
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2021-08-18.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2021-08-18.txt"

(14:58:23) mattock: hello!
(14:58:44) d12fk: good day!
(15:00:10) dazo: Hey!
(15:00:39) mattock: it seems I'm feeling more ill (normal flu) than yeste=
rday, but I think I can endure this meeting
(15:01:55) mattock: well, flu + kid at home and not at kindergarten is no=
t exactly a winning combination :)
(15:02:04) mattock: + having to work
(15:02:29) mattock: who else do we have here today?
(15:02:34) lev_: hello
(15:03:50) dazo: mattock: feel your pain .... that's an impossible fight,=
 just surrender and have fun with the kids instead and let the rest go
(15:04:44) mattock: we take shifts, which would be "ok", but the flu make=
s it all the more annoying
(15:04:58) mattock: anyhow, I think tomorrow I'll be in near-ok condition=

(15:05:01) plaisthos [~arne@...1423.../developer/plaisthos] =C3=A8 entrato n=
ella stanza.
(15:05:02) modalit=C3=A0 (+o plaisthos) da ChanServ
(15:06:31) mattock: cron2 here today?
(15:07:29) cron2_: no, sorry
(15:07:45) cron2_: just came up to say "won't make it", feed the family n=
ow, then pack stuff
(15:07:51) MaxF: hi!
(15:08:25) mattock: hi and ok :)
(15:08:33) mattock: let's move on then
(15:09:04) mattock: https://community.openvpn.net/openvpn/wiki/Topics-202=
1-08-18
(15:09:06) mattock: sync up
(15:09:14) dazo: Is plaisthos around?
(15:09:18) plaisthos: yes
(15:09:39) dazo: you are probably most up-to-date 2.6 stuff right now
(15:09:41) dazo: :)
(15:10:08) plaisthos: Yeah, but I basically took a few days off work sinc=
e last meeting and so status has not really changed
(15:10:19) plaisthos: at least from my side
(15:10:20) dazo: fair enough
(15:10:45) dazo: so, slowly moving progress but not too much happened sin=
ce last week,
(15:12:03) MaxF: @lev_ merged the reproducible-build commits in ovpn-dco-=
win
(15:14:00) mattock: at my end the Windows WiX packaging changes are progr=
essing: https://github.com/OpenVPN/openvpn-build/pull/224
(15:14:14) dazo: great!
(15:14:24) ***lev_ also works on eliminating excessive copying in ovpn-dc=
o-win, which should make performance even better=20
(15:14:33) mattock: I'm going through files going to the MSI installer, h=
ardcoding the paths (at first), and regression testing after a few change=
s
(15:14:55) mattock: so right now the build script has the "old style" (ge=
nerated by "generic" buildsystem") files
(15:15:12) mattock: and I'm migrating it over to the new files from vcpkg=
 and openvpn msbuild progressively
(15:15:29) mattock: the process seems to work very well, so it should not=
 take that many hours to complete
(15:16:54) mattock: any other updates on 2.5/2.6?
(15:17:31) plaisthos: I want add chachapoly to data-ciphers by default if=
 it is available as lowest priority algorithm
(15:17:45) ***lev_ is discussing "Import from URL" feature with Selva to =
make it more community-friendly
(15:18:15) plaisthos: rationale it is that more user friendly if someone =
wants to use chacha, they only need to touch client or server
(15:19:23) dazo: I think that makes sense ... the signalling should be in=
 place for this to be handled gracefully, right?
(15:19:36) plaisthos: sure
(15:19:55) plaisthos: clients will just report one more cipher in data-ci=
phers
(15:20:05) dazo: exactly, so lets do that
(15:20:27) plaisthos: and for the server if will accept clients that only=
 offer chacha but not aes instead of rejecting them
(15:21:15) dazo: which makes sense ... if the client tries only a single =
cipher server is not willing to accept, that's a incompatible client chan=
ge -> not expected to work
(15:27:37) dazo: anything else?
(15:28:23) dazo: seems not :)
(15:28:44) mattock: not from end, except that I'm still waiting to get th=
e repository permissions I need to spin up the new production buildmaster=

(15:29:03) mattock: there was some movement on it yesterday, but still la=
cking perms
(15:29:05) d12fk: is v6 for community even a topic anymore?
(15:29:27) dazo: item #2 -> move 2.4 to old stable support, that's no rus=
h but worth keeping a bit longer .... no need to dive into that now
(15:29:44) mattock: v6 for community - no progress afaik
(15:29:59) mattock: I think it will just happen at some point when nobody=
 expects it
(15:29:59) dazo: ipv6 is still an open issue ... I raised the issue in an=
 internal company meeting last week again
(15:30:32) dazo: mattock: you still got the proper privileges to sneak in=
 ipv6 enabling without revealing yourself? :-P
(15:30:45) mattock: I don't think so
(15:31:01) mattock: even if I had, I would not dare do it
(15:31:10) mattock: I'm chickenshit just like the rest of the crown
(15:31:12) mattock: crowd
(15:31:15) mattock: :)
(15:31:26) dazo: :-P
(15:31:29) mattock: I mean, if it was planned and all that, I would dare =
flip the switch
(15:31:40) mattock: but doing it in the dark without telling anyone - sur=
e hell no :)
(15:32:14) mattock: 2.4 to old stable?
(15:32:20) mattock: any reason not to?
(15:32:48) mattock: it would be nice not to have to maintain multiple bui=
ldsystems for Windows
(15:33:07) mattock: well, windows-nsis does not need _active_ maintenance=
, but still
(15:33:08) dazo: just waiting for a next release (2.4.12, I believe) ... =
so just collecting up a few minor more things if they appear until you ha=
ve time to spin the last round of 2.4 releases
(15:33:16) mattock: oh yes
(15:33:56) mattock: any porting from "master" (e.g. compatibility things)=
 we'd like to have there?
(15:34:16) mattock: like 2.6 <-> 2.4 compatibility
(15:34:58) dazo: I don't think so, but plaisthos might have a better over=
view
(15:37:13) mattock: ok
(15:37:18) mattock: anything else to discuss?
(15:37:24) dazo: not on my end
(15:37:50) d12fk: quick one then
(15:37:54) dazo: so calm and quiet here when cron2 and ordex is missing .=
=2E... :-D
(15:38:04) mattock: looks like it!
(15:38:11) mattock: ok let's end this thing then
(15:38:25) dazo: d12fk: shoot!
(15:38:35) d12fk: hope you feel better soon mattock
(15:38:41) mattock: thanks, I'm sure I will
(15:38:54) d12fk: dazo: I meant the meeting =3D)
(15:39:00) dazo: ahh
(15:39:20) dazo: alrighty ... so that's a wrap :)
(15:39:34) MaxF: by the way, I'll be on vacation for the next two weeks
(15:39:34) d12fk: kk bye
(15:39:41) MaxF: bye!
(15:40:45) mattock: have a nice vacation MaxF!

--------------80FC28472D873A0ACC4E2762--

