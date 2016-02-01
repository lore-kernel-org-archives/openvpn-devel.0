References: <56AF68DC.1020903@...515...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <56AFC6C6.9020606@...515...>
Date: Mon, 1 Feb 2016 22:57:42 +0200
MIME-Version: 1.0
In-Reply-To: <56AF68DC.1020903@...515...>
Content-Type: multipart/mixed; boundary="------------020901010303000103030008"
Subject: Re: [Openvpn-devel] "OpenVPN on Windows" meeting today (1st Feb
	2015)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------020901010303000103030008
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of today's IRC meeting.

- - ---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Monday 1st Feb 2015
Time: 20:00 CET (19:00 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2016-02-01>

The next meeting has not been scheduled yet, but will probably be=20
arranged two weeks from now.

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, d12fk, janjust, mattock, snair, syzzer and valdikss participated=20
in this meeting.

---

Discussed ValdikSS's fix to the block-outside-dns option on Windows Vista:

<https://community.openvpn.net/openvpn/ticket/648>
<http://article.gmane.org/gmane.network.openvpn.devel/10998>
<https://github.com/ValdikSS/openvpn-with-patches/commit/664763ac3cd1e23713=
ecf75456ef26ccb92e6231>

Snair took a quick look and based on that the patch looks ok. Mattock=20
will create and publish test installers with the patch tomorrow, after=20
which snair, mattock and janjust will do testing on Windows 7/8/10 and=20
Windows Server 2012. Further testing by other community members will=20
help build confidence in the revamped patch

--

Discussed the Interactive service patch, in particular the security=20
aspects of it. At installation time, admin gets to choose whether config=20
files are restricted or not in some way, e.g. by only loading them from=20
a certain directory or from any place where the user has access to. The=20
communication channel between GUI and service will be changed to ensure=20
that only startup-relevant options can be passed from GUI to service (so=20
a rogue gui can't do bad stuff).

Snair will do some practical tests to ensure that the restrictions=20
imposed by the interactive service cannot be circumvented.

---

Full chatlog has been attached to this email.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

--------------020901010303000103030008
Content-Type: text/plain; charset=UTF-8;
	name="openvpn_irc_meeting_chatlog_2016-02-01.txt"
Content-Disposition: attachment;
	filename="openvpn_irc_meeting_chatlog_2016-02-01.txt"
Content-Transfer-Encoding: quoted-printable

(21:02:48) mattock: howdy
(21:02:51) ValdikSS: me
(21:03:03) mattock: quick response to a question I did not have time to a=
sk :P
(21:03:11) mattock: who else?
(21:04:04) mattock: (is here)
(21:04:09) cron2_: muh
(21:05:04) mattock: xkjyeah can't make it because of timezone issues (UTC=
+8)
(21:05:27) mattock: lev__, ltfish?
(21:05:32) janjust [~janjust@...1423.../community/support/janjust] =C3=A8 en=
trato nella stanza.
(21:05:38) mattock: ah hi!
(21:05:43) janjust: hi!
(21:06:46) mattock: four people already, so I guess we can start
(21:07:02) janjust: I see 10 on the list :) ?
(21:07:31) mattock: before we start, I should mention that there are some=
 fairly odd issues with our download servers, with links to I602/I002 ins=
tallers missing from the webserver index (https://swupdate.openvpn.org/co=
mmunity/releases/)
(21:07:32) vpnHelper: Title: Index of /community/releases/ (at swupdate.o=
penvpn.org)
(21:07:38) mattock: so I'll probably have to multitask a bit
(21:07:52) mattock: janjust: most are just idling, even though this is ju=
st a meeting channel
(21:10:03) cron2_: the most interesting discussion seems to happen on the=
 list between selva and d12fk now, and neither is here...
(21:10:14) cron2_: review!
(21:10:35) janjust: so we only want to discuss the interactive service bi=
t?
(21:10:56) mattock: topics: https://community.openvpn.net/openvpn/wiki/To=
pics-2016-02-01
(21:10:58) vpnHelper: Title: Topics-2016-02-01 =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)
(21:11:00) ValdikSS: Can we start with block-outside-dns update for Vista=
?
(21:11:12) janjust: there's something I'd like to figure out how to do in=
 windows: let openvpn run in 'normal' mode and only when privileged mode =
is required, THEN pop up the dialog
(21:11:43) janjust: but that's "wishlist" stuff... block-outside-dns seem=
s more practical and relevant for now
(21:11:54) mattock: I'm fine with starting with that
(21:13:40) ValdikSS: Well, it seems that Vista can't do non-equal matchin=
g for a program name and fails, so I edited the code to whitelist openvpn=
.exe before all other filtering rules and use equal matching instead.
(21:15:33) ValdikSS: https://community.openvpn.net/openvpn/ticket/648
(21:15:36) vpnHelper: Title: #648 ("Can't add WFP" filter being fatal?) =E2=
=80=93 OpenVPN Community (at community.openvpn.net)
(21:16:21) cron2_: feature-ack, but someone who understands windows needs=
 to review the code... selva or ltfish have been very helpful with the in=
itial wfp patch but seem busy these days
(21:16:54) janjust: agreed, and I don't understand the WFP details myself=
 eitehr
(21:17:55) mattock: valdikss: t
(21:18:06) mattock: he code is in your GitHub fork, right?
(21:18:46) cron2_: on the list
(21:18:56) snair [~snair@...2116...:3c03:e001:3b00::1004] =C3=A8 entrato nella =
stanza.
(21:19:04) mattock: selva, I presume
(21:19:04) cron2_: http://article.gmane.org/gmane.network.openvpn.devel/1=
0998
(21:19:06) vpnHelper: Title: Gmane -- PATCH Update block outside dns to w=
ork on Windows Vista (at article.gmane.org)
(21:19:20) ValdikSS: mattock: https://github.com/ValdikSS/openvpn-with-pa=
tches/commit/664763ac3cd1e23713ecf75456ef26ccb92e6231
(21:19:26) vpnHelper: Title: Update --block-outside-dns to work on Window=
s Vista =C2=B7 ValdikSS/openvpn-with-patches@...2117... =C2=B7 GitHub (at gi=
thub.com)
(21:19:27) mattock: thanks guys!
(21:19:29) snair: sorry to be late -- yes selva here .. hi
(21:19:32) janjust: Hi snair!
(21:19:40) cron2_: hi snair, cool you could make it
(21:19:47) cron2_: and thanks for the review
(21:19:57) snair: hi janjust! hi cron2_ !
(21:20:08) janjust: which timezone are you in , selva?
(21:20:24) snair: janjsut: EST
(21:20:37) janjust: ow that's not too bad I guess
(21:20:43) mattock: hi snair!
(21:21:01) snair: hi mattock !
(21:22:34) snair: Did anyone mention what happens to --block-dns with iSe=
rvice?
(21:22:59) mattock: I have not heard of anything
(21:23:59) cron2_: Good point.  I'd guess it will blow up, as openvpn.exe=
 has no elevated privs anymore - so it would need to be moved into the is=
ervice as well (and/or duplicated as we have now)
(21:24:09) snair: yes
(21:24:41) cron2_: the iservice code itself is fairly well tested as asta=
ro/sophos is shipping it with their product since ~3 years, but they don'=
t have block-dns
(21:25:34) snair: cron2_: I'm still concerned with allowing any config fi=
le, any options etc...
(21:25:39) cron2_: ok, on my TODO list.  But that is not complicated.
(21:25:46) d12fk: back
(21:26:20) cron2_: snair: "any options" I do not see a major issue with -=
 after all, it's running with your privs, so --up & friends cannot do mor=
e than you can (which is much better than today...)
(21:26:35) d12fk: would be cool to configure the allowed options and thei=
r values via regex
(21:26:54) d12fk: it's just about --route really
(21:27:05) snair: What about --remote
(21:27:18) janjust: cool but nearly undoable ... there're all kinds of sc=
ripts possible
(21:27:25) d12fk: and anything else we move into the service
(21:27:35) cron2_: snair: what's the attack scenario you're afraid of?
(21:27:50) mattock: didn't we have an option whilelisting discussion a wh=
ile back regarding Tunnelblick?
(21:27:53) cron2_ =C3=A8 ora conosciuto come cron2
(21:27:57) janjust: yup mattock=20
(21:28:02) snair: set up a server and push routes, for example
(21:28:09) cron2: we did, but tunnelblick is running openvpn with admin p=
rivs, which we try to stop doing here
(21:28:33) cron2: snair: yes, so you can interfere with people's VPN - bu=
t what do you gain?
(21:28:34) janjust: d12fk, what do you mean "just about --route" ? =20
(21:28:45) d12fk: --remote is not passed to the service
(21:28:46) cron2: janjust: talking about iservice context
(21:28:53) snair: even if openvpn has user privs, the service is ready to=
 setup any routes that it asks for
(21:28:55) d12fk: so you could alter where you connect to, but you can cu=
rrently also just pass a --config to the GUI to start with
(21:29:18) d12fk: routing is done with elevated privs, the rest is run as=
 the user who runs the gui
(21:29:20) cron2: snair: yes, but where is the attack in that?  you can k=
ick someone off their corporate network, so they klick on "stop vpn" and =
are back
(21:29:22) snair: currently you need admin privs, so allowing any config =
is ok
(21:29:39) cron2: currently you have admin privs, so we live in full dang=
er zone...
(21:30:18) janjust: hmm on the client side there are more scripts than --=
up and --route  - although on windows it hardly makes sense to use an --u=
p script
(21:30:28) janjust: and I foresee a split between tun mode and tap mode=20
(21:30:46) snair: cron2_: trick the user to run a rogue program as user a=
nd redirect all traffic kind of scenario is what worries me..
(21:30:47) cron2: janjust: openvpn runs with the user's privileges, so --=
up and friends run with user privs as well - "nothing you cannot do from =
a cmd.exe window"
(21:31:03) cron2: snair: that rogue program could just https to its home =
base...
(21:31:22) janjust: cron2: it gets trickier when the certificate/keypair =
is located in a protected place
(21:31:46) d12fk: i think we're past the discussion if option limiting is=
 useful or not
(21:31:49) d12fk: it is
(21:31:56) d12fk: just not implemented as of yet
(21:31:57) janjust: agreed
(21:32:04) cron2: I totally do not see the point in it :-)
(21:32:32) cron2: it's lots of work, and if you only allow admins to inst=
all config files (-> which we want to do), admins can mess your machines =
anyway
(21:32:34) d12fk: windows limited access to the the routing table and we'=
re opening it again
(21:33:13) d12fk: currently users can install routes by compiling the gui=
 to pass their wanted --route in addition
(21:33:14) snair: If the OS restriction on setting route require admin is=
 pointless, then I lose..=20
(21:34:06) cron2: d12fk: ok, that's something we might reconsider - only =
permit --config files from an (installation-time-checkbox-dependant) admi=
n directory, no other options from the gui->service->openvpn
(21:34:15) cron2: s/reconsider/consider/
(21:34:52) d12fk: the gui passes all kinds of stuff on the comdline in ad=
dition to what is in the config file
(21:34:56) cron2: snair: of course you can tie down everything, and what =
happens?  people run the GUI with admin privileges because that stuff jus=
t gets in the way - and bam, you have full rights for every script, not j=
ust "rights to install routes"
(21:34:57) snair: fine, consider please.. :-)
(21:35:00) d12fk: --msg-channel is one of them
(21:35:31) snair: Only if the user has admin privs -- I am looking at thi=
s from a sysadmin perspective
(21:35:51) janjust: errr d12fk , which option is that?
(21:35:53) cron2: d12fk: understood, "only those that are needed to make =
openvpn start, open the admin interface, open given config"
(21:36:38) cron2: snair: as am I.  Admin puts config in a well-defined pl=
ace user cannot write.  GUI will only ever use configs in \program files\=
openvpn\config\ - where's the remaining attack (provided option filtering=
 gui->service is done)
(21:36:42) cron2: ?
(21:37:23) snair: The user can write a GUI that passes arbitrary options
(21:37:26) cron2: but option filtering gui->service is very easy, as only=
 a very small number of options need be passed - possibly, one could do a=
way with passing "openvpn command line" options there totally and just pa=
ss a structure that has all you need, and the service builds the command =
line from it
(21:37:27) d12fk: janjust: it coming with the i service
(21:37:41) cron2: snair: of course you wouldn't filter that in the gui, b=
ut in the service
(21:38:18) d12fk: i think we agreed to passing them not as string but str=
ucture, so we don't have to do string parsing
(21:38:22) snair: cron2: ok, filter in the service side is all that's nee=
ded
(21:38:24) janjust: can't we just steal (use) what NetworkManager has?
(21:38:27) janjust: the method is similar
(21:38:38) d12fk: on windows?
(21:38:44) cron2: janjust: it's using a special plugin
(21:39:02) janjust: no but NetworkManager has an openvpn plugin that also=
 providers a "barrier" between the gui and the service
(21:39:09) cron2: ... which talks to the NM privileged process using a pi=
pe... which is about what we do now :-) - the built-in code in openvpn is=
 very straightforward
(21:39:27) cron2: so actually NM could do that, and do away with their pl=
ugin
(21:39:57) cron2: the NM approach is a ugly hack that relies on environme=
nt variables and doesn't communicate properly what happens... this is muc=
h better
(21:40:27) janjust: hehe I smell a little NIH syndrome ;)
(21:40:30) cron2: snair: good :-)
(21:40:47) d12fk: actually it was not invented in munich =3DP
(21:41:17) snair: so we all seem to be in agreeement :-)
(21:41:29) d12fk: yep
(21:41:32) cron2: so let me try to summarize
(21:42:09) cron2: - at installation time, admin gets to chose whether con=
fig files are restricted or not (however that is done effectively - restr=
ict to a directory or "to wherever the user has access", etc.)
(21:42:42) cron2: - the communication channel between gui and service get=
s changed to ensure that only startup-relevant options can be passed from=
 GUI to service (so a rogue gui can't do bad stuff)
(21:43:28) d12fk: on thing for the future, which would be nice, is that u=
sers can download the config(s) themselves. that breaks the "admin puts c=
onfig in a secure place" precondition however
(21:43:30) d12fk: maybe
(21:43:44) d12fk: we could let the admin decide as you put it
(21:44:14) d12fk: and have the gui search for configs in program files an=
d %home%
(21:44:26) janjust: it could also depend on the config file - some config=
s do not require any system routing changes=20
(21:44:29) cron2: for my corporate users, I'm not worried much about inst=
alling bogus routes, but I *am* worried about them running stuff like --u=
p scripts with privileges
(21:44:48) cron2: janjust: in that case, just don't start the iservice at=
 all :) and the gui will just run openvpn.exe directly
(21:45:13) janjust: cron2, true, but how will the gui (user) choose betwe=
en those 2 paths
(21:45:24) cron2: "iservice there -> use iservice.  iservice not there ->=
 not use iservice"
(21:45:51) snair: cron2: there could be rogue iservices !
(21:45:52) cron2: it does that today, just nobody notices because nobody =
(but me :) ) has iservice running
(21:46:05) cron2: snair: indeed.  What is the attack angle here?
(21:46:21) janjust: hm I'm thinking of a scenario where the admin has ins=
talled config files but a user wants  to add a harmless config of his/her=
 own
(21:46:26) cron2: "I'm a service, I have all the privileges in the world,=
 now I trick users into telling me about their openvpn config"
(21:47:29) snair: cron2: start a rogue iservice, open a named pipe and wa=
it for a GUI to conenct as admin -- then impersonate
(21:47:59) cron2: snair: well, this is why we must no longer install the =
gui with admin privs, obviously, as soon as we have an iservice"
(21:48:20) d12fk: but then you need to have the right to impersonate in t=
he first place
(21:48:28) d12fk: normal users do not have that
(21:48:56) snair: d12fk: I think same logon session will allow impersonat=
ion
(21:49:15) janjust: but wouldn't you need admin rights to start a rogue s=
ervice?
(21:49:32) d12fk: that a priv that is assigned to accounts not sessions a=
faik
(21:49:45) snair: janjust: no just alimited user process that opens the n=
amed pipe and wait
(21:50:47) snair: d12fk: last time I checked same logon session was enoug=
h   -- will check again
(21:52:45) snair: see under https://msdn.microsoft.com/en-us/library/aa37=
8618(VS.85).aspx
(21:53:29) d12fk: however if the process would run in the same session th=
en it would be started by the user and would have the same rights anyways
(21:54:47) snair: d12fk: think of user runs GUI as admin rights (using UA=
C)
(21:55:29) d12fk: that's why i alsways said the this should never be merg=
ed in the first place
(21:55:41) janjust: hm but that can be countered by checking the security=
 info of the named pipe that you're connecting to
(21:56:27) snair: d12fk: even before we merged it users were using run as=
 admin
(21:57:04) d12fk: yes, but then it was their fault, now it's the communit=
ies responsibility because we made them=20
(21:57:10) snair: anyway easy to fix: GUI should not connect to any named=
 pipe while running as admin
(21:57:29) cron2: can what janjust suggested be easily done?  "hey, you, =
what user are you running with?"
(21:57:31) d12fk: better: gui should not run as admin
(21:57:43) snair: d12fk: agreed -- if I had realized this I wouldn't have=
 agreed to the highestPriv merge...=20
(21:57:51) janjust: AFAICT yes, cron2=20
(21:57:52) janjust: https://msdn.microsoft.com/en-us/library/windows/desk=
top/aa365600%28v=3Dvs.85%29.aspx
(21:57:54) vpnHelper: Title: Named Pipe Security and Access Rights (Windo=
ws) (at msdn.microsoft.com)
(22:00:13) snair: as a safety measure I would also say openvpn.exe should=
 not use msg_channel while running as admin
(22:01:09) cron2: that sounds like a small local change which would kill =
this whole attack for good
(22:01:20) snair: yep
(22:01:27) cron2: (and if someone *wants* to run the GUI as admin, they c=
an, but they don't need the iservice then anyway)
(22:01:37) cron2: "their decision, their foot"
(22:01:40) d12fk: i think it would even be sufficient to only do it there=
 and not duplicate the code
(22:03:10) snair: you mean running openvpn.exe as admin with --msg-channe=
l is ok?  Probably yes, but I'm not sure..
(22:03:34) d12fk: no just saying checking in ovpn only is sufficient
(22:03:45) d12fk: the chack in the gui can be dropped
(22:04:11) snair: no, the GUI running as admin and connecting to the serv=
ice pipe is a bigger concern
(22:04:41) d12fk: but if openvpn blocks it that's not a problem
(22:05:00) janjust: that's different code, though ... and I can try to fi=
nd out if the link I mentioned works as a countermeasure
(22:05:10) d12fk: the pipe server would need impersonate privileges
(22:05:34) d12fk: so it would be running with a high priv account anyways
(22:06:23) snair: d12fk: the pipe server will have it if it was a process=
 started by the same user -- the problem is UAC whgich makes users "bipol=
ar"
(22:06:39) d12fk: that's not true
(22:07:11) snair: That's you trick a user to click on a link and start th=
e pipeserver. In teh same logon session the user runs the GUI with admin =
rights
(22:07:18) d12fk: if the pipe server was started using uac, then you gran=
ted it admin anyways
(22:07:25) d12fk: otherwise it cannot impersonate
(22:08:13) d12fk: so in you scenario the pipe server runs as user and the=
 gui runs as admin? then the pipe server cannot impersonate
(22:08:14) snair: MSDN says Same logon session is enough to impersonate -=
- not sure whether this changed in recent version fo windoes. I'll test t=
his
(22:08:28) d12fk: where dos it say that?
(22:08:46) snair: https://msdn.microsoft.com/en-us/library/aa378618(VS.85=
).aspx scroll down to remarks
(22:09:34) d12fk: "A process (or another process in the caller's logon se=
ssion) created the token using explicit credentials through LogonUser or =
LsaLogonUser function."
(22:09:36) d12fk: that?
(22:10:04) snair: yes
(22:10:28) d12fk: But then you have to call logon user, which consumes cr=
edentials, no?
(22:11:09) d12fk: if you do that then you need no gui after all
(22:11:27) d12fk: you give the process your creds, so it can impersonate =
you
(22:11:35) d12fk: straight forwards, i'd say
(22:12:20) snair: I read it as applies only to named pipe client imperson=
ation=20
(22:13:10) d12fk: key word is token, so you got the token by calling one =
of the functions, then you can impersonate using that token
(22:13:48) d12fk: but we get the token by checking who's on the other end=
 of the pipe and then you need  the SeImpersonatePrivilege privilege
(22:14:04) d12fk: only elevated accounts have it
(22:14:20) d12fk: you can create other accounts yourself, but then you're=
 stupid =3D)
(22:15:08) snair: I've not tested this so probably you are right. Will gi=
ve it a try tonight..
(22:15:18) d12fk: cool
(22:15:38) d12fk: if not the docs are very badly written if i'm asked
(22:16:40) snair: ok, better be safe than ... will get back to this later=
..
(22:17:35) d12fk: fine with me
(22:17:54) d12fk: i'll drop out now, got very silent anyways lately
(22:18:05) syzzer: nice to see we have people that actually understand th=
e windows privilege system :)
(22:18:09) mattock: yeah
(22:18:32) syzzer: and sorry for slacking up with the iservice, d12fk.  t=
oo much other stuff :(
(22:18:33) mattock: d12fk: thinkgs go silent because of the depth of the =
topic
(22:18:41) mattock: nobody else had any input :)
(22:18:44) snair: is the meeting still on :-)
(22:18:49) mattock: yes
(22:19:06) d12fk: alright, as soon as we move away from the color of the =
bikeshed... =3DP
(22:19:07) mattock: so can someone summarize what was said?
(22:19:33) d12fk: cron2's summary earlier was to the point
(22:19:38) cron2: syzzer: oh, good that you are here.  I need an ACK for =
the openvpn side of the iservice v3 patch
(22:19:39) mattock: ok, that I have already
(22:19:46) d12fk: [20:42] <cron2> so let me try to summarize
(22:19:48) d12fk: [20:42] <cron2> - at installation time, admin gets to c=
hose whether config files are restricted or not (however that is done eff=
ectively - restrict to a directory or "to wherever the user has access", =
etc.)
(22:19:49) d12fk: [20:42] <cron2> - the communication channel between gui=
 and service gets changed to ensure that only startup-relevant options ca=
n be passed from GUI to service (so a rogue gui can't do bad stuff)
(22:20:04) mattock: ok, good enough for me
(22:20:04) cron2: syzzer: I basically worked in all that was said about v=
1, but now I changed so much that someone "who is not me" should re-revie=
w that part
(22:20:09) d12fk: in addition snair will check the logonuser case
(22:20:43) snair: what about --block-dns?
(22:20:44) ***cron2 is happy to see progress here :)
(22:21:06) syzzer: cron2: is "stare at code" sufficient for the patch/
(22:21:15) d12fk: --block-dns would have to be implemented in the service
(22:21:22) syzzer: I recall that testing it was painful...
(22:21:23) cron2: snair: I suggest we get "what we have" into the tree so=
 it can be tested further, and then add the necessary bits for --block-dn=
s (service plus callout plus structure)
(22:21:42) snair: ok
(22:21:48) cron2: syzzer: the openvpn side can be stared-at, I think.  It=
 shrunk quite a bit after I hid the msg_channel in tt->options
(22:22:12) cron2: snair: just process-wise, so we can make individual ste=
ps that are not holding up everything before it is perfect
(22:22:33) d12fk: ok cu guys around
(22:22:37) syzzer: yeah, that should improve thing quite a bit - I did th=
at a while ago, but never managed to compile it to a working windows serv=
ice :(
(22:22:41) cron2: syzzer: but testing actually worked out well for me - t=
ested that last week
(22:22:54) snair: cron2: sure
(22:23:05) cron2: d12fk: thanks for making it, and good night :)
(22:23:14) d12fk: nite
(22:23:22) syzzer: good night
(22:23:37) janjust: goodnite d12fk=20
(22:23:50) snair: bye d12fk
(22:23:53) cron2: so... the other pressing windows issue that could be di=
scussed today is valdikss' fix for --block-outside-dns in http://article.=
gmane.org/gmane.network.openvpn.devel/10998
(22:23:55) vpnHelper: Title: Gmane -- PATCH Update block outside dns to w=
ork on Windows Vista (at article.gmane.org)
(22:23:58) d12fk ha abbandonato la stanza ("Konversation terminated!").
(22:24:17) cron2: the "how do we do service in future" needs the openvpns=
ervice2 author who is in GMT+8 as I understand
(22:24:37) mattock: yes, he is
(22:25:08) mattock: I think we can, however, discuss/select the basic app=
roach without him
(22:25:19) mattock: he's almost certainly biased towards ovpnserv2
(22:25:21) mattock: :)
(22:25:50) mattock: anyways, let's do ValdikSS's --block-outside-dns firs=
t
(22:26:12) mattock: we already started that topic, then snair and d12fk a=
ppeared and Interactive Service took over
(22:26:36) snair: sorry abt that
(22:26:50) mattock: here are the links for your convenience:
(22:26:50) mattock: https://community.openvpn.net/openvpn/ticket/648
(22:26:50) mattock: http://article.gmane.org/gmane.network.openvpn.devel/=
10998
(22:26:50) mattock: https://github.com/ValdikSS/openvpn-with-patches/comm=
it/664763ac3cd1e23713ecf75456ef26ccb92e6231
(22:26:52) vpnHelper: Title: #648 ("Can't add WFP" filter being fatal?) =E2=
=80=93 OpenVPN Community (at community.openvpn.net)
(22:26:53) vpnHelper: Title: Gmane -- PATCH Update block outside dns to w=
ork on Windows Vista (at article.gmane.org)
(22:26:54) vpnHelper: Title: Update --block-outside-dns to work on Window=
s Vista =C2=B7 ValdikSS/openvpn-with-patches@...2117... =C2=B7 GitHub (at gi=
thub.com)
(22:28:04) janjust: I'm just wondering : does Vista need this patch in th=
e first place? is there a dns leakage issue on Vista?
(22:28:36) mattock: it should not have any problems
(22:28:55) mattock: leakage issues I mean
(22:29:09) mattock: is the --block-outside-dns useful even if there is no=
 leakage?
(22:29:24) mattock: I mean is there a use-case for it then?
(22:31:04) mattock: ValdikSS: ^^^
(22:33:59) snair: There may not be a need for this feature on vista, but =
we have only one executable and it should run on vista
(22:34:22) syzzer: btw, cron2, I will stare at the iservice code.  just n=
ot today; too tired.
(22:34:30) cron2: syzzer: thanks, good night
(22:35:11) mattock: snair: ok, so having the patch work in Vista is impor=
tant
(22:35:27) mattock: can you do a review?
(22:35:27) janjust: snair: having one executable does not mean you have t=
o run the block-dns stuff on Vista (or even Win7); we could simply print =
an info message and not run the WFP stuff
(22:36:07) cron2: if the patch has no drawbacks, having common code that =
just works is easier than having an extra version check
(22:36:09) snair: janjust: you're right, we could do that=20
(22:37:51) janjust: I agree with cron2, however: "if the patch has no dra=
wbacks" ... but we'll need to test the new patch on the affected platform=
s (Win 8+, 10) to see we don't break anything
(22:38:24) snair: At first sight the code looks ok, but going through all=
 those tests is a pain indeed
(22:41:46) snair: seeing the silence, it may be easier to review, test an=
d merge the code than discuss what to do.
(22:42:18) mattock: I could merge the patch and provide test installers
(22:42:36) mattock: it will take a while to get the tests done
(22:42:39) cron2: that would certainly help testing
(22:42:52) mattock: what exactly needs to be tested?
(22:43:46) snair: That it works on vista and blocks dns on win8/10
(22:44:04) cron2: that --block-outside-dns actually does what it says - o=
penvpn works, no other dns queries ever leave via the normal LAN or wifi =
interface
(22:44:51) snair: I can do a review and test the exec on Win7/win10 but m=
ore tests by end users would be useful  -- making installers available wo=
udl encourage that.
(22:45:54) mattock: I can test Windows Server 2012 and Windows 7
(22:46:31) mattock: any hints on how to verify blocking is working proper=
ly? a combination of packet capture and nslookup or whatever?
(22:47:43) mattock: according to Trac ValdikSS has setup a Windows Vista =
(VM), so that angle is covered=20
(22:47:54) cron2: not nslookup, but stuff like ping or web browsing
(22:48:08) mattock: cron2: ok
(22:48:09) cron2: nslookup isn't using windows APIs so the results are di=
fferent
(22:48:13) snair: https://www.dnsleaktest.com/ is an easy quick test thou=
gh packet capture would be better.
(22:48:14) vpnHelper: Title: DNS leak test (at www.dnsleaktest.com)
(22:48:31) cron2: (nslookup *will* work, but you need to be careful what =
you're querying and what servers to specify to get meaningful results)
(22:48:34) mattock: I will produce test installers tomorrow
(22:49:24) mattock: maybe this is enough for today?
(22:49:47) janjust: think so, almost 2 hours
(22:49:58) janjust: I'll scrounge around for windows 8
(22:50:04) mattock: great!
(22:50:10) snair: I've to runn too soon..
(22:51:29) mattock: ok, let's continue the discussion later!
(22:51:33) mattock: good night guys!
(22:51:37) cron2: good night :)
(22:51:47) snair: good night all -- well still day here..
(22:52:14) janjust: good night :)

--------------020901010303000103030008--

