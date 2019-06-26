From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <e55f098a-1ba1-02d7-5f50-b12e4eec054a@...515...>
Message-ID: <df3e32cc-1534-4fa5-544b-9d59d62fa76b@...515...>
Date: Wed, 26 Jun 2019 14:05:28 +0300
MIME-Version: 1.0
In-Reply-To: <e55f098a-1ba1-02d7-5f50-b12e4eec054a@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Qqz90c1D55LZBBlOkCLHeT6yBZHyXiVWX"
Subject: [Openvpn-devel] Summary of the community meeting (26th June 2019)
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
--Qqz90c1D55LZBBlOkCLHeT6yBZHyXiVWX
Content-Type: multipart/mixed; boundary="pwdqkH8PAJk2w9S9dXE0Zx7dmPb4vNIf4";
 protected-headers="v1"
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Message-ID: <df3e32cc-1534-4fa5-544b-9d59d62fa76b@...515...>
Subject: Summary of the community meeting (26th June 2019)
References: <e55f098a-1ba1-02d7-5f50-b12e4eec054a@...515...>
In-Reply-To: <e55f098a-1ba1-02d7-5f50-b12e4eec054a@...515...>

--pwdqkH8PAJk2w9S9dXE0Zx7dmPb4vNIf4
Content-Type: multipart/mixed;
 boundary="------------07E27639362B3AE162DC3D3C"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------07E27639362B3AE162DC3D3C
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Wednesday 26th June 2019
Time: 11:30 CEST (9:30 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2019-06-26>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, dazo, lev, mattock, sgstair and syzzer participated in this meeting.

---

Mattock gave an update on tap-windows6 HLK testing. Running code
analysis and static driver verifier (SDV) on the tap-windows6 source
code revealed some issues that need to be fixed for "Static Tools Logo
Test" to be guaranteed to pass. Sgstair already fixed some of them:

<https://github.com/OpenVPN/tap-windows6/pull/91>

Mattock will run SDV on tap-windows6 patched with this PR and report
back to sgstair. Sgstair will make a couple of additional fixes tomorrow.

Mattock will start running the "final" round of HLK tests once sgstair's
fixes are in.

Rozmansi pointed out that it should be able to run the "Operate in
Server Core" test on a virtual machine without jeopardizing the validity
of the HLK test result submission for tap-windows6.

---

The OpenVPN 3 team is putting together performance testing documentation
for tap-windows6 and wintun; it will describe how the test environment
was setup, how performance was measured and what results were obtained
from the test runs. The goal is to have a reproducible setup for others
to confirm if they want.

Noted that it would be possible to automate the setup of such a
environment with Terraform or CloudFormation.

---

Talked about various buildslave issues. Cmocka is missing from some of
them. Mattock will go through his buildslave and get that sorted out.
After this we can look into the TCP t_client problem (connects, ping4
and ping6 fail) on the Ubuntu 18.04 buildslave.

---

Talked about the "HackerOne report about sample plugin issue". Agreed
that there is a genuine problem even though it does not directly affect
OpenVPN. However, like bad configuration examples bad sample code will
get used by others and will thus cause problems indirectly. Cron2 will
look into fixing the issue.

Also agreed that we should get IBB to hand a bounty to the reporter.
Mattock will figure out how we can mark the report as worthy of a bounty.

--

Full chatlog attached.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock



--------------07E27639362B3AE162DC3D3C
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2019-06-26.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2019-06-26.txt"

(12:29:14) syzzer: moin :)
(12:29:18) dazo: hey!
(12:29:33) cron2: moin :-)
(12:31:14) eworm [~eworm@...2498.../developer/eworm] =C3=A8 entrato nella =
stanza.
(12:33:23) cron2: so... has anyone seen mattock?
(12:33:36) dazo ha scelto come argomento: Next meeting 4/July/2019 at 20:=
00 CEST.  Agenda at https://community.openvpn.net/openvpn/wiki/Topics-201=
9-06-26
(12:33:57) dazo: Not more than that he appeared/joined here 10 min ago :)=

(12:34:36) cron2: so, maybe we can start with 3, until then
(12:34:46) mattock: hi
(12:34:53) dazo: yeah
(12:34:56) mattock: do you think I would miss a meeting?
(12:35:00) mattock: :P
(12:35:16) cron2: mattock1: no, never ;-) - so, let's start with 1 instea=
d
(12:37:13) mattock: so https://community.openvpn.net/openvpn/wiki/Topics-=
2019-06-26
(12:37:15) vpnHelper: Title: Topics-2019-06-26 =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)
(12:37:26) mattock: let's get #1 out of the way
(12:38:14) mattock: the code analysis (enabled by rozmansi) and static dr=
iver verifier (separate tool) found issues in tap-windows6 which need to =
be fixed before starting the "final" HLK test run
(12:38:21) mattock: sgstair is working on those
(12:38:57) cron2: so it's not just "we need this report" but also "and we=
 need to fix this". OK, I'll wait for PRs to show up and get reviewing.
(12:38:58) mattock: running HLK now would be pointless as any fixes (whic=
h are mandatory) would change the driver and we'd have to run the whole H=
LK test suite again
(12:39:04) cron2: ack
(12:39:28) mattock: so, hopefully I can start the famous "final run" earl=
y next week
(12:40:12) mattock: I also need a Windows Server 2019 Core, but rozmansi =
believes a virtual HLK client is sufficient for that particular test ("Op=
erate in Server Core")
(12:40:48) mattock: anyways, that's all
(12:40:56) cron2: nice
(12:41:15) cron2: send PRs :)
(12:41:21) cron2: (can you share the report?)
(12:41:31) mattock: you mean code analysis results?
(12:41:34) cron2: yes
(12:41:39) mattock: yes, no problem
(12:41:43) mattock: where shall I put it
(12:41:44) mattock: ?
(12:41:53) cron2: I'm curious on the quality of the report, and on the ac=
tual findings
(12:42:01) cron2: mattock1: just mail it to me, pgp-crypted?
(12:42:33) lstip: hello
(12:42:54) mattock: cron2: doing it
(12:43:08) lstip: (ah wrong client)
(12:43:10) lev__: hello
(12:43:24) mattock: hi!
(12:43:28) mattock: cron2: sent
(12:43:31) cron2: hi lev, in all your personalities :)
(12:45:06) mattock: sgstair just sent a link to a commit: https://github.=
com/sgstair/tap-windows6/commit/33136dd79a3f8d8b0fed412f6f911005749faeb0
(12:45:07) vpnHelper: Title: Fix annotation problems noticed by code anal=
ysis. =C2=B7 sgstair/tap-windows6@...2514... =C2=B7 GitHub (at github.com)
(12:46:03) lstip ha abbandonato la stanza (quit: Quit: leaving).
(12:47:30) cron2: that was quick
(12:48:52) cron2: ok, that's no actual code change, just "tell the compil=
er what you are doing here, input or output parameters and such"... if I =
can have this as PR, I'm happy to ACK+merge it :)
(12:51:14) cron2: ok, anything else on tap?
(12:51:19) mattock: I will ask sgstair to create a PR
(12:51:20) mattock: no
(12:51:47) mattock: I can rerun code analysis + static driver verifier af=
ter or before this is merged
(12:52:35) cron2: you could run it on his branch, yes
(12:52:45) sgstair [~sgstair@...2515...] =C3=A8 entrato nella stanza.
(12:53:19) mattock: hi sgstair!
(12:53:20) dazo: Not directly to this tap ... but some somewhat FYI relat=
ed .... We're working on putting together a performance testing documenta=
tion for tap-windows6 and wintun; documenting how we did the setup, how w=
e measured performance and what we got in our runs ... The goal is to hav=
e a reproducible setup for others to confirm if they want
(12:53:32) sgstair: Hi!
(12:53:36) dazo: Hey!
(12:53:37) mattock: dazo: EC2-based?
(12:53:42) lev__: mattock1: yes
(12:53:44) dazo: mattock1: yes
(12:53:46) cron2: dazo: +good
(12:53:57) mattock: well, the ops team (e.g. me) can produce such a setup=
 with Terraform
(12:54:02) mattock: that is reproducible
(12:54:19) dazo: mattock1: we're making a "document" we will put on the c=
ommunity wiki
(12:54:52) mattock: well, this is basically a couple of EC2 instances and=
 some packages/setup on them, right?
(12:55:06) mattock: btw. maybe we discuss tap-windows6 a bit now that sgs=
tair is here?
(12:55:14) mattock: I bet it is late where he is :)
(12:55:23) cron2: hi sgstair :-)
(12:55:24) dazo: mattock1: Ubuntu 18.04 LTS server with openvpn 2.4 serve=
r and Windows 2016 server
(12:55:25) sgstair: a bit late, yeah :)
(12:55:43) sgstair: hey cron2=20
(12:55:44) dazo: or early, depending on time zone ;-)
(12:56:18) mattock: sgstair: does the commit you linked to fix all the MU=
STFIX issues?
(12:56:26) sgstair: yes, it should
(12:56:50) mattock: ok, I can run the tests against it to verify (sgstair=
 was unable to produce the same issues on his build setup)
(12:57:05) mattock: anything else in the code analysis results we should =
fix (now) in your opinion?
(12:58:09) sgstair: the other things I saw were - There are some possible=
 integer overflow issues in stats (32bit overflow in a 64bit counter) - a=
nd there is a possibility to cause a bugcheck if the OS sends a packet sm=
aller than the size of an ethernet header.
(12:58:43) sgstair: I'm not sure if the latter can even happen, but if it=
 can, it would be good to fix.
(12:58:54) mattock: are these fairly trivial fixes?
(12:58:59) cron2: I thought we just look at sizes and drop packets if too=
 small?  but yes, we should just silently throw the packet away
(12:59:01) sgstair: very.
(12:59:21) mattock: I say we fix everything we can now, rather than later=

(12:59:53) sgstair: ok, I can provide another commit with further fixes t=
omorrow.
(12:59:56) mattock: ok, great!
(13:00:18) mattock: I will run the Static Driver Verifier with your curre=
nt commit applied
(13:00:25) mattock: if there's something to report I will report back to =
you
(13:00:27) sgstair: cron2: this is on the path of a packet coming from ND=
IS - I don't recall if we have length checks there.
(13:00:59) sgstair: mattock1: sounds good.
(13:01:08) cron2: for the "is an arp or dhcp or ipv6 nd packet we need to=
 specially handle?" we have lots of checks, but I'm not sure if we *alway=
s* check
(13:01:35) cron2: how does one annotate these IRQL things?
(13:03:36) sgstair: cron2: I'll have to double check, but you can provide=
 an annotation on a function that indicates it's changing the IRQL. It's =
not too hard to find, just find the thing you're calling which does that =
also, and has the annotation you need.
(13:04:07) cron2: ah :)
(13:04:36) cron2: (so, yes, these look scary, but the functions are doing=
 exactly this and named appropriately, we just need to tell the tool)
(13:05:54) sgstair: yeah, they're really not bad. Just the static analysi=
s tools depend on the annotations being correct in order to make useful o=
bservations, so they complain when they see an inconsistency
(13:06:28) sgstair: code analysis is function-level analysis. SDV is more=
 whole-program analysis
(13:09:19) sgstair: I looked closer at that "possible bugcheck" and it is=
 actually somewhere different than I remember - it is a packet that has c=
ome through openvpn into the tap, but I'm not certain that guarantees it =
is ethernet-frame sized. Will look closer, but I'll probably add a guard =
regardless.
(13:10:39) sgstair: I guess it is true that it would have been padded tha=
nks to the changes I made previously; so it should be fine.
(13:10:42) dazo: one thing is what OpenVPN does with tap-windows6 interfa=
ces ... but OpenVPN is not the only user of this driver
(13:11:25) sgstair: yeah, true.
(13:14:02) mattock: anything else on tap-windows6?
(13:14:07) mattock: we have 16 minutes left=20
(13:14:49) sgstair: nothing comes to mind from my end. Will coordinate wi=
th mattock1 over the next few days
(13:15:45) mattock: +1
(13:15:46) sgstair: I did drop the annotation changes commit into a PR
(13:16:04) cron2: sgstair: already :) - nice, I'll handle that later toda=
y
(13:16:30) sgstair: cool
(13:16:43) mattock: ls
(13:16:46) mattock: oops
(13:16:47) mattock: :)
(13:16:50) mattock: anyways
(13:16:55) mattock: so back to the test environment
(13:17:45) mattock: so there will be a document on trac describing how it=
 is setup
(13:18:43) mattock: if we want, it would be quite easy to automate the se=
tup with Terraform and Terraform provisioners so that even a dummy could =
reproduce it, provide he/she has AWS access keys and proper IAM policies
(13:19:13) cron2: not sure if I find the name "Terraform" brilliant or sc=
ary :)
(13:19:23) mattock: it is scary I tell you
(13:19:46) mattock: you can "terraform destroy" everything you built, wit=
h one command
(13:20:03) mattock: which has its uses, except in production :)
(13:20:20) mattock: dazo, lev: anything to add to the perf test environme=
nt topic?
(13:20:44) lev__: mattock1: well we are working on that doc
(13:20:55) dazo: yes, wiki page in trac giving all setup details, indicat=
ing expected results
(13:21:15) mattock: ok
(13:21:41) dazo: I'm not sure terraform has a use case now ... as lots of=
 this documentation can be extracted and made for other kinds of setups t=
oo; like real hardware, etc
(13:21:51) lev__: is Terraform somewhat related to CloudFormation ?
(13:22:14) dazo: It shares 4 letters in the name .....
(13:22:20) dazo: 5 letters!
(13:22:40) lev__: in setup phase you are supposed to create VPC, internet=
 gateway, security group etc. I think this all can be done with cloudform=
ation script
(13:22:51) mattock: lev: that is correct, or with terraform
(13:23:06) lev__: so the end user could just provide API keys
(13:23:22) mattock: terraform is more useful in the sense that it support=
 multiple clouds, _BUT_ the code you write is still effectively tied to a=
 particular cloud
(13:23:37) mattock: because the resources are cloud-specific
(13:23:55) mattock: so not "write once, use anywhere"
(13:23:57) lev__: so for AWS it is a wrapper for CloudFormation?
(13:24:02) mattock: no
(13:24:17) mattock: the aws provider for terraform wraps raw AWS API call=
s
(13:24:47) mattock: I'm not sure if cloudformations support real (SSH) pr=
ovisioning or just user_data
(13:25:03) mattock: but anyways, "the setup is automateable if we need/wa=
nt"
(13:25:31) mattock: buildslave (lack of) maintenance next?
(13:25:56) cron2: very quickly :-) - who owns fedora29, and how can we ge=
t libcmocka installed there?
(13:26:07) mattock: me, by me running some commands :)
(13:26:09) syzzer: not me
(13:26:40) cron2: mattock1: ah, it *is* yours.  You seemed to be ducking =
away everytime someone said fedora29 :-) - so, please be installing libcm=
ocka everywhere we have buildbot fails
(13:27:01) mattock: I shall do that
(13:27:05) ***cron2 was afraid that this is a "look I have donated a VM t=
o you!"-thing where nobody can do anything
(13:27:21) cron2: then we should try to fix t_client on ubuntu 18, whatev=
er is breaking it there for the TCP test
(13:27:38) dazo: mattock1: you need libcmocka-devel (which pulls in libcm=
ocka)
(13:27:46) mattock: dazo: ok noted!
(13:28:09) cron2: good.  two minutes on #3...
(13:28:16) dazo: cron2: is it all TCP tests, or just one?
(13:28:30) dazo: On #3 ... That sample plugin is an ugly example ... it's=
 not a security issue per-say (from a production perspective).  If any on=
e puts that into production as is, it's not only insecure (even without t=
his flaw), it's also acts completely stupid (running "sleep" in forked ou=
t process).
(13:28:30) dazo: This plug-in just demonstrates how the deferred mechanis=
m works and how the main OpenVPN process would behave, it is far from an =
example of how to solve this challenge.
(13:28:37) mattock: #3 HackerOne report about sample plugin issue=20
(13:28:44) cron2: dazo: it's only doing one TCP test, and that fails, but=
 in an unexecpected way (it connects but ping fails)
(13:29:01) dazo: cron2: ipv4 or ipv6?
(13:29:07) cron2: both pings fail
(13:29:25) dazo: okay ... then it's a new issue
(13:29:35) cron2: yep :-)
(13:30:00) dazo: so .. #3 :)
(13:30:16) cron2: anyway, plugin - the way we ship it is a gaping hole.  =
Even if it should not be *used*, it's still showing horribly bad practice=
=2E
(13:30:41) cron2: so a) I think the report is valid and should get a boun=
ty awarded, and b) we need to "do something".
(13:30:42) dazo: Yes, using system() plain out stupid ... but someone mig=
ht think this is clever, so we should kick that out
(13:31:13) dazo: ahh ... well, it's not valid in the context that no syst=
em would ever run this in a production or even test environment
(13:31:21) dazo: it would serve no useful feature at all
(13:31:29) cron2: "just kicking out" is actually not straightforward as t=
he whole "do async stuff with sleep and then..." is done in the system ca=
ll with shell-backgrounding &
(13:32:10) dazo: cron2: exactly .... it's not a simple task ... but might=
 get around things by using threading with join()
(13:32:37) dazo: join() once the "sleep" is done elsewhere, that is
(13:32:49) cron2: I wouldn't call it a "highly rate security vuln", and e=
specially not "in OpenVPN" - but I still think the report should be appre=
ciated.  Who is handling these discussions with OSTIF?  mattock1?
(13:33:04) cron2: what is join()?
(13:34:07) dazo: what you call on a thread ID to finally close it ... it =
will block if the thread isn't finished, otherwise it will just return th=
e "exit code" of the thread
(13:34:13) mattock: cron2: tbh I can't recall us ever having a report on =
HackerOne that was worthy of bounty
(13:34:24) mattock: so I'm not exactly sure how the process goes
(13:34:37) mattock: but I believe it can all be done from within the Hack=
erOne webui
(13:34:37) cron2: mattock1: we had no report yes, so I have no idea eithe=
r :)
(13:35:26) dazo: pthread_join() is the C call :) .... std::thread objects=
 in C++ got a .join() method
(13:35:26) cron2: dazo: mmmh, no manpage on this on my linux system... bu=
t I think the idea of the fork in the system() call was to "exit the pare=
nt right away, child communicates 20s later by file io"
(13:35:35) cron2: ah
(13:35:37) syzzer: not sure on the process, but I agree this report shoul=
d be rewarded
(13:37:10) cron2: ok.  I'll look into the plugin to get the code fixed.  =
mattock1: can you contact hackerone/ostif on the mechanics?
(13:37:18) dazo: I have no strong opinion about the rewarding ... My argu=
ment is that this plug-in itself is of no value in a production environme=
nt
(13:37:38) cron2: true, but we still ship it as sample for "look, this is=
 how you do it!"
(13:38:33) dazo: it's a development example demonstrating how deferred au=
th works .... the system() with sleep is just laziness to not write a gig=
antic code to make something happen later in the background
(13:38:46) syzzer: bad example code is like bad example configs, they pro=
liferate and will and up as a real issue somewhere - even if it's not the=
 case in the initial context
(13:38:49) mattock: cron2: yes I can contact IBB/HackerOne/OSTIF
(13:38:58) cron2: mattock1: thanks
(13:39:03) dazo: yeah, I can agree to that
(13:40:08) dazo: my point is probably more that this isn't a security vul=
nerability in OpenVPN ... it's just really crappy code documentation on d=
eferred auth
(13:40:24) cron2: I agree on this
(13:40:48) cron2: but I've come to the conclusion that we need to "own" t=
his as we ship the bad example code
(13:41:26) syzzer: what cron2 says :)
(13:41:35) dazo: yeah, agreed
(13:41:40) mattock: done for today? 11 minutes past our limit :)
(13:41:52) dazo: lets do 4 more minutes!
(13:41:52) cron2: no news on 2.5 anyway (I'll go and merge the two ACKs w=
e have tonight)
(13:41:53) dazo: :-P
(13:42:17) dazo: I'll try to get the missing patch review out there again=

(13:42:23) mattock: oh, one minor note: I will try to be on my traditiona=
l summer vacation start second week of July
(13:42:35) mattock: but I will wrap up all the important pending stuff re=
gardless
(13:42:40) mattock: such as the infamous HLK stuff
(13:42:43) cron2: when is plaisthos back from vacation?
(13:43:01) dazo: oh ... on that note ... I'm starting my holiday tomorrow=
 .... back July 22
(13:43:07) dazo: cron2: next week
(13:43:47) cron2: uh, 3.5 weeks... so we need to find someone else to rev=
iew plaisthos v5 4/7...7/7
(13:44:18) dazo: I'll see if I get bored in the evenings .... but I won't=
 be actively online
(13:44:18) syzzer: I might be able to step in there
(13:44:33) syzzer: this is the HMAC auth stuff, right?
(13:44:41) cron2: yep
(13:44:47) dazo: yeah, I trust syzzer is capable .... even on the broader=
 parts too
(13:45:12) cron2: most definitely :-) - syzzer: and if your workload gets=
 more reasonable these days "welcome back on board!" ;-)
(13:46:11) dazo: I have reviewed all ... I just need to find out where 5/=
7 and 6/7 went .... 5/7 I might need to write again, seems Thunderbird at=
e it
(13:46:34) syzzer: cron2: not likely, but I might be able to pick up work=
 again anyway :)
(13:46:48) dazo: that said 5/7 is a more heavy one, with hmac stuff in it=

(13:48:04) dazo: syzzer: Also see 9b117603-189a-b5da-b3e4-c7f22c7bc363@...2516...=
=2Elists.topphemmelig.net for example configs and auth-scripts I've used =
for my testing
(13:48:23) syzzer: dazo: will do, thanks
(13:49:19) mattock: ok, done for today
(13:49:27) mattock: ?
(13:49:41) syzzer: yep, lunch!
(13:49:50) dazo: syzzer: 4/7 needs some fixes (compiler warnings) ... and=
 also adds the initial hmac stuff ... your eyes here would be good
(13:50:00) cron2: syzzer:enjoy

--------------07E27639362B3AE162DC3D3C--

--pwdqkH8PAJk2w9S9dXE0Zx7dmPb4vNIf4--

--Qqz90c1D55LZBBlOkCLHeT6yBZHyXiVWX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAl0TUXgACgkQKVhNn0CG
RXizUQf8DMpCNl+DI+goC7g6mHaQ1oeloSTHt5Iunfpma+tUjoVdvz05B8ivDqCI
NYD0UBezMzOcBd0Rx2V7GwyCXDVqzUN/mIaJgdSi7cn9eC+mU1AqL9wsqQi+U3PK
eO5z+AbubfNDSI7OoA3EzyLTOrPM8f3moXr4e1xtfliz07OXxYCIBmQMRIJlkbny
FFe8fcyxf0lg56bD7yC2lENSGLeKIragQ8pDNweXwVW3gedLAObzCbvYBx8KIGll
1fs4BFoHCjww811Bikq+VV9uPET9hHdZ5hAv5zJG4AkbpPrI8itHlT8zlgRBSYPV
Iw3V0rxrdcqdD45HKFDto0Wq1jTJVA==
=LoNx
-----END PGP SIGNATURE-----

--Qqz90c1D55LZBBlOkCLHeT6yBZHyXiVWX--

