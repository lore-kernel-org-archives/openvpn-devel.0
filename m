Message-ID: <4CF8E76C.2000107@...515...>
Date: Fri, 03 Dec 2010 14:49:48 +0200
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070204050204070906080704"
Subject: [Openvpn-devel] Summary of the IRC meeting (2nd Dec 2010)
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
--------------070204050204070906080704
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the previous community meeting.

---

COMMUNITY MEETING

Place: #openvpn-devel on irc.freenode.net
Date: Thursday, 2nd Dec 2010
Time: 18:00 UTC

Planned meeting topics for this meeting were on this page:

<https://community.openvpn.net/openvpn/wiki/Topics-2010-12-02>

Next meeting will be announced in advance, but will be on the same
weekday and at the same time. Your local meeting time is easy to check
from services such as

<http://www.timeanddate.com/world clock>

or with

$ date -u


SUMMARY

Andj, blaisegassend, common, cron2, dazo, ecrist, jamesyonan and mattock
were present in this meeting.

--

Discussed 2.2-beta5 release briefly. Release is ready and will appear on
openvpn.net very soon, hopefully today.

--

Discussed the "Floating TLS" patch:

<http://thread.gmane.org/gmane.network.openvpn.devel/4106>

This had been discussed briefly in an earlier meeting:

<http://thread.gmane.org/gmane.network.openvpn.devel/4189>

After a long discussion agreed that the current approach blaisegassend
has taken is a good one and that the floating-tls feature does not
weaken the security of OpenVPN or break compatibility with
non-floating-tls clients. However, as all implementation details were
not agreed upon, it was decided to continue the discussion on the
openvpn-devel mailing list. Dazo promised to send email with further
details.

--

Discussed enabling --enable-password-save option by default on Windows
builds; this topic has been discussed in an earlier meeting:

<http://article.gmane.org/gmane.network.openvpn.devel/3927>

That discussion continued on the openvpn-user mailing lists:

<http://thread.gmane.org/gmane.network.openvpn.user/30958>

Agreed that it's technically impossible to prevent clients from saving
their passwords, so having this feature disabled is just hurting our
users who depend on this feature. Decided to enable this feature on the
2.2-rc release build.

--

Discussed 2.2 release plans. Currently the plan is to

- Release 2.2-beta5 now
- Release 2.2-rc during Christmas holidays (~25th Dec)
- Release 2.2 (FINAL) in January

Agreed that this plan is doable.

--

Discussed modularization of the SSL layer. This work has been started by
andj who has created an abstraction layer between the SSL provider and
OpenVPN. Currently his abstraction layer works for OpenSSL and PolarSSL.
   Some other SSL providers, such as NSS, may be more difficult to
integrate cleanly, but we need not support them. Being able to switch
between SSL providers benefits those who need FIPS-certified solutions
and users of embedded systems where good performance with minimal
footprint is a high priority.

Agreed to postpone further discussion until January, when andj is ready
to release his patches to public.

--

Discussed milestone dates for OpenVPN 2.3. Current goal is to release
first 2.3-beta in March 2010, and to make the final release in August 2010.

---

Full chatlog as an attachment

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

--------------070204050204070906080704
Content-Type: text/plain; charset="utf-8";
 name=openvpn_irc_meeting_chatlog_2010-12-02.txt
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="openvpn_irc_meeting_chatlog_2010-12-02.txt"

(20:01:45) mattock: okidoki, one minute past already
(20:01:58) mattock: everybody set?
(20:03:44) dazo: I am ... (even though I'll be working in parallel ... dead=
line for a new release approaching at work)
(20:04:04) ***cron2 sits
(20:05:53) mattock: so, topic list is here: https://community.openvpn.net/o=
penvpn/wiki/Topics-2010-12-02
(20:05:55) vpnHelper: Title: Topics-2010-12-02 =EF=BF=BD=EF=BF=BD=EF=BF=BD =
OpenVPN Community (at community.openvpn.net)
(20:06:26) mattock: so 2.2-beta5 release...
(20:06:59) mattock: the download page has been updated already, it's just w=
aiting to be pushed to production
(20:07:10) cron2: cool
(20:07:47) blaisegassend [~blaise@...1437...] =EF=BF=BD=EF=BF=BD entrato ne=
l canale.
(20:08:15) mattock: Frank (our web guy) has not yet responded to me, but I'=
m pretty sure the 2.2-beta5 release will go live later today, or tomorrow e=
vening (UTC)
(20:08:22) mattock: hi blaisegassend!
(20:08:44) mattock: perhaps we should discuss floating-tls patch for a whil=
e? blaise wrote it
(20:08:55) mattock: jamesyonan: are you there?
(20:08:58) blaisegassend: Hi. At Samuli's suggestion I dropped by to discus=
s the floating tls patch.
(20:09:07) mattock: samuli =3D me
(20:09:08) jamesyonan: hi guys
(20:09:20) mattock: hi jamesyonan! good thing you're available!
(20:09:21) ***ecrist waves
(20:09:30) dazo: blaisegassend: we're gonna add your patch the agenda this =
week to then
(20:09:44) blaisegassend: OK
(20:09:46) mattock: I suggest discussing it right now... ok for everybody?
(20:09:53) blaisegassend: Works for me.
(20:10:12) mattock: the patch in question is this: http://thread.gmane.org/=
gmane.network.openvpn.devel/4106
(20:10:13) vpnHelper: Title: Gmane Loom (at thread.gmane.org)
(20:10:28) mattock: we discussed it briefly in last community meeting: http=
://thread.gmane.org/gmane.network.openvpn.devel/4189=20
(20:10:30) vpnHelper: Title: Gmane Loom (at thread.gmane.org)
(20:10:50) mattock: so, the issue was that we were not sure what security i=
mplications it would have
(20:11:02) mattock: besides that sounded like a neat and very useful feature
(20:11:05) dazo: I've just sent a reply to his mail
(20:11:12) dazo: I can pastebin it now
(20:11:23) mattock: dazo: that would be great
(20:11:58) dazo: http://openvpn.pastebin.ca/2008769
(20:12:30) Essobi: So I verified the certs I'm using work on an unmodified =
OpenVPN beta3...
(20:13:11) Essobi: I'm trying to track down why SSL_CTX_user_certificate_ch=
ain_file is bombing now.  I suspect it's using a non-fips cipher/hash somew=
here.
(20:13:19) blaisegassend: For the question of compiling in or not by defaul=
t, I don't think this adds any security holes if you do not enable floating=
-tls.
(20:13:32) ecrist: Essobi: meeting in progress.
(20:13:40) dazo: Essobi: could that wait a little bit ... we can add it to =
the meeting agenda in the end
(20:13:59) Essobi: ecrist: Roger that.. Just commenting on what I'm going t=
hrough here.
(20:14:06) cron2: blaisegassend: are openvpn binaries with and without that=
 patch still compatible?
(20:14:09) mattock: essobi: no problem
(20:14:32) blaisegassend: If you don't set the floating-tls option, openvpn=
 behaves exactly as it would without the option.
(20:14:53) cron2: yeah, but what if I wanted to connect with an unmodified =
client to a server that has the option active (or vice versa)?
(20:15:13) blaisegassend: A client that is not using floating tls can conne=
ct to a server that has it enabled.
(20:15:27) blaisegassend: I have added an opcode that is used by floating t=
ls connections.
(20:15:28) cron2: ok, protocol stays compatible
(20:15:42) blaisegassend: If you don't use that opcode, you are handled lik=
e a not-floating connection.
(20:15:52) jamesyonan: how does this interact with the already-existing TLS=
 session-id ?
(20:16:01) blaisegassend: We have been using it extensively in a mixed envi=
ronment without any problems.
(20:16:27) jamesyonan: so do these ID bytes get prepended to all packets (i=
.e. TLS control channel and data channel as well?)
(20:16:31) blaisegassend: I'm not actually familiar with what the session-i=
d is.
(20:16:39) blaisegassend: So this would be orthogonal to it.
(20:17:07) jamesyonan: basically OpenVPN, when running in TLS mode, has two=
 packet types -- control channel and data channel
(20:17:08) blaisegassend: The Id bytes get prepended to all packets. They g=
et used instead of the IP/port to identify the connection.
(20:18:33) blaisegassend: In floating TLS, both control and channel get wra=
pped in an extra layer that is used to direct the packet to the correct con=
nection. That prefx then gets stripped off and normal processing ensues.
(20:19:02) jamesyonan: so the IP address of the client can change without n=
eeding to trigger a new TLS renegotiation
(20:19:16) blaisegassend: Correct. No renegociation when the IP changes.
(20:20:05) dazo: I hate to be pessimistic ... but that sounds like an easy =
target for session hijacking=20
(20:20:17) jamesyonan: it would be nice if we could figure out a way to do =
this without adding anything to the protocol
(20:20:28) jamesyonan: dazo: no, not really an issue
(20:21:03) blaisegassend: If I remember correctly (but I want to double che=
ck this), the decision of whether to switch to the new IP/port takes place =
after the packet has been authenticated.
(20:21:19) blaisegassend: This should prevent session hijacking.
(20:21:30) jamesyonan: there's a sort of theorem in crypto that any secure =
protocol cannot be made insecure by adding additional layering
(20:21:55) jamesyonan: that's why SSL works over TCP (of course TCP is comp=
letely insecure)
(20:21:57) krzie ha abbandonato il canale (quit: Ping timeout: 272 seconds).
(20:22:09) blaisegassend: You can add denial of service problems by adding =
a layer though.
(20:22:23) jamesyonan: right -- but only DoS
(20:22:33) blaisegassend: Agree.
(20:22:47) jamesyonan: you can't create an active or passive attack by laye=
ring
(20:22:49) blaisegassend: I am open to suggestions on how to do this withou=
t adding to the protocol.
(20:23:19) blaisegassend: If there is an identifier that I could use instea=
d of the 64-bit identifier that I tack on in front of the packet, that woul=
d be a totally good way to go.
(20:23:47) blaisegassend: Not clear to me that it would be easy for a conne=
ction to say whether it is floating or not though.
(20:24:25) blaisegassend: Is this session-id in all packets? Is there a pla=
ce I could read about it?
(20:26:13) mattock: session_id.c and ssl.c seem to contain related code
(20:26:16) jamesyonan: the session-id right now is only in front of control=
 channel packets
(20:26:36) jamesyonan: it's kind of a tradeoff -- doing it without changing=
 the protocol will be more complicated
(20:26:57) jamesyonan: but changing the protocol is sort of a big deal
(20:27:14) krzie [~k@...1423.../community/support/krzee] =EF=BF=BD=EF=BF=BD=
 entrato nel canale.
(20:27:19) blaisegassend: If the session ID is not contained in data packet=
s, how can I determine which connection an incoming packet belongs to?
(20:27:49) blaisegassend: I don't currently see how to answer that question=
 without a change to the protocol.
(20:28:20) jamesyonan: so right now the session ID (on control channel pack=
ets) is 64 bits, but on data channel packets, to save space, there are only=
 a few bits that are used as an index into an array of known session IDs
(20:28:59) blaisegassend: OK, so it is possible to tell which connection a =
packet belongs to easily.
(20:30:31) blaisegassend: Is that index unique across all clients, or is it=
 per-client?
(20:31:10) jamesyonan: just thinking... no, I don't think there's enough in=
fo in a data channel packet to do it statelessly
(20:32:30) mattock: would the current approach blaisegassend has taken (=3D=
adding another layer) the best after all?
(20:32:48) blaisegassend: It is certainly the simplest I could find. :)
(20:33:01) mattock: especially if this feature is not used by a large perce=
ntage of users
(20:33:03) jamesyonan: if you wanted to leverage off of the control channel=
 session ID, you would probably need to add a new control channel message t=
hat says something like "session FOO is now available at 1.2.3.4"
(20:33:15) blaisegassend: But if the information is there in a data packet,=
 I think it would be well worth using it instead.
(20:33:46) jamesyonan: the advantage of doing it this way is that it would =
be more resistant to DoS
(20:33:47) ecrist: really, couldn't this all done with a perl one-liner?
(20:33:54) blaisegassend: I would much much rather not have any message nec=
essary when the session changes IP/port.
(20:34:05) cron2: ecrist: sure, but the line would be awfully long
(20:34:09) ecrist: :D
(20:34:10) mattock: :)
(20:34:31) blaisegassend: This way the networking stack can be completely d=
ecoupled from openvpn.
(20:34:42) blaisegassend: You just change your networking setup, and openvp=
n just works.
(20:35:13) blaisegassend: Otherwise the openvpn client needs to somehow kno=
w that it is sending from a different place than it previously was.
(20:35:14) dazo: as the prepending  approach works now, which (to my unders=
tanding) does extend the protocol without breaking backwards compatibility =
be a good approach, but that we think a bit more about that first ... like =
adding a 32bit (64bit?) field stating protocol features, and then one of th=
ese bits can indicate --tls-float, and then that session id blaisegassend n=
eeds would come encoded somewhere together with openvpn data?
(20:35:14) ecrist: it would be nice for multi-homed networks
(20:35:15) mattock: jamesyonan: so could the client send the "session FOO i=
s now at" message _after_ IP has changed?
(20:35:38) dazo: that sounds like a safer approach too
(20:35:43) cron2: before it changes would be somewhat tricky
(20:35:48) dazo: the server doesn't "guess" where the client moved
(20:35:57) jamesyonan: dazo: agreed -- some sort of capabilities handshake =
would be good
(20:35:59) dazo: cron2: :)
(20:36:02) cron2: but if we ever get to implement the "predict future" modu=
le, I'd like to buy a few lottery tickets :)
(20:36:29) mattock: me too, stupid question :)
(20:36:56) jamesyonan: the problem with the data channel session ID is that=
 it's very compressed and not unique across all clients
(20:38:00) blaisegassend: A bit overwhelmed by the various threads. What is=
 the DOS attack you have in mind? If you only accept the new IP/port after =
you have authenticated the packet, you should be good, no?
(20:38:28) jamesyonan: blaisegassend: there's no encryption at all on your =
ID prefix?
(20:38:47) blaisegassend: No encryption on the prefix.
(20:39:03) blaisegassend: (Just as there is no encryption on the IP/port)
(20:39:22) jamesyonan: right, that's fine
(20:40:00) Essobi: ecrist: Let me know when the meeting is over please. :)
(20:40:19) dazo: Essobi: bored already? ;-)
(20:40:50) jamesyonan: yes, in principle I think the ID prepending approach=
 is less complicated than the alternatives
(20:41:05) blaisegassend: I don't like approaches that need a control messa=
ge to switch because if that control message gets lost you delay when the s=
erver starts sending to the new IP/port.
(20:41:23) jamesyonan: agreed
(20:41:29) blaisegassend: This approach has worked well for me because it i=
s extremely simple. If a packet gets to the server, the server switches to =
the new location.
(20:41:50) blaisegassend: Unless there is a specific security problem that =
folks can find, I would rather keep this simplicity.
(20:41:56) dazo: but if we take that step to prepend ... let's consider a f=
eature handshake, to avoid needing later on to add yet another layer, which=
 might break something more
(20:42:17) dazo: easily
(20:42:23) blaisegassend: I don't want my videoconference to get interrupte=
d for a second because a few control packets got lost.
(20:42:43) jamesyonan: I agree that it's simple.  But it adds some extra ov=
erhead to the protocol.
(20:43:12) blaisegassend: Dazo: What do you mean by feature handshake?
(20:43:27) dazo: blaisegassend: see my msg @19:35:13
(20:43:27) Essobi: dazo: nosir
(20:45:05) blaisegassend: dazo: Are you referring to your adding a 32bit fi=
eld proposal? (I don't have the times displayed).
(20:45:19) ecrist: yes, he is
(20:45:21) dazo: blaisegassend: yes ... I sent a copy in PM
(20:45:28) blaisegassend: In that case, I would argue that the opcode is ef=
fectively doing exactly what you suggest.
(20:45:42) dazo: blaisegassend: how many bits is that opcode?
(20:45:55) jamesyonan: [ I've got a meeting in 10 minutes ]
(20:46:11) blaisegassend: If you see a packet with the FLOATING_TLS_OPCODE =
then you know it is a floating tls packet.
(20:46:43) mattock: jamesyonan: a quick question: did you enable --enable-p=
assword-save on the Windows build for 2.2-beta5?
(20:46:54) mattock: I can't remember if I mentioned about that to you...
(20:46:56) dazo: blaisegassend: yeah, but my point is that we want to make =
sure we can extend the protocol more easily without breaking different clie=
nts protocol support
(20:47:05) jamesyonan: mattock -- no I didn't
(20:47:07) mattock: ok
(20:47:39) mattock: jamesyonan: what's your final take on current floating-=
tls implementation?
(20:47:45) jamesyonan: mattock: there's a setting for that in install-win32=
/settings.in
(20:47:50) jamesyonan: but I would need to rebuild
(20:48:17) ***dazo votes for *not* rebuilding beta5 ... rather do that for =
the RC release
(20:48:23) mattock: +1
(20:48:35) cron2: huh, how did we jump to beta5
(20:48:48) dazo: cron2: mattock diverted it :)
(20:48:54) mattock: cron2: our release pace was too slow for our developmen=
t pace
(20:49:02) cron2: ah
(20:49:10) cron2: mattock: yes, I noticed that
(20:49:25) jamesyonan: I think floating-tls is reasonable if it's disabled =
by default and if it's backward compatible from a protocol perspective
(20:49:52) blaisegassend: By disabled by default you mean not compiled in, =
correct?
(20:50:07) jamesyonan: yes
(20:50:17) blaisegassend: That sounds reasonable.
(20:50:51) blaisegassend: Just out of curiosity, the idea here is to preven=
t code bloat for the default configuration?
(20:51:18) mattock: yes, and also to prevent code bloat for embedded system=
s=20
(20:51:23) dazo: I would like to have a broader discussion about opcode/fea=
ture set indication in the protocol layer before going for an inclusion
(20:51:44) mattock: dazo: you mean like "future proofing" this patch?
(20:51:52) dazo: mattock: yes
(20:52:02) mattock: sounds reasonable to me
(20:52:05) dazo: and to make sure we can extend the protocol more easily in=
 the future
(20:52:29) blaisegassend: It seems to me that the feature set approach make=
s more of a break to the protocol now.
(20:54:02) dazo: it completely possible that I've misunderstood something .=
.. but for me prepending this session ID you use (instead of IP/port) befor=
e the real OpenVPN packets, right?
(20:54:17) blaisegassend: But I'm not sure I have a clear enough picture of=
 your suggestion.
(20:54:44) blaisegassend: Each openvpn packet starts with an opcode. I adde=
d an opcode that is used by floating TLS packets.
(20:55:00) blaisegassend: If a non floating-tls client sees a floating-tls =
packet it will ignore it because it does not know that opcode.
(20:55:16) jamesyonan: re: protocol capabilities handshake, look at key_met=
hod_2_(read|write) in ssl.c
(20:55:31) jamesyonan: this is the place where stuff like that would be imp=
lemented
(20:55:45) dazo: blaisegassend: aha!  Then I catch better
(20:55:53) ***dazo looks at the code
(20:56:02) jamesyonan: the protocol is already designed so that certain cha=
nges can be made here without breaking backward compatibility
(20:57:02) dazo: that's my misunderstanding then ... I was not aware of tha=
t one
(20:57:06) blaisegassend: Would these capabilities show up in a data packet?
(20:57:21) jamesyonan: no, this is the control channel
(20:57:33) blaisegassend: If they don't then I still need something to allo=
w me to determine if a packet is a floating-tls packet, and if it is what t=
he session-id is.
(20:57:43) blaisegassend: An extra opcode seems very natural for that.
(20:57:56) dazo: blaisegassend: indeed
(20:58:05) dazo: jamesyonan: how big is the current OPCODE field?
(20:58:10) dazo: blaisegassend: ^
(20:58:28) dazo: 8 bit?
(20:58:38) jamesyonan: but keep in mind that this is for per-session negoti=
ation, not per-packet
(20:58:41) blaisegassend: Currently the opcode is 6 bits, if I recall, but =
let me double check.
(20:58:49) jamesyonan: I gotta run now
(20:59:02) dazo: jamesyonan: c'ya! Great you could join today!
(20:59:08) blaisegassend: dazo: you sound more in favor of the approach now.
(20:59:15) blaisegassend: jamesyonan: thanks for the discussion.
(20:59:21) mattock: bye jamesyonan!
(20:59:52) dazo: blaisegassend: As long as we're able to extend the protoco=
l without breaking it after your approach
(21:00:26) roentgen [~arthur@...1423.../community/support/roentgen] =EF=BF=
=BD=EF=BF=BD entrato nel canale.
(21:00:34) blaisegassend: I think it would be just as easy to extend the pr=
otocol after the floating-tls patch as before.
(21:00:37) dazo: blaisegassend: but I would like to avoid spending an OPCOD=
E for only this feature .... if it would be possible to indicate the --tls-=
float flag in a feature register which is bigger, we won't limit the protoc=
ol so easily
(21:00:50) dazo: especially if the OPCODE is just 6 bits
(21:02:08) blaisegassend: Just checked. Opcode is 5 bits.
(21:02:24) dazo: that's even "worse" :)
(21:02:26) blaisegassend: Currently only 8 opcodes are used.
(21:02:55) dazo: yeah, but imagine we're having bigger plans for OpenVPN3 .=
.. which will be more modular, and might add a lot of more features
(21:03:14) blaisegassend: Most features you can do just fine without opcode=
s.
(21:03:30) dazo: it's not a requirement to keep it protocol compatible with=
 2.x ... but if that's doable, I think that's better
(21:04:10) blaisegassend: This is a good candidate for an extra opcode beca=
use you want to encapsulate all traffic to/from a client with a session ID.
(21:04:48) dazo: so you send TLS_FLOAT_OPCODE | session ID | openvpn packets
(21:04:57) blaisegassend: Exactly.
(21:05:02) dazo: or NORMAL_OPCODE | openvpn packets
(21:05:08) blaisegassend: Yup.
(21:05:55) cron2: sounds like a nice hack to me :-) (not that i know anythi=
ng about the SSL/TLS stuff)
(21:05:59) blaisegassend: By having floating-tls at this high level, nothin=
g else in the code needs to be aware of it.
(21:06:01) dazo: yeah, but that's why I was initially thinking:  V2_PROTO_O=
PCODE | feature_register (tls-float=3D1)| session ID | openvpn packet
(21:06:42) dazo: and then other features could append their own packets, ba=
sed on the feature register ... and the parse would just extract the packet=
s accordingly
(21:06:50) dazo: do you follow my thoughts now?
(21:07:06) blaisegassend: Yes, but the layering seems backward to me.
(21:07:24) dazo: fair enough, I'm open for other possibilities
(21:07:35) blaisegassend: You are now saying that all opcode types will hav=
e this feature register.
(21:07:58) blaisegassend: Otherwise opcodes that don't have that feature ca=
n't work with floating-tls.
(21:08:27) blaisegassend: But if all opcodes have that feature_register, th=
en it should really appear before the opcode.
(21:08:27) dazo: yes, in the case the opcode is V2_PROTO_OPCODE
(21:08:43) blaisegassend: So now in fact effectively extended what an opcod=
e is.
(21:08:57) dazo: yes
(21:09:41) blaisegassend: I'm going to have to take off here soon.
(21:09:44) dazo: but, to make sure it is backwards compatible ... using a V=
2_PROTO_OPCODE, to make sure we don't break the protocol
(21:10:05) mattock: can we reach an agreement on this today? or shall we co=
ntinue discussion on the mailing list?
(21:10:23) blaisegassend: If you use a V2_PROTO_OPCODE, you are going to br=
eak the protocol.
(21:10:36) blaisegassend: And it isn't clear to me which would be the right=
 V2 opcode to use.
(21:10:48) dazo: not in any other way how your TLS_FLOAT_OPCODE works
(21:11:26) blaisegassend: It might make sense to move this to the mailing l=
ist.
(21:11:29) mattock: I agree
(21:11:42) mattock: think about this for a while and allow other devs to pa=
rticipate
(21:11:55) mattock: dazo: could you send mail to -devel about this?
(21:12:10) blaisegassend: dazo: if you have a specific proposal, could you =
write it up briefly?
(21:12:13) mattock: with a summary of what we discussed today
(21:12:20) blaisegassend: (On the mailing list)
(21:12:21) dazo: mattock: I can ... it'll probably be in the weekend or so
(21:12:30) mattock: I don't think we're in a hurry
(21:12:34) dazo: blaisegassend: I'll combine my proposal
(21:12:45) mattock: excellent!
(21:12:49) mattock: (we can move on) :)
(21:12:57) blaisegassend: Thanks for the discussion folks.
(21:13:03) dazo: blaisegassend: thank you too :)
(21:13:16) mattock: blaisegassend: great that you could discuss this with u=
s!
(21:13:29) blaisegassend ha abbandonato il canale (quit: Quit: Leaving).
(21:13:29) mattock: I hope we'll be seeing you here in the future!
(21:13:53) mattock: ok, so ecrist suggested we discuss --enable-password-sa=
ve on windows builds
(21:14:18) mattock: I believe we decided to include that feature on Windows=
 builds by default... but current 2.2-beta5 builds are still lacking it
(21:14:36) dazo: I'm not too much in favour of that, tbh ... not until we c=
an forcefully disable it from the server
(21:15:15) cron2: people use it, and will not use our builds if we do not p=
rovide it, so this would reduce testing coverage
(21:15:23) cron2: I think we've been through this before...
(21:15:29) dazo: we have
(21:15:46) mattock: I'll try to find the meeting where this was discussed...
(21:16:14) mattock: ok, here: http://article.gmane.org/gmane.network.openvp=
n.devel/3927/match=3Denable+password+save
(21:16:17) vpnHelper: Title: Gmane -- Mail To News And Back Again (at artic=
le.gmane.org)
(21:16:25) mattock: there's a typo, though... "disabled", not "enabled"
(21:17:09) mattock: discussion starts at 21:06:49
(21:19:23) dazo: probably need to see to check up the reactions on the ML
(21:20:31) mattock: let me know if you find a link
(21:22:29) mattock: ok, here they are: http://search.gmane.org/?query=3DTur=
ning+--enable-password-save+on+by+default+on+Windows+builds&author=3D&group=
=3Dgmane.network.openvpn.user&sort=3Ddate&DEFAULTOP=3Dand&xP=3Denable%09pas=
sword%09save&xFILTERS=3DGnetwork.openvpn.user---A
(21:23:04) mattock: or here in thread form: http://thread.gmane.org/gmane.n=
etwork.openvpn.user/30958/match=3Dturning+enable+password+save+default+wind=
ows+builds
(21:23:05) vpnHelper: Title: Gmane Loom (at thread.gmane.org)
(21:24:51) dazo: http://thread.gmane.org/gmane.network.openvpn.user/30958/f=
ocus=3D30974
(21:24:53) vpnHelper: Title: Gmane Loom (at thread.gmane.org)
(21:25:02) dazo: that's one of the main threads
(21:25:05) ecrist: sorry, back
(21:26:05) cron2: I see open source religion at work :)
(21:26:11) cron2: some want it, others oppose it
(21:26:31) mattock: and Jason Haar gave the final comment and nobody dared =
oppose him :)
(21:26:32) dazo: yeah :)
(21:26:56) ***ecrist kind of agrees with him.
(21:26:57) mattock: I think Jason has very good points
(21:27:16) mattock: there really is nothing we can do to _prevent_ people f=
rom using --enable-password-save
(21:27:40) ecrist: all we're really doing is pissing people off by NOT havi=
ng it enabled.
(21:27:49) mattock: and really, the server can't detect if the password is =
typed or not... if the user is motivated to circumvent the protection
(21:28:09) dazo: nope, currently on windows it is "security by obscurity" .=
.. as it's just a rebuild to enable it
(21:28:43) mattock: so, next build (2.2-rc1) will enable it?
(21:28:47) dazo: well, the advantage of enabling it is that it might encour=
age someone to write a patch implementing a push statement for disabling it
(21:28:56) mattock: yep, good point
(21:29:15) cron2: of course the client would be free to ignore that option.=
..
(21:29:18) mattock: except that somebody could modify the openvpn client to=
 ignore the push statement :)
(21:29:19) dazo: lets try it ... I fear it can be noisy=20
(21:29:20) cron2: "open source" :)
(21:29:23) cron2: mattock: +1 :))
(21:29:26) mattock: +1
(21:29:27) mattock: :D
(21:29:41) mattock: ok, so we're in agreement
(21:29:47) mattock: next topic?
(21:29:49) dazo: heck, the client could even be compiled with the username =
and password
(21:29:54) roentgen ha abbandonato il canale (quit: Ping timeout: 260 secon=
ds).
(21:29:56) mattock: yeah, true
(21:30:02) mattock: nasty
(21:30:02) dazo: release plan for 2.2?
(21:30:07) mattock: sounds good
(21:30:17) mattock: 2.2-beta5 will be out probably tomorrow
(21:30:22) mattock: 2.2-rc1?
(21:30:25) dazo: I'm imagining running 2.2-beta5 until Christmas
(21:30:25) mattock: when?
(21:30:30) cron2: very good
(21:31:02) dazo: if nothing happens at all ... I'm wondering if we should r=
epack + compile beta5 as it is to 2.2-rc (without number)
(21:31:16) dazo: I don't see the point of it, other than the visual effect
(21:31:45) dazo: and then if no complaints ... we're releasing 2.2 within f=
irst 2 weeks of January
(21:32:05) mattock: hmm, interesting approach... but makes sense
(21:32:28) mattock: one would assume something changes between versions, bu=
t I guess that's not mandatory
(21:32:30) dazo: As I see it, we don't have much new features in 2.2 which =
might break things
(21:32:51) mattock: I'm sure I find a Windows-related bug we need to fix :)
(21:32:55) dazo: and if we don't have any fixes for some time ... it's as s=
table as we can make it
(21:32:57) dazo: heh
(21:32:58) dazo: true
(21:33:14) ecrist: no big changes in 2.2-beta5 then?
(21:33:14) ecrist: I'd still *really* like to see at least one RC
(21:33:20) dazo: or else, we're back in the track of 2.1_rc15 ... which was=
 "stable" for almost a year
(21:33:22) ***cron2 would *really* like to see the test framework in use...
(21:33:45) mattock: mattock would like to see Windows build system fully op=
erational :)
(21:34:47) dazo: ecrist: yeah, but if there's no complaints to beta5 ... we=
're renaming it to RC ... as it there's nothing to fix yet ... or else we m=
ight wait until march or april before somebody finds something, that would =
rather be a reasonable 2.2.1 release in that case
(21:35:08) mattock: dazo: I agree there's no point in waiting just for the =
sake of waiting
(21:35:28) mattock: I'm sure people will find bugs eventually, but we need =
to push stuff out as fast as possible (without breaking things badly)
(21:35:37) ecrist: why not just release it today as an RC, then?
(21:35:38) dazo: yupp!
(21:35:52) dazo: because we added a couple of features
(21:35:58) ecrist: ah, ok
(21:36:06) dazo: (SOCKS auth + TAP on Solaris)
(21:36:16) mattock: Adding support for SOCKS plain text authentication
(21:36:16) mattock: Add HTTP/1.1 Host header
(21:36:16) mattock: TAP support on Solaris
(21:36:16) mattock: "topology subnet" made to work on Solaris
(21:36:16) mattock: Lots of bugfixes, see Changelog for details
(21:36:31) mattock: ecrist: I think we followed your suggestion ;)
(21:36:36) mattock: by rolling out another beta
(21:36:38) dazo: we did :)
(21:36:40) ecrist: ah, ok
(21:37:01) dazo: ecrist: make up your mind please!  We're jumping when tell=
 us!
(21:37:12) mattock: :)
(21:37:36) mattock: so the plan is this: release 2.2-beta5 now, 2.2-rc @Chr=
istmas, 2.2 (FINAL) on January
(21:37:58) cron2: +1
(21:37:58) mattock: I think that would work
(21:38:11) ecrist: dazo: I'm like a puffer fish, I get all excited easily.
(21:38:23) dazo: heh :)
(21:38:27) mattock: http://en.wikipedia.org/wiki/Puffer_fish
(21:38:29) vpnHelper: Title: Tetraodontidae - Wikipedia, the free encyclope=
dia (at en.wikipedia.org)
(21:38:43) mattock: ecrist: are you poisonous and delicious, too?
(21:39:05) dazo: his wife would probably know :-P
(21:39:09) mattock: +1
(21:39:33) mattock: ok, order in the court...
(21:39:55) mattock: what about the new features cron2 suggested?
(21:40:00) mattock: or talked about
(21:40:05) dazo: that was for 2.3
(21:40:08) dazo: my mistake
(21:40:10) mattock: ok
(21:40:28) dazo: no new features into 2.2, that's frozen now ... only bugfi=
xes
(21:40:32) mattock: good
(21:40:36) cron2: what he said
(21:40:49) ecrist: http://secure-computing.net/files/puffy.jpg
(21:41:07) mattock: next topic would be "Milestone dates for 2.3-beta"
(21:41:09) dazo: I suggested in a mail regarding modularising the SSL layer=
 (somebody has done that job, waiting for 2.2 to be released)
(21:41:30) mattock: I got a the OpenVPN puffy at the cover of my Thinkpad T=
42
(21:41:34) dazo: and I initially said that would be suitable for 2.4 ... an=
d cron2 to said "why not 2.3?"
(21:41:39) andj: hi
(21:41:44) andj: that was me
(21:41:46) andj: :)
(21:41:47) mattock: dazo: oh yes, I remember now
(21:42:04) mattock: andj: welcome!
(21:42:16) dazo: If we have a decent test environment available at that poi=
nt .... I'm in favour to push it into 2.3
(21:42:33) dazo: andj: cool!  thx a lot for your work ... even though we ha=
ven't seen it yet :)
(21:42:49) andj: mattock: thanks, I'll try to get the patches ready for a p=
review ASAP
(21:42:50) dazo: I say the Doxygen patch is mostly welcome almost immediate=
ly
(21:43:13) andj: yeah, that shouldn't change too much
(21:43:36) andj: I've been working on the patches for work, which was fun, =
nice to be able to release something to the community
(21:43:42) dazo: that's for sure for 2.3 ... and if the patches for SSL mod=
ules with minimum OpenSSL support is in place and have been tested and merg=
ed into the tree before we start 2.3-beta ... I'm all for that
(21:44:07) ecrist: I think Essobi still needed some pointers in regards to =
FIPS
(21:44:31) andj: anyway, I'll see if I can integrate some of my own tests i=
nto the new test framework
(21:44:57) andj: (Haven't played with that at all yet)
(21:44:59) dazo: andj: cool!
(21:45:20) dazo: andj: If you get the 2.2 tree around early January ... wil=
l that be enough time for you to massage the patches for inclusion for a 2.=
3-beta - say March-ish?
(21:45:23) cron2: andj: that would be very welcome.  it's somewhat bare-bon=
es yet - it works, but it can certainly be extended
(21:45:52) andj: anyway, the 2.2 work would be partially on my own time, an=
d partially on work time, so I'd have to see how busy things are then
(21:45:57) Essobi: ecrist: Can I start throwing some thoughts at the channe=
l?  Something is wonky in the ctx handed to SSL_CTX_set_cipher_list in ssl.=
c ~ line 1853.
(21:46:14) Essobi: Or wonky in how the FIPS module is handling it.
(21:46:25) Essobi: But I'll BRB
(21:46:26) ecrist: these are the folks that can help you.
(21:47:12) andj: But I'd much rather work towards a stable (2.2) target, th=
an a moving one, as we have now
(21:47:20) andj: So I'll leave that for januari
(21:47:39) dazo: mattock: so ... for 2.3 schedule .... I'm suggesting 2.3-b=
eta (late February/) early March .... with a complete release say late summ=
er - early August, perhaps?
(21:48:04) mattock: what will be in 2.3?
(21:48:12) mattock: IPv6?
(21:48:16) dazo: andj: The 2.2 branch will only get bugfixes .... and the g=
ap between beta3-5 is less than 30 patches, I believe
(21:48:29) dazo: mattock: IPv6 is definitely ... hopefully new Windows GUI?
(21:48:30) mattock: noticeably less, maybe 15
(21:48:45) mattock: new GUI should be no problem
(21:49:02) mattock: when I get Windows python build working=20
(21:49:08) dazo: mm
(21:50:28) mattock: dazo: what does "mm" mean? :)
(21:50:39) dazo: just like the sound
(21:50:44) dazo: (agree)
(21:50:49) mattock: ok, good
(21:51:33) mattock: I think 2.3 release schedule is doable
(21:51:47) mattock: especially as most features are already available
(21:51:59) dazo: yes, the joker is the new SSL modularisation
(21:52:23) andj: and you can't tell until you've seen the code
(21:52:37) dazo: :)
(21:52:40) mattock: let's not worry about that right now, then
(21:52:49) dazo: nope!
(21:52:49) cron2: mattock: any news about coverity?
(21:52:54) ecrist: do we have a list of developers somewhere, yet?
(21:53:02) dazo: probably not
(21:53:04) ecrist: i.e. who's active, recent commits or anything
(21:53:10) cron2: ecrist: don't know anything
(21:53:14) dazo: that's doable to extract from git
(21:53:24) mattock: cron2: no, no progress there (as usual)
(21:53:26) dazo: which timespan?  last year?  last 3 months?
(21:53:45) mattock: I think the changelogs for latest releases are a pretty=
 good indicator
(21:54:05) dazo: actually, the complete 2.2 release ChangeLog do have all d=
evelopers mentioned
(21:54:15) ecrist: just thinking in terms of when someone wants to know who=
 the 'developers' are
(21:54:44) mattock: I think using git for that is best... manually edited l=
ists tend to get outdated
(21:54:51) ecrist: right
(21:54:58) common: I'd be carefull with ssl modularisations
(21:55:00) mattock: and normal people can check the changelog
(21:55:18) ecrist: I'll probably post something at secure-computing.net I p=
arse out
(21:55:22) dazo: and the git log also have e-mail addresses to the authors
(21:55:27) mattock: however, we _could_ mention on the Wiki that "to see wh=
o's developing OpenVPN, check the changelog"
(21:55:28) common: the bridge code gets messy easily due to very different =
interfaces
(21:56:02) common: polarssl may be cheap, I think it got an api similar to =
openssl, but others, like nss, will give you serious headache
(21:56:02) ecrist: my reason for asking is because I want to make sure all =
the developers who want/need access to trac have it
(21:56:42) dazo: common: afaik, andj is using his changes implementing Pola=
riSSL in production ... so the basic stuff should work ... we need to make =
sure OpenSSL works as well, and with some ~3 months development before beta=
 kicks in, I think we should be able to tell
(21:56:50) roentgen [~arthur@...1423.../community/support/roentgen] =EF=BF=
=BD=EF=BF=BD entrato nel canale.
(21:57:01) common: and once you go for different ssls, people will ask for =
nss, as it is easier to get fips 140 with nss than with openssl
(21:57:17) dazo: common: if it's too unstable for 2.3, it'll be pulled out =
and put into 2.4
(21:57:20) common: and then you got three different ssl apis to maintain
(21:57:56) dazo: common: fair enough ... but we don't accept drop'n'run pat=
ches .... so we need to see that people maintain their contributions
(21:58:03) andj: I've tried to keep the backend api as close to the primiti=
ves as possible, and it works well for both polar and openssl
(21:58:17) dazo: ^^^ that is what calms me down
(21:58:45) common: if you want to see what can happen for multiple ssl back=
ends
(21:58:47) andj: but I have no idea how nss/gnutls/... hold up
(21:59:02) common: look at curl, openssl, nss, gnutls, polarssl
(21:59:48) ***dazo trusts andj has done his homework ... until otherwise pr=
oven when the patches arrives :)
(22:00:22) ***andj hopes he can live up to that
(22:00:30) andj: :)
(22:00:41) dazo: :)
(22:00:44) mattock: I agree we should wait for the patches before discussin=
g this further... and if polarssl and openssl work fine using an abstractio=
n layer, nobody can force us to access more messy code (e.g. for nss) into =
the codebase
(22:00:55) dazo: nope
(22:01:03) dazo: (=3D  I agree)
(22:01:06) mattock: we can say "we support these ssl providers: ..."
(22:01:22) mattock: and not these, because it would be difficult to impleme=
nt
(22:01:26) mattock: and error-prone
(22:01:31) andj: anyway, my priority for the moment is cleaning up the patc=
hes and PKCS #11 support for polar
(22:01:43) common: http://fedoraproject.org/wiki/FedoraCryptoConsolidation
(22:01:44) vpnHelper: Title: FedoraCryptoConsolidation - FedoraProject (at =
fedoraproject.org)
(22:02:03) andj: and getting some more tests in. I'll have a look at incorp=
orating them into the test framework
(22:02:10) dazo: andj: Alon Bar-Lev has done a lot of the PKCS#11 work in O=
penVPN ... so he might speak up
(22:03:23) andj: Thanks, I'm not planning on changing anything there, excep=
t for splitting out an OpenSSL and PolarSSL backend
(22:03:34) dazo: :)
(22:03:36) andj: So the basic code should stay the same
(22:04:16) dazo: yeah, he might have a look into that as well ... He is onl=
y active on the ML, so you'll hear from him there
(22:04:33) andj: It'll be a separate patch
(22:04:49) Essobi: Mkay.. So I verified the certs I generated with easy-rsa=
 work in beta3 compiled against the stock openssl I have installed.
(22:04:50) andj: so we can cross that bridge when we get there
(22:05:10) dazo: thx!
(22:05:23) dazo: Essobi: that sounds like good news!
(22:06:05) andj: Anyway, if there's no other questions about the patch set =
I'll go back to lurk mode
(22:06:18) dazo: do that :)  feel free to hang out here!
(22:06:38) dazo: andj: by the way, I sense Essobi might be an SSL resource =
as well ... :)
(22:06:49) andj: thanks for the good reception, I'll see how fast I can get=
 a preview out
(22:07:01) dazo: you're most welcome!
(22:07:18) mattock: andj: see you again!
(22:07:22) Essobi: Using the same config, with the OpenSSL FIPS module, it =
aborts loading at loading the certificate chain file..
(22:07:29) Essobi: http://pastebin.com/dm8bKvzM
(22:07:30) andj: I'm open to any suggestions, what I worked on isn't set in=
 stone, so let me know if there's any major problems
(22:07:47) Essobi: I assume you guys don't want pasting to the channel.. so=
me places consider it rude.
(22:07:48) dazo: andj: we will, when we see patches :)
(22:07:57) dazo: Essobi: that's right :)
(22:08:08) mattock: one more thing about the SSL abstraction layer... what =
are the primary reasons one would want to use a non-OpenSSL SSL implemetnat=
ion?
(22:08:12) mattock: FIPS compliance?
(22:08:14) mattock: performance?
(22:08:23) cron2: openssl code base is HUGE
(22:08:26) andj: embedded systems
(22:08:27) cron2: that's a problem for embedded
(22:08:34) common: footprint & maybe fips certification
(22:08:36) Essobi: mattock: federal security requirement
(22:08:37) andj: and security evaluations
(22:08:44) cron2: on a wr54gl, openssl 1.0 will fit about all available fla=
sh...
(22:08:47) dazo: mattock: OpenSSL can be messy to work with ... NSS is anot=
her reason for FIPS requirements
(22:08:52) andj: which is our game here
(22:09:06) mattock: ok, just wanted to check there are good reasons to do t=
his
(22:09:22) dazo: oh yeah, it is :)
(22:09:47) mattock: so lets just wait for andj's patches and take it from t=
here
(22:09:49) common: dazo: do you expect nss to be easier to work with?
(22:09:49) ***dazo need to do some real work, so he gets his payslip
(22:10:01) Essobi: Using the certified OpenSSL FIPS module gives the produc=
t FIPS compliance by proxy so long as it's the only thing doing crypto in t=
he code, and the libs are build to their spec.
(22:10:12) dazo: common: I dunno ... I've never done nss stuff, except from=
 a little bit on the user side
(22:10:44) Essobi: FIPS compliance is required for a lot US/Canadian State/=
Federal use.
(22:10:56) common: from my experience openssl is hard to beat from an api/d=
ocumentation perspective
(22:12:28) andj: the api is nice, but the code isn't easy to read (not that=
 I want to start a flame war here)
(22:12:30) Essobi: http://pastebin.com/Uu0GK3gT
(22:12:37) andj: which makes it hard to evaluate=20
(22:13:39) common: the documentation is a bitch too, but if once you unders=
tood it, it makes sense
(22:14:05) Essobi: also... 'make check' fails with openssl-fips in use.. It=
 would appear to be the exact same error.
(22:15:35) Essobi: Is there a way to tell if the cert_file in question is R=
SA vs DSA?
(22:15:41) mattock: any objections to ending the "official" portion of the =
meeting? we covered all topics already
(22:16:01) Essobi: mattock: Woops.. sorry, thought it was over.
(22:16:20) mattock: essobi: no problem, I think it has ended already :)
(22:16:47) mattock: no objections yet...
(22:16:58) mattock: I'll write meeting summary tomorrow and send it to -dev=
el

--------------070204050204070906080704--

