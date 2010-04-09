Message-ID: <4BBF0AE8.6090705@...515...>
Date: Fri, 09 Apr 2010 14:09:28 +0300
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090001090908040501060009"
Subject: [Openvpn-devel] Summary of the IRC meeting (8th Apr 2010)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------090001090908040501060009
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the previous community meeting.

---

COMMUNITY MEETING

Place: #openvpn-devel on irc.freenode.net
Date: Thursday, 8th March 2010
Time: 18:00 UTC

Planned meeting topics for this meeting were on this page:

<http://www.secure-computing.net/wiki/index.php/OpenVPN/IRC_meetings/Topics=
-2010-04-08>

Next meeting next week, same place, same time. Your local meeting time
is easy to check from services such as

<http://www.timeanddate.com/worldclock>

or with

$ date -u


SUMMARY

NOTE: the #openvpn-devel channel will be used instead of
#openvpn-discussion from now on.

Decided to fix this bug (in Debian BTS) by patching the man-page to
match code comments:

* "Openvpn manpage does not match the documentation in the code"
   <http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D576823>

Decided to request further information from the author of this bug
report (in Debian BTS):

* "Assertion fails in socket.c:429 in p2p mode due to Debian ipv6 patch"
   <http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D574164>

Decided to fix this bug (in Debian BTS) by using "long long" values:

* "Integer overflow in bytes=3D count"
  <http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D576827>

Discussed the Fabian Knittel's VLAN tagging patchset:

<http://thread.gmane.org/gmane.network.openvpn.devel/3418>

The patchset is on it's way for inclusion, probably going through a
separate testing tree. After patchset has been discussed and ACK'd on
the mailing list, it will be merged to "allmerged" branch in testing tree.

Discussed building OpenVPN Windows installer bundles in length. Cron2
has been building the installer, but the "disconnect" button in the
Windows Client GUI does not work properly. This issue has been discussed
earlier on the mailing list:

<http://thread.gmane.org/gmane.network.openvpn.devel/3385>

The problem is present regardless of whether the installer bundle was
cross-compiled on Linux or compiled natively on Windows. Discussed the
possible causes for this behavior, which may be a manifestation of a bug
rather than a problem in the build process. Decided to try to get a good
Windows developer to bear the responsibility for Windows installers
built from the "testing" tree.

Discussed driver signing issues with Windows Vista / Windows 7. Agreed
that it should be possible to self-sign the drivers OpenVPN uses.
Currently the lack of signed drivers prevents usage of modified (e.g.
IPv6-enabled) TUN/TAP drivers on these OS'es.

---

Full chatlog as an attachment

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


--------------090001090908040501060009
Content-Type: text/plain; charset="utf-8";
 name=openvpn_irc_meeting_chatlog_2010-04-08.txt
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="openvpn_irc_meeting_chatlog_2010-04-08.txt"

(20:56:38) mattock: hi
(20:57:04) mattock: I'm now present both in flesh and in spirit :)
(20:57:28) mattock: it's just been really busy day
(20:57:32) ***cron2 is nearly there
(20:58:01) ***dazo is here too
(21:00:33) ***agi too
(21:01:02) agi: more in flesh than in spirit (quite sick this last 24h)
(21:01:49) mattock: agi: flu?
(21:02:33) agi: mattock: something like that, yes
(21:02:44) agi: fiber and general body pain
(21:03:01) mattock: you mean fever?
(21:03:09) agi: rigt XD
(21:03:20) agi: h
(21:03:35) agi: omg, I should be writing anything in this condition...
(21:03:46) agi: :)
(21:04:04) dazo: agi:  We'll make sure to dump a lot of tasks over to you t=
oday then ;-)
(21:04:10) mattock: I think we should take care of the Debian IPv6 issue fi=
rst so that you can get some rest
(21:04:23) ***dazo agrees
(21:04:37) jamesyonan [~jamesyona@...1320...] =EF=BF=BD=EF=BF=BD entrato ne=
l canale.
(21:05:16) jamesyonan ha abbandonato il canale.
(21:05:38) agi: dazo: lol
(21:05:42) mattock: +1
(21:06:17) agi: there's a minor issue (just arrived) in the debian bts I'd =
like to comment to
(21:06:20) agi: o
(21:06:29) mattock: do you have a link?
(21:06:38) agi: yep, sec.
(21:07:07) agi: http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D576823
(21:07:09) jamesyonan [~jamesyona@...1320...] =EF=BF=BD=EF=BF=BD entrato ne=
l canale.
(21:07:11) vpnHelper: Title: #576823 - openvpn manpage does not match the d=
ocumentation in the code - Debian Bug report logs (at bugs.debian.org)
(21:07:20) jamesyonan: hi
(21:07:27) agi: hi james
(21:07:31) dazo: (btw ... just a side track ... discovered that openvpn-2.1=
.1 is available for Maemo5/Nokia N900 too ... based on agi's Debian package)
(21:07:39) dazo: Hi, James!
(21:07:48) agi: dazo: yep, and working like a charm :D
(21:07:54) dazo: agi:  indeed ;-)
(21:08:03) ***agi hugs his n900, and waves @ dazo's
(21:08:10) mattock: hi james!
(21:08:19) dazo: agi:  ;-)
(21:09:41) mattock: ok, todays topics are here: http://www.secure-computing=
.net/wiki/index.php/OpenVPN/IRC_meetings/Topics-2010-04-08
(21:09:42) vpnHelper: Title: OpenVPN/IRC meetings/Topics-2010-04-08 - Secur=
e Computing Wiki (at www.secure-computing.net)
(21:10:21) mattock: I suggest discussing the two Debian bugs first as Agi n=
eeds some rest to recover from his illness=20
(21:11:06) mattock: agi: can you explain what the ipv6 patch issue is about?
(21:11:43) mattock: we could not find the correct row in the code last week=
 from the Debian testing source packages
(21:11:54) agi: I think it my related to the arch (64 bit)
(21:11:57) mattock: (or was it the week before that)
(21:12:36) agi: letme check the source
(21:13:01) jamesyonan: re: 576823, yes it looks like the man page should be=
 updated to reflect the options.c --help text
(21:13:38) agi: jamesyonan: ok, I'll path debian's package and send the pat=
ch to the list
(21:13:49) mattock: agi: great!
(21:13:58) agi: (if that's even needed)
(21:14:39) mattock: the fix itself is pretty trivial, but I guess sending a=
 patch to ml would not hurt
(21:15:02) cron2: patch is good - so it can be formally ACKed and included
(21:15:09) dazo: I'd appreciate if all patches goes to ML ... and I'll revi=
ew it and apply it to openvpn-testing immediately
(21:15:47) mattock: I think it's important to keep patches (=3Ddevelopment)=
 visible, even with this kind of technically trivial fixes
(21:15:58) agi: ok, cool
(21:16:20) dazo: mattock:  +1
(21:16:31) agi: I don't see any ASSERT in the line specified in the bug rep=
ort
(21:17:00) mattock: agi: we couldn't find one either
(21:17:08) agi: could be the one @ 629
(21:17:10) mattock: I'm not sure what assert it refers to
(21:17:21) agi: that's included in the IPv6 patch
(21:17:31) agi: or the one @409....
(21:17:47) agi: should I ask the submitter for more info?
(21:17:53) mattock: I think that'd be a good idea
(21:18:05) agi: strace, dump?
(21:18:33) cron2: log file should be sufficient (plus maybe a copy of the p=
atched source file...)
(21:18:37) dazo: if possible to grab a core dump, that's probably most easy=
 to work with
(21:18:50) agi: ok
(21:19:03) agi: just another little thing :)
(21:19:07) agi: http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D576827
(21:19:08) mattock: do we have instructions for bug reporters? e.g. "take a=
 core dump"=20
(21:19:11) vpnHelper: Title: #576827 - openvpn: integer overflow in bytes=
=3D count - Debian Bug report logs (at bugs.debian.org)
(21:19:52) agi: should be trivial to fix
(21:20:06) dazo: mattock:  nope ... that's not mentioned, iirc
(21:20:21) mattock: dazo: there's some stuff here: http://www.secure-comput=
ing.net/wiki/index.php/OpenVPN/Documentation_for_testers
(21:20:22) vpnHelper: Title: OpenVPN/Documentation for testers - Secure Com=
puting Wiki (at www.secure-computing.net)
(21:20:25) mattock: could be more, though
(21:20:26) dazo: agi:  sounds so
(21:20:28) cron2: agi: mmmh, 64 bit stuff can be a bit nasty for portability
(21:20:45) agi: cron2: oh, I see
(21:21:03) dazo: mattock:  agreed ... also to mention 'ulimit -c unlimited'=
 as well
(21:21:12) dazo: (to really enable core dumps)
(21:21:52) cron2: agi: I think gcc has "long long" 64 bit types everywhere,=
 but people might not use gcc on 32 bit systems, and printf-support for 64b=
it might also not be available
(21:21:54) mattock: dazo: could you update the documentation? agi could the=
n refer to those instructions
(21:22:03) dazo: mattock:  will do this evening!
(21:22:07) mattock: great!
(21:23:24) jamesyonan: right -- this can be fixed by using "long long" valu=
es
(21:23:56) cron2: jamesyonan: is the code using 64bit counters today?
(21:24:02) cron2: (in other places)?
(21:24:39) jamesyonan: there's already some usage of this for other counter=
 types that are more user-visible -- see counter_type and counter_format in=
 common.h
(21:24:46) cron2: ah, cool
(21:25:05) cron2: in that case, it's really easy :-)
(21:27:02) mattock: any volunteers to do the fixing?
(21:27:08) mattock: ;)
(21:27:18) ***dazo can do that today
(21:27:35) agi: -  int renegotiate_bytes;
(21:27:46) agi: + long long int renegotiate_bytes
(21:27:47) agi: ?
(21:27:56) cron2: agi: no, "counter_type renegotiate_bytes;"
(21:28:02) agi: ahh
(21:28:06) agi: :)
(21:28:21) agi: right
(21:28:34) jamesyonan: right, then use counter_format whenever you want to =
printf it
(21:29:36) mattock: anything else that requires agi's attention?
(21:30:34) cron2: agi: nothing that cannot wait -> off to bed, get healthy =
again
(21:30:45) agi: I'll send the manpage patch tomorrow, and keep an eye on th=
e tester's doc to direct the assertion's bug submitter there
(21:30:56) mattock: agi: take your time
(21:31:03) agi: thanks guys
(21:31:08) mattock: no probs
(21:31:10) ***agi off to sweat
(21:31:28) mattock: ok, which shall it be? The VLAN patchset?
(21:31:42) dazo: +1
(21:32:22) dazo: I've looked at the clean-up patches briefly this evening .=
.. looking good, will double check the #ifdef's ... but initially begins to=
 look good
(21:32:35) mattock: have any patches been included already?
(21:33:32) dazo: nope, I've just pulled his git tree ... nobody seems to ha=
ve reviewed the latest patches ... but the reason could be the Easter as we=
ll
(21:33:51) mattock: could be
(21:34:08) mattock: it could also be the amount of patches sent at once
(21:34:17) ***cron2 had no time
(21:34:35) dazo: well, it's easier to review from his git tree now ... the =
jumbo patch is not saying much
(21:35:00) ***dazo will merge in his git tree when review is done
(21:35:33) mattock: have you created a separate vlan testing tree?
(21:35:38) cron2: is there a full patch somewhere to review? the patch-to-p=
atch is a bit hard to read
(21:35:48) dazo: but from what I've seen so far, it seems as much as can be=
 #ifdef'ed is #ifdef'ed ... which means it is possible to eliminate the VLA=
N patchset from ./configure now
(21:36:11) dazo: cron2:  I can send you a git command to manage that afterw=
ards
(21:36:16) cron2: thanks :)
(21:37:08) mattock: so the VLAN patchset is under control?
(21:37:16) mattock: =3Don it's way to testing
(21:37:26) dazo: mattock:  it is in progress=20
(21:37:30) mattock: great!
(21:38:11) mattock: what about "How to provide windows installation package=
 for "testing" tree?"
(21:38:14) dazo: it's a rather big patchset ... so I'm considering to creat=
e the feat_vlan_tagging branch and push it out, without merge to allmerged =
before it's gone through an official ACK on the ML
(21:38:32) mattock: dazo: sounds good
(21:38:39) cron2: dazo: this sounds like a good plan, especially in case th=
ey want to add more patches
(21:38:59) dazo: yup, that's my thought
(21:40:42) mattock: cron2: could you elaborate on the windows installation =
package issue?
(21:40:52) cron2: mattoch: ok, here we go
(21:41:01) cron2: we want users to test the stuff
(21:41:24) cron2: building unix packages is "fairly" easy, and we're on a g=
ood way (gentoo, freebsd, debian-soon)
(21:42:12) cron2: I tried building a windows bundle, complete with installe=
r and everything, and found problems with the resulting build - but those a=
re most likely because I mis-built something, not because the original sour=
ce is problematic
(21:42:42) cron2: so we need "someone who understands windows" to build ope=
nvpn-testing .exe install bundles...
(21:42:54) jamesyonan: what kind of problem?
(21:43:23) cron2: jamesyonan: openvpn works, but openvpn-gui cannot "discon=
nect" sessions - pressing the disconnect button just has no effect whatsoev=
er
(21:43:50) cron2: I sent this to the list, but no good suggestions came back
(21:44:02) jamesyonan: you should be able to do a full build from source ->=
 installer using 'domake-win' script, if you have the right dependencies in=
stalled
(21:45:15) cron2: jamesyonan: yes, that's what I did, and I got all the res=
ulting files "just fine" - but as the communication between openvpn-gui and=
 openvpn.exe isn't working right, I wonder whether it's my build system (wr=
ong mingw/msys version...) or something in the sources
(21:45:57) jamesyonan: strange -- I haven't seen that before, but keep in m=
ind that domake-win doesn't actually build the OpenVPN GUI -- it expects it=
 to be pre-built
(21:46:12) cron2: yes, I copied it over from the prebuilt package
(21:46:38) cron2: but the problem is in my openvpn.exe - when I install fro=
m 2.1.1 .exe, and then just replace openvpn.exe, I have the same disconnect=
ion problem
(21:47:25) mattock: so the same problem with the package you built and the =
official package?
(21:47:33) jamesyonan: I use this mingw version: (from gcc --version): 3.4.=
5 (mingw-vista special r3)
(21:48:04) cron2: mattock: the problem is in the openvpn.exe that I build -=
 but it's not related to "I use the 2.1.1 installer" or "I have also built =
my own installer"
(21:48:26) jamesyonan: which windows version are you building on?
(21:48:27) mattock: ok, now it makes sense
(21:49:26) cron2: jamesyonan: mmmh.  I used gcc 4.3.3 as cross-build on lin=
ux, and "most recent mingw" (can't check the exact version number) on Windo=
ws XP/SP3
(21:49:36) cron2: sorry, 4.4.3
(21:50:51) jamesyonan: so you're saying that you cross-built openvpn.exe on=
 linux?
(21:51:38) cron2: I have done both - first, I cross-built openvpn.exe on li=
nux, and then I built locally on Windows.  Both openvpn.exe show the same p=
roblem - "disconnect" doesn't work. Everything else works fine.
(21:52:27) mattock: how do the openvpn.exe and GUI communicate?
(21:52:45) jamesyonan: stdin/stdout/stderr
(21:52:58) jamesyonan: it doesn't use the management interface
(21:53:17) mattock: so the GUI can do connect/disconnect... what else?
(21:53:21) cron2: JJK wrote something on the list about windows signal for =
disconnect?
(21:53:33) mattock: and why should disconnect be any different from, say, "=
connect"?
(21:53:46) cron2: mattock: "connect" basically just starts the openvpn.exe =
process (as far as I understand), and "disconnect" stops it
(21:53:59) mattock: kills the process?
(21:54:12) cron2: lemme search for the thread
(21:54:18) jamesyonan: connect is going to cause process instantiation wher=
e disconnect will depend more on a signaling mechanism
(21:55:00) mattock: does not sound like a build issue, but I'm no specialis=
t, either
(21:55:30) d12fk_: hi there
(21:55:34) mattock: hi
(21:55:38) d12fk_: i can shed some light onthis
(21:56:04) d12fk_: the gui creates an event and inherits the event to openv=
pn via createprocess
(21:56:04) cron2: http://article.gmane.org/gmane.network.openvpn.devel/3385
(21:56:04) vpnHelper: Title: Gmane -- Mail To News And Back Again (at artic=
le.gmane.org)
(21:56:36) d12fk_: the name of the event can be passed to the openvpn.exe v=
ia an win32cmdline option
(21:56:59) d12fk_: so openvpn listens for the event and shuts down then
(21:57:08) d12fk_: the gui triggers the event
(21:57:23) cron2: d12fk_: any idea why this would fail?  or how to debug th=
is?
(21:57:58) dazo: (to get the complete Gmane mail thread .... s/article/thre=
ad/ in the URL)
(21:58:06) d12fk_: no clue
(21:58:58) jamesyonan: to see where this functionality is referenced on the=
 openvpn side: grep exit_event *.[ch]
(21:59:56) d12fk_: i use cygwin with mingw 3.4.4 to build the astaro client=
 and it always worked
(22:00:15) jamesyonan: why don't you just add some debugging printfs to ope=
nvpn to show what state it thinks the exit event object is in, then see if =
trying to disconnect from the GUI is detected
(22:00:15) d12fk_: with the latest win32api
(22:00:55) d12fk_: if you use msg you see the output in the gui
(22:01:02) cron2: jamesyonan: I had no idea where to start doing this, so t=
his is already helpful
(22:03:15) cron2: d12fk_: I'm not sure if I read this right
(22:03:30) jamesyonan: see the win32_signal struct in win32.h
(22:04:45) jamesyonan: basically that code tries to make the state transiti=
on of the win32 event object look like a unix SIGTERM
(22:05:29) cron2: ah
(22:06:07) cron2: maybe it was just me calling openvpn-exe in a wrong way
(22:06:26) d12fk_: actually the gui should call openvpn the right way
(22:06:54) cron2: if I run openvpn-gui.exe from cmd.exe, will that make ope=
nvpn.exe run in WSO_MODE_CONSOLE or WSO_MODE_SERVICE mode?
(22:07:24) cron2: (read: will the console from cmd.exe be inherited -> open=
vpn-gui.exe -> openvpn.exe)?
(22:07:29) d12fk_: the first one i hope
(22:07:48) cron2: I see that the code in win32_signal_get() is only execute=
d in WSO_MODE_SERVICE mode
(22:10:13) mattock: cron2: is this enough to get you going again?
(22:10:30) cron2: it's enough to get me going, but it sort of sidetracked t=
he point :-)
(22:10:45) ***cron2 would like for someone who is *not me* to provide openv=
pn-windows binaries
(22:10:52) mattock: :D
(22:11:06) cron2: well, openvpn-testing windows binaries
(22:11:09) cron2: but you got the point :)
(22:11:50) dazo: anyone in the community which have been involved with Wind=
ows patches we could ask?
(22:12:23) ***dazo have quickly looked at a counter_type patch .... he wond=
ers if he's missing something ... http://pastebin.org/141785)
(22:13:54) mattock: cron2: how well is building win32 binaries documented?
(22:13:55) d12fk_: cron2: the gui invokes openvpn.exe like: openvpn --servi=
ce %s 0 --config %s
(22:13:55) cron2: dazo: looks good to me ("ACK!")
(22:14:08) ***dazo creates a patch and mails it
(22:14:17) cron2: mattock: quite well, there is a "domake-win" script in th=
e openvpn source that has lots of documentation in it
(22:14:48) cron2: mattock: ... but it's still not straightforward for peopl=
e that are not regular windows users
(22:15:06) mattock: we could try to find a volunteer on the mailing list
(22:15:14) mattock: and rethink what to do if that fails
(22:15:36) mattock: preferably somebody who actually uses windows
(22:16:49) mattock: however, I think it'd be great if you could solve this =
issue first to give the potential volunteers the (false) impression that ma=
intenance of windows binaries is just a walk in the part :D=20=20
(22:16:54) mattock: in the park
(22:17:02) cron2: hrm
(22:17:21) jamesyonan: yeah right :)
(22:18:25) mattock: cron2: what do you think? do feel like getting rid of t=
he whole windows installer thing right now?
(22:18:29) jamesyonan: I think it makes sense to investigate this as a poss=
ible bug
(22:18:46) cron2: I'll go and do some more tests and see what I can find out
(22:19:15) d12fk_: jamesyonan: has the event handling changes since the lat=
e RCs
(22:19:55) jamesyonan: re: building on Windows, it's a PITA to get it worki=
ng the first time, but then it usually just works the second and third times
(22:20:28) jamesyonan: no, the event code has been stable for years
(22:21:00) d12fk_: in my ideal world this would be a matter of ./configure =
&& make win32 && make installer
(22:21:48) d12fk_: ok, then i can assure that it works and is not buggy, as=
 we ship rc19 since it was released
(22:21:49) cron2: d12fk_: but in a windows world, you need to build drivers=
...
(22:21:59) cron2: oh, there is actually something I forgot
(22:22:13) d12fk_: with a ddk installed and a nifty AC_DDK no problemo
(22:22:14) cron2: to be able to test on w7/64, one needs a signed TAP driver
(22:22:40) cron2: can openvpn com build signed drivers?
(22:22:43) d12fk_: you can generate selfsigned certs with the dk
(22:22:54) d12fk_: ddk sorry
(22:23:17) cron2: d12fk_: can you install them on 64bit windows?  I thought=
 you have to have a "real" signature
(22:23:52) d12fk_: afaik they just need to be signed, no matter what CA, bu=
t i could be wrong
(22:24:19) cron2: that would make the whole excercise a bit pointless :-)
(22:24:53) d12fk_: it actually is very pointless, because the signature jus=
t tells you who signed the thing, not that its bug free
(22:26:00) cron2: well, it can help tracking back malware (and stop unsigne=
d malware) - which is not so bad
(22:26:32) d12fk_: if only users would care or understand what they ack
(22:26:39) cron2: but I don't want to discuss whether this is useful - this=
 is just what has been told to me "I can't test the new tap driver because =
it is not signed"
(22:26:51) d12fk_: true
(22:27:19) d12fk_: look for authenticode on msdn for instructions
(22:27:35) d12fk_: thats the 'brand' ms uses for code signing
(22:28:25) d12fk_: somewhere in the ddk section is a howto with step by ste=
p instructions for staging drivers
(22:29:13) mattock: d12fk: is a subscription required? or is MSDN publicly =
usable?
(22:29:31) d12fk_: its msdn.microsoft.com
(22:30:01) mattock: and you don't need to pay to read the articles or anyth=
ing, right?
(22:30:11) cron2: ok, enough windows today.  Let's see how much time I can =
find this weekend to struggle wit this
(22:30:34) d12fk_: mattock: no it's free
(22:30:40) mattock: great!
(22:30:54) mattock: I have a feeling cron2 may not be subscribed to any MS =
services ;)
(22:31:06) cron2: indeed
(22:31:07) dazo: cron2: I've just sent a patch to the ML, would you mind AC=
K'ing it in public?
(22:31:16) cron2: dazo: fine
(22:31:22) dazo: cron2:  thx!
(22:31:31) jamesyonan: check out http://webcache.googleusercontent.com/sear=
ch?q=3Dcache:873W6tB18aQJ:download.microsoft.com/download/9/c/5/9c5b2167-80=
17-4bae-9fde-d599bac8184a/KMCS_Walkthrough.doc+authenticode+sign+test+kerne=
l+mode+drivers&cd=3D6&hl=3Den&ct=3Dclnk&gl=3Dus&client=3Dfirefox-a
(22:31:32) vpnHelper: Title: Kernel-Mode Code Signing Walkthrough (at webca=
che.googleusercontent.com)
(22:31:37) mattock: cron2: let's try to get this windows installer issue of=
f your shoulders a.s.a.p.
(22:31:47) mattock: I feel your pain
(22:31:49) cron2: mattock: yes, thanks :-)
(22:32:10) jamesyonan: look for "MakeCert" -- MakeCert generates digital ce=
rtificates that can be used for test-signing. They can be either self-signe=
d or issued and signed by the Root Agent key. Self-signed certificates are =
recommended for test-signing drivers. The test certificate can be placed in=
 a file, a system certificate store, or both. The Windows Vista RC1 and RTM=
 releases accepts test certificates that are generated by MakeCert for=20
(22:32:10) jamesyonan: test-signing.
(22:33:37) jamesyonan: so it looks like there's a method for test signing t=
hat doesn't require using a real code signing certificate
(22:33:50) cron2: yep, sounds good
(22:34:36) mattock: are we done for today? I think the roadmap issue is too=
 big for today
(22:34:44) mattock: even for the "next release"
(22:35:15) dazo: agreed
(22:35:44) cron2: done
(22:35:50) cron2: (the ACK)
(22:35:57) dazo: cron2:  thx!
(22:36:14) d12fk_: ok, see you next week then
(22:36:43) mattock: d12fk: is it ok if translate the GUI next monday/wednes=
day?
(22:37:31) d12fk_: sure no hurry. i'm stuck a bit progressing anyways. too,=
 much other stuff to currently
(22:37:40) mattock: ok
(22:37:56) mattock: I'll write some instructions to the wiki and send a mai=
l to -devel about that
(22:38:12) mattock: anyways, good meeting, even if a little Windows-focused=
 ;)
(22:38:46) mattock: anything else?
(22:39:16) d12fk_: no, off finally creating the bug tracker for the gui...
(22:39:21) d12fk_: cu
(22:39:31) mattock: bye!
(22:40:32) mattock: bye guys, see you next week!
(22:41:47) d12fk_: might even have a russian translation soon =3D)
(22:43:19) dazo: c'ya!
(22:43:24) ***dazo heads for a little evening meal
(22:43:36) mattock: likewise

--------------090001090908040501060009--

