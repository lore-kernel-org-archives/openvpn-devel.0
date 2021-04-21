From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <1226b24c-ea68-6336-a320-1d065f9d3a13@...515...>
Message-ID: <f4ea81d5-d0e8-aa03-85cd-387b7fe4c64c@...515...>
Date: Wed, 21 Apr 2021 16:15:13 +0300
MIME-Version: 1.0
In-Reply-To: <1226b24c-ea68-6336-a320-1d065f9d3a13@...515...>
Content-Type: multipart/mixed; boundary="------------D9E0148295CC87F36BE01B73"
Content-Language: en-US
Subject: [Openvpn-devel] Summary of the community meeting (21st April 2021)
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
--------------D9E0148295CC87F36BE01B73
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Wed 21st April 2021
Time: 14:00 CET (12:00 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2021-04-21>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, dazo, d12fk, lev, mattock, ordex and plaisthos participated in 
this meeting.

-- 

Noted that OpenVPN 2.5.2 and 2.4.11 are out and include important 
security fixes. Fixes to "master" and release/2.3 branch will follow soon.

Also wrote our security announcement for those releases:

<https://community.openvpn.net/openvpn/wiki/CVE-2020-15078>

--

Noted that Lev is working on the ovpn-dco MSI installer.

--

Discussed AWS MacOS instances in context of Buildbot. Noted that they're 
essentially dedicated Mac Minis and the minimum billing is one day. So, 
not really disposable virtual machines you could use for five minutes 
and get rid of. The daily price is around $25.

There is an internal OpenVPN Inc. ticket for providing a virtualized 
MacOS VM for use by the community. So we don't need the overprices AWS 
Mac Minis for this.

--

Noted that mattock is 90% free from OpenVPN ops work now. [This means 
the Buildbot environment upgrade can start soon].

---

Full chatlog attached

--------------D9E0148295CC87F36BE01B73
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2021-04-21.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2021-04-21.txt"

(15:01:58) mattock: hi
(15:02:00) plaisthos: hey
(15:02:15) ordex: we stic to the chat?
(15:02:19) cron2: *burb*
(15:02:19) ordex: *stick
(15:02:50) ordex: *prot*
(15:03:18) mattock: chat is fine for me, easier to summarize :)
(15:04:10) ordex: kk
(15:04:15) mattock: I'll add the agenda page
(15:05:48) mattock: I stripped out pretty much everything: https://commun=
ity.openvpn.net/openvpn/wiki/Topics-2021-04-21
(15:05:55) mattock: the previous meeting agenda was also a summary
(15:06:05) ordex: 2.5.2 is out - congrats!!!
(15:06:18) ordex: our palindrome release
(15:06:39) dazo: heh :)
(15:06:58) mattock: added back some stuff
(15:07:18) mattock: also known as "The Plaishos Release"
(15:07:49) dazo: Plaisthos Pandora Box Release
(15:08:12) mattock: "State machine release"
(15:08:12) dazo: but .... so ... topics?
(15:08:15) plaisthos: why my release?
(15:08:20) mattock: 10 patches from you
(15:08:25) mattock: and your Pandora's box
(15:08:27) mattock: :)
(15:08:38) ordex: anything specific to discuss about 2.5 at the moment ?
(15:08:46) mattock: no
(15:08:50) ***cron2 is annoyed about 2.4.11
(15:08:58) ordex: cron2: because of the patch?
(15:09:01) cron2: yes
(15:09:11) dazo: I'm finalizing the Fedora, EPEL and Copr builds for 2.4 =
and 2.5
(15:09:19) ordex: you could change the commit and repush and retag
(15:09:24) ordex: not sure anybody has pulled yet
(15:09:28) ordex: but might be ugl
(15:09:29) ordex: y
(15:09:40) dazo: what about .11?
(15:09:50) mattock: rewriting history should be reserved for kings, emper=
ors and bishops
(15:10:10) cron2: ordex: no, never
(15:10:24) ordex: cron2: I agree - but wanted to see if you could feel a =
little better :p
(15:10:25) cron2: dazo: the commit message for "the CVE patch" is... lack=
ing
(15:10:36) dazo: As the emperor, I announce cron2 as a king :-P
(15:11:04) cron2: yeah, but rewriting *public* history needs lots of "bur=
ning books" and I'm not going to do that :-)
(15:11:09) ordex: we could/should come up with a wikipage about this secu=
rity situation maybe? and there we could add links to the commits? this w=
ay the 2.4.11 commit would somewhat be logically extended
(15:11:32) cron2: we have a wiki page and refer to it from Changes.rst
(15:11:33) cron2: https://community.openvpn.net/openvpn/wiki/SecurityAnno=
uncements
(15:11:38) dazo: cron2: force-push of an amended commit message might be =
acceptable, if it's just the last commit needing changes .... otherwise t=
here is the 'git note', which is a bit annoying to push and fetch
(15:11:41) dazo: but!
(15:11:43) cron2: so that should now be maintained
(15:11:47) dazo: we could use tags here as well ....
(15:12:09) cron2: dazo: well, it's the commit before that... and the rele=
ase has a signed tag... nothing good will come out of this
(15:12:11) dazo: tag the release with cve/2020-xxxx .... and a signed tag=
 can have the appropriate message
(15:12:53) plaisthos: is this really a big deal?
(15:12:55) cron2: we've never used CVE IDs as tags, and it won't triviall=
y work anyway as the CVE is fixed in 2.4, 2.5 and master (eventually)...
(15:13:10) dazo: oh, true
(15:13:18) cron2: plaisthos: it totally annoys *me*, but in the grand sch=
eme, it's probably not that important
(15:13:21) ordex: honestly, I think we can live with this. I don't think =
it's a big deal
(15:13:29) mattock: my hope is that whatever we do does not require 2.4.1=
2
(15:13:41) ordex: I presume 3 or 4 people in total will look at the relea=
se/2.4 branch
(15:13:46) ordex: mattock: nope
(15:14:36) mattock: anyways, do we have the text for https://community.op=
envpn.net/openvpn/wiki/SecurityAnnouncements ?
(15:14:49) dazo: nope
(15:14:50) cron2: use the one from the announcements you sent :-)
(15:14:57) mattock: well if that's good enough
(15:15:01) ordex: maybe we can partly re-use what was written by corp and=
 by mattock in his email?
(15:15:13) ordex: or the corp announcement is too AS related?
(15:15:16) mattock: mattock's email came from Changes.rst
(15:15:29) plaisthos: you can at least take parts of it
(15:15:40) plaisthos: but the crop announcements has some AS specific in =
it
(15:15:54) mattock: someobody invent a title or I will take that from the=
 commit message(s) :D
(15:15:58) plaisthos: e.g. that you need a profile since an AS server alw=
ays requires a client cert
(15:16:15) ordex: kk
(15:16:25) plaisthos: I like this:
(15:16:26) plaisthos: https://community.openvpn.net/openvpn/wiki/Security=
Announcement-f375aa67cc
(15:16:29) plaisthos: :D
(15:17:02) mattock: :)
(15:17:06) d12fk: i think ovpn3 has the issue as well, no?
(15:17:07) ordex: "CVE-2020-abcdef: partial information leak upon unautho=
rized client reconnection"
(15:17:17) dazo: I will take the same text and send to oss-security as we=
ll
(15:17:27) plaisthos: d12fk: which one?
(15:17:28) ordex: d12fk: if it exists, it's only in the closed server imp=
lementation
(15:17:30) d12fk: non-constant-time HMAC
(15:17:34) ordex: ah
(15:17:39) plaisthos: d12fk: that is a super old one.
(15:17:55) plaisthos: I was just picking that link since someone used the=
 commit id there as name for it :)
(15:18:08) cron2: the headline ordex proposed is good
(15:18:19) mattock: I'll buy that
(15:18:26) ordex: sold!
(15:19:11) cron2: wo, the last CVE was actually fixed in master+2.4+2.3+2=
=2E2+2.1
(15:19:23) cron2: I think I was feeling a bit crazy that day...
(15:19:29) ordex: :O
(15:19:36) dazo: we should probably sync up the headline with the CVE des=
cription too ....
(15:21:23) dazo: So the CVE description is: OpenVPN 2.5.1 and earlier ver=
sions allows a remote attackers to bypass authentication and access contr=
ol channel data on servers configured with deferred authentication, which=
 can be used to potentially trigger further information leaks.
(15:21:58) cron2: I have extended this for Changes.rst a bit
(15:22:07) cron2:   In combination with "--auth-gen-token" or an user-spe=
cific token auth
(15:22:08) cron2:   solution it can be possible to get access to a VPN wi=
th an
(15:22:08) cron2:   otherwise-invalid account.
(15:22:08) dazo: (this is worded according to the MITRE CVE specification=
s)
(15:22:09) d12fk: maybe we should add what's not possible with the attack=
 as well
(15:22:27) dazo: that's for the wiki page
(15:22:30) d12fk: i bit more hands-on
(15:22:44) d12fk: oh was talking about wiki
(15:22:46) cron2: d12fk: that's what I just pasted
(15:23:12) mattock: what it the title of the CVE? it does not seem to be =
public yeT?
(15:23:47) dazo: mattock: we haven't pushed the CVE update ;-)
(15:24:27) mattock: here's a start of it
(15:24:27) mattock: https://community.openvpn.net/openvpn/wiki/CVE-2020-1=
5078
(15:24:58) dazo: That looks good enough for me
(15:25:32) dazo: I'll add that URL to the update request to MITRE
(15:25:51) cron2: relevant commits are the top 3 in release/2.5 (f7b3bf06=
, 3d18e308c4, 3aca477a1b5) and top in release/2.4 (0e5516a9)
(15:26:04) cron2: 2.3 and master are not done yet
(15:26:40) mattock: ok, will add that as well
(15:28:08) mattock: done
(15:28:20) ordex: "it is possible to allow tricking a server" << does thi=
s compile for you in english?
(15:28:25) d12fk: typo: vulnerabiliyt
(15:28:32) ordex: allow normally is followed by who is allowed
(15:28:49) ordex: to allow a client to trick a server ?
(15:28:57) ordex: (sounds a bit weird)
(15:29:01) cron2: well, if you'd just use my text...
(15:29:24) cron2: "This bug allows - under very specific circumstances - =
to trick a server using delayed authentication (plugin or management) int=
o returning a PUSH_REPLY before the AUTH_FAILED message, which can possib=
ly be used to gather information about a VPN setup."
(15:29:40) mattock: I'll buy that
(15:29:45) cron2: you already did
(15:29:56) ordex: mattock is buying everything today
(15:30:09) mattock: what about now?
(15:30:19) mattock: I bought something else, a wiki page name
(15:30:29) mattock: now I bought a paragraph / sentence
(15:30:31) cron2: ah, the "allow tricking" is from the release announceme=
nt mail, which says "fixes two vulns... which allow tricking..."
(15:30:33) mattock: https://community.openvpn.net/openvpn/wiki/CVE-2020-1=
5078
(15:30:34) cron2: so there it's good
(15:31:05) cron2: you want the full commit IDs there, so it can be clicke=
d
(15:31:10) cron2: https://community.openvpn.net/openvpn/wiki/CVE-2017-121=
66
(15:31:14) cron2: this one is actually quite nice
(15:31:22) mattock: sure
(15:33:08) ***d12fk is happy with the text
(15:35:45) mattock: updated with commit links
(15:37:00) cron2: this is confusing wrt "which commit is needed for 2.5?"=
=2E.. I'd put this as a bullet list under a "release 2.5:" heading
(15:37:17) cron2: because 2.5 really needs all 3 commits, while 2.4 only =
needs one
(15:37:34) mattock: ok, sounds reasonable enough for me to comply :P
(15:38:03) d12fk: mattock is out of money to buy things =3D)
(15:38:13) ordex: haha
(15:38:23) mattock: done
(15:38:40) mattock: yep, I was already on a spending spree
(15:38:51) mattock: that ended with a huge spending hangover
(15:39:04) ***cron2 sells mattock a "5"
(15:39:05) mattock: typo fixed
(15:39:08) mattock: too slow
(15:39:17) ordex: hehe
(15:39:20) ordex: hadn't noticed
(15:39:25) cron2: too slow :)
(15:39:35) ***cron2 notices that ordex doesn't notice things today :-)
(15:39:47) ordex: don't let everybody else notice
(15:39:48) mattock: do we "recommend" or "urge" people to upgrade
(15:40:01) cron2: if auth tokens are in use, urge
(15:40:05) mattock: ok
(15:40:07) cron2: if delayed auth is in use, recommend
(15:40:09) cron2: otherwise, forget
(15:40:20) ordex: on the kernel list they write: "All users of the 5.10 k=
ernel series must upgrade."
(15:40:39) ordex: regardless of what you are really running
(15:41:06) ordex: cron2: without deferred ath you cannot exploit the bug,=
 no?
(15:41:09) ordex: *auth
(15:41:17) ordex: or am I getting confused?
(15:41:27) cron2: you need deferred auth to get "something back you shoul=
d not see otherwise"
(15:41:38) ordex: right
(15:41:39) cron2: but that is usually not very useful in itself
(15:41:53) cron2: if you combine it with auth-tokens, it becomes the leve=
r to actually get in
(15:42:03) mattock: I added recommendations there, please review
(15:42:14) plaisthos: or stupid admin having echo stuff with secret passw=
ords in there :D
(15:42:15) ordex: but auth-token alone is not enough, right? this was act=
ually my point
(15:42:20) ordex: :D
(15:42:43) cron2: true
(15:42:57) ordex: I am asking because "If you are using auth tokens you s=
hould upgrade as soon as possible " sounds like "if you have auth-token a=
lone, you are in trouble too"
(15:43:02) cron2: so it's "if you are using delayed auth plus auth tokens=
, you *should*..."
(15:43:08) d12fk: i would say ppl with deferred auth must upgrade
(15:43:15) d12fk: ppl without are not affected
(15:43:19) ordex: right, or we simplify: if you use deferred auth you sho=
uld ..
(15:43:32) ordex: yeah, without making it too complex
(15:43:33) plaisthos: you should upgrade anyway.
(15:43:38) ordex: plaisthos++ !!
(15:43:43) d12fk: we don't control what is being pushed
(15:43:46) ***ordex starts 25 minutes of aplause for plaisthos=20
(15:44:08) ordex: yeah i agree with d12fk
(15:44:27) cron2: nobody should be running anything older than 2.5.2, but=
 this is not realistic to expect
(15:44:37) ordex: without making too many assumptions, just tell people u=
sing the buggy knob to upgrade. the impact can be estimated by them based=
 on what they push (if they want..)
(15:44:40) cron2: so if we say for every bug we fix "YOU MUST UPGRADE", p=
eople will just ignore us
(15:45:12) ordex: well, it's also true that if you are not on the latest =
stable, you are on your on in any case. but I agree that being a little s=
pecific is not bad
(15:45:27) plaisthos: If in doubt update.
(15:45:30) cron2: yeah
(15:45:58) ordex: should we go with "if you are using deferred auth you s=
hould .."
(15:46:05) ordex: ?
(15:46:06) plaisthos: if have none of auth-gen-token, plugin and manageme=
nt in your config, you are not affected
(15:46:22) cron2: yes to both
(15:46:38) plaisthos: if you have, better error on the safe side and upgr=
ade since you might be vulnerable
(15:46:40) mattock: let me write that up
(15:47:37) ordex: we can also have a little sentence saying: "this bug af=
fects the following features: *list from plaithos*; you should upgrade un=
less all of the above are deactivated in your setup"
(15:47:58) ordex: I think I have made enough proposals, no tokens left
(15:48:50) mattock: have a look now
(15:48:50) mattock: https://community.openvpn.net/openvpn/wiki/CVE-2020-1=
5078
(15:49:37) cron2: ordex: start a server with --auth-gen-token !
(15:49:43) d12fk: deferred auth is missing, which is not an option, but a=
 return value
(15:49:57) ordex: d12fk: that is part of "plugin"
(15:50:14) ordex: (I think)
(15:50:17) cron2: a plugin may or may not use deferred auth, but "no plug=
in, no management" =3D save :)
(15:50:28) ordex: yap
(15:50:29) d12fk: yeah but isn't plugin / mgmt a bit wide
(15:50:42) ordex: it is, but at least we are on the safe side
(15:50:47) d12fk: okay
(15:50:53) ordex: (I think)
(15:51:14) d12fk: i thought usually you'd know if you use deferred auth o=
n a server
(15:51:16) cron2: well, the new wording is not what I had in mind
(15:51:17) dazo: plugin or scripts can now be deferred though
(15:51:22) ordex: because if we get more meticolus we might have to expla=
in how each of them is used (as auth-gen-tokenalone for example is not pr=
oblematic)
(15:51:24) cron2: dazo: scripts not in 2.5
(15:51:30) ordex: cron2: propose propose!
(15:51:32) dazo: ahh! true
(15:52:11) mattock: 8 minutes left to bikeshed
(15:52:14) cron2: "if you are not using one of auth-gen-token, plugin, or=
 management in your config, you are safe.  In doubt, upgrade.  If you kno=
w you're using deferred-auth, upgrade"
(15:52:41) mattock: all in favor say aye
(15:52:44) cron2: (scripts is not in master yet either, because we're at =
v6 now and I couldn't find time yet to torture that one)
(15:52:48) cron2: ale!
(15:52:49) ordex: aye!
(15:52:54) cron2: uh, close.  aye :-)
(15:53:00) mattock: ale is even better
(15:53:05) ordex: pale ale!
(15:53:48) mattock: cron2 version online
(15:54:44) ***ordex is fine
(15:55:51) cron2: actually why does it say "CVE-2020-15078: partial infor=
mation leak upon unauthorized client reconnection"?  That is just wrong
(15:56:06) cron2: ah, no
(15:56:08) cron2: well
(15:56:21) ***cron2 is confused and needs coffee, and ale
(15:56:42) cron2: it's misleading because you at least need a valid clien=
t cert... so a "totally unauthorized client" can not exploit this
(15:57:05) d12fk: unless client-cert-optional
(15:57:06) cron2: but let's leave it at that
(15:57:17) ordex: yeah, it's too complicated to be summarized in one line=

(15:57:26) ordex: "partly unauthorized" ? :D
(15:58:06) cron2: "an attacker using frowned-upon features on his client"=

(15:58:27) ordex: :D
(15:58:31) mattock: lol
(15:58:50) mattock: attacking in general is frowned upon :)
(15:59:27) d12fk: don't set the evil bit, think of what your mom thinks
(16:00:05) mattock: another phrase of wisdom: "don't you eat that yellow =
snow, watch out where the huskies go"
(16:00:15) mattock: anyhow
(16:00:19) mattock: meeting good enough?
(16:00:24) mattock: 2.3 and master will come soon
(16:00:33) ordex: lol
(16:00:42) cron2: yes
(16:00:46) ordex: mattock: is that what they teach you in kindergarden?
(16:00:49) cron2: anything else on our agenda?
(16:00:59) cron2: mattock: CentOS 7 buildslave
(16:01:05) plaisthos: I am working on a patch set for master
(16:01:06) cron2: and MacOS X buildslave
(16:01:23) plaisthos: now that the CVEs are out there is no longer a risk=
 in posting that to the mailing list
(16:01:28) mattock: ordex: they probably do, not sure
(16:01:32) lev__: working on ovpn-dco MSI installer
(16:02:01) mattock: buildslaves will arrive when I get to upgrading the b=
uildbot setup
(16:02:12) ordex: plaisthos: ay
(16:02:13) mattock: adding linux-based buildslaves should be trivial
(16:02:30) mattock: btw. AWS supports MacOS instances now
(16:02:38) mattock: using one of those is an option
(16:03:06) cron2: those suck because it's really "you just get a dedicate=
d macmini"
(16:03:17) cron2: plaisthos; yes, thanks
(16:03:18) mattock: oh
(16:03:25) mattock: so not really VMs
(16:03:27) cron2: mattock: so, I thought you are free now?
(16:03:45) plaisthos: mattock: yes but they are basically too expesnive
(16:03:49) mattock: from openvpn ops work, 90% free I'd say
(16:03:58) mattock: plaisthos: ok
(16:04:00) plaisthos: since you have to pay for day at a time
(16:04:18) mattock: ah, so no point in doing "latent buildslaves" or anyt=
hing "on demand"
(16:04:25) mattock: unless you push once a week
(16:04:54) cron2: that sounds like a great plan :-) - once a week is revi=
ew day, and then another week later, commit and push to the buildslaves :=
-)
(16:05:20) plaisthos: mattock: we already have an internal ticket for thi=
s
(16:06:11) mattock: for fixing the MacOS buildslave or?
(16:07:05) plaisthos: mattock: OR-1464
(16:07:09) mattock: ok, lemme check
(16:07:18) plaisthos: providing a vm on our mac for community
(16:07:32) ordex: that'd be nice
(16:07:40) mattock: +1
(16:07:54) ordex: ok, then we have a ticket to push
(16:08:26) mattock: anything else?
(16:08:30) plaisthos: AWS mac instances are 1,083 USD per hour
(16:08:38) plaisthos: so 25ish USD per day
(16:09:11) mattock: hmm
(16:09:29) mattock: you can buy a mini for two week's worth of that renta=
l?
(16:09:39) mattock: or a month at most
(16:09:56) mattock: anyhow, I need to go make some food
(16:10:15) cron2: plaisthos: you gave up on making the buildslave on pan =
work?
(16:10:22) plaisthos: a mac mini is more like 1500 EUR because Apple
(16:10:23) ordex: well, no need to discuss cost if we get a VM
(16:10:33) plaisthos: cron2: kind of
(16:10:43) plaisthos: the problem with pan is that its host CPU is too ol=
d
(16:10:47) ***ordex has to leave too - anything else to discuss together?=

(16:11:12) plaisthos: since it doesn't have AVX2 newer macOS versions don=
't run on it anymore :(
(16:11:54) mattock: I'll wait until 13 minutes past, then I'll copy-and-p=
aste the discussion to the chatlog textfile :)
(16:12:15) ***d12fk heads out
(16:12:22) mattock: we're losing people
(16:12:23) cron2: *wave*
(16:12:57) plaisthos: *wave*
(16:13:03) mattock: bye!

--------------D9E0148295CC87F36BE01B73--

