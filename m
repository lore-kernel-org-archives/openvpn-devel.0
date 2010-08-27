Message-ID: <4C77640D.6000708@...515...>
Date: Fri, 27 Aug 2010 10:06:53 +0300
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080301070500070608020003"
Subject: [Openvpn-devel] Summary of the IRC meeting (26th Aug 2010)
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
--------------080301070500070608020003
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the previous community meeting.

---

COMMUNITY MEETING

Place: #openvpn-devel on irc.freenode.net
Date: Thursday, 26th Aug 2010
Time: 18:00 UTC

Planned meeting topics for this meeting were on this page:

<https://community.openvpn.net/openvpn/wiki/Topics-2010-08-26>

Next meeting next week, same place, same time. Your local meeting time
is easy to check from services such as

<http://www.timeanddate.com/worldclock>

or with

$ date -u


SUMMARY

Discussed the status of OpenVPN 2.1.3. This 2.1.3 release candidate
fixed the issue for all who previously had driver signing problems with
Windows Vista/7:

<http://secure.openvpn.net/win>

Agreed that there's no need to postpone release of 2.1.3 further - thus
decided to release it as soon as possible.

--

Discussed dropping support for Windows 2000 in next releases. As
promised last week, Samuli had asked on the -users mailing list if
people still use Win2k with OpenVPN. Only one person responsed, and even
he was not interested in Win2k support in _future_ versions of OpenVPN.
Therefore decided to drop Windows 2000 support after 2.1.3.

--

Discussed the "Compiling OpenVPN v2.1.2 with enable-password-save
option" issue:

<https://forums.openvpn.net/viewtopic.php?f=3D10&t=3D7023>

This allows OpenVPN credentials to be stored in a file. Currently this
is enabled on official OpenVPN _Windows_ builds. Agreed to send mail to
-users mailinglist and take it from there. So far the reaction on the ml
has been positive.

--

Discussed the "Some way of supporting static compilation" issue:

<https://community.openvpn.net/openvpn/ticket/46>

Did some testing to see if creating a static binary would be trivial. As
it was not, decided to ask the Gentoo guys why they need static OpenVPN
binary before going any further.

--

Discussed the "More Flexible TLS Verification for plugins" issue:

<https://community.openvpn.net/openvpn/ticket/44>

Agreed that this functionality would be useful. Dazo agreed to implement
the new version of the plugin interface, which is a prequisite for this
functionality. His patches have already been sent to the -devel mailing
list for review.

--

Discussed the status of Gentoo 2.2-beta3 ebuilds. The Gentoo maintainer
is currently figuring out the best way to approach this issue.

---

Full chatlog as an attachment

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


--------------080301070500070608020003
Content-Type: text/plain; charset="utf-8";
 name=openvpn_irc_meeting_chatlog_2010-08-26.txt
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="openvpn_irc_meeting_chatlog_2010-08-26.txt"

(21:03:55) jamesyonan [~jamesyona@...1320...] =EF=BF=BD=EF=BF=BD entrato ne=
l canale.
(21:04:00) dazo: \o/
(21:04:04) dazo: :)
(21:04:11) mattock: hi james!
(21:04:34) modalit=EF=BF=BD=EF=BF=BD (+o jamesyonan) da ChanServ
(21:04:41) jamesyonan: hi
(21:04:57) mattock: ok, so topics are here: https://community.openvpn.net/o=
penvpn/wiki/Topics-2010-08-26
(21:04:59) vpnHelper: Title: Topics-2010-08-26 =EF=BF=BD=EF=BF=BD=EF=BF=BD =
OpenVPN Community (at community.openvpn.net)
(21:05:32) mattock: shall we start with 2.1.3?
(21:05:52) dazo: yeah, that's a good starter!
(21:05:55) mattock: Ralf on the mailing list is getting restless about 2.1.=
2 being broken...
(21:06:00) mattock: and he's got a point
(21:06:18) dazo: +1
(21:06:21) mattock: jamesyonan: could we release 2.1.3 a.s.a.p. as in now? =
:)
(21:06:28) dazo: and I also gave him a preview of 2.1.3
(21:06:36) dazo: hold the horses a bit!
(21:06:44) jamesyonan: certainly, I can release it today
(21:06:49) dazo: what about --enable-passord-save ?
(21:07:04) jamesyonan: it's usually off by default
(21:07:04) dazo: has that been enabled in earlier releases?
(21:07:11) mattock: oh yes, that one
(21:07:30) jamesyonan: I don't think it's ever been enabled
(21:07:41) dazo: ahh, if it's no regression ... then ship it :)
(21:07:54) dazo: but would be good to validate this
(21:07:56) mattock: yeah, but there's a guy who rebuilds the Windows versio=
n with that option enabled
(21:08:05) mattock: so it's not enabled by default
(21:08:23) mattock: this guy is active in the mailing lists I think
(21:08:40) dazo: okay ... no problem, as long as we are sure
(21:08:41) mattock: Andrew had to use his binary on the Windows build machi=
ne to get it hooked to community vpn
(21:09:04) mattock: anyways, I think we should release 2.1.3 today, then
(21:09:08) cron2: how lame is that, having to use someone else's OpenVPN bi=
nary? *duck*
(21:09:19) mattock: :)
(21:09:28) dazo: the question is then ... should we do some tricks so that =
it could be compile-time enabled, but config disabled by default?
(21:09:52) mattock: jamesyonan: is there a reason why it's disabled by defa=
ult in Windows build?
(21:09:58) jamesyonan: at one time it was proposed to make --enable-passwor=
d-save on by default but there was such an outcry against it that it never =
happened
(21:10:02) dazo: it seems to be a requested feature, and having only compil=
e time enabling seems to be a bit rough for windows users
(21:10:04) mattock: oh
(21:10:15) jamesyonan: but this was years ago
(21:10:33) mattock: perhaps we could ask the people on the -user mailing li=
st and see what they think now
(21:10:55) mattock: it is useful in some scenarios, no doubt about that
(21:11:11) cron2: how difficult would it be to build two sets of windows bi=
naries?
(21:11:44) dazo: jamesyonan:  --auth-nocache doesn't that runtime-disable i=
t?
(21:12:32) jamesyonan: no, --auth-nocache is about disabling the memory cac=
hing of the password for the duration of the session
(21:12:58) jamesyonan: saving passwords is about caching permanently in a d=
isk file
(21:13:36) mattock: would it be possible to make it disabled by default, bu=
t enablable without recompilation?
(21:13:42) dazo: aha ... so that --askpass {FILE} ... will not read {FILE} =
if --enable-password-save is enabled?
(21:13:56) dazo: is *not* enabled
(21:15:08) jamesyonan: let's run it by the lists first -- the primary cause=
 of opposition was that admins didn't want to make it easy for their users =
to save the password
(21:15:37) mattock: jamesyonan: +1
(21:15:41) dazo: +1
(21:15:55) ***dazo thinks a bit further ...
(21:15:59) jamesyonan: but this was years ago when there were not alternati=
ve Windows builds available
(21:16:29) dazo: could it be done in a clever way so that the server could =
enable or disable this feature via a push to the client?  which would only =
be valid via push?
(21:17:03) mattock: server-side setting would be good, if doable
(21:17:19) dazo: when it covers saved passwords to file ... then I do under=
stand the opposition better
(21:17:19) jamesyonan: I believe that ssh does a similar thing, i.e. makes =
it difficult to read password from a file
(21:17:58) dazo: ssh can use $SSH_ASKPASSWD (or something similar)
(21:18:05) mattock: btw. before I forget... only one guy responded to my Wi=
ndows 2000 support mail... and even he was not interested in having win2k s=
upport for _new_ OpenVPN releases=20
(21:18:14) dazo: which points at a script/binary which gives the password
(21:18:18) mattock: so I guess we can drop Win2k support in next release
(21:18:30) dazo: perfect!
(21:18:52) dazo: and we have no test reports for Win2K ... seems people hav=
e fled that one by now
(21:19:49) mattock: fortunately...
(21:19:57) dazo: :)
(21:20:25) mattock: what if I send mail now to the mailing lists about the =
password save option?
(21:20:29) mattock: and we move forward from there
(21:20:59) dazo: I then suggest that we release 2.1.3 as is ... and rather =
do the changes, if accepted by our users in the next release
(21:21:12) mattock: sounds good
(21:21:23) cron2: +1
(21:21:38) mattock: that's settled, then :)
(21:22:22) mattock: ok, so what about 2.2-beta3 release?
(21:22:49) dazo: I will tag the tree now, and push it out
(21:22:54) mattock: was there something missing from 2.1.2 that was require=
d for 2.2-beta3?
(21:23:02) dazo: then jamesyonan should be able to build from git or a tarb=
all from mattock=20
(21:23:11) dazo: yeah, updates to the build script
(21:24:17) mattock: I was wondering if we should have our users "smoke test=
" each release beforehand (similarly to 2.1.3) by asking them on -users?
(21:24:19) dazo: and we have a few community fixes in the meantime as well
(21:24:34) mattock: say, a few days / a week before release?
(21:24:42) dazo: nah, it's beta ... it's supposed to fail, especially early=
 betas ;-)
(21:24:45) mattock: ok :D
(21:25:08) cron2: mattock: i'm with dazo here
(21:25:17) mattock: fine with me
(21:25:27) cron2: the point of beta is "this is broken, go test it now"
(21:25:39) mattock: got to love this positive attitude :)
(21:26:07) mattock: that's true, though...
(21:26:41) mattock: just a clarification... the option we'll ask our users =
about is "auth-user-pass"?
(21:27:07) dazo: mattock:  git tree tagged pushed .... v2.2-beta3 is availa=
ble
(21:27:11) mattock: nice!
(21:27:25) mattock: I'll create the tarballs tomorrow morning and send a li=
nk to james
(21:27:36) dazo: perfect!
(21:27:43) jamesyonan: mattock: well the issue is really the ./configure --=
enable-password-save option
(21:27:57) mattock: jamesyonan: ok
(21:28:54) mattock: jamesyonan: when could you build the Windows installer =
and push out 2.2-beta3?
(21:29:01) mattock: by Monday?
(21:30:44) jamesyonan: mattock: I can do the Windows build fairly easily if=
 there aren't any glitches
(21:30:58) mattock: just let us know if you encounter _any_ issues
(21:31:10) dazo: hopefully not ... not with latest 2.1.3 changes merged int=
o beta2.2
(21:33:19) mattock: hmm, should we discuss static compilation now?
(21:33:31) dazo: +1
(21:33:32) mattock: https://community.openvpn.net/openvpn/ticket/46
(21:33:33) vpnHelper: Title: #46 (Some way of supporting static compilation=
) =EF=BF=BD=EF=BF=BD=EF=BF=BD OpenVPN Community (at community.openvpn.net)
(21:34:03) mattock: what's required at our end for static compilation to wo=
rk?
(21:34:19) dazo: update autoconf scripts, I'd say
(21:34:24) ***cron2 wonders what the point is, as glibc will always do some=
 dynload things
(21:34:46) dazo: some security oriented distroes like to do static compilat=
ions of some packages
(21:35:09) cron2: so there is no way to fix openssl bugs without recompilat=
ion of everything?  good plan
(21:35:10) dazo: to avoid a borken ssl lib or other stuff loaded via LDPREL=
OAD to influence the behaviour
(21:36:04) cron2: but anyway, more positive: I have seen other packages do =
"configure --enable-static", so there seems to be configure magic that we c=
ould tap into
(21:36:05) dazo: This request comes from Gentoo ... and it might be related=
 to the Tin Hat distro ...
(21:36:18) cron2: Tin Foil Hat distro? *duck*
(21:36:19) dazo: exactly ... and we're missing --enable-static now
(21:36:50) dazo: cron2:  http://opensource.dyc.edu/tinhat ;-)
(21:36:51) vpnHelper: Title: Tin Hat | opensource.dyc.edu (at opensource.dy=
c.edu)
(21:36:55) dazo: not far from the truth ;-)
(21:37:28) jamesyonan: what is the problem?  Is there something we are doin=
g in configure.ac or Makefile.am that breaks static compilation?  Or do we =
need some special code there to enable it as an option?
(21:38:12) dazo: we need to somehow enable static compilation support in au=
totools ... I don't know how that's really done yet ... but I've seen OpenS=
SH having this support
(21:38:13) cron2: I think if a system has a shared and static library, the =
linker will default to "shared", so we need to add -static to gcc to get th=
e static linking
(21:38:24) dazo: (Gentoo now patches Makefile after having run ./configure)
(21:39:03) ***cron2 looks at openssh configure*
(21:39:24) dazo: yeah, and you need to link against lib{LIBRARY}.a instead =
of -l{LIBRARY}
(21:39:46) cron2: dazo: I don't think that's needed - that's the point of "=
-static", the linker knows how to do that
(21:40:03) dazo: but it needs access to the .a file at least, iirc=20
(21:40:23) cron2: sure, "-l$lib" + -Lpath, works for .a as well as for .so
(21:42:14) mattock: hmm... I wonder if we could discuss this issue with the=
 Gentoo maintainer
(21:42:37) mattock: to understand the problem and potential solutions better
(21:42:39) cron2: there's no mention of "static" in the current OpenSSH's c=
onfigure :(
(21:42:57) cron2: gcc docs say "call gcc with -static is sufficient"
(21:43:05) dazo: mattock:  I tried ... and he responded he don't know autot=
ools good enough to do this .... that's why they patch Makefile ... which i=
s really hacky
(21:43:19) dazo: hmm
(21:43:58) mattock: nobody else has complained about this, right?
(21:44:14) dazo: not which I know about :)
(21:44:19) mattock: I wonder why they need static compilation...=20
(21:44:43) jamesyonan: why not just add --enable-static to configure.ac and=
 have it add -static to gcc options
(21:44:52) cron2: something like that, yes
(21:45:09) mattock: hmm, if that's so easy, why not
(21:45:19) dazo: if that works, go for it!
(21:46:04) dazo: might be that Alon will frown upon us, though :)
(21:46:27) dazo: (if there is a more "standard" way to do it, though)
(21:47:16) mattock: if it's that easy, let's do it... if it gets hairy, per=
haps ask Gentoo maintainer "why should we do this"?
(21:47:23) cron2: well, we could ask him (Alon, that is)?
(21:47:50) jamesyonan: CFLAGS is passed through to configure -- so in theor=
y you could do:
(21:47:53) dazo: sure!  That's worth a shot
(21:48:04) jamesyonan: CFLAGS=3D"-static" ./configure
(21:48:54) dazo: jamesyonan got a very valid point there!
(21:49:35) mattock: I'll try that
(21:50:38) mattock: hmm, I get "configure: error: OpenSSL SSL library not f=
ound."
(21:51:03) mattock: without "-static" configures just fine
(21:51:19) dazo: you must have the static openssl libraries installed
(21:52:03) mattock: okay
(21:52:54) mattock: I can test tomorrow if installing static OpenSSL libs s=
olves this issue
(21:52:58) jamesyonan: you have to have the whole library dependency tree o=
f OpenVPN available statically
(21:53:07) dazo: true
(21:53:39) mattock: hmm, perhaps I'll ask the Gentoo guys to do the testing=
 for me... they can build static stuff easier than me
(21:53:58) mattock: dependencies espc.
(21:54:45) ***dazo tries on one of his Gentoo boxes now
(21:54:58) mattock: nice!
(21:55:18) mattock: meanwhile we can feast our eyes on this: https://commun=
ity.openvpn.net/openvpn/ticket/44
(21:55:20) vpnHelper: Title: #44 (More Flexible TLS Verification for plugin=
s) =EF=BF=BD=EF=BF=BD=EF=BF=BD OpenVPN Community (at community.openvpn.net)
(21:56:46) mattock: jamesyonan: so currently only some parts of the certifi=
cate are exposed to plugin developers?
(21:56:52) dazo: correct
(21:57:21) mattock: is there any (security?) reason why we couldn't expose =
the field he's talking about? or even the whole certificate?
(21:57:32) jamesyonan: the traditional method of adding features like these=
 has been to have tls_verify extract the cert properties and place them in =
the env var list that is passed to the plugin
(21:57:36) dazo: the eurephia patch which we have in 2.2-beta ... that enab=
les tls_digest_X which is the digest (aka. SHA1 fingerprint) as an environm=
ent variable
(21:58:12) mattock: ok, so what he's suggesting _is_ doable already?
(21:58:25) jamesyonan: no, not really
(21:58:26) dazo: jamesyonan:  with tls_verify ... you mean the function in =
ssl.c?
(21:58:33) jamesyonan: yes
(21:59:54) jamesyonan: but I think he's proposing that we change the plugin=
 API so that the actual OpenSSL certificate objects are passed to the plugin
(22:00:00) dazo: I would say it is doable in theory ... but I'm really not =
sure which method of doing it is best .... environment variables might be t=
oo small/limited for several kb of data
(22:00:17) dazo: putting it to a file, is a security issue
(22:00:23) dazo: so the last option is to modify the API
(22:00:34) mattock: the "--enable-password-save" email here: http://pastie.=
org/1118604
(22:00:41) mattock: shall I press "Send"?
(22:01:12) mattock: how extensive changes the API would need?
(22:01:13) dazo: mattock:  +1
(22:01:26) jamesyonan: mattock: sure
(22:01:28) mattock: some small changes?
(22:01:29) cron2: mattock: +1
(22:01:34) mattock: ok
(22:01:42) mattock: let's see what kind of noise that raises
(22:02:04) mattock: sent
(22:02:09) jamesyonan: well the problem with API changes is that then you m=
ight need to introduce a new version of the API method so as not to break o=
ld plugins
(22:02:24) mattock: is the API documented somewhere?
(22:02:45) dazo: it might not be too big ... but ... there are more approac=
hes to do this .... I'm not sure adding yet another variable to the openvpn=
_plugin_func_vX() is the best approach
(22:02:52) dazo: openvpn-plugin.h
(22:03:31) mattock: and he suggest that "By providing plugin developers the=
 full certificate, they may implement domain specific requirements as neede=
d."
(22:03:56) dazo: which is true ... and a valid point
(22:04:55) mattock: any reason why not to do that?
(22:05:03) mattock: except the time required, that is
(22:05:21) jamesyonan: well how would we pass the certificate object to the=
 plugin method?
(22:05:34) dazo: no, I do not see any issues not to do this ... in fact, if=
 I had that feature available when I started eurephia, I would not need to =
patch OpenVPN
(22:06:27) jamesyonan: maybe we should implement a general method of passin=
g objects (rather than merely key/value pairs via env vars) to plugin metho=
ds
(22:06:38) dazo: jamesyonan:  what if we have a v3 plugin interface, which =
cleans up some of the input arguments to openvpn_plugin_func_v3() ... givin=
g a struct instead with pointers to the different variables
(22:06:51) jamesyonan: then if we think of more objects to pass in the futu=
re, we don't have to change the API
(22:07:09) dazo: then we can add the certificate list ... which would point=
 to X509 objects, usable directly via openssl libs
(22:07:32) dazo: this pointer would be NULL on non TLS plugin-hooks
(22:07:49) jamesyonan: sure, that makes sense
(22:08:18) jamesyonan: we would need to version-tag the struct so it can ex=
pand in the future without breaking older plugins
(22:08:33) dazo: yeah, true
(22:09:14) dazo: another similar approach would be a pointer chain struct .=
...  struct plugin_args { const char *name, const void *data, struct plugin=
_args *next }
(22:09:36) dazo: that way the plugin would have to loop through to look for=
 the "name"d data they are looking for
(22:10:50) jamesyonan: sure, that would work, but would require more suppor=
t code for allocating objects
(22:11:05) dazo: yeah, which is why I don't like that idea _that_ much :)
(22:11:49) jamesyonan: how about just a struct with a version number as the=
 first item followed by data items
(22:12:02) dazo: but the former idea, with a not so flexible struct, could =
just have a "int version" variable ... the plug-in would need to validate t=
hat the version is good ... and if compiling on older openvpn, it would fai=
l to compile
(22:12:14) dazo: heh
(22:12:23) dazo: great minds things alike?
(22:12:24) dazo: :-P
(22:12:45) mattock: dazo: did the Gentoo build succeed?
(22:13:05) dazo: mattock:  nope ... same error as you ... even though I hav=
e the .a files available in the path
(22:13:11) mattock: oki
(22:13:38) mattock: do we want to try to fix this or ask Gentoo guys "why"?
(22:13:55) dazo: I'd say we ask Gentoo guys :)
(22:14:05) mattock: ok
(22:14:07) jamesyonan: I was thinking that we could sort of "guarantee" tha=
t newer versions of the struct would only add new items to the end of the s=
truct, so older plugins could support as long as version number is >=3D to =
what they expect
(22:14:30) mattock: dazo: I'll ask, then
(22:15:08) dazo: jamesyonan:  exactly!   but I thought of the scenario that=
 someone tries to build a plug-in against an older OpenVPN without the vari=
ables they need
(22:15:53) dazo: but that would not be an unexpected scenario, though
(22:16:04) jamesyonan: dazo: how could that not fail?
(22:16:30) dazo: I think I'm saying the same as you, jamesyonan ;-)
(22:16:59) dazo: but!  this would be tricky with ABI compatibility across p=
recompiled versions, though
(22:17:09) jamesyonan: well the idea is that the plugin could detect the ve=
rsion mismatch and fail gracefully
(22:17:18) dazo: yeah
(22:19:12) mattock: do you guys know what to do now? should we ask if someb=
ody on the ml wants to help implement this?
(22:19:22) mattock: this is pretty general purpose stuff I think
(22:19:46) ***dazo begins to get the feel of this ... and is willing to pok=
e into a patch already
(22:19:56) mattock: nice!
(22:20:36) mattock: I think we should more actively send "does somebody wan=
t to work on this with me" -mails to -devel...=20
(22:20:46) dazo: yeah, true enough :)
(22:20:50) mattock: does not hurt to ask
(22:21:11) mattock: if somebody wants the feature in question, there's a go=
od chance he'll help (if he can)
(22:21:19) dazo: sure not ... but some times, that can lead to over-design =
... it's better to put it in our TODO list=20
(22:22:02) mattock: yeah, I see what you mean... I remember a few long disc=
ussion threads like that
(22:22:11) dazo: yeah
(22:23:06) mattock: ok, what about gentoo (2.2-beta) packages?
(22:23:08) mattock: any news?
(22:23:12) dazo: I
(22:23:42) dazo: I've not heard anything more ... the maintainer sounded ve=
ry positive ... but he would need to look into how to do this in the best w=
ay
(22:23:58) dazo: as he said, not everyone is willing to run beta versions i=
n production :)
(22:24:40) mattock: yeah, I'm moving from Debian Testing to stable... and t=
his time (which is third) for good
(22:24:43) mattock: :)
(22:24:43) ***dazo expects an openvpn-beta port in emerge
(22:25:00) mattock: hmm, I'm afraid we've ran out of topics...
(22:25:20) dazo: whot!?!?!?!  We've only been here for 1.5 hour! :-P
(22:25:23) mattock: yep
(22:25:30) mattock: that's pretty standard time, actually
(22:25:50) mattock: a bit on the low side, though
(22:26:14) mattock: jamesyonan: could you let us know when you push out 2.1=
.3?=20
(22:26:35) dazo: jamesyonan:  I see that you don't have any openvpn_plugin_=
{close,abort}_v2() functions, only v1 ... is the v1 version called on v2 pl=
ug-ins in this case?
(22:26:38) mattock: I'll create the tarballs from 2.2-beta3 and send them a=
 link to you
(22:26:42) jamesyonan: I can do it before tomorrow
(22:26:50) mattock: jamesyonan: great!
(22:26:59) dazo: \o/
(22:27:46) mattock: mkay, anything else? I'd like to go for a walk. Been to=
o much inside last few days :)
(22:28:10) dazo: run, mattock, run!
(22:28:12) dazo: :-P
(22:28:18) mattock: great! I will! :D
(22:28:27) mattock: I'll write the summary tomorrow, as usual
(22:28:36) jamesyonan: bye all
(22:28:42) mattock: bye!
(22:28:44) dazo: c'ya!
(22:28:48) ecrist: l8r

--------------080301070500070608020003--

