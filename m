From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <9d879a78-47c9-5be5-5798-98e07bc25c89@...515...>
Message-ID: <2976fd1d-5759-d0b4-bad2-9ea25e5e7d0a@...515...>
Date: Wed, 27 May 2020 13:52:32 +0300
MIME-Version: 1.0
In-Reply-To: <9d879a78-47c9-5be5-5798-98e07bc25c89@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="IGCfIcJ5JlrIX1FQ52GZfLKyU7px1OVuB"
Subject: [Openvpn-devel] Summary of the community meeting (27th May 2020)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IGCfIcJ5JlrIX1FQ52GZfLKyU7px1OVuB
Content-Type: multipart/mixed; boundary="oczXNfaqQICUAIXabIyitFOhVnQ2HSkGF"

--oczXNfaqQICUAIXabIyitFOhVnQ2HSkGF
Content-Type: multipart/mixed;
 boundary="------------4C9B00D2FC8A8AB7D7BBAA53"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------4C9B00D2FC8A8AB7D7BBAA53
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Wed 27th May 2020
Time: 11:30 CEST (9:30 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2020-05-27>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, dazo, lev, mattock, ordex and syzzer participated in this meeting.

---

Talked about OpenVPN testing. We have a server-side testing setup which
is focused on testing the network side. However, the setup is currently
private and not easily reproducible. We agreed that allowing "anyone" to
setup server-side testing would be beneficial.

Fox-IT has a bunch of test tools they could possibly share:

- TLS test setup with loopback-like configuration files running on a
single node
- A C client to test management-external-key
- Python-based test framework that does regexp matching on OpenVPN
connection test logs

Syzzer will make inquiries to see if these tools could be open sourced
fully or partially. In the worst case they would provide "inspiration"
for the OpenVPN community.

Agreed that tests that are easy and quick to run locally by normal
users/developers should be part of our standard "make check" test suite.

Created a new repository in GitHub called "openvpn-tests":

<https://github.com/OpenVPN/openvpn-tests>

This repository will contain server-side tests and other things that do
not fit into "make check". Existing test suites like
"openvpn-windows-buildtest" may be integrated with it later.

Also created a TestCoverage page in the Wiki:

<https://community.openvpn.net/openvpn/wiki/TestCoverage>

--

Talked about man-page reformatting. In a nutshell it is looking pretty
good but will need some work to make it perfect.

--

Syzzer promised to review

<https://patchwork.openvpn.net/patch/1120/>

--

Talked about OpenVPN 2.5.

Dazo will review and ACK plaisthos' INFO_PRE/AUTH patches today.

Cron2 and ordex will try to get the IPv6-only patchset sorted out
15:00-17:00 tomorrow (Thursday).

Mattock has not been able to continue the MSI work but hopes to be able
to do that next week.

--

Full chatlog attached

--------------4C9B00D2FC8A8AB7D7BBAA53
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2020-05-27.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2020-05-27.txt"

(12:30:01) mattock: hello
(12:31:36) lev__: hi
(12:32:50) cron2: yo!
(12:32:59) mattock: this look promising now! :)
(12:34:28) ordex: hi!
(12:35:39) mattock: ok let's do it
(12:35:52) mattock: https://community.openvpn.net/openvpn/wiki/Topics-202=
0-05-27
(12:35:54) vpnHelper: Title: Topics-2020-05-27 =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)
(12:36:09) mattock: I believe dazo is responsible for some of those topic=
s
(12:37:18) cron2: !blame
(12:37:21) dazo: \o/
(12:37:23) mattock: hi
(12:38:03) eworm [~eworm@...2498.../developer/eworm] =C3=A8 entrato nella =
stanza.
(12:38:23) mattock: topic #1?
(12:39:55) dazo: I think we can all agree this is a great idea to have.  =
But who has something ready?  Who will pick up these tasks?
(12:40:36) mattock: krzee was interested in doing this and he should have=
 the bandwidth
(12:40:43) cron2: I do have server side testing, with fairly good "networ=
k side" coverage
(12:40:53) cron2: (tun, tap, ipv6, ipv4, ...)
(12:41:10) cron2: it's lacking any sort of management interaction or plug=
ins
(12:41:17) dazo: After haven looked at plaisthos' auth related patches, I=
 do have some kind of ideas how to do some simple automated management ba=
sed auth testing ... but, the annoying part there is to write some reliab=
le code which does the management interface interaction
(12:41:44) syzzer_: hi
(12:41:49) mattock: \o/
(12:41:50) cron2: syzzer! \o/
(12:41:55) dazo: hey! long time, syzzer_!
(12:42:04) syzzer_: Running TLS tests can easily be done on a single host=

(12:42:25) syzzer_: Just use loopback-like configs
(12:42:37) dazo: yeah
(12:42:47) cron2: t_lpback.sh and t_cltsrv.sh come to mind :-)=20
(12:42:48) syzzer_: This is how we do this for OpenVPN-NL too
(12:43:16) dazo: TLS tests are kind of the lowest hanging fruits
(12:43:30) syzzer_: Yeah, but preferrably with less timeouts than t_cltsr=
v.sh :)
(12:43:55) dazo: and I think krzee would be perfect candidate for those t=
ests, if he got a chance and time for it
(12:43:56) syzzer_: cron2 has reasonable coverage for the network side
(12:44:00) dazo: syzzer_: agreed!
(12:44:42) syzzer_: but having server-side tests that are easier to run "=
for everyone" would be really nice
(12:44:51) dazo: I did look into reducing those timeouts, the annoying pa=
rt of that test is testing timeouts .... so that kind of makes it odd to =
reduce timeouts when testing timeouts
(12:45:23) syzzer_: yeah, but for the other tests, you'd want a flag like=
 "exit with 0 status if connectin setting succeeds" or so.
(12:45:49) syzzer_: Oh, end "immediately exit with exit code non-zero whe=
n TLS connection fails"
(12:45:53) syzzer_: *and
(12:46:00) cron2: yep, when adding tests run in the normal "make check" s=
equence, these should be "a few seconds each", not "2 minutes"
(12:46:45) cron2: (keeping the balance between "test coverage" and "getti=
ng work done though a test run takes 473 hours to complete"...)
(12:46:58) dazo: agreed
(12:47:48) syzzer_: Another option would be similar to how we do it for O=
penVPN-NL: use a (in our case Python) test framework that just does regex=
 matching on the log output until the expected messages are seen (e.g. "C=
onnection Established", "Certiticate expired", "Invalid key usage", etc)
(12:47:57) dazo: that's where you normally split between the various test=
 tiers ... tier 1 are typical quick smoke tests, unit tests which are run=
 regularly (and quickly), tier 2 are more comprehensive tests and tier 3 =
handles regressions
(12:48:37) dazo: syzzer_: could you share that test code?  It would be be=
tter to build on something which exists rather than to build up something=
 new from the ground up
(12:49:23) syzzer_: I might, but tbh the framework is not exactly nice an=
d quite overengineered for this purpose...
(12:49:43) syzzer_: It's currently internal code, so I'd have to convince=
 people to open source it
(12:50:09) syzzer_: Or at least share with a selected few of you as "insp=
iration" ;-)
(12:50:21) dazo: syzzer_: well, it might be easier to strip down an over-=
engineered framework than to write a new one ... if the code is reasonabl=
e, which I kind of image you guys normally write (reasonable code, that i=
s) ;-)
(12:50:33) dazo: that would work too
(12:50:52) dazo: ("inspirational sharing")
(12:51:04) mattock: I think insprirational sharing would be fine
(12:51:28) syzzer_: I'll discuss internally. Maybe just sharing the actua=
l tests without the framework (which you really don't want to use anyway =
;-) ) helps
(12:51:35) dazo: as long as we all have an understanding that shared code=
 might be re-used and licensed as GPL
(12:52:31) mattock: syzzer: thanks!
(12:52:34) dazo: syzzer_: also, if you have any code which interacts with=
 the management interface ... that would be pretty nice ... that's typica=
lly fairly boring and fragile code to write
(12:52:52) syzzer_: I have a small C client to test management-external-k=
ey
(12:53:09) dazo: hmmm ... could probably work
(12:53:45) dazo: but thx a lot, syzzer_!
(12:53:51) syzzer_: np
(12:55:32) cron2: so, let me briefly recap how my server tests work today=
 - then you are informed and inspired, and we can see about next steps
(12:55:57) cron2: there's *3* machines involved
(12:56:03) cron2: one is the server machine, which does
(12:56:10) cron2:  - update git repo
(12:56:12) cron2:  - build
(12:56:37) cron2:  - run local "make check" (with a t_client test vs. the=
 normal reference server, so if we totally botch it, we want to know befo=
re looking into "pure server side" fails)
(12:57:31) cron2:  - use the resulting src/openvpn/openvpn binary to star=
t up ~5 or 6 server instances similar to what runs the "t_client server s=
ide" (tun, tap, udp, tcp, ..., p2p, inetd)
(12:58:06) cron2: - then ssh out to machine #2, which basically runs a re=
gular t_client test against these freshly compiled instances
(12:58:49) cron2: machine #2 has a 2.3, 2.4 and git master binary (not "c=
urrent" but "updated every now and then"), and t_client is run once for e=
ach instance, in sequence (because of the "check ifconfig/route before/af=
ter" test)
(12:59:31) cron2: now, machine #3... for the tap tests with VLANs, you ne=
ed to make sure that vlan isolation works - so there is an extra tap clie=
nt which does nothing except "you can ping me if you're in the right vlan=
"
(13:00:53) cron2: the client machines are all FreeBSD, the server is a Ge=
ntoo, but it does not really matter - it's just giving me a bit more OS c=
overage for free
(13:01:14) cron2: (philip =3D ecrist's test server is a FreeBSD, so we ha=
ve "Linux and FreeBSD servers")
(13:02:23) cron2: so... any questions so far?  Anyone still alive?
(13:02:57) dazo: +1
(13:03:32) cron2: okay :-) - what I propose we should do is:
(13:03:46) cron2: - document "what do we test, and how do we test that?" =
in our wiki
(13:05:00) cron2: maybe a table with "code path" and "test set" (t_cltsrv=
, t_lpback, t_client, server) and a second section that describes these t=
est in more detail ("what do I have to do to run this?")
(13:05:23) cron2: - put the test stuff into a git* repo
(13:05:40) cron2: we have mattock's windows testing framework somewhere i=
n github already, but the t_server stuff isn't
(13:06:22) cron2: I do not actually want the t_server stuff in the "openv=
pn main" tree, because it has sort of a different activity cycle
(13:07:09) mattock: cron2: sounds good
(13:07:10) dazo: Agreed, we could have a separate git repo for test frame=
works and scripts
(13:07:22) syzzer_: yeah, make sense
(13:07:51) syzzer_: though quick tests should just be part of "make check=
" I'd say
(13:08:00) syzzer_: e.g. the TLS tests
(13:08:29) cron2: yes
(13:08:41) mattock:  ok, next topic?
(13:08:44) cron2: everything that a normal user can run "just so" should =
(eventually) end up in the main tests/ tree
(13:08:45) mattock: we have 22 minutes
(13:08:49) cron2: not yet :)
(13:08:56) mattock: ok please continue :D
(13:09:40) cron2: things we want the buildbots to run maybe should also g=
o into the main repo (with the needed config put on the buildbot) - this =
would be t_client stuff
(13:09:56) cron2: this that need special environments, maybe not
(13:10:23) cron2: but I suggest we start with actually *having* a repo, a=
nd then from time to time we look at "what is useful for the main repo".
(13:10:58) ***cron2 wants the servers to also do plugin and management te=
sting :-)
(13:11:17) dazo: there is also nothing wrong about buildbots actually pul=
ling down an openvpn-tests git repo before kicking of tests
(13:11:48) cron2: (oh, as an additional remark: the server test is built =
with different options depending on the day of the week - like, openssl, =
mbedtls, ... - so that could be extended to do plugin-auth on some days, =
script-auth on other days, management-auth on third...)
(13:12:30) cron2: yes, we could "run all tests at all days", but the numb=
er of instances you need for that gets fairly high, and that directly ref=
lects on t_client config on the reference client
(13:12:37) cron2: I'll go and play with that a bit :-)
(13:12:54) cron2: dazo: right.  Let's have a repo, put stuff in there, th=
en see what we can do with it.
(13:13:28) cron2: I just wanted to agree to syzzer that "having test code=
 in the main repo is good, if it's actually somewhat easy to run"
(13:13:52) cron2: I'm done :-) - TODO on mattock: find us a nice repo?
(13:14:02) mattock: you give a name, I will create
(13:14:10) cron2: openvpn-tests
(13:14:13) dazo: agreed ... so, in the main repo we should have tier 1 cl=
ass of tests, the openvpn-tests repo should have tier 2 and tier 3
(13:15:18) cron2: I'd rather not set this in stone right now, but "get to=
 work first, then look at what we have, and see what we can do with it"
(13:15:55) dazo: sounds good to me
(13:16:00) cron2: *like*
(13:16:01) syzzer_: +1
(13:16:17) mattock: we have "openvpn-windows-test", "openvpn-windows-buil=
dtest" and "easyrsa-unit-tests" under OpenVPN in GitHub
(13:16:47) cron2: mmmh
(13:16:47) mattock: I can create "openvpn-tests" if that name does not so=
und too generic (unless it _will be_ generic)
(13:17:20) mattock: we don't actually use "openvpn-windows-buildtest" any=
more as Buildbot does the same thing now
(13:17:29) mattock: I should mark it as deprecated
(13:17:32) cron2: what do you think?  move openvpn-windows-test inside "o=
penvpn-test"?  Or keep separate repos?
(13:17:46) cron2: my gut feeling says "a single repo with subdirectories =
sounds workable"
(13:18:13) mattock: I could work with a subdirectory
(13:18:20) dazo: as things gets going, openvpn-windows-tests can be a git=
 submodule inside openvpn-tests, until we figure out how to merge things
(13:18:58) dazo: with git submodules, it is in a subdirectory ... but han=
dled as a separate git repo when you are inside that directory
(13:19:04) mattock: in any case "openvpn-tests" is a reasonable name give=
n this plan
(13:19:07) syzzer_: the main repo is called "openvpn", so "openvpn-tests"=
 makes sense
(13:19:15) dazo: agreed
(13:19:33) dazo: so ... testing covered?
(13:19:46) cron2: I'm good
(13:19:51) cron2: homework to do :)
(13:19:55) dazo: :)
(13:20:33) dazo: So #2 ... and man page stuff .... I completed converting=
 the whole man page to .rst .... and the preliminary result can be seen h=
ere: https://gist.github.com/dsommers/015dfbbca099efb92ebd36236b67e991
(13:20:35) vpnHelper: Title: man.8.rst =C2=B7 GitHub (at gist.github.com)=

(13:20:55) dazo: And the .rst source file is here: https://gist.githubuse=
rcontent.com/dsommers/015dfbbca099efb92ebd36236b67e991/raw/395fe9cef2db7f=
03645b60c40e26a7881de3d368/man.8.rst
(13:21:12) mattock: https://github.com/OpenVPN/openvpn-tests/
(13:21:13) vpnHelper: Title: OpenVPN/openvpn-tests =C2=B7 GitHub (at gith=
ub.com)
(13:21:32) dazo: This is *far* from perfect yet ... With this conversion,=
 I tried to do as little changes as possible to the content itself - but =
some changes were needed
(13:21:39) cron2: the initial glance says "nice!", the second says "it ne=
eds polishing"
(13:21:41) cron2: like
(13:21:42) cron2: --
(13:21:43) cron2: config
(13:21:43) cron2: file
(13:21:53) cron2: being wrapped between "--" and "config"...
(13:22:08) dazo: The biggest challenge with .rst ... is our option parsin=
g is non-standard and way too flexible for most common tools
(13:22:16) cron2: oh, all the longer options are wraped after "--"
(13:22:22) dazo: yeah, there's a lot of editorial work needed to be done
(13:22:55) dazo: the wrapping is more or less a "github rendering feature=
" ... it seems to wrap of the total length is less than X characters
(13:23:08) dazo: that is out of our control, unfortunately
(13:23:18) dazo: other renderes might do it differently
(13:23:22) cron2: mmmh
(13:24:00) cron2: what is our target for this?  github renderer?  only ma=
npage?  manpage and trac?
(13:24:14) cron2: (I do not care for the github renderer if we're not usi=
ng it in earnest)
(13:24:22) dazo: Alright ... scroll down, and you see the man page render=
ing in plain text
(13:24:39) syzzer_: yeah, most interesing to me is "how does this look in=
 man'
(13:24:51) syzzer_: aha!
(13:24:51) dazo: https://gist.githubusercontent.com/dsommers/015dfbbca099=
efb92ebd36236b67e991/raw/395fe9cef2db7f03645b60c40e26a7881de3d368/man.8.t=
xt
(13:25:08) cron2: the man page rendering looks reasonable (from a quick g=
lance)
(13:25:23) dazo: with a terminal (at least on Linux) also have the proper=
 highlights and underlined text as well
(13:25:47) syzzer_: the man page rendering looks reasonable (from a quick=
 glance)
(13:26:12) cron2: forcing block alignment is something I find silly for a=
 fixed-width font text, but this might be just "groff -man"'s doing
(13:26:52) dazo: yeah, that's groff handling ... when being a proper man =
page file with 'man' it uses terminal width
(13:27:37) cron2: which is good, but if we can make it left-aligned (or h=
owever that is called in english) so it does not fill in lots of blanks i=
nto the lines, I would like that better
(13:27:38) syzzer_: so, looking good
(13:27:43) dazo: So I propose I will clean up some minor glitches on the =
basic formatting (basically incorrect indenting) then I'll push a work br=
anch out and start adding new commits to that branch for the editorial ch=
anges
(13:28:08) dazo: cron2: that's again some man/groff behaviour
(13:28:20) cron2: dazo: yeah, but can we tell man/groff what we want?
(13:28:33) ***cron2 has not enough clue on that front
(13:29:01) syzzer_: the rst source looks quite reasonable too
(13:29:05) cron2: as for the plan "sounds good to me"
(13:29:06) dazo: What you see in the man.8.txt file is the rendered outpu=
t .... what we will generate for the openvpn tarballs (at make dist time)=
 will be the groff file itself
(13:29:38) cron2: understood.  But in the groff file, can we tell groff "=
we'd prefer to have it left-aligned, not block-aligned"?
(13:29:47) cron2: or is that a system-level define?
(13:30:00) dazo: I don't think so, to be honest, I think that's system/ho=
st rendering settings
(13:30:08) cron2: okay
(13:30:55) ***cron2 sneaks in a "patchwork" item and throws https://patch=
work.openvpn.net/patch/1120/ at syzzer_
(13:30:56) vpnHelper: Title: [Openvpn-devel] Switch assertion failure to =
returning false - Patchwork (at patchwork.openvpn.net)
(13:31:07) cron2: syzzer_: could you have a look a that one?
(13:31:12) dazo: but I agree, the "justified alingment" is kind of odd at=
 times ... looks odd in some cases, other times reasonable
(13:31:39) cron2: (or lev__ maybe) - this is "we ASSERT() in the server d=
epending on timing, sometimes, and the server stops" - it should not do t=
hat, but maybe there is a deeper bug lurking
(13:32:08) cron2: dazo: sorry for jumping topics, but when syzzer_ is hon=
ouring us with his presence, I need to take advantage of it :)
(13:32:21) dazo: no worries!  I agree ;-)
(13:32:22) syzzer_: cron2: I've seen it. Haven't really looked into it.
(13:32:33) cron2: "this is code above my pay grade"
(13:32:57) cron2: so... man page covered?
(13:33:55) dazo: I'm happy and I have a plan moving forward :)
(13:34:04) cron2: good.  Short 2.5 update?
(13:34:30) dazo: I'm planning to give the final ACKs to plaisthos INFO_PR=
E/AUTH patches today
(13:34:39) cron2: my side: reviewing the ipv6-only patch set.  Not happy =
with all the details.  Need focused time with ordex to discuss, then new =
patchset on the list.  ordex: can I have a 2h timeslot, please? :-)
(13:34:47) cron2: dazo: nice
(13:34:53) dazo: I've asked lev__ to followup on the compression+async pa=
tches as well
(13:34:55) ordex: cron2: can we schedule it this afternoon ? or when ?
(13:35:23) cron2: ordex: full of video conf shit already :-( - what about=
 tomorrow?  This is very light on my agenda so far
(13:35:54) cron2: Thu or Fri, basically any time between say 10 am and 5 =
pm works
(13:35:58) ordex: cron2: afternoon? say around 2pm ?
(13:36:20) cron2: you found the only timeslot that is taken :-) (2pm-3pm)=
=2E  So, 3pm-5pm tomorrow?
(13:36:24) ordex: :D
(13:36:25) ordex: ok
(13:36:27) ordex: 3-5
(13:36:40) cron2: check
(13:36:49) ordex: alright!
(13:36:50) cron2: mattock: how's msi coming along?
(13:37:58) ***dazo brb
(13:38:13) cron2: he fell into a hunger coma, it seems
(13:38:18) mattock: it is not, I have not found enough time to focus on i=
t
(13:38:49) mattock: the cloudvpn stuff obviously pushed everything back a=
nd now that cloudvpn is "out" all the other stuff became urgent
(13:39:05) mattock: I hope I could focus on it next week
(13:39:13) mattock: I need a couple of solid days to finish it
(13:39:48) mattock: I expect it to fail in interesting ways as that's how=
 it usually goes...
(13:40:44) cron2: yes :)
(13:41:39) mattock: anything else? 10 minutes overtime
(13:43:17) cron2: I've started on https://community.openvpn.net/openvpn/w=
iki/TestCoverage
(13:43:20) cron2: nothing there yet
(13:43:30) cron2: but it can be put in the minutes so you can all contrib=
ute :)
(13:45:23) syzzer_: nothing else from my side. I'm looking at the patch c=
ron2 threw at me.
(13:46:19) cron2: this test coverage thing needs more brains
(13:46:48) mattock: cron2: I'll mention that page in the summary which is=
 almost done

--------------4C9B00D2FC8A8AB7D7BBAA53--

--oczXNfaqQICUAIXabIyitFOhVnQ2HSkGF--

--IGCfIcJ5JlrIX1FQ52GZfLKyU7px1OVuB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAl7ORnAACgkQKVhNn0CG
RXgDwwgAkZSI5Y0C6To5PC/NMxtsasmNLgpW+ZiDeXo/7R/Pv3P6ieWKymV7nJAZ
Q6nN4sG/jMpP5eZxdukOW2VXju5PERzoef8JzdQfoE/o+w5F9jVUsuaLqBvpoXAi
vbbIG/4qgtGqw/uPBZHAjcZD1Rf5+5W26016xMculn4guRpFzKo0DTHtLEPvn9ys
esJsit+t1HqSw9Lt8+K8y9s/aof4LEeY9g0N/Z0k2OONyFY8kf8wVkdSijBurw3R
2biZaVC156KSMedBvJQH/dCkZiezrq/MUGBGTkoKSw0csEUco8xGS6bq2YrUNwyA
Ok9F5qyOyC1dM/mdQPXxLmSpSAKGMw==
=WtsV
-----END PGP SIGNATURE-----

--IGCfIcJ5JlrIX1FQ52GZfLKyU7px1OVuB--

