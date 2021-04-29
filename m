From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <1226b24c-ea68-6336-a320-1d065f9d3a13@...515...>
Message-ID: <84b81651-ab06-8702-59bc-eb3e7d74e109@...515...>
Date: Thu, 29 Apr 2021 10:27:20 +0300
MIME-Version: 1.0
In-Reply-To: <1226b24c-ea68-6336-a320-1d065f9d3a13@...515...>
Content-Type: multipart/mixed; boundary="------------0A48EDCE3B8A7BA2868C3600"
Content-Language: en-US
Subject: [Openvpn-devel] Summary of the community meeting (29th April 2021)
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
--------------0A48EDCE3B8A7BA2868C3600
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Wed 29th April 2021
Time: 14:00 CET (12:00 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2021-04-29>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, dazo, d12fk, lev, mattock, ordex and plaisthos participated in 
this meeting.

-- 

Talked about 2.5.2 and 2.4.11 releases. Noted that the RPM packages are 
moving towards the stable repos for Fedora and EPEL repositories. No 
major complaints have been heard from users so far.

Some distros like Gentoo and Debian have not yet updated their packages 
with the security fixes. We poked them during the meeting.

---

Lev has working MSI installer for ovpn-dco. No MSM's, just small update 
to WiX XML and installer script. Script downloads zip with driver 
(inf/cat/sys) and CustomActions.DLL (which is C# DLL, part of  ovpn-dco 
repo). Lev is now testing various (un)install scenarios.

A fully working installer should be available by the end of this week.

---

Talked about 2.6 patches. Cron2 is working hard to merge the patches 
plaisthos and ordex are pushing his way. Right now plaisthos' backlog is 
about 30 patches.

There has been no progress at the FreeBSD end regarding a FreeBSD kernel 
DCO module.

---

Noted that an issue was found in the peer fingerprint code by cron2's 
new test instance. It's a particularily silly bug: you tell openvpn "try 
once!", and it will try twice, then report "oh, my (1) try failed!

---

Had a long discussion about deprecating features and maintaining 
compatibility with old clients, in particular in the context of OpenVPN 
2.6 and DCO. Plaisthos is now using a compatibility mode option which 
sets some configuration defaults to make it easier to fix older clients 
to work with newer servers. There was some opposition to this strategy, 
but nobody could present any better solutions given on our unwritten 
policy of "we must not break old clients".

---

Mattock gave an update on the new Buildbot setup. His plan (which will 
be publishes shortly on Trac) includes consolidating several things in 
to the new Buildbot environment:

- Current Buildbot system (CI/CD)
- Release packaging (Windows, Debian/Ubuntu)
- Parts of internal OpenVPN Inc. QA which is done manually now

The new setup is being built publicly in

https://github.com/mattock/openvpn-vagrant

and

https://github.com/OpenVPN/openvpn-vagrant

which allows anyone to spin up a Buildbot setup for OpenVPN and 
contribute tests and fixes to it.

---

Full chatlog attached

--------------0A48EDCE3B8A7BA2868C3600
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2021-04-29.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2021-04-29.txt"

(14:59:26) ordex: hallo!
(14:59:29) plaisthos: hey
(14:59:36) dazo: hepp hepp!
(14:59:38) cron2: *burp*
(14:59:48) plaisthos: video call or text today?
(15:00:39) novaflash [b9e34bf1@...2592...] =C3=A8 ent=
rato nella stanza.
(15:00:58) cron2: no preferences
(15:01:25) ordex: I think mattock prefers text, for easier reporting
(15:01:30) cron2 ha scelto come argomento: https://community.openvpn.net/=
openvpn/wiki/Topics-2021-04-28
(15:01:38) ordex: the call was more to discuss things that should not be =
written :D
(15:01:39) d457k =C3=A8 ora conosciuto come d12fk
(15:01:48) mattock: text is better for me definitely :)
(15:01:58) modalit=C3=A0 (+o d12fk) da ChanServ
(15:02:47) ***d12fk is happy with anything
(15:03:07) lev__: guten tag
(15:03:08) dazo: lets chat ... that works :)
(15:03:21) d12fk: lev__: daag
(15:03:23) dazo: text, I meant
(15:04:18) mattock: ok, so let us move on
(15:04:37) mattock: https://community.openvpn.net/openvpn/wiki/Topics-202=
1-04-28
(15:04:39) dazo: #1 ... sync up on 2.5/2.6
(15:04:41) mattock: sync-ups
(15:05:05) ordex: # emerge --sync
(15:05:29) ***cron2 fills all disk
(15:05:36) dazo: 2.5.2/2.4.11 releases are moving towards the stable repo=
s for Fedora and EPEL repositories
(15:06:07) ordex: cool
(15:06:20) cron2: freebsd got moved to 2.5.2 right away :-)
(15:06:22) dazo: No real complaints (a packaging challenge with systemd n=
ot properly restarting openvpn on upgrade on newer Fedoras only - nothing=
 critical for OpenVPN community)
(15:07:01) cron2: haven't heard from debian yet... poking berniv6 as we s=
peak
(15:07:02) dazo: I announced the upgrade on fedora-devel .... and people =
started testing the upgrade quite soon after, so I'm grateful for that
(15:08:14) lev__: I have working MSI installer for ovpn-dco. No MSM's, ju=
st small update to WiX XML and installer script. Script downloads zip wit=
h driver (inf/cat/sys) and CustomActions.DLL (which is C# DLL, part of  o=
vpn-dco repo). Now testing various (un)install scenarios.
(15:08:27) ordex: gentoo has no 2.5.2 in list yet
(15:08:44) cron2: complain!
(15:08:49) dazo: soo the bleeding edge source distros are falling behind!=
?!?
(15:08:54) ordex: hehe
(15:08:55) dazo: :-P
(15:09:46) ordex: I can open a bug with them
(15:09:53) ordex: an mention the CVE
(15:09:55) ordex: *and
(15:09:59) cron2: indeed
(15:11:15) dazo: yeah, sounds good
(15:12:02) cron2: that is indeed lame... not even a "masked out" version
(15:12:14) cron2: and no 2.4.11 either
(15:13:11) dazo: I see archlinux has picked it up ... https://archlinux.o=
rg/packages/?q=3Dopenvpn .... but now we're more into the more exotic dis=
tros
(15:13:13) vpnHelper: Title: Arch Linux - Package Search (at archlinux.or=
g)
(15:13:39) mattock: arch is esoteric? :)
(15:13:53) mattock: I thought it was the new, better Gentoo
(15:13:55) dazo: arch and gentoo ;-)
(15:14:05) novaflash: exotic, not erotic
(15:14:05) mattock: ha
(15:14:08) novaflash: esoteric *
(15:14:21) mattock: those words are difficult to distinguish from each ot=
her, yes
(15:14:23) mattock: :)
(15:14:41) cron2: arch-gentoo
(15:14:42) mattock: anyhow, gentoo and debian will be poked
(15:14:56) mattock: "update your packages damn you!"
(15:15:10) mattock: anything else on this topic?
(15:15:11) cron2: I poked debian already, but maybe that poor soul is bus=
y eating or so :-)
(15:15:32) cron2: so, 2.6 - I'm making progress with my "ACKed but not fu=
lly tested/merged yet" backlog
(15:15:45) cron2: (and ordex/plaisthos are filling up again :-) )
(15:15:57) mattock: replenishing the queue, so to speak
(15:15:57) cron2: deferred script auth has landed, 6 minutes ago
(15:16:28) ordex: he can't get enough
(15:16:58) cron2: whenever the patchwork queue falls under 30, 1-2 new se=
ts land
(15:17:38) dazo: plaisthos: how large is your patch backlog queue now?
(15:18:06) plaisthos: 30 or so
(15:18:42) dazo: that's close to half the size a couple of months ago, so=
 we're moving forward :)
(15:18:54) plaisthos: not really :)
(15:19:06) ordex: well, a chnk of those 30 is the dco thing
(15:19:15) dazo: right
(15:19:19) plaisthos: the dco patches are pretty big
(15:19:20) ordex: *chunk
(15:19:31) ordex: those we merge without review :-P
(15:19:45) ordex: jokes aside, I also think there is progress
(15:19:53) ordex: things are moving forward at a reasonable pace
(15:19:56) dazo: so, perhaps get the next set of patches to the ML?
(15:20:00) dazo: I agree
(15:20:00) ordex: (it'd be nice if it was always like this :-])
(15:20:06) cron2: dazo: not right now
(15:20:11) plaisthos: dazo: there are close to 15 patches on the list
(15:20:13) ordex: dazo: we have another 10/15 still pending review
(15:20:19) ordex: so better wait for them to get burnt first
(15:20:20) cron2: there is a refactoring set and a "crypto things" set w.=
i.p.
(15:20:24) plaisthos: dazo: you are welcome to join reviewing
(15:20:24) ordex: going through them..
(15:20:29) ordex: :D
(15:20:31) ordex: ^^
(15:20:34) dazo: I'll try
(15:21:32) d12fk: i'll better stay trapped in ovpn3 land
(15:21:50) d12fk: for king and country
(15:22:07) cron2: berniv6 woke up, he's working on getting the CVE patche=
s backported to 2.5.1 + patches
(15:22:26) cron2: (Debian)
(15:22:36) mattock: \o/
(15:22:39) cron2: and 2.4.x + patch
(15:23:28) cron2: my test infra has grown a new instance that does finger=
print validation
(15:23:37) cron2: which, of course, found a new bug on the client side :)=

(15:24:06) d12fk: yeah testing tends to produce those =3D)
(15:24:17) cron2: it's a bad habit
(15:24:29) d12fk: lol
(15:24:45) cron2: (it's a particularily silly bug... you tell openvpn "tr=
y once!", and it will try twice, then report "oh, my (1) try failed!"...)=

(15:24:56) ordex: does anybody has the CVE link at hand on openvpn.net ?
(15:25:12) dazo: https://community.openvpn.net/openvpn/wiki/CVE-2020-1507=
8
(15:25:29) dazo: https://cve.mitre.org/cgi-bin/cvename.cgi?name=3DCVE-202=
0-15078
(15:25:30) vpnHelper: Title: CVE - CVE-2020-15078 (at cve.mitre.org)
(15:25:39) ordex: thanks!
(15:25:48) cron2: https://community.openvpn.net/openvpn/wiki/SecurityAnno=
uncements
(15:25:51) cron2: and here, of course
(15:28:22) dazo: so ... 2.6?
(15:28:54) ordex: I have created a bug with gentoo: https://bugs.gentoo.o=
rg/786423
(15:28:54) mattock: I think that is directly dependent on the length of t=
he patch queue
(15:28:56) vpnHelper: Title: 786423 net-vpn/openvpn 2.4.9 and 2.5.1 affec=
ted by security bug (at bugs.gentoo.org)
(15:29:03) cron2: lev__ stated something above about having a working isn=
taller with DCO
(15:29:05) cron2: which is nice
(15:29:07) mattock: yes
(15:29:17) cron2: FreeBSD folks have replied "we had no time to do anythi=
ng".  So, no DCO there yet.
(15:29:45) d12fk: maybe they are a bit caucious after the wg thing
(15:29:52) cron2: the "2.6" item is more "report about current progress a=
nd state of things" than about "when do we release 2.6?" :-)
(15:30:07) lev__: yeah I should have openvpn-gui MSI installer ready this=
 week built from latest plaisthos dco branch
(15:30:08) plaisthos: For 2.6 I am starting to write 'compat-mode' to all=
ow going back to earlier behaviour in case of changes in defaults that mi=
ght break compatibility
(15:30:10) cron2: d12fk: nah, this is more a one-man-show-no-time-thing (=
different one-man, though)
(15:31:22) lev__: it should have working reference counting etc, however =
it makes sense only when other apps  use the same this driver (which is o=
penvpn connect in future)
(15:31:41) lev__: I will coordinate with connect team
(15:32:18) mattock: great!
(15:32:23) ordex: plaisthos: are you sure we want to carry so much comple=
xity for supporting old clients?
(15:32:27) d12fk: plaisthos: does that make sense
(15:32:40) d12fk: isn't it compat enough to use an older version
(15:32:48) plaisthos: ordex: yes
(15:33:10) plaisthos: it is either that or never updating defaults to sen=
sible values I am afraid
(15:33:27) plaisthos: e.g. tls-version-min should be really TLS 1.2 nowad=
ays
(15:33:31) d12fk: major version are the magic wand here
(15:33:38) plaisthos: but that breaks 2.3 and older peers
(15:33:54) lev__: mattock: when MSI installer part is done, I could look =
at arm64 support - what I understood from mail correspondence with MSFT, =
recent WiX should support it out of the box, so I could try that
(15:34:00) ordex: plaisthos: if we still support tls-1.1, users can stil =
change their config to make that happen, no?
(15:34:10) plaisthos: tls 1.0 but yes
(15:34:11) ordex: instead of having a "compat" knob?
(15:34:15) ordex: yeah 1.0
(15:34:42) ordex: my fear is that having such compat code will be a huge =
legacy to carry around
(15:34:50) ordex: for "we don't know how long"
(15:34:54) mattock: lev: yes, that is how I understood it as well
(15:34:58) plaisthos: ordex: the idea is to have a easy way to give non e=
xperienced users/ui writer a toggle to do this
(15:35:20) plaisthos: ordex: it is just meant to a best effort with thing=
s that can also be achieved with other config options
(15:35:26) ordex: ah because you look at this from the client perspective=
? that wants to connect to an old server?
(15:35:34) plaisthos: yes
(15:35:38) ordex: hm
(15:35:43) cron2: "has to, because someone is running AS on RHEL" *run*
(15:35:53) plaisthos: AS does not need it
(15:35:55) ordex: :D
(15:35:58) ordex: AS is recent enough
(15:36:01) d12fk: what's wrong with carrying old versions then
(15:36:07) cron2: does AS do IPv6 properly nowadays?
(15:36:11) plaisthos: cron2: no
(15:36:17) cron2: software museum :-)
(15:36:30) cron2: but sorry, just could not resist
(15:37:15) plaisthos: but yes, AS needs also IPv6 support
(15:38:26) d12fk: i.e. client configs don't come from users, but from adm=
ins, and they should know what to do, or their vendors
(15:38:42) cron2: muhahah
(15:38:59) ordex: d12fk has a point though
(15:39:22) ordex: if the user is managing his own config, then we must as=
sume he can deal with it
(15:39:23) ordex: no?
(15:39:29) d12fk: after a few iterations the compat-mode magic will be un=
maintainable
(15:39:31) d12fk: i fear
(15:39:37) plaisthos: look, it is either we make an easy way for users to=
 fix their configs that even idiots can get rigfht
(15:40:03) plaisthos: or you need to guide them through a document which =
specifies how to modify their config to still connect to older servers
(15:40:47) d12fk: what to do when we switch to 1.3 as default?
(15:40:56) ordex: or we tell them to reach out to who handles the server =
:p
(15:41:04) d12fk: i.e. min required version
(15:41:21) plaisthos: compat-version 2.3.0 will lower the default to TLS =
1.0
(15:41:36) plaisthos: while compat-version 2.4.0 will not
(15:42:16) d12fk: but is this easier for a user to pick the right version=
 for the server he wants to connect to?
(15:42:45) d12fk: especially if there are more than one version to pick f=
rom
(15:43:32) plaisthos: I didn't want a full toggle since I did not want to=
 always fall back to TLS 1.0 for example
(15:43:44) dazo: perhaps this should somehow be push-able?  or build on t=
he DNS SRV patches, to "push" config details *before* connecting?  (just =
uncritical out loud thinking)
(15:43:50) plaisthos: If anyone has a better idea how to handle this
(15:43:59) plaisthos: d12fk: hard no
(15:44:02) plaisthos: sorry
(15:44:05) plaisthos: dazo: hard no
(15:44:28) dazo: okay, lets move on
(15:44:36) cron2: dazo: you can't push TLS-level things before you have T=
LS...
(15:44:45) plaisthos: some of the things compat would enable weaken your =
security. You don't want that be easily turned on by something as week as=
 DNS
(15:44:49) ordex: a DNS record may contain them :|
(15:44:55) dazo: cron2: right, hence the DNS SRV idea
(15:45:06) ordex: agreed with plaisthos - it should not be an automatic d=
ecision
(15:45:16) ordex: even though the clueless user has no idea what he will =
do doing
(15:45:23) ordex: "just add this in your cvonfig and it automagically wor=
ks"
(15:45:31) dazo: yeah
(15:45:44) ordex: hmm
(15:45:45) d12fk: then go the full way and don't even hide weak security =
behind a compat-mode flag
(15:45:56) plaisthos: yes
(15:46:21) ordex: I am more for killing compatibility with older server. =
blame server admin. or go the extra mile to understand what to do
(15:47:27) plaisthos: I am maintaining client software
(15:47:41) plaisthos: let me give my perspective
(15:47:47) ordex: yap
(15:48:35) plaisthos: I don't want to explain every god dman user how to =
manually fix their configs to work again against all the crappy netgear, =
dlink, old pfsense, hyperSecureVPNScam etc
(15:48:47) dazo: We probably need to first properly document our goals fo=
r backwards compatibility; what we support and how we support it, and und=
er which circumstances this might be handled differently.  Right now, we =
have an unwritten policy saying "don't break backwards compatibility"
(15:49:01) ordex: yeah
(15:49:05) plaisthos: I want to add a box [x] Enable compatibility with o=
lder server (INSECURE)
(15:49:36) ordex: plaisthos: couldn't the UI do that and manually add the=
 settings required in the config?
(15:49:43) dazo: my thoughts exactly
(15:50:11) cron2: sure, but that would mean "reimplement the same thing i=
n windows-gui, tunnelblick, android".  Is that less err-prone?
(15:50:18) d12fk: basically you're prolonging the deprecation period inde=
finitely
(15:50:19) dazo: at least as a starting point to get experience how that =
works
(15:50:24) ordex: hm
(15:50:53) plaisthos: implementing in the ui is quite error prone and doe=
s not help users on other platforms
(15:50:57) ordex: the question is: do we want to provide all these lazy v=
endors more reasons to stick to their old buggy versions?
(15:51:11) ordex: because it boils down to that I think
(15:51:17) ordex: no pain -> no effort to upgrade
(15:51:28) cron2: do we want users to upgrade to new clients, or do we wa=
nt them to stick to "what works with their server"?
(15:51:41) d12fk: ship two version of ovpn then, use the old one for comp=
at
(15:51:55) d12fk: *tunnelblick
(15:52:12) plaisthos: users will stay on older version since it works
(15:52:17) cron2: tunnelblick does that, but I think it's a silly approac=
h (because that means *we* get to maintain 2.3 forever...)
(15:52:21) dazo: it could even be the same source code ... just with a ./=
configure --enable-compat-build
(15:52:30) cron2: hard noi
(15:52:46) d12fk: this effort is about using unmaintained functionality, =
no?
(15:52:48) plaisthos: --enable-compat-build has what advantage compared t=
o compat-mode?
(15:52:59) cron2: "more #ifdef" \o/
(15:52:59) plaisthos: and then you have two 2.6.0 version which behave di=
fferent
(15:53:05) ordex: <o>
(15:53:08) cron2: hard no
(15:53:11) ordex: agreed
(15:53:19) plaisthos: it is basically compat-mode just hardcoded as confi=
gure option
(15:53:54) dazo: yeah, to move forward .... I'm just spinning slightly fu=
rther on d12fk suggestion with "two versions"
(15:54:44) mattock: move to the backburner?
(15:54:46) plaisthos: basically making 2.6.0 ready to allow DCO in the de=
fault config will break all 2.3 peers
(15:54:53) plaisthos: and some 2.4.x peers
(15:54:59) dazo: anyhow, we are now trying to solve a challenge technical=
ly without having a policy behind ... which makes it harder to decide on =
which technical solutions is best
(15:55:34) plaisthos: dazo: we don't need a policy here
(15:55:46) plaisthos: we are just discussing what we want to do
(15:55:47) dazo: Perhaps a better starting point would be to agree on a c=
ompatibility policy, and find solutions which supports the policy
(15:56:22) mattock: we have a list of deprecation but I think when things=
 get deprecated/removed is arbitrary: https://community.openvpn.net/openv=
pn/wiki/DeprecatedOptions
(15:56:28) dazo: I disagree, this discussion clearly demonstrates that we=
 are lacking a policy on how to handle compatibility breakage in newer ve=
rsions
(15:56:34) novaflash: i kind of agree with dazo here - at some point ther=
e will be a new function that breaks compatibility with older clients. li=
ke tls 1.1, tls 1.2, etc support when openvpn was only tls 1.0. how was i=
t handled then?
(15:57:00) cron2: it was negotiated, and did not break anything
(15:57:09) cron2: but the defaults were always kept "safe, if possibly in=
secure"
(15:57:12) plaisthos: the current policy is basically to error on backwar=
ds compatibility over all
(15:57:15) cron2: (like, BF-CBC, TLS 1.0, ...)
(15:57:30) novaflash: mm okay it seems like that won't be entirely possib=
le here
(15:59:13) plaisthos: so my compromise here was. Do not keep full backwar=
ds compatibility by default but allow enabling it again wiht compat-mode
(15:59:30) dazo: plaisthos: I would word it differently; because of the L=
ACK of a policy, we basically  error on backwards compatibility over all
(15:59:32) novaflash: that seems like a perfectly sane solution
(16:00:00) cron2: dazo: that was our policy.  "Never break existing custo=
mer setups".  Your words :-)
(16:00:06) ordex: :D
(16:00:35) novaflash: tough call
(16:00:42) plaisthos: dazo: to be honest, policy and so is really coperat=
e stuff. In a community project like ours I would prefer, we discuss abou=
t prbolem and come up with solution that everyone can agree on
(16:00:58) ordex: should we continue this discussion once plaisthos has p=
rovided a draft of the patch? so we can also see what's the actual effort=
 in implementing this compat thing ?
(16:01:10) plaisthos: arguing why something should be this way or that wa=
y because of a policy is just the same discussion just with one meta leve=
l more
(16:01:29) dazo: and by first agreeing to a policy, we can find solutions=
 within those limitations ... as that is a common ground to have the disc=
ussion
(16:01:32) d12fk: Q: will compat-mode decay? i.e. only offer compat to th=
e last version
(16:02:11) d12fk: otherwise we will never be able to remove stuff at all
(16:02:20) ordex: d12fk: that's the question we don't want to answer now =
:D
(16:02:21) plaisthos: d12fk: yes, it is best effort
(16:02:28) plaisthos: we never promise 100% compatibility
(16:03:09) d12fk: what is the promise then?
(16:03:33) plaisthos: it is only menat to give user an easier (or actuall=
y possible for them)  way to configure the options they could also set ma=
nually
(16:03:54) cron2: d12fk: maybe something like "for 99% of the users, an u=
pgrade on either end will not break their VPN"
(16:03:59) plaisthos: for 2.3 you woudl manually need to set tls-version-=
min, fiddle with data-ciphers and data-ciphers-fallback
(16:05:04) cron2: d12fk: and if we break that promise, by removing option=
s, we tell people 1 release in advance
(16:05:06) ordex: plaisthos: I think the point d12fk is trying to make is=
 that there will likely be routers shipping 2.3.x for the next 10 years -=
 will we keep the compat code around that long? or do we want to come up =
with our own policy to get rid of this compat code?
(16:05:33) cron2: .oO(all these routers will ship old wg code now)
(16:05:38) ordex: or maybe 15 years - because old SDKs stay out that long=

(16:05:57) plaisthos: realistically currently we look what is used and tr=
y to stay compatible with that
(16:06:10) plaisthos: we no longer check 2.2 anymore for compatiblity act=
ively
(16:06:49) plaisthos: but 2.3 is still used too much to break it without =
giving people an easy way to still use it IMO
(16:07:15) ***dazo need to go
(16:07:16) ***cron2 tests 2.2 clients against master
(16:07:37) ordex: hm ok
(16:07:40) mattock: let's move on, shall we
(16:07:44) mattock: 7 minutes overtime
(16:07:45) ordex: yap
(16:07:47) plaisthos: yap
(16:07:50) cron2: ordex: but that's more "because I wanted to see if I co=
uld" :-)
(16:07:54) ordex: I guess we all have enough info about this problem
(16:08:01) ordex: cron2: FOOOOM
(16:08:04) ordex: :D
(16:08:06) cron2: item 4 should be easy enough
(16:08:08) ordex: I know you can!
(16:08:11) mattock: yes, no
(16:08:16) cron2: meh!
(16:08:24) cron2: so, 3?
(16:08:26) cron2: and 2?
(16:08:38) mattock: I have a one-master + two-slave setup running
(16:08:59) mattock: I also intend to use the setup for release builds
(16:09:10) cron2: so you built a new master and new slaves, and we should=
 now move the existing slaves over?
(16:09:17) mattock: not yet
(16:09:25) cron2: eventually :)
(16:09:28) mattock: I will be building the buildmaster config from scratc=
h
(16:09:43) mattock: the jump from 0.8.2 to 3.1.0 is too big to port the c=
ode over with minor changes
(16:09:58) cron2: I will need exact instructions on "which python version=
, which buildbot module + which version" etc.
(16:10:05) mattock: I might also split the work between multiple masters,=
 if that makes sense
(16:10:11) mattock: yeah, I will have those
(16:10:30) mattock: I'll also see if I could integrate additional tests f=
rom our internal QA to the buildbot system
(16:10:37) cron2: multiple masters means "multiple status pages", which I=
 do not like much
(16:10:43) mattock: some poor QA people are running tests manually
(16:10:58) cron2: can we script these QA people?
(16:11:01) mattock: cron2: not necessarily, but we're not there yet
(16:11:07) cron2: okay
(16:11:14) mattock: we actually can in many cases
(16:11:22) cron2: I'd like a script that makes the QA people ask once a d=
ay for "why can't we not have IPv6 here?"
(16:11:26) mattock: the QA tasks they're running are essentially the same=
 that t_client is doing
(16:11:27) ordex: [for the records, Gentoo already had a bug: https://bug=
s.gentoo.org/show_bug.cgi?id=3D785115 for the version bump related to the=
 last CVE]
(16:11:29) vpnHelper: Title: 785115 net-vpn/openvpn: Multiple vulnerabili=
ties (CVE-2020-15078) (at bugs.gentoo.org)
(16:11:35) cron2: bump
(16:12:02) mattock: anyhow, so good progress, and I will publish some pla=
ns in Trac once I have the internal QA thing figure out, need to talk to =
krzee about that
(16:12:04) ordex: :D
(16:12:43) mattock: also, I'm building the setup in openvpn-vagrant, so a=
lmost anyone can then spin up the buildbot setup
(16:12:50) mattock: and/or contribute to it
(16:13:06) mattock: of course, the production setup will not be on Vagran=
t :D
(16:13:15) mattock: that's all
(16:13:37) ordex: I guess it's late enough and we can postpone the ramini=
ng points to next week ?
(16:13:39) cron2: plaisthos: any ideas on 2.?
(16:14:00) cron2: ordex: nah, this one is about "CVE backport to 2.3", an=
d we should have a plan here
(16:14:06) cron2: 5. can go to next week
(16:14:25) plaisthos: the patch for 2.3 is almost identical, wasn't it?
(16:14:38) plaisthos: or we declare 2.3 as not maintained anymore
(16:14:53) cron2: it did not work
(16:15:10) cron2: we declared 2.3 as "it is maintained, though no release=
s are built", I think
(16:15:25) ordex: yeah. we still push patches AFAIR
(16:15:31) cron2: the 2.4 patch backported to 2.3 led to "no early PUSH_R=
EPLY" (good), but then an AUTH_FAILED (wat?)
(16:15:42) cron2: with correct password
(16:16:00) plaisthos: oh
(16:16:07) plaisthos: will need to take a look then I fear
(16:16:22) cron2: your words were along the lines of "2.3 must be even mo=
re broken than I thought" or something like that :-)
(16:16:30) cron2: thanks :-)
(16:16:30) plaisthos: yes ...
(16:16:47) ***cron2 is done
(16:17:18) mattock: end of meeting?
(16:17:47) d12fk: agreed
(16:18:01) cron2: +1
(16:18:45) mattock: ok, will write summary after dinner
(16:18:51) cron2: enjoy
(16:18:55) ordex: thanks! and enjoy!
(16:19:00) ***ordex waves
(16:19:13) d12fk: it is too early for dinner
(16:19:22) mattock: I'm starting to make dinner, so no worries :D
(16:19:37) d12fk: impressive
(16:20:02) ***d12fk waves as well
(16:20:23) ordex: :D

--------------0A48EDCE3B8A7BA2868C3600--

