From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <604d3782-646c-4f12-b789-2ae9ebbae069@...515...>
Message-ID: <3bbb5dd7-f02e-df3e-ef14-d93ed140b8aa@...515...>
Date: Thu, 23 Sep 2021 10:16:41 +0300
MIME-Version: 1.0
In-Reply-To: <604d3782-646c-4f12-b789-2ae9ebbae069@...515...>
Content-Type: multipart/mixed; boundary="------------B008627AC25E9E8429704A9E"
Content-Language: en-US
Subject: [Openvpn-devel] Summary of the community meeting (22nd September
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
--------------B008627AC25E9E8429704A9E
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on libera.chat
Date: Wed 22nd September 2021
Time: 14:00 CET (12:00 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2021-09-22>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

dazo, mattock, lev, MaxF, ordex, plaisthos and rob0 participated in this 
meeting.

---

Talked about "master" / 2.6. Noted that the full compat-mode patchset 
has been merged. The next step is to start merging the DCO patches.

For 2.5 we have a sitnl bugfix and we need a rst2html if we wish to move 
to 2.5 Windows releases built with MSVC. Some other patches like the 
"Windows 11 fix" will be included in next 2.5 as well:

<https://community.openvpn.net/openvpn/ticket/1418>

---

Noted that there is no particular reason to make "the last 2.4 release" 
anytime soon.

---

Talked about enabling IPv6 for the openvpn.net domain [in Cloudflare]. 
No progress has been seen, which probably equates with "no progress". We 
probably need a carrot, planning and some coordination to get this done.

---

Mattock gave an update on the new buildbot. It now works in both Vagrant 
and EC2:

- Linux builds (no packaging yet)
- Windows builds + signing [+ MSI packaging]

The next step is to create the new _production_ EC2 buildmaster. 
Mattocks related PRs have now been approved and merged now, which makes 
this easier.

---

Noted that MaxF and in particular nariman are working on recreating 
their own nternal OpenVPN CI/CD system. It was agreed to have a 
discussion about their requirements to see if we could co-operate there 
instead of implementing essentially the same thing twice.

-- 

Full chatlog attached



--------------B008627AC25E9E8429704A9E
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2021-09-22.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2021-09-22.txt"

(15:02:08) MaxF: hi!
(15:02:21) lev__: Hello
(15:03:33) mattock: hi
(15:05:54) mattock: who else do we have here?
(15:06:01) plaisthos: me
(15:06:28) ordex: ay
(15:06:29) mattock: cron2 said he'd be late
(15:07:09) mattock: let's get on with this thing :)
(15:07:38) dazo: hey!
(15:08:12) mattock: hi!
(15:08:30) mattock: https://community.openvpn.net/openvpn/wiki/Topics-202=
1-09-22
(15:10:52) mattock: sync up on 2.5/2.6
(15:10:56) ordex: regarding 2.6 we have managed to merge the full compat-=
mode patchset
(15:10:57) mattock: anything new on that front
(15:11:08) ordex: so now the focus will shift to dco support
(15:11:16) ordex: and cleaning up smaller things here and there
(15:11:34) ordex: for 2.5 we have a bugfix about sitnl, that is on the ml=
 pending approval
(15:11:39) plaisthos: the only thing we might want to add to compat patch=
set is to have --nobind as default when --client/--pull is specified
(15:11:47) ordex: maybe we could issue a new release after merging that, =
unless we want to wait longer
(15:12:17) ordex: plaisthos: do you think that is really required for bac=
kwards compatibility?
(15:14:20) plaisthos: or we just change the default without adding it to =
compat
(15:14:20) plaisthos: :D
(15:14:45) plaisthos: I just thought falling back to old behaviour would =
be safer
(15:18:21) mattock: mm
(15:19:06) mattock: so maybe a new 2.5 release
(15:19:12) mattock: dco next
(15:19:15) mattock: anything else?
(15:20:48) lev__: for 2.5 we also have "windows 11" fix=20
(15:21:22) lev__: https://community.openvpn.net/openvpn/ticket/1418
(15:21:56) rob0: fwiw (not much) I am here
(15:21:56) mattock: oh yes
(15:22:11) mattock: so at least two solid fixes
(15:22:46) ordex: yap
(15:22:56) mattock: I might try out the new msibuilder/buildbot setup to =
build 2.5
(15:22:57) ordex: wasn't there something else which was already committed=
 but not released for 2.5?
(15:23:09) mattock: it will fail in rst2html unless lev's patch was backp=
orted there
(15:23:58) mattock: maybe some other fixes as well
(15:24:09) lev__: mattock: didn't we agree to do Frankenstein releases fo=
r 2.5 and switch to full Windows release in 2.6
(15:24:11) mattock: it would be nice to be able to build 2.5 and 2.6/mast=
er snapshots, plus releases
(15:24:22) mattock: possibly
(15:24:27) mattock: can't recall the details anymore
(15:24:49) lev__: basically we build arm64 on windows and rest on linux
(15:25:07) lev__: too bad we need to maintain 2 build systems
(15:25:34) lev__: or we can be brave enough and start producing 2.5 build=
s with msvc
(15:26:10) mattock: I think we could try full-windows builds on 2.5
(15:26:19) mattock: and if that backfires horribly we could backpedal
(15:26:33) mattock: it would simplify things at my end greatly
(15:27:50) mattock: when would we push out the next 2.5?
(15:27:52) mattock: roughly
(15:28:54) mattock: "some weeks from now"?
(15:29:12) ordex: maybe we need cron2's feedback for this question
(15:29:21) ordex: to see if he has something else in the pipe for 2.5
(15:30:12) mattock: +1
(15:30:22) mattock: ok, let's move forward shall we
(15:30:27) ordex: kk
(15:30:52) mattock: 2.4 -> oldstable : does the sitnl fix affect/apply to=
 2.4?
(15:31:41) ordex: don't think we have sitnl in 2.4
(15:32:20) dazo: sitnl is 2.5
(15:32:29) mattock: ok, good
(15:32:32) ordex: kk
(15:32:33) mattock: so no need for two big releases
(15:33:46) ordex: ok
(15:33:59) ordex: I think we don't want to make any 2.4 release anyway
(15:34:05) ordex: what is the thing with oldstable?
(15:34:11) ordex: did we have a deadline?
(15:34:26) mattock: we decided to do "one last 2.4 release" when enough p=
atches have accumulated, then move it to oldstable
(15:34:29) mattock: nothing else
(15:34:51) mattock: no deadline
(15:35:09) mattock: it may be that 2.4 just dies away without the "final =
release" (if I'm lucky, lol) :)
(15:36:38) mattock: anyhow
(15:36:48) mattock: IPv6 to community -> no progress afaik
(15:37:05) mattock: buildbot, which is not on the agenda: works in both V=
agrant and EC2 (linux and windows builds + signing)
(15:37:15) mattock: next step: deploy the production buildmaster
(15:37:36) mattock: that's just wrapping the thing into configuration man=
agement, which is not a big deal
(15:37:46) ordex: so build.openvpn.in will get a new service?
(15:37:50) mattock: no
(15:37:51) ordex: "an upgrade"
(15:37:55) ordex: ok
(15:37:58) mattock: I will spin up a new instance
(15:38:03) mattock: build.openvpn.in has more than just buildmaster
(15:38:30) mattock: this new EC2 instance will be just the buildbot-host =
(buildmaster docker container + latent docker buildbot workers)
(15:38:31) ordex: yeah, but will we keep the buildmaster running on that =
instance? or will it be kille din favour of the new one?
(15:38:50) mattock: old one shall die once the new one is deemed working
(15:39:07) mattock: some of the SSH and user configs need to be moved ove=
r to the new server as well
(15:39:35) ordex: okyz
(15:39:52) mattock: some tweaking is needed there because previously buil=
dmaster lived on the EC2 instance itself, now it lives in a container
(15:39:56) mattock: but nothing insurmountable
(15:40:35) mattock: anything else for today?
(15:40:52) mattock: oh, and the buildbot/openvpn-build work I did was app=
roved by lev and merged
(15:40:57) mattock: so it is mainstream now
(15:41:39) ordex: cool
(15:41:57) ordex: mattock: for the ipv6 to community - there was no progr=
ess or no mention of ipv6 at all in the past 7/10 days?
(15:41:57) ordex: :D
(15:42:17) mattock: no mention
(15:42:26) mattock: but I think "no mention" ~ "no progress"
(15:42:49) ordex: ok
(15:42:57) ordex: well, at least knowing that ipv6 is in the air would be=
 a good sign
(15:43:02) ordex: even if no progress was made :D
(15:44:25) mattock: I think we need to push it to get it moving forward
(15:44:40) mattock: review/create a plan and set a date with the ops team=

(15:47:11) ordex: the problem is finding a carrot
(15:47:28) ordex: as of now I think the DNS issue in openvpn3 was the onl=
y excuse we found :D
(15:47:40) ordex: but there is no real practical need for noe
(15:47:41) ordex: now
(15:48:22) mattock: yes, that's a big part of the problem
(15:49:27) mattock: one brief update
(15:50:02) mattock: I've discussed our new CI/CD system (that is, buildbo=
t) briefly with nariman and MaxF - they're also rebuilding their CI/CD
(15:50:32) ordex: oh ok
(15:50:44) mattock: so, we'll discuss the requirements at their end - per=
haps we can avoid duplicating too much effort if we coordinate
(15:51:02) mattock: they wanted to use docker containers for it, which is=
 incidentally what I ended up using as well
(15:51:50) dazo: that's really great!
(15:51:51) mattock: so, we'll arrange a discussion about it - maybe next =
week or so if that's fine for everyone
(15:52:24) mattock: everyone involved in the project
(15:53:03) dazo: as long as we can make the management levels agree on ho=
w to handle/splitting costs for the infrastructure .... sharing the load =
of managing and maintaining the infrastructure is great!
(15:53:22) ordex: cool
(15:53:33) MaxF: @mattock We're actually thinking about using vagrant ins=
tead of docker now, because we'd like to run our tests with the actual ke=
rnel of the OS on which we're testing
(15:54:53) dazo: MaxF: could it be possible to make it more "backend agno=
stic" ... so it doesn't matter as much if it is docker, vagrant, podman, =
AWS-whatever-cool-name-they-think-they-have or whatever else is available=

(15:55:15) mattock: as for buildbot: it does not care what the worker is =
running on
(15:55:18) dazo: clearly, there needs to be some configs for each of the =
backends ... but that the rest of the stack is quite agnostic
(15:55:26) mattock: but buildmaster itself can be a container np
(15:55:43) mattock: it is the buildmaster that has all the logic about dr=
iving the tests, workers are disposable
(15:55:51) mattock: whether they're VMs, containers or whatnot
(15:56:06) mattock: but yeah, I think we should discuss your requirements=
 a bit and see if there is some common ground
(15:56:29) dazo: but maybe also consider the CI/CD to also have functiona=
l mechanisms to extract artefacts and test results
(15:57:00) mattock: yeah, the build system (worker) does not need to be t=
he same system that tests the executable
(15:57:13) mattock: build system could be docker, but test system could b=
e something else
(15:57:21) MaxF: @dazo I'm not actually the CI person, Nariman is, but he=
 isn't here today. Making it backend agnostic sounds good
(15:57:23) dazo: this can also be used as documentation how we do our rel=
ease builds
(15:57:46) dazo: and then moving further from there to reproducible build=
s
(15:57:47) mattock: I'm suggesting co-operation especially because I know=
 how much work building this kind of system is :)
(15:57:58) dazo: yeah, exactly
(15:58:27) mattock: I'm willing to spend the time to make you happy, beca=
use that will make me happy in the long run :)
(15:58:35) mattock: anyhow
(15:58:37) dazo: hehehe
(15:58:46) mattock: "next week" would be ok for a discussion?
(15:59:04) mattock: maybe even next week's community meeting or before/af=
ter?
(15:59:18) mattock: it might take a bit of time
(15:59:21) dazo: I think so
(15:59:34) MaxF: I'll ask Nariman, but I'll be at the meeting anyway
(15:59:41) mattock: ok, thanks a lot MaxF!
(16:00:33) mattock: meeting concluded?
(16:00:46) dazo: lets find a time+date wher nariman can join
(16:01:19) mattock: yes, assuming "next week's meeting" does not work for=
 him
(16:01:30) mattock: I'm very flexible in "when" during normal European wo=
rking days
(16:05:03) mattock: ok, meeting concluded

--------------B008627AC25E9E8429704A9E--

