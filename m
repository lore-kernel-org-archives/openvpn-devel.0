From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <6a623f26-a30c-eb91-204b-8f938cad2994@...515...>
Message-ID: <952dbe12-682f-2699-45d3-87bab53a4328@...515...>
Date: Thu, 23 Apr 2020 22:19:29 +0300
MIME-Version: 1.0
In-Reply-To: <6a623f26-a30c-eb91-204b-8f938cad2994@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="poxQZNK2sq8bN04VqnztUkUfm8NjzoYUz"
Subject: [Openvpn-devel] Summary of the community meeting (23rd April 2020)
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
--poxQZNK2sq8bN04VqnztUkUfm8NjzoYUz
Content-Type: multipart/mixed; boundary="BYmS6gMuWkAQmVtcFf8oCwpWOqgOlMtrK"

--BYmS6gMuWkAQmVtcFf8oCwpWOqgOlMtrK
Content-Type: multipart/mixed;
 boundary="------------F553F70FF5A3B88781829FD2"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------F553F70FF5A3B88781829FD2
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Thu 23rd April 2020
Time: 20:00 CEST (18:00 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2020-04-23>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, dazo, mattock, ordex and Pippin participated in this meeting.

---

Talked about the proposed update to our patch to pkcs11-helper:

<https://github.com/OpenVPN/openvpn-build/pull/172>

It was agreed that using the patch version from Fedora Rawhide would
make more sense, as that is more widely tested. Plus the patch does not
seem to have any Linux-specifisms that could break on Windows (=3Dour
target system here).

---

Mattock mentioned that OSTIF.org is currently waiting for 2.5.0 before
launching their security audit.

--

Discussed the OpenVPN 2.5 release.

Ordex and cron2 revived the ipv6-only patchset. Wiscii has tested it
already and has reported that it works. OpenVPN Inc. will provide
additional QA resources to test it as well.

Cron2 has a couple of Windows-specific patches on his plate (tun-mtu,
IPv6 netbits in netsh / iService) which need some focused review effort.

There are also a couple of patches from plaisthos which could be merged
easily once there's a bit of time for a review.

The async-cc patchset is waiting for testing, but we have a volunteer
who is willing to test the rebased code.

Ordex will review the tls-group patch in the upcoming days.

Mattock should have time to focus on the MSI work starting next week
after wrapping up a rather big internal project.

---

Noted that AAAA record seems to be missing for community.openvpn.net.
Mattock will fix that. Also, he will add monitoring of the IPv6
addresses of the community services to OpenVPN Inc's monitoring system.

--

Full chatlog attached

--------------F553F70FF5A3B88781829FD2
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2020-04-23.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2020-04-23.txt"

(21:00:55) cron2: yeaaha
(21:01:02) mattock: hi
(21:01:09) ***cron2 complains about topic
(21:03:33) mattock: ok complain
(21:03:40) mattock: https://community.openvpn.net/openvpn/wiki/Topics-202=
0-04-23
(21:06:37) ***dazo is here
(21:06:51) mattock: hi!
(21:09:35) cron2: hi dazo!
(21:09:40) cron2: how's madness?
(21:12:20) dazo: mad :-P
(21:13:47) cron2: you're all so talkative today... :)
(21:14:40) dazo: hehe ... looked at the #1 topic ... surprised to see a r=
ed hat bz reference in a project used for Windows builds ....=20
(21:15:05) mattock: ok now distractions are over
(21:15:26) mattock: so, I wanted to bring up the pkcs11 patch because I d=
on't want decide by myself whether it is acceptable or not
(21:15:30) mattock: thoughts?
(21:16:03) cron2: I have no idea what he's talking about
(21:16:20) cron2: ah
(21:16:46) cron2: so we import the pkcs11 patch from redhat (or a common =
source), and that patch has issues.  So it ended up in RH's BZ and they n=
ow let us know
(21:17:52) cron2: 2017
(21:18:55) dazo: okay ... so .... there is a patch in the opensc project =
(where pkcs11-helper comes from, managed by alonb) ... which is not being=
 accepted because it is "too complex", and it has been an open pull-req f=
or 2 years.  And the patch we have in our build repo is based on that.  W=
hat I don't understand yet is how we have a "faulty" patch in our repo
(21:19:08) cron2: that patch has a bug
(21:19:15) cron2: which is explained in the RH BZ
(21:19:27) cron2: so we get a patch for the patch now :)
(21:20:18) cron2: and we actually have an open trac ticket (1075) related=
 to "long IDs do not work"
(21:20:22) dazo: yeah ... I would probably look into what dwm2's git repo=
 has and compare that patch/commit with our patch
(21:20:50) mattock: I would =3D I will?
(21:20:52) mattock: :P
(21:21:02) dazo: I suggest! :-P
(21:21:11) mattock: I thought so!
(21:22:09) ordex: are we doomed ?
(21:22:15) cron2: ordex: yes
(21:23:05) dazo: from a quick look ... the first change (token[1] -> toke=
n[0]) that looks fine and sane
(21:23:44) dazo: the second change I don't see in dwm2's repo during my q=
uick glance .... from a style perspective it looks odd too
(21:24:07) dazo: (but that style seems to be common in that repo)
(21:27:00) dazo: This is what Fedora ships in Rawhide ... and I would pre=
sume prior release has the same patch though ... https://src.fedoraprojec=
t.org/rpms/pkcs11-helper/blob/master/f/pkcs11-helper-rfc7512.patch
(21:27:01) vpnHelper: Title: Tree - rpms/pkcs11-helper - src.fedoraprojec=
t.org (at src.fedoraproject.org)
(21:27:12) dazo: (and that is related that rh bz)
(21:27:51) dazo: Rawhide ships with pkcs11-helper-1.22
(21:28:51) dazo: the patch was introduced Nov 2017 and seems to have been=
 unmodified since then
(21:32:14) mattock: well
(21:32:15) mattock: https://github.com/OpenSC/pkcs11-helper
(21:32:17) vpnHelper: Title: GitHub - OpenSC/pkcs11-helper: Library that =
simplifies the interaction with PKCS#11 providers for end-user applicatio=
ns using a simple API and optional OpenSSL engine (at github.com)
(21:32:18) dazo: I see that the Fedora patch have the same tokstr[0] refe=
rence, but is lacking the second change
(21:32:24) mattock: has been unmodified since then
(21:32:32) dazo: yeah
(21:32:52) dazo: I would suggest to rather use the patch from Fedora and =
see if that resolves the issue
(21:33:09) mattock: is there anything in there that could behave differen=
tly on Windows?
(21:33:10) dazo: That patch is tested on quite some installs
(21:33:22) cron2: mattock: doesn#t look like it
(21:33:43) dazo: I wouldn't say, no
(21:33:56) mattock: then I think dazo's suggestion makes sense
(21:34:14) mattock: I can ask the guy about that approach and ask him to =
test
(21:35:33) mattock: ok and done with this?
(21:35:37) cron2: wfm
(21:35:49) dazo: sounds good
(21:35:52) mattock: I have two other small topics
(21:35:55) mattock: just an update
(21:36:24) mattock: right now OSTIF is waiting for OpenVPN 2.5.0 before t=
hey launch their audit
(21:36:36) cron2: Derek reappeared?
(21:36:40) mattock: yes
(21:37:13) mattock: I poked the other guy there, Amir, to get Derek's att=
ention and that worked :D
(21:38:42) mattock: I had something else but I forgot, so let's move on
(21:38:58) mattock: OpenVPN 2.5?
(21:39:19) cron2: ordex and I have started to revive the ipv6-only patchs=
et
(21:39:37) cron2: (that is, ordex has poked me, and I have agreed)
(21:40:08) mattock: why did it not go in the last time?
(21:40:11) ordex:  it's not far from completion though
(21:40:18) ordex: lack of test
(21:40:21) mattock: ok
(21:40:23) ordex: but corp has QA to allocate now
(21:40:24) cron2: lack of review, mostly
(21:40:28) ordex: that too
(21:40:31) cron2: wiscii has tested and reported "it works"
(21:40:43) cron2: so it should not generally be very painful
(21:41:54) ordex: yap
(21:42:15) ordex: as next step it'd be nice to write down a couple of tes=
ts we want to see happening, so that i can pass them to QA
(21:42:30) ordex: I'll try to poke cron2 again the coming days to make th=
is happen :] if he's fine
(21:43:09) cron2: ordex: yes
(21:43:39) cron2: I have a core router to swap tomorrow night, but all th=
e prep work is done (except "carry the 70kg monster into the 3rd floor, p=
ut it in the rack")
(21:44:20) cron2: but besides this, time planning looks lighter these day=
s :)
(21:44:44) cron2: Besides ipv6-only, there are two windows specific patch=
es that are sitting on my plate, one for "tun interface MTU" (which got s=
talled, and the author has re-sent and rebased).  The other is related to=
 IPv6 netbits in windows netsh and/or iservice, which needs brains + test=
ing.
(21:46:30) cron2: there's a few patches from plaisthos that need a bit of=
 time for review, and could be merged then quickly...
(21:47:00) cron2: and then we're waiting for the async-cc patchset... (fo=
r which a tester has volunteered a few days ago, if I saw this right)
(21:47:08) ordex: yap
(21:47:23) ordex: a guy says he's using that patchset, so he'd be fine wi=
th testing the rebased code
(21:47:54) cron2: yes!
(21:48:06) ordex: I have the tls-group patch on my plate too
(21:48:12) ordex: will review these days
(21:48:15) cron2: nice
(21:48:28) cron2: oh, and the tls-auth-token stuff is still not working p=
erfectly
(21:48:40) cron2: it is biting people @ work, so I know what to look for
(21:49:19) cron2: (when the token expires after 8h, and people re-login w=
ith 2FA, this *new* token is then not stored properly in the client, and =
1h later - tls reneg-sec - the client is AUTH_FAILED again)
(21:49:41) cron2: I need to reproduce this in a test setup with shorter t=
imers, and then I can poke plaisthos about it
(21:50:30) cron2: mattock: what about your end?
(21:52:23) mattock: my end has not moved forward, because I wanted to get=
 a rather big internal project out of my hands first - but that is almost=
 done so I can probably really move forward with the MSI stuff etc. next =
week
(21:52:36) cron2: cool
(21:52:43) mattock: I want to minimize multi-tasking and rather focus on =
it properly
(21:52:43) cron2: well, the outlook is :)
(21:55:20) mattock: anything else?
(21:55:22) cron2: we need to add some sort of motivation for people here =
to be a bit more talkative, like "who types most words gets a free bottle=
 of beer" :-)
(21:55:35) cron2: not on 2.5, but on community & IPv6...
(21:56:25) Pippin_: free beer? i'm in :)
(21:56:52) ordex: :p
(21:56:56) cron2: mattock: shall I add your e-mail address to our monitor=
ing, so you can hear first-hand if IPv6 breaks...?
(22:02:16) mattock: Pippin_: congratulations: you made it to the attendee=
 list with that!
(22:02:18) mattock: :)
(22:02:28) mattock: cron2: hmm
(22:02:43) mattock: I could maybe actually add those IPv6 addresses to ou=
r monitoring system
(22:02:54) cron2: sounds like a plan :)
(22:02:57) mattock: it is a recent EC2 instance all of which _do_ have IP=
v6 addresses
(22:03:09) cron2: (right now, the problem is "there is no v6 address in t=
he DNS for community", so it seems cloudflare messed that up)
(22:03:09) mattock: I really don't know what broke it, unless reboot chan=
ges the public IPv6 address
(22:03:16) mattock: oh
(22:03:18) mattock: ok
(22:03:29) cron2: no, it's=20
(22:03:30) cron2: $ ping6 community.openvpn.net
(22:03:30) cron2: ping6: hostname nor servname provided, or not known
(22:03:47) cron2: it was cloudflared to death
(22:04:00) mattock: regardless, monitoring the IPv6 addresses makes sense=
 because not too many people use it so breakages may go unnoticed for too=
 long, even without manual cron2-monitor
(22:04:16) mattock: ok I'll add a ticket about this to myself
(22:04:19) cron2: +1 *like* *thumbsup* :-)
(22:04:20) cron2: thanks
(22:08:21) mattock: created
(22:08:50) mattock: we need service and certificate monitoring anyways an=
d we already have the tools for it
(22:08:58) mattock: so this is just a small extension of it
(22:09:03) mattock: not a big deal(tm)
(22:09:08) mattock: ok 9 minutes past so that's it
(22:09:15) mattock: summary almost ready
(22:09:16) dazo: :)
(22:09:51) cron2: fine.  I'm tired and need a beer & sofa now - good nigh=
t, folks.
(22:10:19) mattock: good night!

--------------F553F70FF5A3B88781829FD2--

--BYmS6gMuWkAQmVtcFf8oCwpWOqgOlMtrK--

--poxQZNK2sq8bN04VqnztUkUfm8NjzoYUz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAl6h6kIACgkQKVhNn0CG
RXhOOAgAsL6UMoBxxYxsR/Nz72Xywtupx+eZtpKuSe9xXtBBbhYU93a4IZn1SR9z
2dwbgl3Pe7kWGUAW1N0Fqa77uFukkopd0WSTiB5tuL/sA1EZj6zQYEgRxh+elv+0
0yqLgvCoZ8pI3tp46wbNGGQ2k7FJZt+Zsdwzy5mEYfymCRu/vv70wzvLYntoNm9X
U17jGjWAozT6ud7VTf+P196+5ogrwGUQ0F079CuORjjgZVEwQyY8ngCq1pda1Kjn
FcTmxC0vRLnIDHKSimlTKkjYW4qM67AAHUc0NZB6v04YPnh3kREcl+1sIOuXxtdX
8ZMSYGhkxOX6hkAbOSQffQlB/ZdTYg==
=YedD
-----END PGP SIGNATURE-----

--poxQZNK2sq8bN04VqnztUkUfm8NjzoYUz--

