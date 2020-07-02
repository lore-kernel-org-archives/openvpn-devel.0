From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <f8932a9a-4ab2-a830-0b8b-cb684bc5ce77@...515...>
Message-ID: <6fcc554b-f6e5-6125-6ea3-0029fe99df5d@...515...>
Date: Thu, 2 Jul 2020 22:19:06 +0300
MIME-Version: 1.0
In-Reply-To: <f8932a9a-4ab2-a830-0b8b-cb684bc5ce77@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="AURfRFv3EChdE7az8hibdbKzwhk1itTou"
Subject: [Openvpn-devel] Summary of the community meeting (2nd July 2020)
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
--AURfRFv3EChdE7az8hibdbKzwhk1itTou
Content-Type: multipart/mixed; boundary="FXMt68FoPWfEssP6TjejDcxIbMeDsAcjZ"

--FXMt68FoPWfEssP6TjejDcxIbMeDsAcjZ
Content-Type: multipart/mixed;
 boundary="------------2BBA5B5D39AB236F703521A8"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------2BBA5B5D39AB236F703521A8
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Thu 2nd July 2020
Time: 20:00 CEST (18:00 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2020-07-02>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, krzee, lev, mattock and plaisthos participated in this meeting.

---

Talked about the status of OpenVPN 2.5:

<https://community.openvpn.net/openvpn/wiki/StatusOfOpenvpn25>

OpenVPN 2.5 MSI installers are available for wider testing now:

<https://build.openvpn.net/downloads/temp/msi/>

They seem to work on all platforms except Windows 10 ARM64 which has
driver installation issues. These issues may be caused by bad packaging,
or be genuine issues in the MSI installer code. Mattock will look into
it. Agreed that we should underline the fact that Wintun driver is
present in the MSI installers.

Talked about async-cc. Much of the code is in multi.c, which is a
tangled mess of magic. Plaisthos is not sure that his patches are
correct, so it will be looked into by him, cron2 and/or ordex. It was
noted that the band-aid fixes made by lev work ok, but regardlress may
not be correct.

The man-page patch also still needs some work.

Besides the above there's not really any work left for OpenVPN 2.5

That said, due to vacations and all that we may have to postpone the
first release post mid-August.

---

Talked about automating MSI installer generation. Mattock will try to
get it done tomorrow.

--

Talked about having krzee participate in the maintenance of community
servers. Nobody was opposed, but we want talk to ecrist as well.

Krzee is also working on fixing the IPv6 issues with community atm.

---

Agreed to follow our usual meeting schedule in July. Mattock will send
out the invites and setup the topic pages, even though he won't be
attending the meetings due to his vacation.

--

Full chatlog attached



--------------2BBA5B5D39AB236F703521A8
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2020-07-02.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2020-07-02.txt"

(21:00:29) cron2: so!
(21:00:37) lev__: guten aben
(21:02:59) krzee: moinmoin
(21:03:00) mattock: hi!
(21:04:17) plaisthos: moin
(21:05:06) cron2: mattock: we need an agenda page!
(21:05:32) mattock: scheisse
(21:05:34) mattock: just a sec
(21:05:37) krzee: cron2, ive never used ipv6 really but i understand our =
domain being on CF is not favored because no ipv6 on there yet, i plan on=
 looking in to fixing stuff to work properly when ipv6 is enabled there. =
are there any issues with us using CF on openvpn.net when ipv6 is working=
?
(21:05:43) lev__: schneller!
(21:06:15) cron2: krzee: I have no issue with CF... I totally fail to und=
erstand why someone went to the effort to turn *off* IPv6 on CF, which is=
 now on-by-default
(21:06:50) ***plaisthos knows some of the ops team poeple and better keep=
s silent
(21:06:56) krzee: it broke some stuff, but that will be fixable
(21:07:12) krzee: i plan on fixing it
(21:07:13) cron2: I do not care too much about the corp web sites, but I =
am fully convinced that all community web sites MUST have IPv4 and IPv6
(21:07:16) cron2: thanks :-)
(21:07:36) cron2: and yes, enabling IPv6 used to break things, which is w=
hy you enable it, and then fix what is broken
(21:07:49) krzee: np, just wanted to be sure that my fix isnt pissing in =
the wind, that we're ok with CF once ipv6 is good on it
(21:08:20) cron2: mattock had some issues with CF and caching when we had=
 to re-upload an installer file with a changed checksum - but I understan=
d that this is "under control" now
(21:08:57) krzee: the double cache is annoying, for swupdate i made a jen=
kins script that corp people can run
(21:09:15) cron2: (if you ask me "would you put your personal web page on=
 CF", the answer is no, because I have issues with the whole anti-ddos ma=
fia - but I will not object or complain about openvpn stuff using CF)
(21:09:22) krzee: dazo def knows about the job, not sure if samuli does t=
ho
(21:09:55) mattock: https://community.openvpn.net/openvpn/wiki/Topics-202=
0-07-02
(21:10:15) krzee: also if there was private data going to openvpn.net i w=
ould be able to agree with CF being an issue, but we google index it all =
anyways so :shrug: there
(21:10:47) cron2: krzee: thanks for caring, and working on it.
(21:10:57) mattock: another meeting ended, now I have focus
(21:11:21) cron2: is dazo coming?
(21:11:54) mattock: I do not know
(21:11:57) lev__: he is on vacation, but let's see
(21:12:08) cron2: mmmh.
(21:12:14) krzee: yw :)
(21:12:15) mattock: so, shall we go through 2.5 status or what?
(21:12:41) cron2: I would say "quick update" (like 1-2 lines), and then b=
ig discussion on the way forward with async-cc
(21:13:00) mattock: MSI: works, except that arm64 seems to have tap-windo=
ws6 problems
(21:13:17) cron2: "my" things are in :-) - and I want to work a bit on wi=
ndows/netmask issues and help dazo with the manpage.  Plus, merge what co=
mes up.
(21:13:18) mattock: not sure what the issue is - is it the way I built th=
e installer, or an actual bug
(21:13:36) mattock: have not had the time to look into it, but will try t=
omorrow
(21:13:37) lev__: mattock: did you also test wintun=20
(21:13:45) mattock: uh no, but can you?
(21:13:51) cron2: sgstair is hanging around in #openvpn-devel... maybe we=
 can ask him to have a look?
(21:13:51) mattock: it did install wintun though
(21:14:10) lev__: you just need to add --windows-driver wintun to use it
(21:14:20) mattock: ok, that would be worth a shot definitely
(21:14:21) cron2: how does the "install wintun" work with the MSI?  Is th=
ere a checkbox, or will I get a "tap9" *plus* a "wintun" device by defaul=
t?
(21:14:39) lev__: I can surely do it, but I am on vacation next week=20
(21:14:41) cron2: iow, how do we *want* it to work?
(21:14:54) mattock: by default you get both, but you can select/deselect =
the components you want
(21:15:17) lev__: make sure that if one adds --windows-driver wintun to p=
rofile, it will work
(21:15:25) mattock: ok
(21:15:32) lev__: (answering on how to test)
(21:15:48) mattock: the wintun driver is the standard one for wintun proj=
ect, so it "should work" if openvpn is able to use it
(21:15:53) mattock: that said, better test
(21:16:15) krzee: OPS also wants me to ask community if i can start helpi=
ng more on the community nodes that we have... and maybe even one day in =
the future bring them more inline with our other infrastructure (ie: ngin=
x instead of apache, linux instead of fbsd, that kind of stuff)=20
(21:16:29) lev__: shall we make this option more visible? maybe prompt to=
 user "hey we now support new shiny driver, add this to your vpn config t=
o use it"
(21:16:29) cron2: are you building wintun from source or picking up signe=
d modules?
(21:16:56) mattock: lev__: if the msi installer bundles the INSTALL-win32=
=2Etxt we could add that info there
(21:17:09) krzee: maybe the topic i just mentioned should go on a future =
agenda so we can have ecrist around for it ^
(21:17:09) cron2: krzee: let's discuss this separately, not intermixed wi=
th 2.5 status
(21:17:14) mattock: on the first install the "Do you trust this publishes=
?" prompt comes up for both wintun and tap-windows6
(21:17:23) krzee: cron2, agree, another day even
(21:17:33) cron2: ecrist isn't usually attending the meetings, so more "c=
atch him on openvpn-devel and see what he thinks"
(21:18:01) lev__: mattock: if you provide me link to installer, I can hel=
p with testing tomorrow
(21:18:15) mattock: lev__: https://build.openvpn.net/downloads/temp/msi/
(21:18:17) vpnHelper: Title: Index of /downloads/temp/msi/ (at build.open=
vpn.net)
(21:18:48) lev__: since we also support multiple tunnels, we should proba=
bly test wintun and tap connections simultaneously
(21:19:52) cron2: mattock: have you announced this installer for "wider c=
ommunity testing" already? I can't find anything on the list (in 30 secon=
ds)
(21:20:09) mattock: no I have not, but I can do that while I send the sum=
mary today
(21:20:17) lev__: we have "techinical preview" page, but it is outdated a=
lready
(21:20:35) cron2: I have the feeling that this stuff is good enough to ge=
t wider community testing :-)
(21:20:52) cron2: and "client side + windows changes" should be mostly fi=
nished already
(21:22:29) lev__: I have also tested wintun in server mode, worked fine b=
ack then (after a few rounds of fixes)
(21:23:09) cron2: that comment was more about "server code is expected to=
 change quite a bit, so even if people test that today, it doesn't say '2=
=2E5 is all good!'"
(21:23:18) cron2: well, multi-server
(21:25:11) cron2: seems the status update about MSI has finished :-)
(21:25:20) cron2: so... async-cc
(21:25:41) cron2: plaisthos: do you have a mental road and a rough estima=
te on the time line?
(21:26:04) cron2: I am in favour of postponing 2.5 by 2 or 4 weeks, if th=
at means we get proper code in multi.c, not 5 rolls of bandaid stacked
(21:26:28) cron2: (this is why I had hoped for dazo to be here...)
(21:27:59) ***cron2 gets himself a glass of wine
(21:28:53) mattock: cron2: excellent idea :)
(21:31:27) cron2: so, wine glass filled, spilled, mopped up, still no sig=
n from ordex or plaisthos
(21:32:15) lev__: not enough wine, obviously
(21:32:42) lev__: if you drink a few bottles you may summon James
(21:33:31) cron2: hehe, what is James doing these days?
(21:33:36) mattock: sent email about MSIs
(21:34:00) mattock: working in a silo on something big and exciting, as a=
lways
(21:34:54) cron2: lev__, mattock, what do you think?  Mattock, because it=
 affects your release building, and lev__ because you've seen the code an=
d followed the discussion
(21:35:19) mattock: well, I will be on vacation starting next monday and =
_try_ to do as little work as possible
(21:35:24) cron2: July is fairly relaxed for me on reviewing, testing, me=
rging - so for me, it would work
(21:35:25) krzee: james is doing lots of awesome mesh stuff these days
(21:35:26) lev__: I don't know how much code plaisthos is going to refact=
or
(21:35:34) mattock: I'm willing to a release if everything else is prepar=
ed in <4 weeks though
(21:35:51) krzee: funny too cause when i look back at the OLD ovpn3 roadm=
ap i can see he was already thinking about the mesh stuff
(21:35:53) cron2: nah, release plan was "mid august", but that might be p=
ostponed as well
(21:35:57) lev__: I have some kind of test setup for deferred auth and cc=

(21:36:21) cron2: lev__: if you're on vacation next week, can you share t=
hat with plaisthos and ordex?
(21:36:33) cron2: (I assume it needs corp credentials for AWS - which is =
ok with me)
(21:37:16) lev__: at least latest master+async-cc+my patch (could be squa=
shed into async-cc series) survives stress testing=20
(21:37:32) lev__: cron2: sure
(21:37:57) cron2: lev__: how long will you be on vacation, and will you b=
e "totally offline" or can we throw the occasional review your way?
(21:38:13) lev__: one week
(21:38:44) cron2: short enough
(21:39:16) lev__: I will take my laptop, just in case
(21:40:13) lev__: I have to say that amount of "band aids" is less then o=
ne might think
(21:40:55) lev__: after plaisthos removed that variable it is just one ad=
ditional patch which could be also squashed into async-cc series
(21:42:05) cron2: let's see what he'll come up with.
(21:42:34) cron2: since nobody is screaming "WE MUST KEEP THE CODEFREEZE =
DATE!!!" I just declare "we postpone as long as it needs, and then start =
with beta/pre-release testing"
(21:42:50) mattock: +1
(21:43:31) mattock: so async-cc is the only piece really missing, correct=
?
(21:43:48) cron2: yes (plus manpage, but I need dazo to tell me what he n=
eeds from us there)
(21:44:59) mattock: ok, I will note that down
(21:45:30) cron2: there is "update auth-user-pass docs" on your plate, ac=
cording to the wiki list
(21:46:35) mattock: I believe that went out of the door when my patch mad=
e everybody thinking that "maybe we should really fix the problem"
(21:46:44) mattock: my patch is still there to be merged
(21:46:50) mattock: unless somebody fixed the actual issue
(21:46:53) mattock: can't recall
(21:47:10) cron2: I think Selva fixed the issue :)
(21:47:46) mattock: yeah, then we can tick that part off
(21:47:50) mattock: shall you or I?
(21:47:51) cron2: ah
(21:47:56) cron2: is the msi building automated?
(21:47:57) plaisthos: sorry I also semi afk
(21:48:03) mattock: no, not automated
(21:48:08) mattock: it is not _that_ trivial
(21:48:08) cron2: plaisthos: welcome back :-)
(21:48:21) cron2: mattock: can you...?  so we can see "I have merged some=
thing, it fixed stuff!"
(21:48:40) lev__: mattock: can we bring this page down https://openvpn.ne=
t/download/openvpn-2-5_git-wintun-technology-preview/ since wintun is now=
 in master
(21:48:42) vpnHelper: Title: OpenVPN 2.5_git wintun technology preview | =
OpenVPN (at openvpn.net)
(21:48:44) mattock: hmm, if I can somehow outsource all the work I have f=
or tomorrow then maybe
(21:48:45) cron2: plaisthos: can you let us know your thoughts regarding =
multi.c?
(21:48:54) mattock: lev: sure
(21:49:45) mattock: ummm
(21:49:53) mattock: requires modifying joomla
(21:49:55) mattock: sorry
(21:49:56) mattock: wordpress
(21:49:58) mattock: forgot
(21:50:02) plaisthos: basically I don't trust the current patch to be oor=
rect
(21:50:12) plaisthos: Without understanding how it all woorks
(21:50:15) mattock: lev: can you create tickets in the OW (website) proje=
ct?
(21:50:52) mattock: I'd rather not go touch on the website, except when I=
 do a release and I must
(21:50:53) plaisthos: so basically I need to spend the time anyway
(21:51:08) plaisthos: and if I spend it anyway I can fix the thing that I=
 am seeing
(21:51:14) cron2: plaisthos: throw stuff at me and ordex if needed :)
(21:51:24) ***cron2 promises to test compile patches before pushing
(21:52:44) lev__: mattock: OW-351
(21:53:08) mattock: lev__: ok, great!
(21:53:22) mattock: async-cc and multi.c are related, right?
(21:53:40) mattock: for the record
(21:53:45) cron2: yes
(21:53:49) lev__: multi.c is where most of async-cc functionality is
(21:53:52) mattock: ok
(21:53:56) cron2: multi.c is a tangled mess of magic
(21:54:07) mattock: I will write that down verbatim :)
(21:56:16) mattock: almost one hour
(21:56:22) mattock: anything else on 2.5?
(21:57:09) plaisthos: I know that lev's band aid fixes work
(21:57:33) plaisthos: but I found out that I currently don't understand t=
he code well enough to say if it is correct or not
(21:58:03) lev__: "Understanding is a three edged sword: your side, their=
 side, and the truth."
(21:58:59) mattock: 2 minutes
(21:59:58) mattock: just for record: I think having krzee help with the c=
ommunity servers would be good - they're pretty low maintenance overall, =
but when they have to be updated its always a big project
(22:00:26) cron2: no objections (but I am not involved in forum/trac, so =
I have no voice)
(22:00:46) mattock: forums, trac, pwm (self-service LDAP  portal), 389ds,=
 patchwork
(22:00:51) mattock: all different beasts
(22:01:11) mattock: plus buildmaster, all the buildslaves
(22:01:20) mattock: surprising amount of "special" nodes
(22:01:48) krzee: i hope to get ecrist present to give his opinion on it =
as well, but i didnt msg him about it yet or anything, im fine with addin=
g it to a future agenda to give him notice
(22:01:55) mattock: yepyep
(22:01:58) mattock: agreed
(22:02:10) mattock: call it a day?
(22:02:50) cron2: yeah.  We have work to do. :-) (lev__: if you feel bore=
d, I have plugin-auth-pam async auth patch to review :-) - but I do hope =
that Selva can find time for it)
(22:03:48) lev__: cron2: I was planning to work on test setup for deferre=
d stuff and test wintun for the rest of the week
(22:04:02) mattock: one more topic: next meeting when?
(22:04:05) cron2: ok
(22:04:10) mattock: August?
(22:04:13) cron2: mattock: wednesday, 11 am MEDT
(22:04:18) mattock: I won't be here
(22:04:26) mattock: if somebody else organizes it that is fine by me :D
(22:04:30) cron2: *you* might be on vacation, but there's people getting =
work done :-)
(22:04:34) mattock: I can send the invites
(22:04:40) cron2: if you set up the agenda page + invitations, that's goo=
d enough
(22:04:42) mattock: +1

--------------2BBA5B5D39AB236F703521A8--

--FXMt68FoPWfEssP6TjejDcxIbMeDsAcjZ--

--AURfRFv3EChdE7az8hibdbKzwhk1itTou
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAl7+MyoACgkQKVhNn0CG
RXi29ggAg/QHKgGYOl+llCNVTYpoPtNdhmee8+BjLeGaFcZk2PHu3xao2fir9Lk4
5muIzABuFzihtWohGcsiXLZKiOBR8WbxfGRYMQB2/4M4CWxXS+o8t73ZxKjqCxd6
YpdFy3GIlHGT1PJNsrf8exioEEl8YdBCdp6C+UF6ghCEtuRcwabjG3HTaxZzC+1U
2XZ/Kv5Tv1iPoIMl4iG0jX5BrbGpGkoScrUUoHkAwc2mH9LhulU/E2tBh4le9lQ0
TvSe3DgihyBMgSkA6RrHc/4rs8ggJmdqlBXLwmA0JmRZJEbp4bkF6DtiWP81zJM1
rWxKOYDLszhUV/WyuQHygwShWPRFww==
=mrHZ
-----END PGP SIGNATURE-----

--AURfRFv3EChdE7az8hibdbKzwhk1itTou--

