From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <604d3782-646c-4f12-b789-2ae9ebbae069@...515...>
Message-ID: <42e7467d-67b9-a6c3-6348-bb1d1e0ef21c@...515...>
Date: Wed, 15 Sep 2021 15:58:11 +0300
MIME-Version: 1.0
In-Reply-To: <604d3782-646c-4f12-b789-2ae9ebbae069@...515...>
Content-Type: multipart/mixed; boundary="------------0CABCBCC2D50BDC8FD0F451C"
Content-Language: en-US
Subject: [Openvpn-devel] Summary of the community meeting (15th September
 2021)
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
--------------0CABCBCC2D50BDC8FD0F451C
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 8bit


Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on libera.chat
Date: Wed 15th September 2021
Time: 14:00 CET (12:00 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2021-09-15>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, dazo, mattock, MaxF, ordex, plaisthos and rob0 participated in 
this meeting.

---

Plaisthos is preparing patches that drop support for the APIs that are 
deprecated in OpenSSL 3.0.

Agreed that the OpenSSL 3.0 patches should be master only, so only 2.6 
will have full OpenSSL 3.0 support with external key support and without 
compiler warnings. OpenVPN 2.4/2.5 would continue to work, but would 
have some missing features.

---

No news on "OpenVPN 2.4 to oldstable" transition, nor IPv6 for community.

---

Talked about the new buildbot. Mattock will spin up an EC2 buildmaster 
instance "somewhere" by Monday next week, if he does not have access to 
the "correct" place by then. The buildmaster instance can then be 
migrated to the "correct" place later.

Mattock will also implement the fixes to openvpn-build suggested by Lev:

<https://github.com/OpenVPN/openvpn-build/pull/226>

What remains is merging the above PR and mattock's openvpn-vagrant 
dockerized buildbot work:

<https://github.com/OpenVPN/openvpn-vagrant/pull/18>

-- 

Full chatlog attached


--------------0CABCBCC2D50BDC8FD0F451C
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2021-09-15.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2021-09-15.txt"

(15:03:38) mattock: hi!
(15:03:45) MaxF: hi!
(15:04:54) dazo: hey!
(15:05:04) rob0: I'm here.  You may start. ;)
(15:05:11) dazo: hehehe
(15:05:55) plaisthos: From my side
(15:06:21) plaisthos: I am preparing patches to no longer use the APIs th=
at are deprecated in OpenSSL 3.0
(15:06:36) plaisthos: that cosists of a few small patches and one that wi=
ll be very big
(15:07:05) cron2: do we expect openssl 3.0 to be a hard requirement soon?=

(15:07:39) plaisthos: to still support external keys we will need to impl=
ement a provider (replaces engines and RSA_method/EC_method) and that pro=
vider is a lot of a code, mostly boilerplate code to get all things setup=

(15:07:51) plaisthos: cron2: I expect Ubuntu 22.04 to ship with OpenSSL 3=
=2E0
(15:08:19) plaisthos: Current OpenVPN still compiles/works with OPenSSL 3=
=2E0 with the exception of extgernal key
(15:08:56) cron2: who (except the Android app) uses external key these da=
ys?
(15:10:18) plaisthos: Windows=20
(15:10:53) plaisthos: cryptoapicert uses the same mechanism
(15:11:13) dazo: cron2: I also expect Fedora 36 to upgrade to openssl 3.0=
 .... discussions already begun
(15:11:30) dazo: so in the timeline of 6-8 months, yes
(15:11:57) dazo: (sooner if we care about the Rawhide development version=
 - which moves forward constantly)
(15:12:44) cron2: oh, I thought cryptoapicert would use "something window=
s", and be not a problem
(15:13:14) cron2: how long is the support cycle for 1.1.1?  aka "how long=
 can we get away with just shipping windows binaries with 1.1.1"?
(15:13:23) plaisthos: yeah external-key bridges to management and cryptoa=
picert does the same for windows api
(15:13:36) plaisthos: cron2: 2023 or something like that
(15:14:00) plaisthos: but that is more a rethorical question as I will ha=
ve the patches for the external provider ready before that ;)
(15:14:35) cron2: understood.  I do wonder about our review/test/merge cy=
cle and these patches competing with DCO for attention - this is why I'm =
asking
(15:14:52) cron2: but maybe we can get Fox crypto folks interested again =
:-)
(15:16:17) plaisthos: But for a more pratical answer
(15:17:06) plaisthos: We can merge the OSSL 3.0 patches to master only, s=
o only 2.6 will have full OpenSSL 3.0 support with external key support a=
nd without compiler warnings and OpenVPN 2.4/2.5 just work with those kno=
wn caveats
(15:17:27) MaxF: > but maybe we can get Fox crypto folks interested again=

(15:17:38) MaxF: interested in dco for Linux or Windows?
(15:17:50) MaxF: or in OpenSSL?
(15:17:58) nariman [~nariman@...2624...] =C3=A8=
 entrato nella stanza.
(15:18:42) dazo: openssl, I'd say
(15:20:23) MaxF: hm, I don't think we'll be migrating OpenVPN-NL to OpenS=
SL anytime soon, but I can read the patches and test
(15:21:28) cron2: plaisthos: yep, let's see we can get 2.6 out before Ubu=
ntu 22.04 :-)
(15:21:34) dazo: I'm fine with the approach plaisthos suggests, openssl 3=
=2E0 only for master/2.6
(15:22:39) plaisthos: MaxF: do you guys have any insights if mbed TLS get=
s TLS 1.3 anytime soon?
(15:23:05) MaxF: don't know, sorry
(15:23:26) MaxF: maybe I can convince our customer to switch if not ;)
(15:24:46) plaisthos: yeah no problem
(15:24:53) plaisthos: or to wolfSSL *ducks*
(15:24:59) mattock: :)
(15:25:38) cron2: *howl*
(15:26:48) mattock: anything else on this topic?
(15:27:34) cron2 ha scelto come argomento: https://community.openvpn.net/=
openvpn/wiki/Topics-2021-09-15
(15:28:09) mattock: the topic being "2.5/2.6 sync up"
(15:28:19) cron2: nothing on 2.5
(15:28:25) rob0: well, no useful input from me, but I did get a good idea=
 for an April 1 announcement: OpenVPN now supports ROT 13
(15:28:40) cron2: ordex/plaisthos/I are working on the compat-mode patche=
s for 2.6
(15:28:48) cron2: rob0: double-ROT13, I hope?
(15:28:53) plaisthos: rob0: that would be actually quite easy now for me =
to implement ...
(15:29:09) plaisthos: since I am implementing a provider I can also offer=
 new crypto algorithms
(15:31:36) dazo: lets make it tripple-ROT13 for additional security then =
=2E... :-P
(15:32:11) plaisthos: ROT13-EDE?
(15:33:10) mattock: if it worked for Caesar it should work for us
(15:33:16) MaxF: we could apply it a random number of times
(15:33:33) dazo: :-D
(15:33:35) cron2: I hear things did not work out well for Caesar
(15:33:36) mattock: we're not even going after Gaul, like he did
(15:33:48) mattock: they did work out well, up until a certain point in t=
ime
(15:33:53) mattock: :D
(15:34:07) mattock: anyhow
(15:34:15) mattock: topic #2?
(15:34:22) mattock: which is probably "no progress there"
(15:34:30) mattock: like topic #3, which is "no progress there"
(15:34:33) mattock: meeting concluded? :P
(15:34:43) cron2: buildbot?
(15:34:48) cron2: this would be #4
(15:34:50) mattock: yes
(15:35:19) cron2: progress?
(15:35:34) mattock: so, the production instance in the wheels of bureaucr=
acy, _but_ if I don't have access to the "correct place" by next monday I=
'll just spin up an AWS instance "somewhere" and make it work in AWS
(15:35:51) mattock: then I can migrate it over to the correct place later=

(15:35:56) ***cron2 makes a note to ask on tuesday :)
(15:36:02) mattock: yeah, no problem
(15:36:20) mattock: Lev provided good feedback on the openvpn-build PR: h=
ttps://github.com/OpenVPN/openvpn-build/pull/226
(15:36:26) mattock: so I need to shuffle the build process around a bit
(15:36:33) cron2: progress!
(15:36:53) mattock: but openvpn-build will have all that's needed to buil=
d OpenVPN on Windows for Windows without the buildbot overhead
(15:37:03) mattock: and openvpn-vagrant "msibuilder" VM will support that=
 process
(15:37:10) cron2: nice
(15:37:20) mattock: well, it _does_ support that process already
(15:38:18) mattock: but that's all, I'll make the fixes suggested by Lev =
and then we should just merge my PRs in openvpn-vagrant and openvpn-build=

(15:39:18) mattock: I see dazo promised to do some Red Hat 8 testing last=
 week
(15:39:34) cron2: especially for build, this is basically "you and lev ar=
e happy", I think, as nobody else understands that stuff today
(15:39:50) mattock: and the changes are isolated from the rest of the stu=
ff
(15:39:55) cron2: dazo *did* the RH 8 testing, and ACKed the patch, which=
 was merged and such :-)
(15:40:01) mattock: so even if there's a gaping hole in there (unlikely) =
nothing would explode
(15:40:02) mattock: ok
(15:40:12) mattock: just tried to deflect attention somewhere lse :D
(15:40:13) mattock: else
(15:40:51) cron2: oh, interesting, new patch from ilya in patchwork (whic=
h did not make it into my mailbox), on windows/msvc building.  For you an=
d Lev__ :-)
(15:41:04) mattock: for Lev, I'd say
(15:41:12) mattock: he's the Visual Studio man
(15:41:25) mattock: I'm just a "run steps x,y,z on Windows" man
(15:41:28) mattock: :P
(15:44:21) mattock: anything else?
(15:45:14) ordex: here here !!
(15:45:17) mattock: hi!
(15:45:22) ordex: hi :)
(15:45:28) mattock: you still have time to raise your concerns and give y=
our updates!
(15:45:29) mattock: :)
(15:45:29) ordex: nothing else here except what cron2 said
(15:45:42) ordex: compat-mode is being crunched
(15:46:54) cron2: waiting for text on --cipher
(15:48:05) ordex: yap - plaisthos will you chime in? or don't care much?
(15:48:11) ordex: if not, I will spin another round
(15:48:25) plaisthos: I do not have that strong opinion
(15:48:54) plaisthos: also I am probably too familar with how all of that=
 stuff works, so I don't know what will be actually be helpful to a user
(15:52:28) ordex: makes sense
(15:52:29) ordex: okok
(15:52:31) mattock: I need to split in 3 minutes or so
(15:54:31) cron2: yeah, so do I
(15:54:38) mattock: ok let call this a meeting then
(15:54:47) cron2: I call this thing "a meeting!"
(15:54:56) dazo: +1

--------------0CABCBCC2D50BDC8FD0F451C--

