Message-ID: <4D021744.7010307@...515...>
Date: Fri, 10 Dec 2010 14:04:20 +0200
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010600090502050005040108"
Subject: [Openvpn-devel] Summary of the IRC meeting (9th Dec 2010)
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
--------------010600090502050005040108
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the previous community meeting.

---

COMMUNITY MEETING

Place: #openvpn-devel on irc.freenode.net
Date: Thursday, 9th Dec 2010
Time: 18:00 UTC

Planned meeting topics for this meeting were on this page:

<https://community.openvpn.net/openvpn/wiki/Topics-2010-12-09>

Next meeting will be announced in advance, but will be on the same
weekday and at the same time. Your local meeting time is easy to check
from services such as

<http://www.timeanddate.com/world clock>

or with

$ date -u


SUMMARY

Common, dazo, ecrist, essobi, jamesyonan, krzie and mattock
were present in this meeting.

--

Discussed common's "Use extv3 extensions such as subjectAltName as
common_name" patch which had not been ACKed:

<http://thread.gmane.org/gmane.network.openvpn.devel/4185>

Common fixed a few minor, stylistic issues with the patch.

In deeper analysis it was noted that this feature, or using an external
CA for OpenVPN certs in general, may be dangerous. Consider the
following scenario:

- An external root CA (e.g. Verisign) is used for OpenVPN certificates,
  with or without an internal sub-CA
- A certificate field such as subjectAltName contains an email address
  and is used as common_name in OpenVPN

Even if a sub-CA is included in the certificate signing chain, it's
likely that OpenVPN/OpenSSL will happily accept certificates signed
_only_ by the external root CA. So, a malicious person could connect to
the VPN by having a certificate with a faked email address signed by the
external CA.

This feature could be implemented more safely as a separate plugin using
the new v3 plug-in API, as that will provide full access to the X509
certificate object in C code. Dazo sent the second version of the v3
plug-in API to openvpn-devel mailing list today.

--

Discussed MacOSX keychain certificate support patch briefly:

<https://community.openvpn.net/openvpn/ticket/8>

This patch had failed to compile on latest OpenVPN versions. Krzie and
dazo are fixing this issue.

---

Full chatlog as an attachment

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


--------------010600090502050005040108
Content-Type: text/plain; charset="utf-8";
 name=openvpn_irc_meeting_chatlog_2010-12-09.txt
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="openvpn_irc_meeting_chatlog_2010-12-09.txt"

(20:03:01) mattock: meeting time?
(20:03:05) dazo: \o/
(20:03:18) ***dazo wonders where james went ....
(20:03:45) mattock: left 7 hours ago
(20:04:15) mattock: anyways... topic list here: https://community.openvpn.n=
et/openvpn/wiki/Topics-2010-12-09
(20:04:17) vpnHelper: Title: Topics-2010-12-09 =EF=BF=BD=EF=BF=BD=EF=BF=BD =
OpenVPN Community (at community.openvpn.net)
(20:04:20) mattock: "list" :)
(20:04:22) dazo: then I just remember him online in the morning :)
(20:04:43) mattock: common: are you present?
(20:05:03) common: yep
(20:05:12) common: community.openvpn.net is unreachable via v6 atm?
(20:05:42) mattock: could be, my ip6tables config is still incomplete
(20:05:50) dazo: mattock:  I'd like james' opinion on that patch as well
(20:06:08) mattock: if ipv6 access was working earlier, I can fix it in ~10=
 mins=20
(20:06:29) mattock: I'll mail james and fix the community ipv6 issue while =
waiting
(20:07:17) jamesyonan [~jamesyona@...1320...] =EF=BF=BD=EF=BF=BD entrato ne=
l canale.
(20:07:17) modalit=EF=BF=BD=EF=BF=BD (+o jamesyonan) da ChanServ
(20:07:20) common: 2607:f0d0:1000:1::76 is the last hop here
(20:08:22) dazo: jamesyonan:  we're having a short list today ... http://th=
read.gmane.org/gmane.network.openvpn.devel/4185/ ... the v2 patch from Dec =
1 is the interesting one
(20:08:23) vpnHelper: Title: Gmane Loom (at thread.gmane.org)
(20:09:01) mattock: jamesyonan: just sent you mail, please ignore it :)
(20:09:43) dazo: mattock:  we should quickly revisit the 2-3 last agendas, =
to be sure we haven't overlooked anything=20
(20:09:55) mattock: ok, I'll check them
(20:10:32) mattock: the last two topic pages:
(20:10:32) mattock: https://community.openvpn.net/openvpn/wiki/Topics-2010-=
12-02
(20:10:32) mattock: https://community.openvpn.net/openvpn/wiki/Topics-2010-=
11-25
(20:10:34) vpnHelper: Title: Topics-2010-12-02 =EF=BF=BD=EF=BF=BD=EF=BF=BD =
OpenVPN Community (at community.openvpn.net)
(20:10:35) vpnHelper: Title: Topics-2010-11-25 =EF=BF=BD=EF=BF=BD=EF=BF=BD =
OpenVPN Community (at community.openvpn.net)
(20:13:07) ***dazo sees he has forgotten to write an e-mail to the -devel l=
ist
(20:14:18) dazo: jamesyonan:  are you looking at the patch?  or waiting for=
 us to say something?
(20:14:30) jamesyonan: yeah, I'm looking at it now
(20:14:46) dazo: then I won't disturb mode :)
(20:16:14) dazo: I just spotted one thing there when looking at it now ....=
 the switch() in extract_x509_extension() does not have a default: target
(20:16:43) mattock: common: ip6tables is now letting in ipv6 traffic to por=
ts 80 and 443
(20:16:48) mattock: on community.openvpn.net
(20:17:02) dazo: wouldn't it be better to replace those empty GEN_*'s which=
 has a return false with a default:?
(20:17:51) dazo: another thing, the extensions is only freed on success, no=
t on failures
(20:18:14) dazo: (due to the switch() )
(20:19:48) dazo: common:  may I suggest that you have a  bool retval =3D fa=
lse;  and that you in the case GEN_EMAIL: target sets retval =3D true; and =
uses return retval at the end ... then remove all the other returns and rat=
her replace them with a break; statement instead .... does that make sense =
to you?
(20:20:37) dazo: (obviously, you need some more changes in the GEN_EMAIL: s=
ection, though)
(20:21:50) mattock: ...
(20:21:57) common: for default: I felt it was more clear if I left the othe=
r values in, so in case somebody wants an ip address, there are less changes
(20:22:30) dazo: yeah, but then again, what if you get an unknown value?  y=
ou're missing a catch-all scenario for error handling
(20:22:43) common: but, you are right, for certificates where the field is =
not email, this would leak mem currently
(20:23:13) common: if you have a second, let me improve what we got
(20:23:27) dazo: I got one more thing
(20:23:34) jamesyonan: we don't want want to leak mem, even in the case of =
exceptions
(20:23:46) dazo: +  if (strncmp("ext:",x509_username_field,4) =3D=3D 0)
(20:23:47) dazo: +    {
(20:23:47) dazo: +      if (!extract_x509_extension (ctx->current_cert, x50=
9_username_field+4, common_name, sizeof(common_name)))
(20:24:00) dazo: that last if ... do not have any error handling at all
(20:24:49) dazo: so if extract_x509_extension() returns false ... there is =
no warning that the expected field was not found
(20:25:01) dazo: gah!=20=20
(20:25:07) dazo: I read it boolean inverse!
(20:25:40) dazo: anyhow, if ctx->error_depth is not set ... you still don't=
 provide a generic warning
(20:26:42) dazo: and in my opinion, that's also an error, so that part shou=
ld also do a 'goto err;' call
(20:26:51) mape2k ha abbandonato il canale.
(20:27:50) mattock: jamesyonan: any comments from you regarding the patch?
(20:28:22) mattock: dazo: did we discuss the Magic socket limitation earlie=
r?
(20:28:39) mattock: "socket size limitation" I mean
(20:28:42) dazo: mattock:  we did ... and that's no problem, it is tunable =
via --sndbuf and --rcvbuf
(20:28:47) mattock: ok
(20:29:04) ***dazo discovered that when checking the code more thoroughly
(20:29:26) common: http://p.carnivore.it/tRJKNB
(20:29:28) vpnHelper: Title: tRJKNB on :set paste private nopaste service (=
at p.carnivore.it)
(20:30:03) dazo: common:  line 38-40 needs to go into an else block
(20:30:21) jamesyonan: I think it's okay in principle, it just needs to be =
cleaned up a bit.
(20:30:38) dazo: jamesyonan:  you see this as a useful feature too?
(20:31:22) common: dazo: right
(20:31:23) dazo: common:  I know you like those empty cases ... but I'd say=
 remove them ... rather put a comment section there, stating alternative an=
d not-implemented variables
(20:31:42) common: done
(20:32:13) common: http://p.carnivore.it/5Itbmf
(20:32:14) vpnHelper: Title: 5Itbmf on :set paste private nopaste service (=
at p.carnivore.it)
(20:32:30) jamesyonan: what about #ifdefing out by default?
(20:32:52) jamesyonan: since this is probably something that only a small f=
raction of people would need
(20:33:30) dazo: #ifdef, I agree to ... if it should be default in or out, =
that I'm more uncertain about
(20:33:46) common: actually I consider authentication using not the common =
name field of a cert a really sensible feature
(20:34:08) common: common name is not meant to be uniq in any way
(20:34:15) dazo: common:  just some background on reasons for #ifdef .... t=
hat's basically to protect those running openvpn on embedded stuff, to save=
 them from extra code which they most likely won't use
(20:34:36) dazo: which adds extra bytes in the binary code
(20:34:42) common: so if you rely on real certificates, not self-signed, yo=
u need it
(20:35:30) mattock: for embedded systems it does not matter whether it's en=
abled or disabled by _default_... they can always build their own version
(20:35:36) dazo: common:  please define 'real certificates' and 'self-signe=
d' ... that can be understood in different ways
(20:36:14) dazo: mattock:  +1
(20:36:24) jamesyonan: it would be nice, in the future, to create an abstra=
ction layer for code that does various tests/examinations of the X509 cert.
(20:36:38) common: jamesyonan: agreed
(20:37:01) jamesyonan: perhaps it could be added to the plugin model
(20:37:07) common: dazo: if you buy your certificates from a ca, or you hav=
e/run a ca for a company
(20:37:18) dazo: jamesyonan:  we should revisit that topic ... we've receiv=
ed a bigger patchset now which modularises the SSL implementation .... and =
we can now support PolarSSL in addition to OpenSSL
(20:37:59) ***ecrist is here
(20:38:05) mattock: hi ecrist!
(20:38:26) ecrist: apologies for my tardiness
(20:39:20) dazo: common:  that's what I thought ... well, that's first of a=
ll not recommended in the docs, iirc .... as that can really be a security =
issue, if someone orders a certificate from the same CA and then tries to c=
onnect to your box .... that certificate will still be valid for OpenVPN, a=
nd then you really do need a better match in plug-ins anyway ... I'm afraid=
 that's a big can of nasty worms=20
(20:40:18) mattock: dazo: good point
(20:41:06) common: dazo: I'm aware of the problems, and thats why I need so=
mething I can rely on
(20:41:17) dazo: and then, there's already the tls_digest_%i  environment v=
ariable available, which contains the SHA1 fingerprint/digest in the OpenVP=
N 2.2 base, which can be used for a certificate match
(20:41:32) common: which is the email address, as we can assure you won't g=
et a certificate for an email address you do not own
(20:41:59) common: this requires a storage of all certificate fingerprints
(20:42:04) dazo: I'm also working on a v3 plug-in API which will give acces=
s for C plug-ins to the complete X509 certificate
(20:42:09) common: which I do not have, and can't get
(20:43:02) dazo: by trusting that e-mail address in that field, you need to=
 trust that the _external_ CA has done it's job properly as well
(20:44:03) common: we got a certificate chain, but you may be right
(20:45:11) dazo: (meaning: you need to make sure the CA cannot modify the e=
-mail address ... and/or that they validate that the address is a proper ad=
dress ... and that nobody else can order certificates without notifying the=
 user using that e-mail address)
(20:45:47) dazo: - and preferably also require some kind of confirmation on=
 that e-mail address
(20:46:32) dazo: I agree to your argument that certificate fingerprints dat=
abase can be daunting to setup ... that's a valid point
(20:46:41) mattock: sounds like a can of worms
(20:46:54) dazo: that was what I just realised now as well
(20:47:45) common: http://p.carnivore.it/8W96W2
(20:47:47) vpnHelper: Title: 8W96W2 on :set paste private nopaste service (=
at p.carnivore.it)
(20:50:14) dazo: common:  that patch looks fine, code wise ... the only dis=
cussion point now is if this feature is safe, from a usage perspective in a=
 real-life scenario
(20:51:16) mattock: use it at your own risk? ifdef out by default?
(20:51:31) mattock: similarly to --enable-password-save
(20:51:42) common: in our case
(20:52:11) common: we got our own ca, which is a sub ca of a authoriative ca
(20:52:37) common: if you know effs ssl observatorium paper, you know the c=
a ;)
(20:52:39) dazo: yeah ... but I think I would even insist on a startup warn=
ing if -x509-username-field is used that you should not use external CA cer=
tificates=20
(20:53:08) dazo: or, that's un-precise
(20:54:09) dazo: but you get my idea, I think ... that we should make a lit=
tle noise in the log file that you have a potentially more risky configurat=
ion, if not configured correctly
(20:54:39) mattock: dazo: +1
(20:54:47) mattock: ifdef out + big warnings?
(20:54:55) dazo: mattock:  yupp
(20:55:13) common: hargh, so I still have to compile my own=20
(20:56:17) dazo: common:  just to make sure I've caught it correctly .... i=
f I have sub-CA certificate signed by VeriSign (f.ex.) .... and I have sub-=
CA + VeriSign CA certs in --ca .... if a user signed by sub-CA, I expect it=
 will be authenticated fine .... but what if a certificate signed by VeriSi=
gn stops by .... will that authenticate properly?
(20:56:55) common: I do not know
(20:56:56) mattock: doesn't valid auth need both Verisign and the sub-CA si=
gning?
(20:58:02) ecrist: no, verisign can't sign certificates that are valid unde=
r a sub-CA
(20:58:06) dazo: if it requires the user certificate to be signed by the su=
b-CA only, then this is fine .... but if it's enough with only the top-CA, =
then this is nasty
(20:58:18) ecrist: you never give them your keys when you submit your CSR
(20:58:51) dazo: ecrist:  that's right ... but I'm seeing it from a little =
bit different angle
(20:59:04) common: ecrist: question is, if there is a cert signed by verisi=
gn, would it be valid too
(20:59:23) common: given you have them as top of your chain anyway
(20:59:24) ecrist: by definition, no, because it's not in the same chain
(20:59:38) common: somebody to try this?
(20:59:39) ecrist: programmatically, I can't say, but as SSL is supposed to=
 work, no
(20:59:55) mattock: jamesyonan: do you know how this works?
(21:00:01) dazo: both certificates are valid, one is signed by VeriSign, th=
e other one is signed by sub-CA .... and if OpenVPN accepts the user cert s=
igned by VeriSign or not ... as that do have a valid signature from VeriSig=
n, just as the sub-CA do
(21:00:41) jamesyonan: It's worth a test to verify, but my experience with =
OpenSSL is that when you load it with a list of CAs, it will validate if an=
y of the CAs match.
(21:00:41) dazo: ecrist:  so you say that when the --ca in OpenVPN is a cer=
tificate chain, the user certificate must be of the same certificate chain =
to be valid?
(21:00:49) ecrist: yes
(21:01:01) Essobi: Yup.
(21:01:34) mattock: what if we test this as jamesyonan suggested?
(21:01:48) mattock: start by asking about this on -users and/or -devel
(21:01:52) dazo: jamesyonan:  can you clarify "it will validate if any of t=
he CA's match"?   is that exclusively all CA's or or just one or more CA's =
in the chain?
(21:02:16) dazo: ('any' is the word confusing me)
(21:02:17) ecrist: jamesyonan: perhaps I missed something, but if you're li=
sting the root CA for Verisign as an openvpn CA, then yes, any certificate =
signed by them would work
(21:02:58) ecrist: if you only list the secondary CA certificate, only cert=
ificates signed by that CA will work, not all that are signed by the parent=
 CA
(21:03:05) dazo: what ecrist says, makes sense to me, and is closer to my u=
nderstanding of it ... but I've never tried it
(21:04:17) ***ecrist has tried, but not within openvpn
(21:04:22) Essobi: It may be configurable to accept sub-ca or not.  Might c=
heck the openssl.cnf docs.  I vaguely remember seeing some verbage somewher=
e for that.
(21:05:35) mattock: if I'm not mistaken, this is about the same thing: http=
://openvpn.net/archive/openvpn-users/2005-10/msg00278.html
(21:05:36) vpnHelper: Title: [Openvpn-users] CA and Sub CA (at openvpn.net)
(21:06:38) common: nah
(21:07:02) dazo: it's related, as it is about this implicit trust issue
(21:07:48) mattock: ok, what should we do?
(21:07:49) jamesyonan: most of OpenSSL's CA verification is done using X509=
_STORE objects, which are essentially lists of CAs.  And these objects will=
 verify any cert for which a chain can be constructed that ends in a non-in=
termediate root cert in the CA.
(21:08:22) dazo: mattock:  I'm tempted to send this question to JJK :)
(21:08:37) mattock: I think we should ask about this on -users and -devel
(21:08:54) mattock: worst case, #ifdef out by default and print big warnings
(21:09:01) mattock: is that ok for all?
(21:09:48) mattock: dazo: and if we send a mail to any mailinglist, JJK wil=
l read it :)
(21:11:31) dazo: mattock:  yes, mailing list (-users, probably) for the CA =
certificate chain authentication, for sure
(21:12:22) dazo: mattock:  re: this patch .... the code is fine, but I'm ve=
ry sceptical to this feature when I begin to understand the depth of it ...=
 I'm really not completely convinced we should add this feature like this
(21:12:23) jamesyonan: dazo: "any of the CAs match" means one or more CAs m=
atch
(21:12:39) dazo: jamesyonan:  thx!
(21:12:50) common: actually I think I could test this
(21:13:24) common: while we have our sub-ca, people we work with have their=
 own sub-ca from the same ca
(21:13:24) dazo: mattock:  another reason is ... that this feature can be i=
mplemented via the new v3 plug-in API as a separate plug-in, as that will p=
rovide full access to the X509 certificate object (in C, that is)
(21:13:38) jamesyonan: it seems that the bigger issue is the risk of using =
third-party CAs
(21:14:22) mattock: ok
(21:14:22) dazo: yes, when using a third-party .... you really need to know=
 what you're doing in this case
(21:14:35) jamesyonan: because in this case, you really need to examine the=
 entire cert chain -- it may not be enough to use OpenSSL's default validat=
ion
(21:15:57) mattock: shall we move the discussion to mailing lists?
(21:16:17) Essobi: iirc, you can require more things to match between the C=
A and the client for proper auth, in openssl.cnf, that could increase the v=
alidity that a specific CA is found and not a rougue sub-ca...
(21:16:17) dazo: I personally think this feature belongs more at home in a =
separate plug-in ... where the complete chain can be validated better as we=
ll
(21:16:56) mattock: dazo: and the plugin approach will be possible with plu=
gin API v3?
(21:17:03) dazo: mattock:  yes
(21:17:13) mattock: how far are we from v3?
(21:17:36) common: got a git tree?
(21:18:16) dazo: common:  it's not published yet ... it's still in the work=
 ... but I'll try to get some patches out for a review this weekend, is tha=
t fine?
(21:18:24) common: sure
(21:18:47) jamesyonan: Essobi: were you able to write up your findings on F=
IPS?
(21:18:51) mattock: so much for the "mini-meeting" I was thinking of :D
(21:19:16) dazo: mattock:  the complete skeleton is practically done ... it=
's just to add the X509 certificate object left
(21:19:55) mattock: sounds good
(21:20:15) mattock: regarding other topics... any old topics we need to rev=
isit or didn't manage to discuss earlier?
(21:20:48) mattock: oh, osx keychain support
(21:20:52) mattock: ecrist: any progress?
(21:21:02) dazo: mattock:  I didn't see anyone, it was just a feeling I had=
 ... and I saw that I should send an e-mail to the mailing list re: --tls-f=
loat ... that was what was bothering me :)
(21:21:29) mattock: dazo: I think you promised to send mail about that, yes=
 :)
(21:21:32) edmund: Hey All, I'm guessing this has been discussed before, bu=
t I was just wondering.... What is the best available OpenVPN interface for=
 iOS4 (iPhone) since Apple probably wont open up the SSL API guts to anyone=
 besides Juniper and Cisco? Thanks
(21:22:01) mattock: edmund: you should probably ask at #openvpn channel ins=
tead
(21:22:06) dazo: edmund:  checkout !iphone on #openvpn
(21:22:06) krzie: mattock, if ecrist hasnt tested that, you can gimme an ac=
count on the openvpn vpn server (since it auths via ldap) and i can test it=
 now
(21:22:45) mattock: krzie: you mean you want to be able to access the VPN?
(21:22:56) dazo: I think there were some issues with getting that compiled =
properly ... it was some mismatch with some #ifdef defines and autotools, i=
irc ... but I have no OSX box where to test this out=20
(21:22:56) edmund: Ok thanks. over to #openvpn.
(21:23:00) krzie: not especially, but it requires password auth and im on O=
SX
(21:23:18) mattock: oh yes, the compile issues...
(21:23:33) mattock: those need to be figured out first
(21:23:39) krzie: ohhh, if it doesnt compile then nevermind
(21:23:51) krzie: i thought it was just waiting for testers
(21:24:31) krzie: dazo, i wouldnt be against giving you a temp shell on a o=
sx box later if you wanted to dig it out
(21:24:40) krzie: i cant on this one, but one at home i can
(21:25:02) Essobi: jamesyonan: Boss signed off on it. ;)  All I got to do i=
s write the beta3/stable patches, and write up the how-to on building it. ;)
(21:25:04) dazo: krzie:  that could really help out, if it's possible to do=
 all from ssh
(21:25:27) Essobi: jamesyonan: Actually... I need somewhere to host a few p=
ages now too. Hmm.
(21:26:42) mattock: unless there's anything else, I'd say the official part=
 is over... :)
(21:27:20) ecrist: mattock: it's broken, dazo is supposed to fix it
(21:27:35) ecrist: right now, it won't compile properly, it's missing an in=
clude or something
(21:28:03) dazo: ecrist:  can you tell krzie what he needs to get his envir=
onment ready for some debugging of this?   it's difficult to fix it without=
 OSX
(21:28:29) ecrist: yeah, did you ever fix the compile issues?
(21:30:20) krzie: i already should have what you need
(21:30:23) krzie: xcode and whatnot
(21:30:39) mattock: macports or something, too?
(21:30:45) krzie: aye
(21:30:45) dazo: ecrist:  the thing is, it's impossible for me to really te=
st it without the proper environment ... it's like writing code in darkness
(21:30:48) krzie: always
(21:30:55) krzie: in fact macports is why i have xcode ;)
(21:31:13) krzie: i compile a bit of stuff via commandline... it should be =
good to go
(21:31:39) krzie: dazo, plus i could even give you root on it if you needed=
, its a fresh install and i plan on redoing it soon
(21:31:42) krzie: good timing ;)
(21:31:48) cron2: oopsa
(21:31:50) cron2: missed the meeting
(21:32:24) ecrist: doesn't vmware support os x now as a guest?
(21:32:34) krzie: yes, it does
(21:32:42) krzie: hackintosh style ;]
(21:32:50) mattock: does apple approve that?
(21:33:08) mattock: or have they filed a lawsuit already? :)
(21:34:07) Essobi: lol
(21:34:16) Essobi: It's not an official guest man.
(21:36:11) mattock: anyways, I'll write the summary tomorrow as usual

--------------010600090502050005040108--

