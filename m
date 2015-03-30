Message-ID: <5519AD9B.9050708@...515...>
Date: Mon, 30 Mar 2015 23:10:03 +0300
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <54CF5CB4.2080607@...515...>
In-Reply-To: <54CF5CB4.2080607@...515...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="ovxCwvAId3RPU7dqrTN9C4mEIaquHmS00"
Subject: [Openvpn-devel] Summary of the IRC meeting (30th Mar 2015)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ovxCwvAId3RPU7dqrTN9C4mEIaquHmS00
Content-Type: multipart/mixed; boundary="------------010304050907020607000405"

This is a multi-part message in MIME format.
--------------010304050907020607000405
Content-Type: multipart/alternative;
	boundary="------------090105080205070409030102"

--------------090105080205070409030102
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the previous IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-devel on irc.freenode.net
Date: Monday 30th Mar 2015
Time: 20:00 CEST (18:00 UTC)

Planned meeting topics for this meeting were on this page:

<https://community.openvpn.net/openvpn/wiki/Topics-2015-03-30>

The next meeting has been scheduled for Monday 13th April 20:00 CEST (18:00=
 UTC):

<https://community.openvpn.net/openvpn/wiki/Topics-2015-04-13>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, dazo, m-a, mattock and syzzer participated in this meeting

---

Discussed OpenVPN 2.3.7 release which should be released within a reasonabl=
e timeframe (a few weeks).

The "Openvpn with crytpodev on FreeBSD does not work" bug will be tested an=
d a fix applied in 2.3.7:

<https://community.openvpn.net/openvpn/ticket/480>

A fix to the "FreeBSD topo subnet self-route not via loopback interface <ht=
tps://community.openvpn.net/openvpn/ticket/481>" will go in unless some une=
xpected issues are encountered:

<https://community.openvpn.net/openvpn/ticket/481>

The "Man-page contains useless dash escapes" will be fixed:

<https://community.openvpn.net/openvpn/ticket/512>

The "LZO compression initialized message displays based on build, not confi=
g" ticket turned out the be invalid:

<https://community.openvpn.net/openvpn/ticket/367>

The "mktun in freebsd" ticket will be fixed, as it's just a documentation p=
atch:

<https://community.openvpn.net/openvpn/ticket/85>

The "ifconfig syntax change insufficiently documented" issue will be fixed:

<https://community.openvpn.net/openvpn/ticket/370>

Discussed TLS version negotiation, which was originally enabled in 2.3.3, t=
hen turned off in 2.3.4 due to unforeseen problems outside our control. Sin=
ce 2.3.3 the underlying problems in OpenVPN have been fixed. In addition it=
's now possible to disable version negotiation in case there are problems.

For these reasons it was agreed that turning on TLS version negotiation aga=
in in 2.3.7 makes sense. M-a reviewed the enablement patch and sent a condi=
tional ACK plus a man-page update proposal to openvpn-devel mailing list.

---

Discussed topics related to the OpenVPN 2.4 release.

It was decided to give NSSM a shot as an option for openvpnserv.exe:

<http://www.nssm.cc>

The Interactive Service makes use of the original openvpnserv.exe, which is=
 thus not going to disappear overnight.

Discussed the "The MacOS X keychain patch". A resolution for a .gitignore i=
ssue was found earlier today on #openvpn-devel. The patch can go in once so=
mebody (such as plaisthos) ACKs the changes between versions v3 and v4 of t=
he patch.

Discussed the "openvpn-gui.exe is not signed" issue. This is not a problem =
in released OpenVPN installers as they include a (signed) openvpn-gui.exe a=
s-is. In upcoming 2.4 -based installer this will be a problem as (unsigned)=
 openvpn-gui.exe is hidden inside (signed) openvpn-gui-installer.exe. Matto=
ck will modify openvpn-build so that it signs openvpn-gui.exe before packag=
ing it into openvpn-gui-installer.exe.

Attempts to talk about the "Interactive Service" failed as d12fk was not pr=
esent.

Discussed the AEAD patchset from syzzer:

<https://github.com/syzzer/openvpn/tree/aead-cipher-modes8>

The patches have been tested for interoperability with James' ovpn3 codebas=
e, but they need proper review. Decided to do this review in the next meeti=
ng (13th Apr).

---

Discussed the "Inline CRL" ticket:

<https://community.openvpn.net/openvpn/ticket/421>

Agreed to close it as "wontfix".

---

Full chatlog is attached.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


--------------090105080205070409030102
Content-Type: text/html; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta content=3D"text/html; charset=3Diso-8859-15"
      http-equiv=3D"Content-Type">
  </head>
  <body bgcolor=3D"#FFFFFF" text=3D"#000000">
    <pre wrap=3D"">Hi,

Here's the summary of the previous IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-devel on irc.freenode.net
Date: Monday 30th Mar 2015
Time: 20:00 CEST (18:00 UTC)

Planned meeting topics for this meeting were on this page:

<a class=3D"moz-txt-link-rfc2396E" href=3D"https://community.openvpn.net/op=
envpn/wiki/Topics-2015-03-30">&lt;https://community.openvpn.net/openvpn/wik=
i/Topics-2015-03-30&gt;</a>

The next meeting has been scheduled for Monday 13th April 20:00 CEST (18:00=
 UTC):

<a class=3D"moz-txt-link-rfc2396E" href=3D"https://community.openvpn.net/op=
envpn/wiki/Topics-2015-04-13">&lt;https://community.openvpn.net/openvpn/wik=
i/Topics-2015-04-13&gt;</a>

Your local meeting time is easy to check from services such as

<a class=3D"moz-txt-link-rfc2396E" href=3D"http://www.timeanddate.com/world=
clock">&lt;http://www.timeanddate.com/worldclock&gt;</a>

SUMMARY

cron2, dazo, m-a, mattock and syzzer participated in this meeting

---

Discussed OpenVPN 2.3.7 release which should be released within a reasonabl=
e timeframe (a few weeks).

The "Openvpn with crytpodev on FreeBSD does not work" bug will be tested an=
d a fix applied in 2.3.7:

<a class=3D"moz-txt-link-rfc2396E" href=3D"https://community.openvpn.net/op=
envpn/ticket/480">&lt;https://community.openvpn.net/openvpn/ticket/480&gt;<=
/a>

A fix to the "FreeBSD topo subnet self-route not via loopback interface<a c=
lass=3D"accepted ticket" href=3D"https://community.openvpn.net/openvpn/tick=
et/481" title=3D"Bug / Defect: FreeBSD topo subnet self-route not via loopb=
ack interface? (accepted)"></a>" will go in unless some unexpected issues a=
re encountered:

<a class=3D"moz-txt-link-rfc2396E" href=3D"https://community.openvpn.net/op=
envpn/ticket/481">&lt;https://community.openvpn.net/openvpn/ticket/481&gt;<=
/a>

The "Man-page contains useless dash escapes" will be fixed:

<a class=3D"moz-txt-link-rfc2396E" href=3D"https://community.openvpn.net/op=
envpn/ticket/512">&lt;https://community.openvpn.net/openvpn/ticket/512&gt;<=
/a>

The "LZO compression initialized message displays based on build, not confi=
g" ticket turned out the be invalid:

<a class=3D"moz-txt-link-rfc2396E" href=3D"https://community.openvpn.net/op=
envpn/ticket/367">&lt;https://community.openvpn.net/openvpn/ticket/367&gt;<=
/a>

The "mktun in freebsd" ticket will be fixed, as it's just a documentation p=
atch:

<a class=3D"moz-txt-link-rfc2396E" href=3D"https://community.openvpn.net/op=
envpn/ticket/85">&lt;https://community.openvpn.net/openvpn/ticket/85&gt;</a>

The "ifconfig syntax change insufficiently documented" issue will be fixed:

<a class=3D"moz-txt-link-rfc2396E" href=3D"https://community.openvpn.net/op=
envpn/ticket/370">&lt;https://community.openvpn.net/openvpn/ticket/370&gt;<=
/a>

Discussed TLS version negotiation, which was originally enabled in 2.3.3, t=
hen turned off in 2.3.4 due to unforeseen problems outside our control. Sin=
ce 2.3.3 the underlying problems in OpenVPN have been fixed. In addition it=
's now possible to disable version negotiation in case there are problems.

For these reasons it was agreed that turning on TLS version negotiation aga=
in in 2.3.7 makes sense. M-a reviewed the enablement patch and sent a condi=
tional ACK plus a man-page update proposal to openvpn-devel mailing list.

---

Discussed topics related to the OpenVPN 2.4 release.

It was decided to give NSSM a shot as an option for openvpnserv.exe:

<a class=3D"moz-txt-link-rfc2396E" href=3D"http://www.nssm.cc">&lt;http://w=
ww.nssm.cc&gt;</a>

The Interactive Service makes use of the original openvpnserv.exe, which is=
 thus not going to disappear overnight.

Discussed the "The MacOS X keychain patch". A resolution for a .gitignore i=
ssue was found earlier today on #openvpn-devel. The patch can go in once so=
mebody (such as plaisthos) ACKs the changes between versions v3 and v4 of t=
he patch.

Discussed the "openvpn-gui.exe is not signed" issue. This is not a problem =
in released OpenVPN installers as they include a (signed) openvpn-gui.exe a=
s-is. In upcoming 2.4 -based installer this will be a problem as (unsigned)=
 openvpn-gui.exe is hidden inside (signed) openvpn-gui-installer.exe. Matto=
ck will modify openvpn-build so that it signs openvpn-gui.exe before packag=
ing it into openvpn-gui-installer.exe.

Attempts to talk about the "Interactive Service" failed as d12fk was not pr=
esent.

Discussed the AEAD patchset from syzzer:

<a class=3D"moz-txt-link-rfc2396E" href=3D"https://github.com/syzzer/openvp=
n/tree/aead-cipher-modes8">&lt;https://github.com/syzzer/openvpn/tree/aead-=
cipher-modes8&gt;</a>

The patches have been tested for interoperability with James' ovpn3 codebas=
e, but they need proper review. Decided to do this review in the next meeti=
ng (13th Apr).

---

Discussed the "Inline CRL" ticket:

<a class=3D"moz-txt-link-rfc2396E" href=3D"https://community.openvpn.net/op=
envpn/ticket/421">&lt;https://community.openvpn.net/openvpn/ticket/421&gt;<=
/a>

Agreed to close it as "wontfix".

---

Full chatlog is attached.
</pre>
    <pre class=3D"moz-signature" cols=3D"72">--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock</pre>
  </body>
</html>

--------------090105080205070409030102--

--------------010304050907020607000405
Content-Type: text/plain; charset=UTF-8;
	name="openvpn_irc_meeting_chatlog_2015-03-30.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="openvpn_irc_meeting_chatlog_2015-03-30.txt"

(20.59.04) mattock: anyways, it's nearly meeting time
(20.59.12) mattock: https://community.openvpn.net/openvpn/wiki/Topics-201=
5-03-30
(20.59.14) vpnHelper: Title: Topics-2015-03-30 =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)
(21.00.42) mattock: who do we have here today?
(21.00.46) mattock: me, m-a, cron2
(21.00.51) mattock: anyone else?
(21.01.05) cron2_: dazo was around just a few minutes ago...
(21.01.52) ***cron2_ looks around for syzzer and plaisthos...
(21.02.18) ***syzzer present!
(21.02.40) mattock: hi syzzer!
(21.02.54) mattock: now if we only had d12fk!
(21.03.08) Sullitaz: dazo, I have to go, thanks for your help
(21.03.09) syzzer: wow, lots of scrollback
(21.03.24) Sullitaz: I will get back to you later probably
(21.03.40) ***cron2_ reads through the open ticket list for "milestone 2.=
3.7" and reports that this cron2 is a lazy bastard...  on (fixed) bug own=
ed by syzzer, 5 by me...
(21.04.02) Sullitaz: bye everybody
(21.04.15) Sullitaz ha abbandonato la stanza (quit: Quit: ChatZilla 0.9.9=
1.1 [Firefox 36.0.3/20150319201009]).
(21.04.46) mattock: https://community.openvpn.net/openvpn/report/3?asc=3D=
1&page=3D2
(21.04.48) vpnHelper: Title: {3} Active Tickets by Milestone =E2=80=93 Op=
enVPN Community (at community.openvpn.net)
(21.04.48) cron2_: syzzer: isn't 410 done?
(21.05.15) syzzer: cron2_: ah, yes, that one can be closed!
(21.05.32) cron2_: syzzer: you or I?
(21.05.39) syzzer: loggin in...
(21.06.04) cron2_: mattock: is your trac account samuli or mattock?  I se=
e tickets assigned to both of you...
(21.06.12) mattock: please use samuli
(21.07.47) cron2_: actually only one
(21.08.42) mattock: I couldn't find any active tickets assigned to "matto=
ck"
(21.08.50) mattock: https://community.openvpn.net/openvpn/report/4
(21.08.52) vpnHelper: Title: {4} Accepted, Active Tickets by Owner =E2=80=
=93 OpenVPN Community (at community.openvpn.net)
(21.09.01) mattock: oh, "Accepted"
(21.09.09) mattock: that narrows down the selection a bit
(21.09.23) cron2_: I already reassigned the only one I foudn
(21.09.47) cron2_: anyway - shall we start?  I think m-a is only interest=
ed in the 2.3.7 bits, so maybe start there?
(21.09.59) m-a: thanks
(21.10.40) mattock: yeah, let's move forward
(21.10.55) mattock: two tickets: https://community.openvpn.net/openvpn/ti=
cket/480
(21.10.57) vpnHelper: Title: #480 ([PATCH] Openvpn with crytpodev on Free=
BSD does not work) =E2=80=93 OpenVPN Community (at community.openvpn.net)=

(21.11.03) mattock: and the second one later :)
(21.11.16) cron2_: well, I'd like to get out 2.3.7 "reasonably soonish", =
say in ~2 weeks time or so, but the bugs you've mentioned (481 and 480) s=
hould definitely go in
(21.11.49) mattock: #480 needs to wait for the test results, right?
(21.11.53) m-a: so from the FreeBSD end of things, https://bugs.freebsd.o=
rg/bugzilla/show_bug.cgi?id=3D195004#c4  is the status - awaiting feedbac=
k. Ermal happens to also be the original reporter against pfsense (URL in=
 comment #1 on the same bug)
(21.11.55) mattock: or is there anything we can do to expedite things?
(21.11.56) vpnHelper: Title: Bug 195004 [PATCH] security/openvpn: Fix ope=
nvpn with aesni.ko loaded (at bugs.freebsd.org)
(21.12.25) cron2_: yes.  Not tagged milestone 2.3.7, but the new patch so=
unds like it should not have side effects (the first one was strictly no-=
go, because it changed user-visible behaviour)
(21.12.54) m-a: someone would need a FreeBSD box with aesni support, Open=
VPN + OpenSSL + aesni engine, reproduce the problem and then we might wan=
t to see.
(21.13.49) cron2_: technically the patch looks reasonable to me, but I ca=
n't test it either
(21.13.59) m-a: should we make ecrist test drive the thing? Should I test=
 drive it in the official port as an option, to check for regressions?
(21.14.19) m-a: ecrist maintains the FreeBSD openvpn-* development ports
(21.14.22) mattock: yep
(21.14.55) syzzer: yeah, I expect this to fix it, but I need someone to t=
est it
(21.14.57) cron2_: I'm not sure this will really give exposure, as it wil=
l only make a difference if an engine is used
(21.15.33) cron2_: whether it breaks anything or not can be tested on any=
thing that uses openssl engine... now whether it *fixes* the FreeBSD case=
, we need to test there :)
(21.15.40) mattock: It looks like the Ermal guy in the FreeBSD bug report=
 has the necessary test setup
(21.15.42) m-a: it would, however, simplify testing if all people need to=
 do is flip the switch
(21.15.59) m-a: actually the guy is in the pfsense bug report
(21.16.07) mattock: is ecrist's testing port based on Git "master" or wha=
t?
(21.16.14) cron2_: on systems without engine, it's a no-op...
(21.16.24) m-a: The FreeBSD bug "reporter", garga (aka Renato Botelho) ha=
s only relayed the thing to me. The originator is Ermal Lu=C3=A7i.
(21.16.28) cron2_: mattock: yes, ports/openvpn-devel is using weekly snap=
shots
(21.16.30) mattock: ah, I see
(21.17.20) cron2_: given the number of people that do (not) use engines, =
maybe ask for volunteers on the -devel and -users list to give it a quick=
 test?
(21.17.44) mattock: sounds like a good idea
(21.17.50) mattock: in the worst case it does not help
(21.17.53) syzzer: tbh, I still don't understand why on earth someone wou=
ld want to do aes-ni through engines/cryptodev...
(21.18.07) syzzer: but well, I *is* broken...
(21.18.08) m-a: seems reasonable to me; my proposal for the FreeBSD port =
is that I add a ports option for users to apply the patch so they can rep=
ort back. Not sure if it's BSD specific.
(21.18.15) cron2_: syzzer: how is it done elsewhere?
(21.18.30) syzzer: it's just an instruction set extention
(21.18.40) cron2_: so openssl uses it directly?
(21.18.51) syzzer: so you simply execute the instruction, no need for any=
 transitions to kernel mode
(21.18.55) syzzer: yes
(21.19.48) syzzer: cryptodev makes sense for crypto-accelerators which re=
quire god-mode, like stuff that gets access to your entire system through=
 dma, etc.
(21.22.18) cron2_: m-a: let's try asking the users on the two lists, and =
if nobody is there who uses the engines, we'll just patch and ship...  (i=
t will also only fire in --daemon mode, so most client setups won't even =
see that code)
(21.22.33) m-a: ok
(21.22.40) mattock: who will ask?
(21.23.03) cron2_: syzzer: are you on the users list?
(21.23.12) syzzer: cron2_: yes
(21.23.19) ***cron2_ volunteers syzzer  (and runs)
(21.23.26) mattock: +1
(21.23.41) syzzer: ok, will do
(21.24.30) cron2_: thanks.  So, #481 - I know what to do there, I just ne=
ed to see whether it works out (use "route-gateway" as a next-hop here, i=
nstead of "my own ip").
(21.25.34) cron2_: with 4cc6a2595947a0e2f13b we should always *have* a ro=
ute-gateway address - which might not be the "true" server address, but t=
hat does not matter, as long as it's "on the other side"
(21.26.11) m-a: will it work through firewalls and martian address filter=
ing if you pick the wrong one?
(21.26.26) cron2_: yes
(21.27.02) cron2_: we out a subnet route onto the interface anyway, so "a=
ll in the subnet" should be ok with martian (reverse path) filtering
(21.28.04) cron2_: firewalls: the "remote end of ifconfig tun" address "s=
hould" not manifest itself outside openvpn - unless someone configures it=
 from an --up script, and in this case, it's broken today (because in --t=
opology subnet, no peer address exists, that field is overloaded with the=
 netmask)
(21.30.06) ***cron2_ is reasonably confident that it will work out, but, =
well, it needs testing -> my job ("I broke it, I'll get to fix it")
(21.30.39) mattock: cron2_: so this will go into 2.3.7?
(21.30.44) cron2_: anything else in the bug list that needs fixing before=
 2.3.7 but has no milestone?
(21.30.57) cron2_: mattock: this is the plan, the fix is fairly localized=
, and it's a true bug fix
(21.31.01) syzzer: tls version negotiation!
(21.31.16) mattock: yep, forward
(21.31.20) cron2_: mattock: it might turn out to be more difficult, in wh=
ich case "we'll see"
(21.32.14) m-a: #85 has been going for a while and is mostly documentatio=
n
(21.32.41) m-a: mktun in FreeBSD - document that only Linux needs it and =
what the BSDs use instead.
(21.33.24) cron2_: what I wanted to do here was to just print it (use "if=
config tunX create" on this platform)
(21.33.38) m-a: ok
(21.34.16) cron2_: so, yes, no real functionality added, just documentati=
on/help text.
(21.34.24) m-a: similar thing for #370
(21.35.02) cron2_: still waiting for a doc patch, that one...
(21.36.02) m-a: https://community.openvpn.net/openvpn/ticket/367 - just r=
ename the message per comment #2 and move on?
(21.36.03) vpnHelper: Title: #367 (LZO compression initialized message di=
splays based on build, not config) =E2=80=93 OpenVPN Community (at commun=
ity.openvpn.net)
(21.36.28) mattock: I can probably sneak https://community.openvpn.net/op=
envpn/ticket/512 into 2.3.7 too
(21.36.30) vpnHelper: Title: #512 (Man-page contains useless dash escapes=
) =E2=80=93 OpenVPN Community (at community.openvpn.net)
(21.36.36) mattock: while we're at fixing the man-page
(21.37.05) cron2_: m-a: 367 actually puzzled me, because I'm fairly sure =
this is not printed all the time, just when it is used.  Let me test that=
=2E
(21.38.35) m-a: So, the FreeBSD port just got the patch with an "experime=
ntal" port option. Dubbed version 2.3.6_3, differences at https://svnweb.=
freebsd.org/ports?view=3Drevision&revision=3D382705
(21.38.37) vpnHelper: Title: [ports] Revision 382705 (at svnweb.freebsd.o=
rg)
(21.40.26) mattock: that was quick
(21.40.41) cron2_: well, I can confirm that it is *not* printing this if =
not called.  Closing, bogus
(21.40.43) ***dazo is here now
(21.40.57) mattock: hi dazo!
(21.41.16) dazo: sorry ... domestic issues delayed me
(21.44.16) cron2_: #367 done!
(21.44.20) mattock: great!
(21.45.36) cron2_: mattock: #512 sounds good :)
(21.45.42) cron2_: so, what about tls-version-min?
(21.47.21) mattock: syzzer?
(21.47.24) m-a: cron2_: what's the reference?
(21.47.33) m-a: can't see it on the agenda nor the implied ticket list
(21.47.58) syzzer: ah, yes, tls version negotiation
(21.48.04) syzzer: I sent a patch a little while ago
(21.48.20) cron2_: Message-Id: <1426015605-4068-1-git-send-email-steffan@=
karger.me>
(21.48.35) syzzer: I think it is time to re-enable it by default
(21.49.38) syzzer: but, in contrast with the previous time we attempted i=
t, have a mechanism in place to revert to the old behaviour if users enco=
unter issues
(21.50.02) ***cron2_ tends to agree
(21.50.44) syzzer: so, now I need someone to review the code
(21.51.06) m-a: http://sourceforge.net/p/openvpn/mailman/openvpn-devel/th=
read/1426015605-4068-1-git-send-email-steffan%40karger.me/#msg33581243
(21.51.08) vpnHelper: Title: OpenVPN / Mailing Lists (at sourceforge.net)=

(21.52.01) m-a: I don't oversee everything (would have to check off-line)=

(21.52.16) m-a: I have recently written similar code for fetchmail, albei=
t with different user interface and thus semantics.
(21.53.14) m-a: plausibility check, is "if (tls_version_max =3D=3D TLS_VE=
R_1_0)" in the bottom hunk sufficient, or do you also need to check tls_v=
ersion_min (or is that nailed to 1.0 anyhow elsewhere?)
(21.53.47) syzzer: tls-version min is by default nailed to 1.0
(21.53.58) m-a: and seeing the code is changed twice, for client and serv=
ice, it may warrant refactoring.
(21.54.01) dazo: syzzer: so there are openvpn installations who falls int=
o the SSLv23_client_method() group of handshake methods?
(21.54.22) m-a: s/service/server/
(21.54.45) syzzer: m-a: yes, I considered that, but did not do that for t=
his patch on purpose - minimal patches only for 2.3
(21.55.17) m-a: fine
(21.55.18) dazo: oh right ... I saw the last sentence in the commit log .=
=2E. SSLv23_client_method() =3D=3D enable negotiation
(21.55.21) syzzer: dazo: I don't get what you mean, can you explain?
(21.55.43) cron2_: syzzer: the totally logical OpenSSL API got him
(21.55.55) syzzer: ah, good :p
(21.56.01) cron2_: "SSLv23 enables TLS 1.1 and higher, while TLSv1 only d=
oes TLS 1.0"
(21.56.13) dazo: I didn't understand instantly why whe needed SSLv23_{cli=
ent,server}_method()
(21.56.16) m-a: SSLv23 is the only method that negotiates version.
(21.56.29) syzzer: awesome API, right? ;)
(21.56.33) cron2_: totally
(21.56.35) m-a: All other methods (SSLv2, SSLv3, TLSv1, TLSv1_1, TLSv1_2)=
 nail the respective version.
(21.56.58) dazo: right
(21.57.02) dazo: now I see the point :)
(21.57.02) m-a: So basically you use SSLv23_*_method() in the constructor=
, and limit the interval of negotiable versions. You do that by EXCLUDING=
 versions you do not want.
(21.57.39) m-a: The remaining range of versions must then be contiguous.
(21.58.01) m-a: (the latter point isn't in the docs but is what Viktor Du=
chovni of Postfix fame explained to me)
(21.58.14) m-a: JFTR
(21.58.21) dazo: thx!
(22.00.20) syzzer: ok, my workstation is dying on me so this all takes a =
little longer that it should, but tls-version-min defaults to '1.0', and =
we only accept '1.0', '1.1' and '1.2' as valid options currently
(22.00.30) mattock: ok so what prevents version negotiation issues like w=
e had with 2.3.3?
(22.00.39) cron2_: tls-version-max 1.1
(22.00.57) cron2_: that option did not exist back then, plus "if cryptoap=
i is used, max is set to 1.1 automatically"
(22.01.09) mattock: ok, good, I'll mention that in the summary
(22.01.09) syzzer: it doesn't, but when you have issues, you can set --tl=
s-version-max 1.1 or --tls-version-max 1.0
(22.01.10) m-a: is this in the manual page and will it be in the release-=
notes?
(22.01.45) syzzer: where in this case --tls-verion-max 1.0 will revert th=
e behaviour to the *exact* old default behaviour (calling TLSv1_{client,s=
erver}_method() )
(22.03.08) cron2_: this is an interesting point
(22.03.19) syzzer: release notes at least. --tls-version-min is in the ma=
n page, but I'm not sure it makes sense to mention this too
(22.03.19) cron2_: why does our 2.3 man page have --tls-version-max, whil=
e the code does not
(22.03.37) syzzer: the code has --tls-version-max too, right?
(22.03.43) cron2_: yeah
(22.03.44) cron2_: it has
(22.03.45) cron2_: I'm confused
(22.04.11) cron2_: please ignore me while I reboot my memory
(22.04.18) mattock: so what are we turning on in 2.3.7 again? :P
(22.04.44) cron2_: *automatic* negotiation, unless manually disabled
(22.04.48) syzzer: that by default OpenVPN will negotiate TLS versions, w=
hich will result in connections using tls 1.2, instead of tls 1.0 by defa=
ult
(22.05.53) mattock: ok, I think I've seen the light
(22.07.29) mattock: I will mention that we will flip the switch again
(22.07.35) mattock: are we done with this topic?
(22.07.53) cron2_: someone needs to ACK the patch :)
(22.08.01) syzzer: ^^ that
(22.08.52) mattock: any takers?
(22.09.13) m-a: reviewing
(22.10.27) syzzer: m-a: thanks!
(22.11.29) cron2_: mattock: jumping topics in the meantime a bit to the w=
indows service wrapper - I think we should definitely bundle nssm.exe for=
 the time being.  If 2.4 ever sees the light, we'll have to give people a=
n option what to install, as openvpnserv will also be the "Interative Ser=
vice" part, if I understood d12fk right (so they can use nssm for non-int=
eractive, and openvpnserv for iserv)
(22.12.16) cron2_: the main issue with the service as it is seems to be "=
recovery after openvpn crash" or "suspend and resume" - with the iserv, t=
he gui will do all this, so I expect it to "simply work" then
(22.12.37) mattock: cron2: hmm, yes, that might be so
(22.13.06) mattock: I can't recall whether the "Interactive Service" actu=
ally makes use of openvpnserv.exe or not
(22.13.12) cron2_: I would even offer 2.3 based installers with nssm
(22.13.23) cron2_: it does, the patch adds functionality to the openvpnse=
rv.exe sources
(22.13.42) mattock: ok, then nssm.exe would be complementary
(22.13.51) mattock: as well as a better alternative for 2.3.x
(22.14.08) cron2_: maybe offer "old service and old tap" bundles for cons=
ervative users, and "nssm and tap6" for more modern environments, or such=
=2E..
(22.14.16) mattock: I'll do a proof of concept and see how it works
(22.14.34) mattock: I think we can kill tap-windows (NDIS 5) at the momen=
t we drop XP support
(22.14.50) mattock: NDIS 6 driver has been very stable after the last rem=
aining issues were fixed
(22.15.02) mattock: the question then becomes: when is XP dead in our eye=
s?
(22.15.20) mattock: we've decided on 2.4, but what about 2.3.x?
(22.15.27) cron2_: it seems to be in full zombie mode, hard to kill
(22.15.34) cron2_: so we don't...
(22.16.23) mattock: we'll see if it goes away before 2.4 is stable :)
(22.16.30) mattock: at that point it does not really matter
(22.16.31) cron2_: I suggest we support it as long as the pain level is b=
earable - if "things" happens (like, MinGW64 dropping XP support) we reco=
nsider
(22.16.38) mattock: yeah, makes sense
(22.16.57) cron2_: nssm definitely looks non-suckish :)
(22.17.07) m-a: syzzer: you'll need to patch the manual page doc/openvpn.=
8, too
(22.17.24) m-a: I will detail this in a post to the list.
(22.17.55) cron2_: mattock: on the agenda, the TLS version negotiation bi=
t is actually for 2.3.7 only - 2.4 has it already (as had 2.3.3, but we u=
n-enabled it only in 2.3)
(22.18.01) dazo: or that a bug appears which requires too much work to de=
bug and fix on XP ... if fixable present and fixable a more modern Window=
s, then we fix it ... but only trivial fixes for XP-only
(22.18.02) syzzer: m-a: that sounds reasonable :)
(22.18.36) cron2_: dazo: yeah, that's part of "pain level" :)
(22.18.45) dazo: :)
(22.19.56) mattock: cron2_: noted and fixed
(22.20.52) mattock: I take it that a PoC of nssm integration has a genera=
l blessing
(22.21.15) mattock: if something comes up in the PoC then we can reconsid=
er, but otherwise we'll stick with it
(22.21.24) cron2_: haven't seen anyone on the list speak against it... so=
, all for it :)
(22.21.32) mattock: ok, good!
(22.24.08) mattock: next topic?
(22.24.22) cron2_: next topic: regarding MacOS X keychain patch - I went =
back and checked.  Plaisthos ACKed v3 (and James implicitely so, based on=
 "if it will not break Android"), but v4 changed the OpenVPN bits again. =
 So I would actually ask plaisthos to ACK the differences v3->v4
(22.25.11) mattock: the .gitignore issue is now history, right?
(22.25.26) mattock: so if plaisthos ACKs v3->v4 the patch can go in?
(22.25.28) cron2_: yes
(22.25.30) mattock: great!
(22.25.42) cron2_: I will ignore the .gitignore part of the patch, but do=
 not need a new patch for that
(22.26.07) cron2_: so the "Makefile" bit was more a distraction, sorry fo=
r that
(22.27.11) cron2_: remaining topics: iservice (d12fk not here, so hard to=
 agree on the way forward - I have some ideas, but want his OK for that) =
and AEAD.  Syzzer?
(22.27.24) m-a: syzzer: where do I find the version-related bits in the p=
olarssl code?
(22.27.26) cron2_: oh, and openvpn-gui.nsi...
(22.27.38) m-a: syzzer: seems missing.
(22.27.57) mattock: well, openvpn-gui.nsi thing is quick
(22.28.20) syzzer: m-a: polarssl has tls-version-min and tls-version-max,=
 but already does version negotiation by default
(22.28.55) mattock: the work is practically done, the only real issue bei=
ng that the openvpn-gui.exe is unsigned... this is because openvpn-build =
signed openvpn-installer.exe, not openvpn-gui.exe inside it
(22.28.55) m-a: syzzer: so we might bump into issues when a polarssl-base=
d box negotiates against a fixed-TLS-version openssl based box?
(22.29.17) mattock: while the "proper" fix would be to have a separate bu=
ildsystem for openvpn-gui, that would be a major undertaking
(22.29.24) syzzer: m-a: no, the openssl box will just enforce the version=
 it supports
(22.29.29) mattock: so I'm inclined to just hack openvpn-build a bit and =
be done with it
(22.29.35) syzzer: that interop has been tested and used quite extensivel=
y
(22.29.45) ***m-a scratches head and asks, how would the 2.3.3 problem th=
en have showed itself?
(22.30.15) cron2_: mattock: hack openvpn-build and be done with it :)
(22.30.37) cron2_: m-a: talking to 2.3.3, and failing, because in *some* =
setups 1.2 just does not work
(22.30.41) mattock: cron2_: I will take the pragmatic approach this time =
and do as I suggested :D
(22.31.57) cron2_: if used with cryptoapi (which polarssl doesn't support=
) tls 1.2 blows up right away, and someone else also had a failure case b=
ut we never found out why it failed for them
(22.31.57) syzzer: m-a: the 2.3.3 problem occurred when both peers suppor=
ted version negotiation, but some mitm (corporate firewall, China's GFW) =
did not recognize the protocol any more and blocked it
(22.32.16) syzzer: also, it would break when 1.2 was negotiated, but then=
 a smartcard would refuse to sign the (larger) 1.2 hashes
(22.32.45) m-a: OK, the latter are outside our control and only the user =
can sidestep them in a deliberate decision to downgrade.
(22.33.10) syzzer: yes, all problems were out of our control actually, bu=
t we did not have counter measures in place
(22.33.12) syzzer: we do now :)
(22.33.13) cron2_: we work around the cryptoapi issue now ("if cryptoapi =
enabled set version-max 1.1")
(22.33.26) m-a: does polarssl have version pinning that needs to be imple=
mented? The tls-version-max 1.0 workaround would otherwise not work with =
PolarSSL-based builds (or I don't see how)
(22.34.15) m-a: oh sorry, different API
(22.34.31) syzzer: well, I would actually expect setting 'min 1.0' and 'm=
ax 1.0' to result in exactly the same as calling TLSv1_method()
(22.34.40) syzzer: same goes for polarssl
(22.35.04) m-a: I think I've seen SOMETHING in the openssl docs on which =
versions it offers
(22.35.27) syzzer: I kept the call to TLSv1_method() in there just to be =
100% sure we can revert back to the old behaviour
(22.38.20) syzzer: m-a: we are restricting what openssl offers, with the =
--tls-version-min and --tls-version-max
(22.38.27) m-a: I know that.
(22.38.39) m-a: perhaps I'm digging to deep here.
(22.39.07) syzzer: hmm, then I don't get what you're looking for
(22.41.23) mattock: once the TLS version patch is covered, we only have o=
ne topic left: AEAD=20
(22.45.08) syzzer: m-a: can I help you in any way with your quest?
(22.45.29) m-a: syzzer: I am currently writing a proposal for the manual =
page.
(22.45.32) m-a: :-)
(22.46.25) syzzer: okay, I'll just keep quiet than ;)
(22.46.28) syzzer: *e
(22.46.34) cron2_: AEAD in the meantime?
(22.46.59) mattock: m-a: this is entirely off-topic, but this what I was =
referring to earlier:
(22.46.59) mattock: $=C2=A0apt-file -x search ".*/m-a$"
(22.46.59) mattock: module-assistant: /etc/bash_completion.d/m-a
(22.46.59) mattock: module-assistant: /usr/bin/m-a
(22.46.59) dazo: mattock: looking at some old trac tickets .... #421 can =
probably be closed as "wontfix" ?
(22.47.02) mattock: agreed
(22.47.35) cron2_: +1
(22.47.48) mattock: yeah, +1
(22.49.20) ***m-a drowned in scrollback
(22.49.36) cron2_: sorry
(22.50.20) mattock: AEAD?
(22.50.30) mattock: is this for/from syzzer primarily?
(22.50.42) syzzer: yes
(22.50.43) m-a: mattock: I don't get the point of the apt-file -x search
(22.51.01) ***m-a wonders which hats were sneaked on his head without him=
 noticing
(22.51.02) mattock: there's no point expect that there's a tool called "m=
-a" in debian
(22.51.06) cron2_: he found an obscure program called "m-a"
(22.51.12) syzzer: sorry, trying to explain my girlfriend how to explain =
a friend of hers how to scp something to my home server...
(22.51.13) mattock: I've actually used it
(22.51.24) mattock: syzzer: good luck :P
(22.51.38) syzzer: but, AEAD
(22.52.02) syzzer: so, I have a series of patches, which have been intero=
p-tested with james' ovpn3 code
(22.52.22) syzzer: but we need to find a way to get them reviewed
(22.52.33) cron2_: cool
(22.52.49) syzzer: the most recent ones I've sent to the list are the pol=
arssl logging improvement patches
(22.52.58) mattock: syzzer: are all the patches available?
(22.53.40) syzzer: mattock: https://github.com/syzzer/openvpn/tree/aead-c=
ipher-modes8
(22.53.41) vpnHelper: Title: syzzer/openvpn at aead-cipher-modes8 =C2=B7 =
GitHub (at github.com)
(22.54.08) mattock: would it make sense to arrange another meeting and ha=
ve James participate?
(22.54.26) cron2_: most definitely :)
(22.54.36) cron2_: syzzer: how big is the change?
(22.54.58) cron2_: like, "2 files, totally trivial" or "all the crypto mo=
dules fully revamped"
(22.55.12) syzzer: yes, I think James is definitely needed for this
(22.55.23) syzzer: cron2_: no, it introduces a new on-the-wire packet for=
mat
(22.55.40) mattock: most definitely stuff which requires James
(22.55.47) m-a: so, conditional ACK and relevant manual page update propo=
sal (which needs to be ACKed by itself) sent to the openvpn-devel list.
(22.55.54) syzzer: it doesn't change much on the existing code, but it is=
 quite a bit of code
(22.55.56) mattock: m-a: thanks!
(22.56.06) syzzer: m-a: great!
(22.56.15) m-a: nevermind.
(22.56.44) syzzer: m-a: well, as you've noticed, any review efforts are m=
ore than welcome :)
(22.56.53) m-a: my little compensation for getting the FreeBSD tickets mo=
ving :)
(22.57.02) mattock: so when do we arrange the AEAD meeting?
(22.57.13) mattock: next Monday is probably bad due to Easter and all
(22.57.18) mattock: two weeks from now?
(22.57.27) mattock: or non-monday?
(22.57.36) syzzer: next week is bad for me indeed
(22.57.51) m-a: Easter Monday is a public holiday in Germany
(22.57.59) mattock: also here in Finland
(22.58.06) syzzer: but 13/4 works for me
(22.58.16) m-a: I'm out on the AEAD stuff anyhow.
(22.58.44) ***m-a wondering where the manual page update patch got stuck.=

(22.58.47) mattock: any objections to a meeting on 13th Apr?
(22.58.55) cron2_: syzzer: I'm fine to review the packet format, but we n=
eed James
(22.59.03) m-a: I abstain from the vote.
(22.59.04) mattock: m-a: I got the mail
(22.59.04) cron2_: m-a: sourceforge greylisting...
(22.59.09) cron2_: maybe
(22.59.15) cron2_: april 13 is good
(22.59.18) m-a: yeah but the conditional ACK has already made it
(22.59.24) cron2_: weird
(22.59.49) mattock: I received both emails from m-a
(23.00.02) cron2_: ok, need to go and break other stuff now...  *wave*
(23.00.16) m-a: ok, then it's probably delayed in my inbound path section=
=2E Perhaps University spam filters or firewalls.
(23.00.18) mattock: I'll add a tentative topic page for 13th Apr and info=
rm James about it
(23.00.30) cron2_: thanks
(23.00.50) m-a: so final question
(23.01.08) m-a: is there any detailed planning (target date) regarding a =
2.3.7 release?
(23.01.36) m-a: or is it flexible and just based on the trac milestones?
(23.01.41) cron2_: "four weeks ago"... I really don't know, when I find t=
ime to work on these tickets.  But hopefully soon
(23.01.50) cron2_: it is flexible, but I do not want to drag too long
(23.02.02) m-a: fair enough
(23.03.59) m-a: ok, my patch hit the archives, http://sourceforge.net/p/o=
penvpn/mailman/openvpn-devel/thread/1427745294-31041-1-git-send-email-mat=
thias.andree%40gmx.de/#msg33676596
(23.04.00) vpnHelper: Title: OpenVPN / Mailing Lists (at sourceforge.net)=

(23.04.42) mattock: https://community.openvpn.net/openvpn/wiki/Topics-201=
5-04-13
(23.04.43) vpnHelper: Title: Topics-2015-04-13 =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)

--------------010304050907020607000405
Content-Type: application/pgp-keys;
 name="0x198D22A3.asc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="0x198D22A3.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: GnuPG v1

mQGiBEsHuu4RBACnPwEKcLYmlwe8v2e8xizlO1fCeqOA7zj6tU/T/1+YTJhrVbgW
PiRYSNKAmAq0uLFLQ14KpIDsrtdi5ySeUTf64kJtDrBa2si6h0HUyNHf9EX6rUVC
g/CTpsfYEkqlfMoBH7w7L5O2yidwWA+F4RGWhruzP7i1z+bBsIguSxiBzwCg5qPh
pgkFGeWArp/OUBHkaqmPZ00D/08dmkrez9d7C/PoR/cFq0nQBqL3zmsRxv66I6fM
TUqwaRpweWHh9P6XR+pTJjBglVSvk9kLv+PYCvk7yxbT3M6OA/GrSEp/53itlzOU
MPkv/OF6BmbRbYJK5HAsZgHGbuZxUHUqm4qJ+t4+WZaz9i8WtYbOM6T9aNWQrVUW
dUMqA/4tZlHJzCrd1NbfEetQVeso9rzzWWWmDAusbvkowfrFHXJGUjfL0hBmxj/9
JmZtwU+i8G+MKQS0w9rCVLEMLoHLLxPH+Jiknz3Y2xE6CbiSvL+8cvOolgADz/06
MniHKOZb4tPFPw7ObESeAGp4T9FgT53fJ14AMjGLyHv6EXbfvbQsU2FtdWxpIFNl
cHDDpG5lbiA8c2FtdWxpLnNlcHBhbmVuQGdtYWlsLmNvbT6IYAQTEQIAIAUCSwe6
7gIbAwYLCQgHAwIEFQIIAwQWAgMBAh4BAheAAAoJEMKdl+0ZjSKjsfsAoK6khXtq
w2xDtNBv/UhRhuVH0NQOAKCDWiB2zYNvHWLYnuIpAlE1sAnGPrQlU2FtdWxpIFNl
cHDDpG5lbiA8c2FtdWxpQG9wZW52cG4ubmV0PohgBBMRAgAgBQJMQBsAAhsDBgsJ
CAcDAgQVAggDBBYCAwECHgECF4AACgkQwp2X7RmNIqPF2wCdGPyl6OvMw4cEMvua
kJgNA9Ze0owAniPcTDGPT7VXIFHH09JT3KhNG80huQINBEsHuu4QCACPBIR9NYsm
whbmqUo0SHJIiOZGZxWCoH81Npn413+v76y1hJqfWpvuqVDcHfDjynWAHRI9/ApG
YySJiwc1xtGvkogdZOdiswj/k4CM8iLP/aPb3jBGc5vOtskrdP6olIsDaYRdc88r
uLSFTAfXZkl6P+H3yU9AD42IOAM5qrhqzKrilwetHZPY3KKJHb5eL8vYvPXMqPiJ
Dd/mDSS2YAR0ZwO1Xu0jTFl5dYS16xFd5eao+aMuyQmjNShk/UZdcDPzQ/JIrYew
RD/zjqrVhuXkpjBtIf6XyMsjKowNNCcJgb4W3WagKTccvJzhzUAtWi/VG+iby7d0
zm1S2m5kzBwnAAMFB/4wKiGouoYmYR2JMSeaCCyIpKhlMgEmFy6NFounE+kGVfPo
/Zu+WmtR50Gz7PEQQj5D8KoiXJho34pxrUUrhgb2JCgeZv0ghUd/gL+XJZLHXEr4
GciTtIR8yOkYCOh83M1zfg2Z5ueiwd8/+Deu4ujoSC2NDryJS3L0+BdDVtlD9J5e
TXpvw2fTFBr1L6GDksDED4O5K9dsypTmranwmU+AYQVUrNpVzE+GmkEpy//YLGOy
peP/qxbecVLD7wl3hJYvX5w9nW/VYcbdJQwWgsCNKZWPdfyugbkSIuJDFIY5TPy5
W2+6Z8rJ3bkxiaAcwQsvt/GGtlzDY5V2j3vuW3Z8iEkEGBECAAkFAksHuu4CGwwA
CgkQwp2X7RmNIqOCsACgt6WfXtjFJADtFQfBNuq44D3ah0wAoOKrtzynaFSzetlp
djVoyYTHIHSB
=3Dx2Xe
-----END PGP PUBLIC KEY BLOCK-----

--------------010304050907020607000405--

--ovxCwvAId3RPU7dqrTN9C4mEIaquHmS00
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlUZrZwACgkQwp2X7RmNIqMPugCfTz78oJC9iPuvmAKNbaaTRkzB
qLMAoKV9zggY2NZ0iGsI2bi2wNO+KX6X
=R+zB
-----END PGP SIGNATURE-----

--ovxCwvAId3RPU7dqrTN9C4mEIaquHmS00--

