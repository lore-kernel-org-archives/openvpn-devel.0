Message-ID: <4C4007BC.8010909@...515...>
Date: Fri, 16 Jul 2010 10:18:20 +0300
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010901070205020204040308"
Subject: [Openvpn-devel] Summary of the IRC meeting (15th Jul 2010)
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
--------------010901070205020204040308
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the previous community meeting.

---

COMMUNITY MEETING

Place: #openvpn-devel on irc.freenode.net
Date: Thursday, 15th Jul 2010
Time: 18:00 UTC

Planned meeting topics for this meeting were on this page:

<https://community.openvpn.net/openvpn/wiki/Topics-2010-07-15>

Next meeting next week, same place, same time. Your local meeting time
is easy to check from services such as

<http://www.timeanddate.com/worldclock>

or with

$ date -u


SUMMARY

Discussed handling of security vulnerabilities. Historically security
issues have been reported by security researchers directly to James
Yonan and fixed within days. Decided to

- use a closed security mailinglist for receiving and discussing
undisclosed security vulnerabilities
- encrypt communications on the security ml using PGP
- include key OpenVPN community members in the mailinglist
- include key package maintainers / distributors in the mailinglist (to
give them time to prepare for repackaging)

Also discussed fixing and disclosing of security vulnerabilities. Agreed
that we should disclose security issues in 3 weeks - or less, if a fix
is ready. If a fix is not ready in 3 weeks we should disclose the issue,
provide workarounds (if any) and then fix the issue a.s.a.p.

Agreed that all security issues - whether they're theoretical or being
exploited - should be fixed. Also agreed that our users should be
informed about vulnerabilities in external software OpenVPN depends on
(e.g. OpenSSL). This will be done after developers of the external
software have already disclosed the vulnerability.

Discussed various mechanisms to make security vulnerability discussions
secure. Sending of security vulnerability reports to us could be done
securely with a simple HTTPS webapp. Alternatively, we could make an
official PGP public key available for sending in reports. There are two
options for securing discussions on the security mailinglist:

- everybody uses the same PGP public/private keypair which expires, say,
after one year
- everybody uses personal PGP keys for communication: all need to have
the public keys of everyone else and each mail has to be encrypted once
for every recipient

Agreed that the second option is better, if mail clients can be
configured to do multiple encryption automatically. Samuli promised to
check if Thunderbird + Enigmail supports this. Samuli also promised to
check if SF.net mailinglists could be used for the -security ml.

--

Discussed the "Build failure on OpenBSD 4.7 IFF_MULTICAST" bug:

<https://community.openvpn.net/openvpn/ticket/17>

Cron2 is still awaiting test reports from krzee and fkr.

--

Discussed our buildbot install briefly. It already does the continuous
integration stuff by automatically building OpenVPN "allmerged" branch
and reporting of build problems. By the end of this month we should have
buildbot-created Debian/Ubuntu packages available. Agreed that we should
provide packages for both "beta2.2" and "allmerged" branches.

--

Discussed promises made in these meetings. Agreed that they're easy to
forget and hard to track. Decided to try using Trac for tracking the
promises:

<https://community.openvpn.net/openvpn/report/12>

Samuli promised to review latest meeting summaries and create Trac
tickets as required.

--

Discussed the broken bridge scripts. Waldner has now written the
bridging HOWTO, as promised:

<https://community.openvpn.net/openvpn/wiki/OpenVPNBridging>

---

Full chatlog as an attachment

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock




--------------010901070205020204040308
Content-Type: text/plain; charset="utf-8";
 name=openvpn_irc_meeting_chatlog_2010-07-15.txt
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="openvpn_irc_meeting_chatlog_2010-07-15.txt"

(21:04:31) mattock: hi james!
(21:04:43) mattock: let's start the meeting!
(21:04:47) krzee: i wont have time to even look at servers for a bit, migra=
tion craziness
(21:04:58) krzee: (also wont be in the meeting, later guys!)
(21:05:13) mattock: krzee: later
(21:05:27) mattock: ok, so what about this: "How do we tackle security issu=
es?  (f.ex. CVE's)  How are they announced?"
(21:05:34) mattock: full topic list here: https://community.openvpn.net/ope=
nvpn/wiki/Topics-2010-07-15
(21:05:35) vpnHelper: Title: Topics-2010-07-15 =EF=BF=BD=EF=BF=BD=EF=BF=BD =
OpenVPN (at community.openvpn.net)
(21:06:47) mattock: dazo: is the CVE topic from you?
(21:07:08) dazo: A guy on #openvpn wondered about how we announce security =
issues and fixes
(21:07:14) mattock: dazo: ok
(21:07:33) mattock: jamesyonan: do we (=3Dcompany) have a policy for CVE's?=
=20
(21:07:38) jamesyonan: in the past, security issues that have been found ar=
e communicated to me confidentially
(21:07:59) dazo: and I can't say I remember having seen much of such announ=
cement, especially of fixes ... I've seen one CVE, which was tackled in 2.1=
_rc9
(21:08:11) jamesyonan: the security issue is then publicly announced at the=
 same time a fix is released
(21:08:35) dazo: Yeah, that's the normal procedure
(21:08:48) dazo: Maybe it would make sense to have a "inner circle" of some=
 people who will receive such issues?
(21:08:51) ecrist: personally, I think hiding vulnerabilities like that is =
not the right way to go about it
(21:09:11) mattock: at least if hiding leads to postponing the fixing
(21:09:26) dazo: It's not about hiding it, it will become visible ... but w=
e need some time to get it fixed, so we don't put our users at risk immedia=
tely
(21:09:46) ecrist: or, when hiding leads to admins not knowing, especially =
when there are things that can be done to mitigate a vulnerability outside =
a code patch
(21:09:48) dazo: when the vulnerability is known, the attack vector is much=
 more like
(21:09:52) dazo: likely
(21:10:02) ecrist: if it's a problem, they're already vulnerable
(21:10:10) mattock: ecrist: good point
(21:10:18) cron2: that's the old debate about reasonable disclosure
(21:10:23) ecrist: instead, the only people that know about it are a few co=
ders, and potential hackers.
(21:10:30) ecrist: cron2: exactly
(21:10:33) dazo: yeah, but if it's not publicly known, attackers might not =
begin to look for vulnerable openvpn server as easily
(21:10:37) ecrist: I'm just stating my stance on the subject
(21:10:40) cron2: I'm all for disclosure, but at the same time, giving the =
developers "reasonable amount of time" to fix & rollout
(21:10:51) dazo: cron2:  +1
(21:11:01) ecrist: -1
(21:11:03) jamesyonan: I think this is a generally agreed on practice -- th=
ere's no perfect solution but the least-worst solution seems to be to delay=
 the public disclosure by a reasonable amount of time so a fix can be devel=
oped
(21:11:32) dazo: full disclosure, but give a little reasonable time to get =
a fix out before it's announced ... usually such announcements are coordina=
ted with MITRE or similar institutions too
(21:11:51) mattock: also, this depends on who has found the issue... and if=
 it's already in the wild being exploited
(21:12:08) mattock: e.g. if a security researcher finds it, it may or may n=
ot be in the wild
(21:12:30) krzee ha abbandonato il canale (quit: Read error: Connection res=
et by peer).
(21:12:38) dazo: in such cases, CVE's are usually published immediately ...=
 but CVE's which are not in the wild, are kept with a low profile until an =
agreed date
(21:13:36) dazo: but I agree with jamesyonan, this is usually the common pr=
actice, also within F/OSS
(21:15:10) mattock: what do we consider reasonable amount of time for a fix?
(21:15:23) mattock: probably not 12 months like Apple and Microsoft? :)
(21:15:43) ecrist: whenever the developers feel they want to, more than lik=
ely
(21:15:47) dazo: difficult to say, depends on the vulnerability ... < 4week=
s, I would say
(21:16:41) ecrist: if you're going to adopt that policy, I think it's a fai=
r trade off to stick to a max lifetime, say, 3 weeks.  if it's not patched =
at 3 weeks, announce the vuln and allow the community to review
(21:16:45) dazo: 4 weeks gives time to investigate, fix and test the fix wi=
thout being way too stressed, but still having pressure
(21:16:59) ecrist: a month is a long time
(21:17:09) ecrist: I think 3 weeks it too long, tbh
(21:18:05) dazo: I'm not sure what's the common everywhere practice .... bu=
t some places I know it's up to 6-8 weeks ... but in those cases, it's been=
 coordinating with other vendors as well
(21:18:33) jamesyonan: historically, most OpenVPN security issues have been=
 fixed within days
(21:19:55) ecrist: if that's the case, put a 2 week lifetime on it
(21:20:49) dazo: I think ecrist got a good point, though ... fix internally=
 within 3 weeks ... and if not, the -devel list must be involved somehow ..=
. but not like announcing a vulnerability which we must fix
(21:20:52) mattock: there's also the delay before upstream fixes reach dist=
ributors (e.g. software repos)
(21:21:14) dazo: true
(21:21:15) ecrist: mattock: I think that's where the -devel comes in
(21:21:21) ecrist: and, really, it's up to them
(21:21:27) mattock: yep
(21:21:49) ecrist: so, ideally, upon notice, reveal to security@ (include r=
epo owners) and patch/release
(21:21:58) ecrist: if it's not patched in time, release to -devel
(21:22:12) dazo: when we have a fix and have published it, then yes - it's =
their "problem" .... but until a fix is ready, it's actually our main respo=
nsibility
(21:22:33) dazo: ecrist:  +1
(21:22:57) ecrist: if it's patched in a couple days, staying inside that ti=
meout is possible, even with rerolling packages
(21:23:06) mattock: I agree that repo owners should be notified of any secu=
rity issues... so that they can prepare for repackaging
(21:23:08) ecrist: but the timeout can still be a drop0dead
(21:24:00) ecrist: I think non-devs (such as myself) should be members of s=
uch a list, however, to keep things honest.
(21:24:06) ecrist: and disclosed.
(21:24:06) mattock: jamesyonan: could we have a closed mailinglist or somet=
hing for security issues?
(21:24:36) mattock: with a few key members from the community
(21:24:45) jamesyonan: yes, I agree that makes sense
(21:25:15) mattock: any ideas how to implement the list?
(21:26:01) dazo: a mail alias with the allowed people on @openvpn.net ?
(21:26:11) ecrist: just need to create a closed list on sf, where the other=
 lists are
(21:26:15) ecrist: you can lock them down
(21:26:23) mattock: ecrist: ok, did not know that
(21:26:37) mattock: perhaps that'd be the easiest way
(21:26:39) dazo: Do we trust sf.net enough?
(21:27:08) ecrist: I don't see why we couldn't
(21:27:24) ecrist: would be bad pub for them for such a thing to be opened =
up
(21:27:29) mattock: the mails go through countless of mail servers anyways,=
 so...
(21:28:03) dazo: that's true enough ... I was more worried if somebody at s=
f.net managed to leak out mails on our locked down list
(21:28:13) ecrist: I don't think this sort of thing needs to be that secret=
ive
(21:28:29) ***dazo is just very careful by nature
(21:28:38) mattock: as long as we fix the issues in a timely manner we shou=
ld not need to worry
(21:28:55) dazo: fair enough
(21:29:39) mattock: and I don't many try to sells exploits that are known t=
o the vendor already... if dazo was thinking along those lines
(21:29:53) jamesyonan: the members of the security team could always exchan=
ge PGP public keys and use them to discuss issues of critical sensitivity
(21:30:04) mattock: yep, that's true
(21:30:08) ecrist: that is an option
(21:31:13) dazo: agreed
(21:32:17) mattock: what if we do this:
(21:32:17) mattock: - create a closed security mailinglist
(21:32:17) mattock: - disclose the issues in 3 weeks or less, if a fix is r=
eady
(21:32:17) mattock: - if a fix is not ready in 3 weeks, disclose the issue =
(and provide workarounds, if any), then fix the issue a.s.a.p.
(21:32:17) mattock: - inform (some) package maintainers about upcoming fixe=
s, before disclosure
(21:32:37) mattock: - include key community members in the security mailing=
list
(21:33:01) ecrist: I think all major package maintainers and vendors should=
 be allowed on the list.
(21:33:11) dazo: +1
(21:33:19) ecrist: i.e. Snom who has an OpenVPN client on their VOIP phones.
(21:33:49) jamesyonan: +1
(21:34:10) mattock: +1, as long as we can somehow verify the trustworthines=
s of those on the list
(21:34:22) dazo: jamesyonan:  when you received such alerts earlier ... can=
 you describe that process?  Whom contacted you?  How did they contact you?=
  When and how did it get disclosed?
(21:34:23) mattock: common sense helps, of course :)
(21:35:10) jamesyonan: usually these issues are first found by security res=
earchers
(21:35:48) jamesyonan: they communicate the issue to me via encrypted email
(21:36:13) jamesyonan: There's different classes of issues
(21:37:02) jamesyonan: Some issues are theoretical only (these are often fo=
und by automated source code analysis tools)
(21:37:32) jamesyonan: Some issues are really issues in other software but =
that affect OpenVPN
(21:38:07) jamesyonan: An example of the latter is the infamous random numb=
er bug that was introduced a few years ago into debian OpenSSL
(21:39:23) mattock: I think the "external software issues" should be disclo=
sed a.s.a.p.
(21:39:33) dazo: mattock:  +1
(21:39:39) jamesyonan: the latter bug would cause keys to lack entropy
(21:39:42) mattock: and perhaps the theoretical ones, too
(21:39:50) ecrist: but a workaround should be available, as well.
(21:40:08) ecrist: I think the theoretical ones should be patched, the same=
 as other critical ones.
(21:40:23) dazo: mattock:  but!  it such announcements needs in these situa=
tions to be coordinated with the other group ... so that we don't announce =
something which they need more time on to fix
(21:40:33) jamesyonan: yes the  "external software issues" are usually anno=
unced without any coordination with the OpenVPN project
(21:41:37) jamesyonan: In the case of the Debian random number bug, there w=
asn't much the OpenVPN project could do except to encourage people to updat=
e their OpenSSL package
(21:41:43) dazo: as long as we're not in the loop, then that's very fine ..=
. but if we get to know about an "external" issue, we need to respect any e=
mbargo defined by the "external" part
(21:42:16) mattock: dazo: agreed
(21:43:02) dazo: re: theoretical issues ... yes, we can disclose it almost =
asap, as soon as we have evaluated it to really be theoretical
(21:43:57) jamesyonan: many OpenSSL vulnerabilities that have occurred over=
 the years could be protected against by using tls-auth
(21:43:58) dazo: but I would be more careful there ... as there's enough cl=
ever guys on the internet who can make theoretical work in practice
(21:44:19) mattock: we can also discuss each issue separately on the securi=
ty mailinglist
(21:44:23) mattock: if there are bordercases
(21:44:29) dazo: +1
(21:44:58) mattock: and I agree with ecrist that all, even theoretical, iss=
ues should be fixed
(21:45:16) dazo: +1
(21:45:39) mattock: of course, I have not seen what amount of noise automat=
ed code analysis tools create, so...=20
(21:45:51) jamesyonan: the policy of the project has always been to fix all=
 potential security issues, even theoretical issues for which there is no k=
nown exploit
(21:46:05) mattock: I think that's a good policy
(21:46:30) dazo: agreed
(21:48:07) mattock: ok, so in a nutshell:
(21:48:07) mattock: - inform our users of problems in external software (an=
d possible workarounds) after the external party has disclosed the vulnerab=
ility
(21:48:07) mattock: - fix all security issues (theoretical and real) in the=
 given time
(21:48:07) mattock: - if necessary, discuss issues on a case-by-case basis =
on -security ml
(21:48:36) mattock: do we want to use PGP?
(21:48:44) dazo: pgp, please
(21:48:45) cron2: yes
(21:49:26) mattock: ok, what if I add "check what SF.net mailing lists can =
do for us" to my TODO list?
(21:49:37) ecrist: works for me
(21:49:44) mattock: and then proceed with discussing who's gonna be on the =
list
(21:49:59) dazo: +1
(21:50:06) ecrist: +1
(21:50:15) jamesyonan: +1
(21:50:48) mattock: jamesyonan: what about the initial mails from security =
analysts? could they go directly to the mailinglist?
(21:50:56) mattock: or do they need to go through you first?
(21:51:08) jamesyonan: usually they go to me first
(21:51:35) jamesyonan: the researcher might not know about the existence of=
 the list unless we publicize it
(21:52:01) ecrist: I think an effort to publish the existence of the list i=
s appropriate
(21:52:13) mattock: ecrist: agreed
(21:52:16) dazo: it might be reasonable to consider mentioning it on the of=
ficial web pages and community pages
(21:52:45) mattock: let's do that when the list is up and working
(21:52:51) mattock: the publishing part I mean
(21:53:02) jamesyonan: if we wanted to set up a system for security researc=
hers or other members of the general public to submit security concerns, it=
 might be reasonable to set up an official PGP public key that could be use=
d to encrypt the communications.
(21:53:21) mattock: +1
(21:53:22) ecrist: and distribute that key to members?
(21:53:42) jamesyonan: We could also provide a basic security issue submiss=
ion web app over https.
(21:53:54) ecrist: auto-send to the list
(21:53:56) mattock: I was just wondering how PGP works in a mailing list sc=
enario...
(21:54:19) dazo: mattock:  you need to encrypt with all recipients pubkeys,=
 afaik
(21:54:26) ecrist: I think the only way to do it is to either know everyone=
 on the list and encrypt to each, or have one key pair for the whole list
(21:54:37) dazo: I like the submission webapp ... that sounds "simpler"
(21:54:50) mattock: perhaps one keypair is simpler for everyone
(21:55:36) ecrist: we could change it every 12 mos, perhaps
(21:55:38) dazo: but more difficult to track authenticity ... can you trust=
 that nobody didn't loose the key (with or without knowing it)?
(21:56:02) ecrist: dazo, I think it's not so important to authenticate the =
message as it is to keep it private
(21:56:33) dazo: yeah, with a recycling, that makes sense ... but you'll st=
ill need to save the old keys to read old messages
(21:56:35) mattock: if somebody's key is compromised, the attacker still ne=
eds to somehow receive that person's mails
(21:59:06) mattock: I mean, is there any security benefit to using separate=
 PGP keys and encrypting the same mail 10 times over?
(21:59:18) mattock: or rather 10 times in a row
(21:59:51) dazo: True ... but in a long term perspective, I think it might =
be  better to have a webapp ... which will take the message, encrypt it wit=
h all pubkeys it got available and send it to the mailing list
(21:59:54) ecrist: mattock: the issue comes from having to get all members'=
 keys, and the potential to miss keys for new members
(22:00:19) ecrist: dazo, we need to consider the email exchange that would =
take place in the process
(22:00:48) mattock: ecrist: agreed... there might be a lot of email exchang=
e after the initial submission=20
(22:01:03) mattock: in which case sending mails so that everyone can read t=
hem can be a terrible pain
(22:01:09) mattock: depending on the mail client, I guess
(22:01:20) dazo: ecrist:  if the webapp get the message from the reporter v=
ia https ... webapp encrypts the message with X pubkeys ... it will send on=
e mail to the mailing list which can be decrypted by all recipients
(22:01:37) ecrist: I know.
(22:01:43) mattock: dazo: what about the response to that initial mail?
(22:01:45) ecrist: but what happens when I want to respond to that message
(22:02:10) mattock: the response has to be encrypted by the responding user=
 several times with separate keys... which may be an issue
(22:02:17) dazo: the webapp would simply request a valid e-mail address ...=
 and use that as From: in the mail header
(22:02:33) dazo: ahh
(22:03:00) mattock: dazo: did you see the light? :)
(22:03:26) ecrist: I use apple mail, so I have to do all this by hand (sinc=
e I'm not interested in changing client)
(22:03:31) ecrist: which makes it really difficult
(22:03:38) dazo: maybe ... it would require much more of the sender to add =
all the pubkeys to the encryption, yes
(22:03:43) mattock: I guess it's the same with Thunderbird
(22:04:19) dazo: Enigmail do have some clever tricks up the sleeve, I think=
 ... with some aliasing ... or "add these keys when sending to xxxx"
(22:04:43) ecrist: GPGMail for OS X up to 10.5 was nice, but apple breaks m=
any nice plugins
(22:04:44) ecrist: :\
(22:05:07) mattock: if there's a concrete benefit in using separate keys th=
en we should reconsider... but if not, using one keypair makes more sense
(22:05:32) mattock: I think we should reconsider this after a good night's =
sleep
(22:05:46) mattock: no need to carve this into a stone right now
(22:06:06) dazo: mattock:  pro for one key pair - easy to setup and get sta=
rted, cons: more vulnerable if key is lost + need to rekey regularly
(22:07:01) ecrist: unless we were to setup some remailer, to which we encry=
pted the message, it decrypted, and re-encrypted to each user.
(22:07:49) dazo: mattock:  pro for several key pairs - individial setup per=
 recipient requires no maintenance from ML admin ... cons: might miss new-c=
omers + some mail clients are more tricky + (I forgot now)
(22:08:53) jamesyonan: for the security submission web app, I would just ha=
ve a script that loops through each recipient's public key and remails to t=
hem.
(22:09:12) dazo: ecrist:  good idea, probably the best solution though ... =
but someone need time to do it
(22:09:22) jamesyonan: I'm not a big fan of shared private keys
(22:09:32) mattock: however, if the "global" private key is lost, the attac=
ker still needs to get to the actual encrypted mails somehow... and if he d=
oes not have access to a mail account on -security mailing list, how can he=
 read the mails?
(22:10:02) mattock: and if some of us gets his/her machine cracked, then it=
's irrelevant if it was a "global" key or the person's own PGP key
(22:10:03) mattock: right?
(22:10:09) dazo: jamesyonan:  you wouldn't need much changes to the webapp =
to just add '-r <recipient>' to a gpg encryption process in that iteration =
instead, and send it once to the ML
(22:10:27) jamesyonan: dazo: yes
(22:10:33) ecrist: honestly, the timeframe we're looking at, I think this a=
ll may be a little overkill
(22:10:50) mattock: ecrist: agreed, hence ^
(22:11:24) dazo: but temporary solutions have a tendency to become "tempora=
ry" for a long time, especially if it does its job pretty decent
(22:11:27) ecrist: I'm still more for the idea of an annual mailing list ke=
y pair
(22:11:46) ecrist: we can distribute through an ssh/sftp account to ml users
(22:11:47) mattock: me too
(22:13:32) mattock: did somebody understand what I was after in my monologu=
e above?
(22:14:10) dazo: mattock:  I did
(22:14:15) mattock: =3Dme don't see problem in our scenario with using glob=
al keys
(22:15:12) mattock: I'm just trying to keep things simple
(22:15:26) dazo: mattock:  I can agree to that, as long as ML members don't=
 use that key to encrypt messages to the ML ... because communication on th=
at ML should be possible to authenticate some how
(22:15:56) mattock: ok, I see
(22:17:02) ecrist: I'll download thunderbird and play with some mailing lis=
ts I have control of and test some things out
(22:17:44) mattock: on the other hand, we are constantly communicating with=
 each other without any authentication (IRC, mailinglists)
(22:17:45) dazo: I just checked the Enigmail add-on ... you can set up rule=
s to add public keys when sending mails to specific recipients
(22:17:52) mattock: but let's do some more research
(22:18:14) mattock: if separate PGP keys is doable, then let's by all means=
 do it
(22:18:21) mattock: that'd be optimal
(22:18:36) dazo: who does that research?
(22:18:51) mattock: ecrist volunteered I guess :)
(22:19:07) mattock: in fact, I can test Thunderbird + Enigmail, as I have i=
t installed alrady
(22:19:08) mattock: already
(22:19:09) cron2: it's doable, but it depends on the mailing list software =
in use
(22:19:37) mattock: I'll check the SF.net mailinglists... what they can do
(22:20:14) mattock: could somebody else check how other email clients work =
with PGP multiple keys per mail?
(22:21:18) mattock: any Outlook users? :)
(22:21:33) dazo: poor bastards ...
(22:21:38) ***dazo hides
(22:23:25) mattock: ok, should we discuss something else for a while... I'l=
l do some research tomorrow and send mail to -devel
(22:23:53) mattock: I think the "Release cycle" stuff would take too long, =
it's getting late
(22:24:02) dazo: agreed, next week
(22:24:11) mattock: cron2: what about the OpenBSD build failure?
(22:24:22) mattock: which is this: https://community.openvpn.net/openvpn/ti=
cket/17
(22:24:23) vpnHelper: Title: #17 (build failure on OpenBSD 4.7 IFF_MULTICAS=
T) =EF=BF=BD=EF=BF=BD=EF=BF=BD OpenVPN (at community.openvpn.net)
(22:24:26) cron2: well, I need an ACK on the patch... :-)
(22:24:44) dazo: I've looked at the patch ... looks sensible to me, but I d=
on't have any *BSD systems to test it on right now
(22:25:04) cron2: mattock: how is buildbot coming along?
(22:25:31) dazo: cron2:  when it's tested ... I'll condense your 2 patches =
into one and commit it, hope you don't mind that
(22:25:47) mattock: cron2: haven't touched it in ~1,5 weeks, been working o=
n forums.openvpn.net
(22:25:55) cron2: dazo: I'm fine with that.  It just happened to happen tha=
t way
(22:26:09) dazo: :)
(22:26:19) mattock: however, I should be able to manage to make first Debia=
n/Ubuntu packages using buildbot before end of this month
(22:26:38) mattock: forums have been progressing pretty nicely
(22:27:19) ***dazo will spend some time rebasing the beta2.2 branch, to fix=
 up some issues with wrongly based wintap branch
(22:27:33) cron2: well, so it's up to krzee and frk to test the patch and r=
eport back...
(22:27:50) dazo: fkr, I believe you meant :)
(22:27:56) mattock: dazo: should the first buildbot packages be from beta2.=
2 branch?=20
(22:28:01) mattock: or "allmerged"?
(22:28:01) cron2: yes
(22:28:20) mattock: although both can be provided pretty easily
(22:28:21) dazo: mattock:  yes please! :-P
(22:28:29) cron2: +2
(22:29:04) dazo: It makes sense to build both ... the difference is quite b=
ig already, with beta2.2 missing ipv6 stuff basically
(22:29:30) mattock: cron2: just in case you haven't heard the status of bui=
ldbot... I managed to get it to build OpenVPN ("allmerged") and report any =
build problems via email to me
(22:29:44) cron2: mattock: no I missed that.  Cool!
(22:29:48) cron2: which platform?
(22:29:52) mattock: now it's just packaging stuff
(22:29:58) mattock: Debian Lenny
(22:30:50) mattock: I'll start with packaging for Debian Lenny, Ubuntu 9.10=
 and 10.04 ... I have easy access to all of those
(22:31:09) mattock: and they're almost the same packaging-vise
(22:32:57) mattock: dazo: I remember you talked about having a public task =
(or promise) list...
(22:33:19) dazo: yeah ... that can basically be these meeting minutes
(22:33:45) dazo: just list up subject, description and owner ... and we'll =
nag people to do their job until it's out of the list
(22:34:42) mattock: could we use Trac tasks for that?
(22:35:08) dazo: possibly, yes ... there's actually already a TODO list tra=
cker there, iirc
(22:36:32) dazo: (it just needs a report query on Type: TODO)
(22:36:53) mattock: I think that'd be nicer than having a wiki page
(22:37:25) mattock: dazo: could you create the query?
(22:37:36) dazo: mattock:  sure can do :)
(22:37:51) vpnHelper ha abbandonato il canale (quit: Read error: Connection=
 reset by peer).
(22:37:54) vpnHelper [~vpn@...1336.../krzee/bot/vpnhelper] =EF=BF=BD=EF=BF=
=BD entrato nel canale.
(22:38:04) mattock: do I need to enter my own tasks to Trac, too? I have my=
 own TODO list already ;)
(22:38:15) openvpn2009 ha abbandonato il canale (quit: Ping timeout: 240 se=
conds).
(22:38:23) Guest12047 [~admin@...1321...] =EF=BF=BD=EF=BF=BD entrato nel ca=
nale.
(22:38:27) dazo: those important ones would be nice
(22:39:15) mattock: I think it's nice if you guys can remember what I promi=
sed... although I (almost) always do what I promise
(22:39:50) mattock: let's try the Trac TODO list tomorrow
(22:39:54) mattock: see how it turns out
(22:40:37) dazo: https://community.openvpn.net/openvpn/report/12
(22:40:38) vpnHelper: Title: Public TODO list =EF=BF=BD=EF=BF=BD=EF=BF=BD O=
penVPN (at community.openvpn.net)
(22:40:39) dazo: here you go :)
(22:41:20) mattock: ok
(22:41:46) mattock: are we done for today?
(22:42:12) ***dazo thinks so
(22:42:46) ***dazo hears thunder ... and is looking fwd to the rain after i=
t ... just hopes it comes close enough ...
(22:43:16) mattock: ok, I'll summarize the meeting tomorrow and test how Tr=
ac works for tracking promises :)
(22:43:28) dazo: :)
(22:43:58) mattock: I'll check the latest meeting summaries to see what pro=
mises are still unfulfilled and add them as tasks
(22:44:12) dazo: mattock:  thanks a lot!!!
(22:44:18) mattock: I vaguely remember some bridge scripts...
(22:44:21) mattock: no probs!
(22:44:45) dazo: waldner was the one on that one, iirc
(22:45:22) mattock: yep, my memory served me well :)
(22:45:45) ***dazo is more concerned about my forgotten tasks :-P
(22:46:00) waldner: https://community.openvpn.net/openvpn/wiki/OpenVPNBridg=
ing
(22:46:01) vpnHelper: Title: OpenVPNBridging =EF=BF=BD=EF=BF=BD=EF=BF=BD Op=
enVPN (at community.openvpn.net)
(22:46:22) waldner: (I didn't post it because I thought it was too late alr=
eady)
(22:46:35) mattock: waldner: great!
(22:46:41) waldner: :)
(22:47:22) waldner: unfortunately I don't have a chance to test OS X or Sol=
aris (and few for *BSD), so somebody will probably need to fill those in
(22:47:29) dazo: waldner:  I think we're just in the door, about to leave t=
he meeting room ... it's now all the interesting discussions surfaces ... t=
hose hallway discussions :-P
(22:47:29) mattock: excellent stuff!
(22:47:52) waldner: the ASCII asrt diagram sucks, but I think is adequate f=
or the purpose
(22:48:10) waldner: dazo: true
(22:49:10) dazo: nah, ascii art is more than good enough

--------------010901070205020204040308--

