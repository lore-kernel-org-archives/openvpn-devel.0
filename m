From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <b99b879f-d0c1-af75-b2f9-cda3fa5ef526@...515...>
Message-ID: <f363aeaf-15b4-038b-12b3-656ab3f1e3fc@...515...>
Date: Wed, 16 Sep 2020 14:14:03 +0300
MIME-Version: 1.0
In-Reply-To: <b99b879f-d0c1-af75-b2f9-cda3fa5ef526@...515...>
Content-Type: multipart/mixed; boundary="------------DEBED817B72B72099FD00DCC"
Content-Language: en-US
Subject: [Openvpn-devel] Summary of the community meeting (16th September
 2020)
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
--------------DEBED817B72B72099FD00DCC
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Wed 16th September 2020
Time: 11:30 CEST (9:30 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2020-09-16>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, dazo, lev and mattock participated in this meeting.

---

Went through patches in Patchwork and tickets in Trac and assigned them
to people and milestones.

--

Agreed that the next release should be OpenVPN 2.5-rc1. Beta4 has been
really stable as far as we can see.

It was also agreed that EasyRSA 3 should go into rc1. This will require
some documentation fixes at the EasyRSA 3 side and hopefully only minor
changes to the MSI installer code. The rc1 install will not include
EasyRSA 2.

Noted that OpenVPN 3 support in OpenVPN GUI can't make it to 2.5-rc1,
but it can also be introduced later in a Windows installer release

Noted that the Debian 10 packaging fix should go into 2.5-rc1:

<https://community.openvpn.net/openvpn/ticket/1326>

Set the release date for OpenVPN 2.5-rc1 to Monday 21st September 2020.

--=20

Full chatlog attached

--------------DEBED817B72B72099FD00DCC
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2020-09-16.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2020-09-16.txt"

(12:31:47) cron2: meeting time!
(12:31:55) lev__: yes
(12:34:54) dazo: Hey!
(12:39:22) cron2: mattock around?
(12:39:39) ***dazo pings him internally
(12:43:06) dazo: so should we just start somehow and while we wait for mo=
re people to arrive?
(12:43:34) cron2: yeah
(12:43:57) cron2: I have put stuff on the agenda
(12:44:16) dazo ha scelto come argomento: Agenda at https://community.ope=
nvpn.net/openvpn/wiki/Topics-2020-09-16
(12:44:21) cron2: right :)
(12:45:34) cron2: so.  I have a few patches in trac that are relevant for=
 2.5, and of course I'd love to see an ACK :-) - but none of these are cr=
ucial for 2.5.0
(12:46:15) cron2: I intended to merge the plugin build patch from dazo to=
day ("it looks good"), but got distracted by a power outage... so it will=
 take me some time to get my infra back up.
(12:46:27) cron2: "patches in patchwork", that is
(12:46:47) dazo: Could we just list the patchwork IDs here ... so we can =
quickly see what we can manage this week?
(12:47:33) cron2: #1454 (dazo v3), #1446 (FreeBSD/tap+subnet), #1441 (cli=
ent-connect plugin), #1439 (ipv6 pool +1)
(12:48:16) cron2: #1446+#1439 are easy for ordex
(12:48:29) dazo: I can follow up with ordex on those two
(12:48:35) cron2: #1441 is easy for dazo (v4 coming, as soon as #1454 is =
merged)
(12:48:50) dazo: perfect, that's a simple one then
(12:49:06) dazo: As soon as v4 hits pw/ml, I'll dive into it
(12:49:06) cron2: #1454 is easy for me (as soon as I have power... the op=
envpn infra is on "real" computers, not on the laptops)
(12:49:20) dazo: fair enough
(12:50:19) cron2: then we have a number of bugs in trac tagged as "milest=
one: release/2.5"
(12:50:22) cron2: https://community.openvpn.net/openvpn/report/3?asc=3D1&=
page=3D2
(12:50:26) cron2: (scroll down)
(12:51:36) cron2: some have patches in trac already, some will most certa=
inly not make it ("feature wish" style), but we need to go through them a=
nd see "which category is it?  fix for 2.5, close because already fixed, =
bump to 2.6"
(12:52:43) dazo: isn't there a patch on the ML already for ticket #1085?
(12:53:16) cron2: yes, #1446
(12:53:23) cron2: review, merge, close :)
(12:53:36) dazo: okay, so that's fine
(12:53:45) dazo: #399 can probably be closed
(12:53:49) cron2: (or actually, in that case, review, merge, document, an=
d upgrade to "release 2.6" for a proper rewrite)
(12:54:39) cron2: yeah
(12:55:13) dazo: #439 ... I think that one can be moved to a 2.5.1 target=
 ... test using a script deemed to fail, if this is no longer an issue, c=
lose it
(12:55:51) cron2: yeah
(12:55:55) dazo: #538 is kinda out of our hands, it requires an updated p=
kcs11-helper lib
(12:56:32) dazo: I'd say it can be closed, we can't do much more about it=
 from our end
(12:57:01) cron2: can we push other maintainers?
(12:57:24) dazo: you mean alonbl?
(12:57:45) cron2: no, the package maintainers on RH
(12:58:10) cron2: umm
(12:58:30) cron2: I'm confused.  This talks about Debian and CentOS.
(12:59:08) cron2: if I understand this right, "our side" is fixed.  Your =
last comment is "CentOS 6 and 7".  So maybe talk to the pkcs11-helper mai=
ntainers there to get it patched?
(13:00:09) dazo: In this case, pkcs11-helper comes from the Fedora EPEL r=
epo, which CentOS can use .... but the policy is to not upgrade package v=
ersions mid-releases ... and for some reason, it seems the package mainta=
iner has settled with version 1.22, even on latest Fedora releases ...
(13:00:24) cron2: maybe backport the bugfix?
(13:00:30) cron2: or is it bigger?
(13:00:38) dazo: I fear it might be too big, but I'll investigate
(13:01:05) cron2: (definitely not "2.5", though... maybe just remove the =
milestone as not coupled to a particular openvpn release at all)
(13:01:23) dazo: Yeah, makes sense
(13:01:37) dazo: dwmw2 is the package maintainer, and he is really reason=
able ... so when he has not moved forward, it usually got a reason
(13:01:56) cron2: yeah
(13:02:28) cron2: #552 has been pushed to 2.6
(13:02:41) cron2: #554 is crypto, I have no idea, but it sounds "2.6"ish
(13:03:11) dazo: agreed, I'll see if we can challenge plaisthos to have a=
 look at that one
(13:05:28) dazo: Is #1147 still an issue?
(13:05:34) dazo: " token authentication issues "
(13:06:57) cron2: looking at #936 right now
(13:07:01) dazo: I'd say #1229 is 2.6
(13:08:53) dazo: I can probably whack together a quick patch for --nobind=
 being set if --client is used without --lport
(13:09:20) dazo: but, I think that's more a 2.5.1 task, than 2.5.0
(13:09:31) cron2: I don't really want to do that "this late in the cycle"=
, and it's not crucially important.  I take this (#936) and bump to 2.6
(13:09:44) dazo: alright
(13:10:07) dazo: yeah, I agree ... it's not a critical 2.5.0 task
(13:10:32) cron2: #1229 is actually something for 2.5 or 2.5.1 - that is =
"make the windows installer more robust"
(13:10:45) dazo: (and the current behaviour should be "well known" for th=
ose reading docs or got experience with OpenVPN)
(13:10:53) cron2: but it can be "2.5.1" or "2.5.0-I602" or whatever... ma=
ttock needs to say something about it
(13:11:29) cron2: #1147 is still "somewhat an issue".  Maybe not this par=
ticular ticket, but the larger field of work
(13:11:43) cron2: we know that NM on the client side interferes with toke=
ns
(13:12:00) dazo: hmmm
(13:12:00) cron2: and we know that async authentication on the server sid=
e interferes with tokens
(13:12:21) cron2: so I'd leave that particular ticket as reminder "plaist=
hos and I need to get work done"
(13:12:41) dazo: alright, so possibly 2.5.1?
(13:13:40) dazo: #1232 got a wrong "Milestone" ... that's an OpenVPN Conn=
ect issue
(13:13:41) cron2: which actually brings up the question of "what do we wa=
nt to tag and release next, _beta5 or _rc1, with full code freeze"
(13:14:21) cron2: #1305 is also more "no milestone"
(13:15:15) mattock: damn, meeting
(13:15:19) mattock: yes I am here finally
(13:15:21) cron2: hah
(13:15:49) dazo: Since the current changes since beta has been really min=
or changes, and what we have in the pipe is also minor stuff ... I'd say =
the next release should be rc1
(13:16:35) dazo: since beta4*
(13:17:55) cron2: I agree
(13:18:02) cron2: mattock, lev__: what do you think?
(13:19:47) mattock: I think rc1 is reasonable
(13:19:52) dazo: #1326 ... I'd call this a known issue, related to usage =
of the deprecated openvpn@*.service unit file .... should really migrate =
over to openvpn-client@*.service or openvpn-server@*.service
(13:20:01) mattock: MSI-vise things look quite stable
(13:20:20) lev__: I am fine with rc1
(13:20:46) cron2: dazo: is this an issue with our package or with the way=
 people do things?  Can you comment this "for dummies" in the ticket?  I =
have no clue, I'm just relaying back and forth
(13:21:19) lev__: Havent=E2=80=99 heard new complains about Windows clien=
t since beta4
(13:22:06) cron2: I like that :)
(13:22:13) cron2: *when* do you want rc1?
(13:22:42) dazo: cron2: it's a Debian packaging specific issue ... where =
they added lots of workaround code when moving from sys-v/rc.d style to s=
ystemd unit files ... and it has lots of corner cases which appears every=
 now and then
(13:22:54) cron2: dazo: but this is our debian package, not "theirs"
(13:23:23) dazo: yes, but it is still part of this horrendous "move from =
rc.d to systemd hacks"
(13:23:48) mattock: oh there is the debian 10 packaging fix which "seems =
easy to fix" given all the upstream bug reports / fixes
(13:23:56) mattock: that's something for 2.5-rc1
(13:23:57) dazo: this is why I ended up with openvpn-{client,server}@.ser=
vice unit files ... because some distros would otherwise not ship more sa=
ner unit files and skip this nonsense
(13:25:50) cron2: lev__: #783 just reappeared on my radar :)
(13:27:25) mattock: lev: btw. what about OpenVPN 3 support in OpenVPN GUI=
? That PR has been lying there for a long while
(13:27:36) dazo: I would see #783 in context of #1186
(13:27:40) mattock: possible to get it into 2.5-rc1?
(13:28:17) cron2: I do not think that this qualifies as "minor bug fixes"=
 for beta4->rc1
(13:28:19) dazo: mattock: that could also be added into another -I6xx rel=
ease only, not tied to OpenVPN 2.x release
(13:28:35) lev__: No, that would require some work
(13:28:39) cron2: dazo: as well.  If you happen to reach ordex... :-)
(13:29:10) dazo: cron2: is #783 a blocker for now?
(13:29:19) lev__: I can have a look at 783, or dazo
(13:29:50) cron2: dazo: nah, that's just something trivial (and not rally=
 important) where lev stated 10 months ago that "surprisingly this is sti=
ll open" and then "nothing" :)
(13:31:19) dazo: I can dive into #1186 ... and carry #783 along side
(13:31:24) cron2: *like*
(13:31:34) cron2: anyway - rc1 tomorrow?  friday?  next week?
(13:31:54) mattock: I suggest Monday next week
(13:32:09) dazo: so, lets say tomorrow ... so we'll manage Monday! :-P
(13:32:39) cron2: well, the tag+push is quickly done :) but if mattock ha=
s no time tomorrow it's a bit silly to leave the tag around for 3 days
(13:32:45) mattock: the openvpn3 support in openvpn-gui can definitely co=
me in an installer release
(13:33:03) cron2: I701 :)
(13:33:20) mattock: I have other quite urgent stuff for this week so Mond=
ay would be better
(13:33:21) cron2: whatever
(13:33:26) cron2: ok, monday it is
(13:33:33) dazo: cron2: should we also pull in an updated lz4?
(13:33:53) cron2: dazo: worth a check to see if there is anything relevan=
t new
(13:34:13) dazo: https://github.com/lz4/lz4 ... latest is 1.9.2, we have =
1.7.4 (iirc)
(13:34:14) vpnHelper: Title: GitHub - lz4/lz4: Extremely Fast Compression=
 algorithm (at github.com)
(13:34:31) dazo: 1.7.5 it seems
(13:35:42) cron2: yeah, sounds like it
(13:35:47) cron2: bugfix release with fuzzing bugs found
(13:36:00) dazo: https://termbin.com/stv2/ ... that's the shortlog diff
(13:36:07) cron2: https://github.com/lz4/lz4/releases
(13:36:09) vpnHelper: Title: Releases =C2=B7 lz4/lz4 =C2=B7 GitHub (at gi=
thub.com)
(13:36:32) mattock: uh, I fear a new tap-windows6 release: https://github=
=2Ecom/OpenVPN/tap-windows6/pull/124
(13:36:33) vpnHelper: Title: MSM: Save last error code before overridden =
by PrintError() by rozmansi =C2=B7 Pull Request #124 =C2=B7 OpenVPN/tap-w=
indows6 =C2=B7 GitHub (at github.com)
(13:36:33) mattock: :)
(13:36:34) dazo: anyhow, to big a move for 2.5.0
(13:36:39) mattock: the fewer the better :)
(13:38:03) dazo: mattock: that tap-windows6 patch does look like somethin=
g we want
(13:38:29) dazo: but it's a minor bugfix, so can come in 2.5.1 or a Windo=
ws installer update
(13:39:27) mattock: if possible with some other tap-windows6 fixes as the=
 signing process is quite cumbersome
(13:39:47) mattock: not something I'd like to do for minor changes
(13:43:04) cron2: re (had *two* phone calls at the same time...)(
(13:43:33) dazo: mattock: that tap-windows6 change was so trivial even I =
could dare to approve it ... which I did on GitHub
(13:43:41) mattock: ok
(13:44:01) dazo: do tap-windows6 use ML for ACKs?
(13:44:12) cron2: no, GH review only
(13:44:38) cron2: dazo was just promoted to master windows driver develop=
er!
(13:45:44) dazo: hahahaha ... oh dear .... :-P
(13:45:49) cron2: openvpn-build and tap-windows6 "live on github" and do =
PRs, issues and "rebase and merge"-click style
(13:45:51) dazo: expect Windows explosions!
(13:45:59) mattock: I feel dazo should build and sign tap-windows6 MSM's =
from now on!
(13:46:00) mattock: :P
(13:46:30) dazo: mattock: sure, ship me a Windows infected computer and g=
ive me 12 months to learn how to use it with the required signing tools :=
-P
(13:46:56) cron2: you have 4 days to rc1 release, and windows DVDs can be=
 downloaded these days :)
(13:47:20) cron2: (but I think the actual building and signing of that st=
uff is done on Ubuntu...?)
(13:47:54) cron2: ah, there is another topic, if I may keep you away from=
 food a bit longer...
(13:47:59) cron2: "upgrade easy-rsa"
(13:48:18) mattock: cron2: you mean "move from easy-rsa 2 to easy-rsa 3"?=

(13:48:23) cron2: yes
(13:48:36) dazo: I think that's a reasonable request for 2.5
(13:48:54) cron2: I think ecrist suggested that, and said wiscii has done=
 a very good job in the upgrade scripts
(13:49:11) dazo: That's what I recall as well
(13:49:15) mattock: somebody needs to learn how to modify the MSI install=
er with Wix toolkit
(13:49:20) mattock: I have no clue how it works
(13:50:00) mattock: lev: any experience with WiX?
(13:50:09) lev__: A little bit
(13:50:19) mattock: mine is limited to cscript build.wsf msi
(13:50:20) lev__: It is dreadful
(13:50:55) mattock: I wonder if we could outsource that as well to ecrist=
/wiscii
(13:51:39) lev__: Do we just need to update shipped easyrsa ?
(13:51:45) mattock: hmm
(13:51:46) mattock: well
(13:51:47) mattock: possibly
(13:51:57) cron2: I have no idea
(13:52:00) mattock: if it is just about bundling different files then the=
 change could be trivial
(13:52:21) mattock: I suppose it might be
(13:52:45) cron2: now *this* is something we can ask ecrist and wiscii, h=
ow to do the 2->3 upgrade
(13:53:01) cron2: "only ship new + README", "ship both" "ship something, =
and run a script", ...
(13:53:08) lev__: I can possibly do wix part
(13:53:19) mattock: I would "ship new"
(13:53:22) mattock: not "both"
(13:53:28) dazo: agreed
(13:53:33) lev__: But not sure about upgrade path for users
(13:53:39) dazo: only new + docs how to upgrade
(13:54:01) dazo: https://github.com/OpenVPN/easy-rsa/blob/master/doc/Easy=
RSA-Upgrade-Notes.md
(13:54:02) vpnHelper: Title: easy-rsa/EasyRSA-Upgrade-Notes.md at master =
=C2=B7 OpenVPN/easy-rsa =C2=B7 GitHub (at github.com)
(13:55:31) mattock: +1
(13:56:24) dazo: it's lacking some more docs on the 'easy-rsa upgrade' mo=
de
(13:58:26) mattock: ok so make easy-rsa3 a goal for 2.5-rc1, or 2.5.0?
(14:01:23) cron2: it would be good to give people a chance to actually te=
st that, so "one of the RCs"
(14:02:21) mattock: +1
(14:02:42) mattock: so some documentation changes + integration into WiX/=
MSI
(14:03:10) mattock: dazo: can you create a ticket to easy-rsa about the d=
ocumentation changes?
(14:03:20) dazo: Sure
(14:03:28) mattock: thanks!
(14:03:46) mattock: with the deadline of "soon, before end of this week" =
:)
(14:04:49) mattock: end of meeting?
(14:05:02) cron2: yes
(14:05:10) mattock: lev kind of promised to look at the WiX part :)
(14:05:22) mattock: I'll write the summary
(14:08:11) dazo: thx!

--------------DEBED817B72B72099FD00DCC
Content-Type: application/pgp-keys;
 name="pEpkey.asc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="pEpkey.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----

mQENBF9XbKwBCADAEsX9sF+0PauqVCIX5SzteYzz2/awfjio7R4A7yGOkCPyFZui
ryItvJ9Oh21Woq2DW41JNZ16BR+3gJnWZ2wjKrYORXkk6Cq2mGfs1VHkikOXGeKh
G0kmNgewOB2xrbk27VvhALeUBRlbHF5w1XqGekm1tB/a8OThiyLA/jCzTf8LGSCq
rZoeg/DSvUNoOIuz/VzKvPRBNrvBgGfoR4qMmg5m6OaneaPckCuT58eNDMOGW3SD
f1wk31xBaqHNV2VMAyFuioxl3oyWdjp0dwdvgop+/l/8TJ/gUWqfQ8k5sik40Vlr
LrTwlR5+2/zOutJIy2N4T3xvz/4W6AthWe5BABEBAAG0JVNhbXVsaSBTZXBww6Ru
ZW4gPHNhbXVsaUBvcGVudnBuLm5ldD6JAVQEEwEIAD4WIQTUwk9SkPxedAa+noMq
Bow1gbDSfQUCX1dsrQIbAwUJAeEzgAULCQgHAgYVCgkICwIEFgIDAQIeAQIXgAAK
CRAqBow1gbDSfU62CACJBr2t6bor5THu7nx6NMTV2ubtsUYyHiLD4FeMXgRDSMhV
1GPJwSVF7qg1yNShlqco04Hykp/hDP83CG6ivZC21QACcVaUnRfACDETBGZ5ciUi
gLwjknDR9sQ9azOoqPp+bNBrlLWiQdYw7nyuNUYYGXQkv2stj7Rb11fR8IkWhIky
2VK8n5ppd3Al1nTNWxZkrTBgCO/JYXSWaZXFydwOPQxlzIBBeUoM3yoVxCP7qypu
ZbVQrDSX9L4LAFIBtgWaEBc2a2ocdlrwcQTovC8CWbg/b+0cG0FUsCuRhH4hsZOI
UiOwGGku2uLH5+JNKNDYgNmWgBZhV6wl59X4iZqguQENBF9XbKwBCADuoJFZ4PwJ
aCXWadIuuhy7pn+Gu7og85UGbb0xuI2mPtzR83V2qur/LeY8OnQSMSyy5n3ZBim5
noTe7la+9v/sYX+CC9Zj9KXXkTYiwDWtg+Pvwwjooee/ea336/kYaQSn1L2KHOJW
SgkQlfvM5FIvekQRvJ7scHn0o1tXKCtKVAOP9XIZdl2Dp+QGtKRAwJRFUiyd5oMq
7vY2x0YJoRS9Looq/+iqYNM+9zU0CjRNSXzfnKxBzSOVLtYBDFsud2LCt0bE5Gky
RFBq6cbJUt6aQInzzxVPW7kzEGKHi25AeCZ5UkX07eIGLwNO7PAX7A6YmsbF4Xbd
21sZEbb6EBVtABEBAAGJATwEGAEIACYWIQTUwk9SkPxedAa+noMqBow1gbDSfQUC
X1dsrAIbDAUJAeEzgAAKCRAqBow1gbDSfQe7CACZ6GI+rgKsIuXzhbyafZALyk55
d7I/6iFYNhCYUrVSOT187fhu1F/NTMCvcgQiOly+vvi9Xnw1JJTHVRSAmSMtCz/i
pM8mwU9HHQpHaN6adLdPsfhqsQM3/rGpQ6eGaNimfiQygA1YESvQIUC/edYw3ItF
4LOGu0Eyl5fbXV17ei21BzYiSrqtoBVfS0/G6p9fhP6j8w6OmpIc+ugSY/JmHNMb
NAjg6BR4Uuib/XeMIhtm57UmZqtJzBN0K61exQ2dJTvVdQ4X7wIqB73q3oNLJqJ1
kCZgoaLwFQhBMvRgh8zmk3Xm45RrmJAuPtgT4lzD1QcH0HZLkQFeI5QuHNC8
=3DqMWb
-----END PGP PUBLIC KEY BLOCK-----

--------------DEBED817B72B72099FD00DCC--

