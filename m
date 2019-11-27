From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <3f14bd18-10f2-7783-7060-301a54f5c5ff@...515...>
Message-ID: <2f9ad893-1e9c-bb05-6664-ce570c802c65@...515...>
Date: Wed, 27 Nov 2019 20:27:25 +0200
MIME-Version: 1.0
In-Reply-To: <3f14bd18-10f2-7783-7060-301a54f5c5ff@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="1X81WmGKB2VSF56d9vVMF0D53bYiqpOx2"
Subject: [Openvpn-devel] Summary of the community meeting (27th November
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
--1X81WmGKB2VSF56d9vVMF0D53bYiqpOx2
Content-Type: multipart/mixed; boundary="Oc9cVVUgo9APkWUsMdTAQNCaYvWqI8UzP"

--Oc9cVVUgo9APkWUsMdTAQNCaYvWqI8UzP
Content-Type: multipart/mixed;
 boundary="------------08BF5947A7AA52B4DA0B3F70"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------08BF5947A7AA52B4DA0B3F70
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Wednesday 27th November 2019
Time: 11:30 CET (10:30 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2019-11-27>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, dazo, lev, mattock, ordex and syzzer participated in this meeting.

---

The Windows 10 ARM64 laptop seems to now stay connected reliably.
Mattock will wrap up the firewalls for it and create users for those who
need to access it, then the task is done.

---

Mattock will test an OpenVPN executable with wintun support with the
OpenVPN Windows test scripts:

<https://github.com/OpenVPN/openvpn-windows-test>

It was agreed that integrating these scripts with Buildbot is a good
goal. So far mattock has ran these scripts at release time only.

---

Noted that the conversion of the OpenVPN 2 man-page to RST format is
best done at 2.5 beta time, because some manual changes are necessary
after the automatic conversion process.

--

Full chatlog attached


--------------08BF5947A7AA52B4DA0B3F70
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2019-11-27.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2019-11-27.txt"

(12:26:27) mattock: hello
(12:27:08) cron2: meow
(12:30:01) mattock: I have 30 mins today btw
(12:30:13) mattock: who do we have here besides cron2?
(12:30:18) ***syzzer present
(12:30:22) mattock: hi!
(12:30:27) syzzer: hello all :)
(12:31:44) lev__: hello
(12:31:50) mattock: hi lev!
(12:33:40) mattock: let's start this thing
(12:33:46) cron2: wooosh
(12:34:06) mattock: https://community.openvpn.net/openvpn/wiki/Topics-201=
9-11-27
(12:34:08) vpnHelper: Title: Topics-2019-11-27 =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)
(12:34:46) mattock: quick arm64 update
(12:35:03) mattock: connection to it "seems stable", as in: "windows upda=
te and reboots have not been able to kill it"
(12:35:10) mattock: nor has the thing completely shut down (yet)
(12:35:16) cron2: nice
(12:35:21) lev__: gutt
(12:35:56) mattock: firewall rules to isolate it from the rest of my netw=
ork are in place, _but_ don't yet work as expected (-> need debugging)
(12:36:11) mattock: then its just about creating user accounts for those =
who need it (lev primarily)
(12:36:36) mattock: next topic
(12:36:37) mattock: :)
(12:37:52) lev__: wintun!
(12:38:07) ***lev__ looks around
(12:38:16) ***syzzer hides
(12:38:24) cron2: haha :)
(12:38:30) syzzer: Didn't find time yet...
(12:40:02) lev__: yeah that one is most invasive, touches event handling =
in OpenVPN
(12:41:00) syzzer: anyone actually *testing* that commit would be very we=
lcome btw
(12:41:24) syzzer: I can do stare-at-code, but don't expect to find time =
to perform any decent testing
(12:44:03) cron2: mattock1: you have this windows testing framework...
(12:44:13) cron2: kind of t_client tests for windows
(12:44:26) lev__: it probably makes sense to test the whole thing, includ=
ing interactive service support in follow-up commits. The signed installe=
r is here http://staging.openvpn.net/openvpn2/
(12:44:50) cron2: can we hook this into the buildbot repo, so we can push=
 stuff at it and see if it explodes? With configs for "--dev-type tap6" a=
nd "wintun"?
(12:44:51) ***dazo is here ... almost forgot again :-$
(12:45:19) mattock: yes I do have Powershell-based Windows smoke-testing
(12:45:40) lev__: sounds like a plan
(12:45:45) mattock: basically it can test openvpn.exe (directly), openvpn=
-gui and even openvpnservice
(12:45:56) mattock: I do run it prior to doing releases
(12:46:34) mattock: if somebody can give an openvpn.exe plus libs I can r=
un some basic tests
(12:46:59) ***lev__ raises hand
(12:47:02) mattock: https://github.com/OpenVPN/openvpn-windows-test
(12:47:03) vpnHelper: Title: GitHub - OpenVPN/openvpn-windows-test: Power=
shells scripts for automating testing of OpenVPN on Windows (at github.co=
m)
(12:47:34) mattock: I believe openvpn-gui nowadays supports --disconnect =
which that PS script does not yet use (but would be nice if it did)
(12:47:36) syzzer: cool
(12:47:44) lev__: or you could just install the client from the link abov=
e
(12:47:51) mattock: that works as well
(12:48:37) lev__: BTW, GUI now supports development with Visual Studio - =
Selva has merged my PR recently
(12:48:57) mattock: yep
(12:49:03) lev__: we are making msvc dev great again
(12:49:08) cron2: yep (thanks to Selva, in absence :) )
(12:49:19) cron2: lots of PRs that "just happened" without me having to d=
o anything
(12:49:34) ordex: hi
(12:49:45) lev__: bongiorno
(12:50:03) mattock: hi
(12:50:31) mattock: ok, move on?
(12:50:33) mattock: I have 10 minutes
(12:51:21) cron2: mattock1: can you hook this smoke-framework into buildb=
ot?
(12:51:35) syzzer: sure, what's next?
(12:51:50) mattock: cron2: I probably could
(12:52:05) mattock: not sure what kind of mess that would end up as, but =
it's a good goal
(12:52:48) mattock: I primarily connect to the t_client servers with it a=
nyways...
(12:53:19) ***cron2 puts that on mattocks1 TODO shortlist :))
(12:53:19) mattock: if buildbot is easily able to run Powershell scripts =
on a Windows buildslave then I don't see any major issues
(12:53:24) mattock: :)
(12:53:27) cron2: dazo: how's the manpage coming along?
(12:53:34) cron2: ordex: how's the reviews coming along?
(12:53:52) cron2: plaisthos: what about Selva's comments regarding "gramm=
ar and language" updates to the TLS patches?
(12:54:19) cron2: (please no questions "how's merging of ACKed patches co=
ming along" :) )
(12:54:56) ordex: cron2: I thought it was easier :D implementing a couple=
 of basic tests to ensure I understood it for real
(12:55:13) ordex: will try to see if there are patches that can be merged=
 as they are, without requiring the rest of the code to come along in one=
 go
(12:56:16) cron2: thanks
(12:56:20) cron2: (makes sense)
(12:56:25) dazo: cron2: manpage ... we decided to postpone that until we'=
re about to publish the beta release or so ... The automation tools we fo=
und to convert *roff to .rst does a reasonable job, but there is some edi=
ting needed
(12:57:03) dazo: I've also started to see if there are some possibilities=
 to
(12:57:15) cron2: dazo: did we? I missed that memo, it seems :-) - ok. So=
 we can merge man page fixes "as is" for now.
(12:57:34) cron2: (I found a few trac tickets regarding man page fixes th=
at I bounced your way "because you're on it anyway")
(12:57:44) dazo: ... extend rst2man to add some extended options support =
we use in OpenVPN which is not that standard
(12:57:54) cron2: ah
(12:57:58) cron2: what language is that in?
(12:58:01) dazo: Python
(12:58:16) cron2: mattock likes that :)
(12:58:19) dazo: hehe
(12:58:57) dazo: There's not that many option parses who handle --option =
ARG1 ARG2 OPTIONAL_ARG3 ... this seems to be an OpenVPN speciality
(12:59:31) dazo: The man page rendering isn't terrible, it is just a bit =
less consistent with --option ARG
(12:59:46) cron2: "why are people opening installer issues against openvp=
n-gui"...?
(13:00:12) dazo: (where the latter makes ARG underlined, while ARG1 ARG2 =
OPTIONAL_ARG3 is not)
(13:01:20) dazo: But I'll propose a few alternatives once we're getting c=
loser to this
(13:02:03) cron2: ic
(13:02:05) mattock: ok I will check out now - can follow what is happenin=
g here but don't expect to get a response quickly :)
(13:03:40) cron2: https://github.com/orgs/OpenVPN/people
(13:03:41) vpnHelper: Title: People =C2=B7 OpenVPN Inc =C2=B7 GitHub (at =
github.com)
(13:03:46) cron2: this list is a bit weird
(13:08:15) syzzer: I'm checking out too - need to grab lunch and head ove=
r to external meeting
(13:16:05) cron2: seems nobody wants to say anything anymore
(13:16:08) cron2: enjoy :)
(13:16:26) cron2: (I am somewhat distracted by datacenter reorganizations=
=2E..)
(13:17:39) dazo: enjoy ... everything :-P
(13:17:57) cron2: yeah

--------------08BF5947A7AA52B4DA0B3F70--

--Oc9cVVUgo9APkWUsMdTAQNCaYvWqI8UzP--

--1X81WmGKB2VSF56d9vVMF0D53bYiqpOx2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAl3ewA0ACgkQKVhNn0CG
RXgLTAf5AcWxvy4F/48UtF5dz+xW9MLWD3tSWW4HwKVC87UpySiYnKywb3uCpxb0
xUX1xXMiQZYin8iW4N8knOnKcJnPZc7gmYk8UE+x+E3Q8b+Y+gGZ7NgseUyRYtHZ
hB197+bURwzrQ57LslRrn1R0uQHmlB8k5HttVfvsIuh+GBbrhvdGxnWfwdZA0gRU
6xAJ4aOgBfZ+by52NZRmaM5oPPNs4vmgwiCdDf2VwLVrFWBKx8nyw/+KmeZhpDD2
c9LTjm+eYlK49aGtwrO2ZhsMoAoHhSEfkoeBnbTnafCXeP7fiwrbc0ty/r0vrU0/
nov+xGyMP0IPjw4d1scEyydrjDMDcw==
=nxZL
-----END PGP SIGNATURE-----

--1X81WmGKB2VSF56d9vVMF0D53bYiqpOx2--

