From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <0118782c-d5eb-485d-eee6-73dfa7e6399b@...515...>
Message-ID: <92448668-2ca8-d2b0-e86a-368105a35687@...515...>
Date: Thu, 19 Dec 2019 22:23:33 +0200
MIME-Version: 1.0
In-Reply-To: <0118782c-d5eb-485d-eee6-73dfa7e6399b@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="175Os2vyEKL3T2i3vsljSIs9F1pBkXgVN"
Subject: [Openvpn-devel] Summary of the community meeting (19th December
 2019)
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
--175Os2vyEKL3T2i3vsljSIs9F1pBkXgVN
Content-Type: multipart/mixed; boundary="5EtWT9kU3WeZObrIXVXTrVG8tHcR0ZY1E"

--5EtWT9kU3WeZObrIXVXTrVG8tHcR0ZY1E
Content-Type: multipart/mixed;
 boundary="------------F65729C1E80C73C06EC0F076"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------F65729C1E80C73C06EC0F076
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Thurday 19th December 2019
Time: 20:00 CET (19:00 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2019-12-19>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, lev, mattock and rozmansi participated in this meeting.

---

Discussed the status of wintun patches. The original patches have been
merged, with some improvements like support for multiple tunnels. What
remains is refactoring and improvements.

The OpenVPN 2.5 MSI installer code needs to be updated to include wintun
support. Rozmansi is working on it.

--

Discussed moving from netsh to ipapi on Windows. And, by default, using
ipapi via iService. While netsh is easier to debug, using ipapi is much
faster, which has a big effect with a large number of routes. Also noted
that netsh set/add can use "validate=3Dno" to speed up DNS provisioning.

--

Agreed that in the short term having a thin command-line launcher that
allows running OpenVPN with iService from the command-line. The iService
is required to use Wintun with OpenVPN.

--

Noted that IPv6 on forums was still unreachable. Cron2 and mattock
debugged and fixed this during the meeting.

--

Full chatlog attached


--------------F65729C1E80C73C06EC0F076
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2019-12-19.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2019-12-19.txt"

(20:54:28) mattock: almost time
(20:55:23) rozmansi [sid334387@...2315.../web/irccloud.com/x-wjeamthsozplmfw=
u] =C3=A8 entrato nella stanza.
(20:55:35) rozmansi: hi
(20:58:24) mattock: hi!
(20:58:33) lev__: hello
(20:58:57) mattock: selvanair said he won't make it, but promised to chec=
k the chatlog
(20:59:04) mattock: cron2 said he'd be a bit late
(20:59:19) mattock: maybe we can start with wintun, if there is anything =
left to be discussed there :)
(21:00:43) lev__: original wintun patch series is merged
(21:00:59) lev__: next we have refactorings and improvements
(21:01:08) rozmansi: exactly
(21:01:17) lev__: some are acked, some are sent but not acked, some are n=
ot yet sent
(21:01:29) rozmansi: nothing drastical. just bits and odds (I suppose)
(21:01:46) lev__: IMO the most important is support of multiple tunnels
(21:01:58) lev__: functionality-wise
(21:02:02) rozmansi: oh, I can ack one right now. Tested it on my hardwar=
e today before I left for home...
(21:02:44) lev__: that's your patch :)=20
(21:02:58) mattock: btw. "official" topic list is here: https://community=
=2Eopenvpn.net/openvpn/wiki/Topics-2019-12-19
(21:03:00) vpnHelper: Title: Topics-2019-12-19 =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)
(21:03:04) lev__: the one with --dev-node support
(21:03:20) cron2: eww
(21:03:21) cron2: I'm here
(21:04:45) rozmansi: hi
(21:05:06) lev__: about installer - so far wintun support is in patch to =
openvpn-build, but that's NSIS installer=20
(21:05:20) mattock: hi cron2!
(21:05:21) lev__: is it so that we plan to use MSI for 2,5
(21:05:27) mattock: yes
(21:05:29) lev__: guten aben
(21:05:33) rozmansi: lev__: yes
(21:06:09) lev__: so maybe we need wintun support there, too
(21:06:45) rozmansi: I have a PR to add MSI packaging on openvpn-build op=
en a loong time now. But it's dusty and a lot of things changed in the me=
anwhile. I plan to get it in shape for 2.5
(21:07:41) rozmansi: That PR dates long before Wintun was created. So it =
has TAP-Windows6 driver install only.
(21:07:47) cron2: we want all the goodness in 2.5 :-)
(21:08:24) rozmansi: Adding Wintun to the MSI is easy, as Wintun is shipp=
ed as ready-to-use MSI merge module...
(21:09:24) rozmansi: What needs more work is to make something similar fo=
r the TAP-Windows6. The Wix's plugin used to install drivers (Difx) didn'=
t perform very well on upgrades the last time I tested it.
(21:09:40) lev__: I've sent a patch today with removes 5s route-delay for=
 non-dhcp IP set method. By default we use DHCP (expected wintun) and I w=
as wondering, cannot we switch to IPAPI as a default to make connection 5=
 seconds faster
(21:10:18) rozmansi: Wintun should work with ipapi - WireGuard is using w=
inipcfg to configure it.
(21:10:36) cron2: yes, we should be using ipapi via iservice by default
(21:10:41) lev__: as I mentioned in -devel, openvpn3 uses netsh and doesn=
't have that delay
(21:10:47) cron2: Selva has been talking about this for a long time
(21:11:06) cron2: netsh is easier to debug than ipapi ("because you can r=
un the commands by hand") but ipapi is faster
(21:11:17) cron2: which makes a difference if you're isntalling like 10.0=
00 routes
(21:11:24) cron2: valdikss does this
(21:12:03) lev__: but that is relevant when you don't use iservice
(21:12:09) rozmansi: another delay, I fixed (but not sent a patch yet) wi=
th netsh is that netsh ipv4 dns set/add should have validate=3Dno (as per=
 IPv6). This speeds DNS provisioning considerably. I recon that's because=
 routes are not set _before_ the DNS.
(21:12:25) cron2: we can use IPAPI without iservice
(21:12:52) cron2: and ACK to rozmansi :)
(21:13:02) lev__: cron2: yes, but we cannot use wintun without service, a=
fter rozmansi will send his patch :)=20
(21:13:35) lev__: expect when openvpn is running as system
(21:14:02) cron2: is this equal to "run as administrator" or do you need =
even higher privileges?
(21:14:10) rozmansi: selva insisted on this, and I think she has a point
(21:14:11) lev__: even higher
(21:14:35) cron2: what is the rationale for wintun to enforce this?
(21:14:50) cron2: (as in "why is 'network administrator' not good enough?=
")
(21:15:03) rozmansi: wintubn was designed for wireguard, and wireguard al=
ways runs its tunnels as SYSTEM service.
(21:15:13) rozmansi: And security model was tightened around this.
(21:15:55) rozmansi: I don't make decisions with Wintun and WireGuard. Yo=
u should talk to the boss. :)
(21:16:05) cron2: the boss does not like me
(21:16:53) cron2: so how does "steal system permissions from login servic=
e" work?
(21:16:58) cron2: why does it work?
(21:17:11) lev__: for those who wants to run openvpn via command line wit=
h wintun, we were thinking of utilizing iservice for that, make something=
 like command-line openvpn-gui
(21:17:21) cron2: (I have seen the code, but wonder why that's allowed...=
)
(21:18:01) rozmansi: Windows' security. A lot of things is allowed. Some =
to allow backward compatibility, others for convenience.
(21:18:24) cron2: lev__: yeah, some sort of run-openvpn.exe wrapper that =
does the iservice callout
(21:18:33) cron2: shouldn't be too hard actually
(21:19:41) lev__: maybe just add this functionality to openvpn.exe - dete=
ct that we are not run by iservice and have no system privilege -> switch=
 to command-line gui mode
(21:20:08) cron2: there is too much stuff inside openvpn.exe --some-speci=
al-option already
(21:20:55) rozmansi: how many people are running openvpn.exe from command=
 line/batch in Windows?
(21:20:55) lev__: I proposed to add --enable-system-elevation, but no-one=
 liked it :(
(21:21:01) cron2: do not call it "command-line gui" mode, that will just =
confuse people (as the gui *has* a command-line itnerface)
(21:21:31) cron2: rozmansi: any question that starts with "how many peopl=
e are running openvpn <in a funny way>" will not have a happy ending :-)
(21:21:46) rozmansi: lev__: because the SYSTEM hack machine code would st=
ill be present in the binary and antiviruses might trigger false alarms. =
But, does "might" justify not doing it?
(21:21:48) lev__: openvpn-gui-nogui.exe
(21:22:05) cron2: run-openvpn.exe
(21:22:18) lev__: that works, too
(21:22:23) rozmansi: openvpn-tui
(21:22:29) cron2: haha :)
(21:24:01) lev__: rozmansi: what does antivirus alarm mean exactly "this =
app wants system elevation" - well thanks, I know, because I run it from =
command line with wintun -> continue
(21:24:33) rozmansi: does just telling the people: "If you want to use op=
envpn.exe this way, you do SYSTEM elevation yourself, or switch to TAP-Wi=
ndows6" not suffice?
(21:25:37) lev__: but yeah, we will solve it with run-openvpn.exe (or wha=
tever)
(21:26:25) cron2: having a CLI is actually nice for testing in developmen=
t (and I do not want to work as SYSTEM, however I would do that in the fi=
rst place)
(21:26:39) cron2: (how *do* I "elevate myself", anyway?  I know how to "r=
un as Administrator"...)
(21:27:00) rozmansi: lev__: take my previous remark only as the suggestio=
n for 1st version
(21:27:01) lev__: you need to download a tool from MS site
(21:27:18) lev__: https://docs.microsoft.com/en-us/sysinternals/downloads=
/psexec
(21:27:19) vpnHelper: Title: PsExec - Windows Sysinternals | Microsoft Do=
cs (at docs.microsoft.com)
(21:27:46) lev__: psexec -s -i openvpn.exe
(21:27:50) rozmansi: maybe Selva and I are just paranoid about this SYSTE=
M elevation. psexec have it too.
(21:28:40) lev__: also with psexec the whole process will run as system, =
not just single API call
(21:29:22) cron2: we do not want that
(21:29:25) cron2: for obvious reasons
(21:30:19) rozmansi: then maybe we just leave this SYSTEM token hack in t=
he OpenVPN and see if it causes any issues in the testing stage of the 2.=
5?
(21:30:20) lev__: I am not against having elevation code in openvpn
(21:30:30) cron2: rozmansi: no
(21:30:55) cron2: if Selva says no and you feel "uneasy" about it, then w=
e shouldn't go there
(21:31:21) rozmansi: true
(21:35:15) rozmansi: in some future, probably openvpn.exe should always b=
e run via iservice on Windows. If ran directly, it's just behave as an op=
envpn-tui.exe and ask iservice "call me back baby!"
(21:35:16) lev__: so we agreed that we'll make command-line launcher
(21:36:01) cron2: rozmansi: that's what lev__ suggested, but I do not lik=
e this, tbh.  We have too many special-cases already - and the launcher w=
ould really be very small and trivial (and easier to review)
(21:36:10) cron2: lev__: at least I agree :)
(21:37:02) rozmansi: yes, I agree this is currently the best option
(21:39:36) lev__: can we switch to ipapi/netsh as a default way to set IP=
 address ? then we make connection 5sec faster
(21:39:59) cron2: send a patch, see what Selva says
(21:40:04) cron2: I think it's reasonable
(21:41:50) mattock: more on these topics?
(21:41:59) mattock: 19 minutes left
(21:42:29) lev__: ok, so path is clear with wintun - need to merge 2 acke=
d patches, one more ack and patches from rozmansi=20
(21:43:09) cron2: I'm not sure I understand the "tun.c: do not add/remove=
 routes on tun" patch
(21:43:30) cron2: if we do not need to do so, why has your patch added th=
at just a few patches ago?
(21:43:38) lev__: that basically removes uneeded code I've added in merge=
d patch
(21:44:17) lev__: I didn't have enought knowledge how routing is set in o=
penvpn back then :) now I do
(21:44:18) cron2: this is not actually a good thing
(21:45:01) cron2: I do not think check_add_routes() will do the on-link p=
refix
(21:45:06) cron2: only what you have in "route" commands
(21:46:32) cron2: so this is worrying me
(21:46:43) cron2: we have added *and ACKed* code that seems to be unnecce=
ssary
(21:46:53) cron2: and are removing *and ACKing* it based on a commit mess=
age that is wrong
(21:48:09) lev__: well I got this route:
(21:48:11) lev__:  10.8.0.0    255.255.255.0         On-link          10.=
8.0.2    261
(21:48:41) cron2: this is a consequence of running the windows equivalent=
 of "ifconfig eth0 10.8.0.2/24"
(21:48:47) rozmansi: i always get the on-link route too on my windows
(21:48:48) cron2: it will configure IP address and add the on-link route
(21:49:34) cron2: we never needed to explicitly do this for IPv4 for any =
--ip-win32 method on windows - but we accepted the necessity "if you say =
this is needed, it seems to be necessary"
(21:49:40) lev__: I don't think commit message is wrong?
(21:49:56) cron2: of course it is, because check_add_routes() specificall=
y does *not* do the on-link route
(21:50:05) cron2: (because it is never needed)
(21:50:59) cron2: check_add_routes() walks the route_option list, which i=
s filled from "route" commands in the config/pushed
(21:51:03) lev__: well it doesn't mention on-link stuff
(21:51:09) lev__: (commit message)
(21:51:21) cron2: yes, but it removes stuff that only handles on-link rou=
tes
(21:51:43) cron2: so the commit message should say "it turns out this is =
not needed" not "this is handled by check_add_routes()" because it is not=

(21:53:15) lev__: ah I got it now, true
(21:53:33) cron2: (if you have *no* "route" in your config and nothing pu=
shed, check_add_routes()->...->add_routes() will actually do "just nothin=
g" - which was a regression we had when adding IPv6 support ("send no ipv=
4 routes and openvpn crashes") :)
(21:54:36) lev__: do you want me to resend with fixed commit message or w=
ould you be willing to amend it yourself, having already ack for v1 ?
(21:54:52) cron2: so - I'll adjust the commit message accordingly ("turns=
 out that is not needed at all, windows automatically adds connected v4 s=
ubnet")
(21:55:11) cron2: we have the discussion in the meeting notes and that's =
on the list
(21:55:41) lev__: danke
(21:55:56) cron2: (just as a side note, the "refactor tun.c" hit the repo=
s like 15 minutes ago)
(21:56:09) cron2: so, before mattock runs away...
(21:56:35) cron2: mattock: can you and ecrist *please* get together and f=
ix IPv6 to forums?  It *pings*, but TCP connects go unanswered - looks fi=
rewalled
(21:56:35) mattock: yes
(21:56:52) mattock: ok
(21:56:59) lev__: I remember a while ago I've already sent the patch with=
 correct fix but incorrect explanation in commit message :)
(21:57:24) cron2: since I monitor this (because it needs to work!) I get =
about 6 mails per day to remind me of that fact, and that annoys me into =
action :-)
(21:57:34) cron2: mattock: so what OS is running forums, and who is tendi=
ng the OS?
(21:57:47) cron2: lev__: yes, you like to do that, just to see me run in =
circles :-)
(21:58:35) mattock: the OS is FreeBSD, and ecrist is the one doing the te=
nding
(21:58:45) mattock: my role is just to have functional base configuration=
s in there
(21:58:47) cron2: *sigh* he was pointing your way
(21:58:55) cron2: what sort of firewalling does it run?
(21:59:02) mattock: that said, I'm checking to make sure somebody has not=
 broken our EC2 security groups
(21:59:12) mattock: I've never touched the firewall there
(21:59:23) mattock: probably whatever is the default in freebsd
(21:59:39) cron2: freebsd by default has "no firewall"
(21:59:42) cron2: maybe EC2 then
(22:00:01) cron2: if you look in /etc/rc.conf and find no mention of "pf"=
 or "ipfw" or such, no firewall
(22:00:38) mattock: let me check now
(22:00:54) mattock: EC2 security groups do allow traffic from any IPv4/IP=
v6 to 80/443
(22:00:56) mattock: so that's not it
(22:01:30) mattock: pf_enable=3D"YES"
(22:01:36) cron2: ah, here we go :)
(22:02:01) cron2: if you have 5 more minutes, we can get this fixed
(22:02:12) cron2: is there a pf_rules=3D... setting?
(22:02:46) cron2: if yes, this is the file to use, if not, it's /etc/pf.c=
onf
(22:03:12) mattock: looks reasonable without any knowledge in pfctl:
(22:03:12) mattock: pass in proto tcp from any to <self> port =3D http fl=
ags S/SA keep state
(22:03:12) mattock: pass in proto tcp from any to <self> port =3D https f=
lags S/SA keep state
(22:03:36) cron2: <self> is a "list", that should be defined further up
(22:03:50) cron2: I tend to just use
(22:04:02) cron2: pass in proto tcp from any to em0 port =3D ...
(22:04:16) cron2: with "em0" being "my address on the outside interface"
(22:04:19) mattock: how would I list the lists?
(22:04:34) cron2: where have you been looking?  in the file, or in "pfctl=
 -s rules"?
(22:04:42) mattock: pfctl -s
(22:05:06) cron2: pfctl -t self -T show
(22:05:25) mattock: also /etc/pf.conf seems to have the "stuff"
(22:05:51) cron2: there should be a definition of "self" in the beginning=
, like=20
(22:06:02) cron2: table <self> { 1.2.3.4, 2001::1 }
(22:06:31) mattock: if you give me your IPv6 IP I can tcpdump and see if =
your packets arrive there
(22:06:41) mattock: to rule out some obscure EC2 SG issue
(22:06:58) cron2: 2001:608:4::ce:c0f
(22:07:05) mattock: ok
(22:07:13) cron2: Trying 2600:1f1c:702:ae00:57df:e63:fbd0:a360...
(22:07:18) cron2: (port 80)
(22:08:24) mattock: they do arrive there
(22:08:33) cron2: so not EC2
(22:08:47) cron2: so what's in "pfctl -t self -T show"?
(22:09:24) mattock: what if I PM you the whole /etc/pf.conf? there is not=
hing really sensitive in there
(22:09:56) cron2: fine
(22:12:07) mattock: in the meanwhile I will send out the summary
(22:12:25) cron2: mmmh, this is interesting.  <self> { self } should be s=
ome sort of magic that does "all addresses assigned to the interface(s)"
(22:12:58) mattock: and it is not working for IPv6 or?
(22:13:20) cron2:  I've never used "self", staring at the manpage now
(22:14:40) cron2: pass in on $in_if proto tcp to any port {80, 443}
(22:14:49) cron2: argh, mixing channel and PM
(22:16:06) cron2: maybe { self } only works if the addresses are present =
at pf load time - so if you just do "pfctl -f /etc/pf.conf" on the file a=
s it is now, it works
(22:17:19) cron2: where is ordex anyway? and dazo? and plaisthos? already=
 on vacation y'all?
(22:17:35) cron2: Trying 2600:1f1c:702:ae00:57df:e63:fbd0:a360...
(22:17:35) cron2: Connected to forums.openvpn.net.
(22:17:37) cron2: whee \o/
(22:18:09) cron2: peace of mind is comming
(22:18:22) cron2: so, sofa time for me
(22:18:32) cron2: patches merged, grumbled at, pushed
(22:19:02) rozmansi: good night everyone :)
(22:21:29) mattock: good night!

--------------F65729C1E80C73C06EC0F076--

--5EtWT9kU3WeZObrIXVXTrVG8tHcR0ZY1E--

--175Os2vyEKL3T2i3vsljSIs9F1pBkXgVN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAl373EUACgkQKVhNn0CG
RXiK1wgAktBIyTGImIlk92O4DWyKhrAAxID/sgVtNXbhjQ44Ks6xS6q8oakRpPsV
44EO4+3VnBkWtnBvCZAIOI1S3+sTdm/ufrB17ZxMC7VYgB6tXeVpTk23aEvR+fwP
YBxnonNlmFUsZ93yyUUwpjEMaT1Z/9kTUOM4jYexLRL8UPlwtLrk7sOwxIwFRLuY
jadtluCL4NCXWcUwzNIfYNt9LCgI5u4BDhZ25yJf/I0cLu9DlFPBK1mx3JILEEz3
+cQoh2pN3eK8UlrRo5qolpPCca7+cZsLTrAZMeDqxMZ7bHTLxIIzkQwFq4GjNsS2
p6xcILuS6fVQWKpaQykSCCOxgyEg/w==
=teLV
-----END PGP SIGNATURE-----

--175Os2vyEKL3T2i3vsljSIs9F1pBkXgVN--

