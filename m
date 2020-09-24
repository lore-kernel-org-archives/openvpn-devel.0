From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <b99b879f-d0c1-af75-b2f9-cda3fa5ef526@...515...>
Message-ID: <9fcf98af-9357-2a82-27a4-06c1a851f385@...515...>
Date: Thu, 24 Sep 2020 22:06:26 +0300
MIME-Version: 1.0
In-Reply-To: <b99b879f-d0c1-af75-b2f9-cda3fa5ef526@...515...>
Content-Type: multipart/mixed; boundary="------------1429C3E743D68F3963D411F1"
Content-Language: en-US
Subject: [Openvpn-devel] Summary of the community meeting (24th September
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
--------------1429C3E743D68F3963D411F1
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Thu 24th September 2020
Time: 20:00 CEST (18:00 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2020-09-24>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

becm, cron2, dazo, lev and mattock participated in this meeting.

---

Talked about OpenVPN 2.5. Noted that MSI is getting into a nice shape,
though we have some fixes pending for it. We also have a new
tap-windows6 release in the pipe.

Agreed that we want to do an RC2 release for 2.5, mainly because there
is a fair amount of changes related to Windows.

Set the release date for 2.5-rc2 to "mid next week". This gives mattock
some time to build a new tap-windows6 driver as well as get his other
urgent stuff out of the way.

---

Noted that Trac tickets related to OpenVPN Connect should be assigned to
denys.babets. He will take them from there.

--

Full chatlog attached

--------------1429C3E743D68F3963D411F1
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2020-09-24.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2020-09-24.txt"

(21:00:08) mattock: hello
(21:01:41) dazo: hey!
(21:01:45) dazo ha scelto come argomento: Agenda at https://community.ope=
nvpn.net/openvpn/wiki/Topics-2020-09-24
(21:01:46) lev__: guten nacht
(21:01:59) dazo: lev__: that's when the day starts!
(21:02:20) lev__: then guten abend
(21:02:33) dazo: :-P
(21:03:50) dazo: Btw ... how's the MSI stuff going?
(21:04:12) lev__: I think it is in a good shape
(21:04:41) dazo: Great!
(21:05:19) lev__: there is one issue which could be fixed, though, but I =
wouldn't call it showstopper (support for modify/repair)
(21:05:39) dazo: so that's more a feature than a bug?
(21:05:57) cron2: now!
(21:06:01) mattock: hi
(21:06:25) lev__: both
(21:06:45) mattock: there is also some activity on tap-windows6
(21:06:51) lev__: unprivileged user may break VPN connection of administr=
ator
(21:07:13) lev__: but we have the same problem with Connect
(21:07:22) mattock: btw. 2.0 had 18 release candidates
(21:07:31) mattock: we can do a few before breaking the record
(21:07:35) mattock: https://build.openvpn.net/downloads/releases/
(21:07:37) vpnHelper: Title: Index of /downloads/releases/ (at build.open=
vpn.net)
(21:09:57) cron2: working on it :-)
(21:10:07) cron2: mattock: have you seen that we need a new tap driver?
(21:11:52) mattock: yes, and selva said "wait"
(21:11:57) mattock: did not check later today
(21:13:09) lev__: cron2: what is the thing with new tap driver ?
(21:14:31) cron2: changing the MAC address via control panel was doubly b=
roken
(21:14:43) cron2: .inf file was broken, setting the wrong key - that was =
fixed yesterday
(21:14:54) cron2: driver was using the wrong variable for ARP and ND - th=
at was fixed today
(21:15:04) cron2: so, now things should be fixed for good
(21:16:45) lev__: cool, we should update Connect client as well
(21:19:16) mattock: what about the next rc?
(21:19:19) mattock: what, when?
(21:19:56) cron2: you tell me :-) - it should come with the new tap drive=
r.
(21:20:01) cron2: I can do the RC2 any time
(21:20:29) lev__: I would like to add dhcp-option DOMAIN support for wint=
un
(21:20:31) dazo: Do we need another RC?
(21:20:52) dazo: $ git shortlog v2.5_rc1..release/2.5
(21:20:52) dazo: Simon Rozman via Openvpn-devel (4):
(21:20:52) dazo:       netsh: Specify interfaces by index rather than nam=
e
(21:20:52) dazo:       netsh: Clear existing IPv6 DNS servers before conf=
iguring new ones
(21:20:52) dazo:       netsh: Delete WINS servers on TUN close
(21:20:52) dazo:       openvpnmsica: Simplify find_adapters() to void ret=
urn
(21:21:09) dazo: These are bugfixes ... doesn't look that scary even
(21:21:32) cron2: dazo: not on the unix side, but windows with the new dr=
iver and "netsh config fixes" might need another round of testing
(21:21:53) cron2: also, we are aiming to beat 2.1, which made 2.1_rc22 (n=
ot to forget having an rc21b!)
(21:22:07) dazo: hahahaha .... oh dear!
(21:22:09) mattock: 2.0 actually
(21:22:16) mattock: 2.1.4 was the last 2.1
(21:22:18) dazo: no, 2.1_rc22 was a thing
(21:22:31) cron2: mattock: release candidates come before 2.1.0 :-)
(21:22:33) dazo: 2.1.4 was the last release
(21:22:50) cron2: commit 1852709cd5093995f97ba4860d1a6083c6df6d6c (tag: v=
2.1_rc22)
(21:23:10) cron2: anyway
(21:23:13) mattock: yes of course, but 2.0-rc18 was the biggest achieveme=
nt in RCs so far
(21:23:23) mattock: but yeah
(21:23:30) mattock: I propose "mid next week" for rc2
(21:23:31) cron2: mattock: uh - no?  2.1_rc22 is more than 2.0_rc18?
(21:23:35) dazo: mattock: you're awake?  22 comes after 18 ;-)
(21:23:44) mattock: where do you guys see 2.1_Rc22?
(21:23:49) mattock: not on build.openvpn.net?
(21:23:55) dazo:  git tag -l | grep v2.1_rc
(21:23:58) mattock: ok
(21:24:00) cron2: in the commit quoted above
(21:24:03) mattock: I withdraw my objections
(21:24:10) mattock: that's pretty incredible
(21:24:13) cron2: not sure what release had the most versions actually bu=
ilt and published :-)
(21:24:45) cron2: anyway, mid next week, it is
(21:24:47) mattock: anyhow, mid next week because tap-windows6 will consu=
me half-a-day plus I just received "urgent" things for tomorrow
(21:25:04) cron2: there is the time fix v3, plus another simon msica fix =
that is under discussion
(21:27:00) cron2: plaisthos is fighting some convoluted stuff which is mo=
re likely to end up in 2.5.1
(21:27:41) cron2: dazo: the 2.0 releases are not tagged in git
(21:28:26) cron2: 2.2 was amazingly short-lived, only up to 2.2.3
(21:28:29) dazo: cron2: that's right ... because our git history starts a=
t the BETA21 SVN branch .... the 2.0 and prior releases are probably in t=
he historical-cvs git repo
(21:28:48) cron2: you have that old stuff?  cool
(21:28:48) dazo: we dragged our feets with 2.4 :-P
(21:29:00) cron2: v2.3.18
(21:29:01) dazo: that history is not as fine-grained as the 2.1 history
(21:29:06) cron2: v2.4.9
(21:29:09) cron2: yeah, indeed :)
(21:29:22) dazo: https://github.com/OpenVPN/openvpn2-historical-cvs
(21:29:24) vpnHelper: Title: GitHub - OpenVPN/openvpn2-historical-cvs: Ju=
st a read-only repository containing the historical OpenVPN 2.0 releases,=
 pulled out of the now non-existing CVS repository. Each commit is essent=
ially a new version, so not a fine grained overview, but gives an impress=
ion of the development process. (at github.com)
(21:29:41) cron2: nice
(21:29:43) mattock: if keep on halving the last number we'll soon move to=
 the Google Chrome versioning scheme
(21:30:03) cron2: let's just make the next community release real good, a=
nd make it "v4"
(21:30:10) mattock: \o/
(21:30:12) cron2: so it's clear "it's more advanced than 3!"
(21:30:18) mattock: yeah!
(21:30:21) dazo: hahahaha
(21:30:56) dazo: v4 should be an openvpn re-write in Rust :-P
(21:31:53) cron2: so... anything else on 2.5 or tap?
(21:31:59) mattock: not from my end
(21:32:40) cron2: there's an ongoing discussion about the lack of DNS dom=
ain setting in wintun, but I'm not sure if it will lead to an actual patc=
h
(21:32:50) cron2: (for 2.5.0, that is)
(21:33:05) becm: tap0901.sys-removal on uninstall
(21:33:09) ***becm duck
(21:33:21) cron2: becm: what does that mean, for "not the windows guy" pe=
ople?
(21:33:26) lev__: I can send the patch tomorrow, the code is fairly small=
 (and has been in openvpn for 6 years)
(21:33:40) lev__: *openvpn3
(21:35:24) lev__: after uninstalling client, driver still presents in sys=
tem, to actually remove it one needs to use pnputil
(21:35:47) cron2: is that with msi and msm packaging?
(21:35:49) cron2: or nsis?
(21:36:14) lev__: all of them
(21:37:41) lev__: I don't know if this is a bug or feature
(21:38:25) mattock: you're speaking of the drivers in the DriverStore rem=
aining behind?
(21:38:28) becm: since the install/unistall is (nearly) identical to wint=
un, I'd opt for bug.
(21:39:04) becm: that one gets removed just fine.
(21:39:41) mattock: ok
(21:40:03) cron2: that would have been my next question :)
(21:40:36) becm: it's not realy (regular) user-visible and negligable on =
a 16GiB Windows-Installation. :)
(21:40:57) lev__: IIRC wintun has some sort of reference counting, where =
each user (like wireguard/openvpn) increments it by one, and when it decr=
eases to zero driver gets removed
(21:42:11) mattock: that does ring a bell
(21:42:41) cron2: I've heard this mention as a generic plus for "MSM", so=
 I expected this (without knowing anything) to be "automatic"
(21:43:02) cron2: do we delete tap interfaces on deinstall?
(21:43:14) lev__: OTOH this bug has a nasty consequence - if you happen t=
o install a driver with a wrong signature, upgrade will not resolve it si=
nce windows would assume that driver already presents. We had this issue =
on Johan's laptop during last hackathon
(21:44:08) lev__: we do delete interfaces
(21:45:06) cron2: THat should be good enough then... but, I have no idea =
what MSM and MSI really do
(21:46:34) lev__: becm: would you mind to create an issue to tap-windows6=
 about this (driver doesn't get deleted)
(21:47:58) becm: lev__: can we rule out the double-registration (root\tap=
0901, tap0901) as the reason?
(21:49:19) lev__: we could, but maybe not right now :)
(21:50:18) lev__: mattock: do you have download numbers for 2.5 beta4/rc1=
 ?
(21:50:27) mattock: unfortunately no
(21:50:30) mattock: well
(21:50:32) mattock: possibly
(21:50:41) mattock: if I remembered where I need to login to get them
(21:50:43) mattock: :D
(21:51:00) mattock: I'll try something
(21:51:23) dazo: Anything else?
(21:52:17) cron2: not from me
(21:52:32) mattock: no luck
(21:52:40) mattock: nothing from me
(21:53:10) dazo: One FYI on Trac tickets related to OpenVPN Inc products =
=2E... A new user should be signed up here now, denys.babets, who will be=
 the ticket owner for the Connect and non-OSS related things
(21:53:59) dazo: So anything Connect, Access Server or OpenVPN Cloud rela=
ted can be reassigned to Denys
(21:54:08) cron2: *thumbsup*
(21:54:11) mattock: do we want to keep those tickets in Trac?
(21:54:26) mattock: or just assigned them so that Denys can close them an=
d move them to a more proper place?
(21:54:37) dazo: He will follow-up on these tickets, sort out what can be=
 sorted out in Trac and otherwise redirect to more appropriate places
(21:54:43) mattock: ok
(21:54:44) cron2: I have no opinion, but they need to be handled one way =
or the other
(21:54:46) mattock: sounds good
(21:54:48) cron2: yes
(21:55:02) dazo: (would be silly to redirect to to our support platform j=
ust to say: You need a new config from your service provider)
(21:56:28) mattock: ok, I'll write summary now
(21:56:44) mattock: I propose "good night all"
(21:58:02) dazo: g'night!
(21:58:08) cron2: yeah.  good night :)

--------------1429C3E743D68F3963D411F1
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

--------------1429C3E743D68F3963D411F1--

