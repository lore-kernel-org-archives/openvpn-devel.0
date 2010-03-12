Message-ID: <4B9A3AD7.5080805@...515...>
Date: Fri, 12 Mar 2010 15:00:07 +0200
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060607060801010208060108"
Subject: [Openvpn-devel] Summary of the IRC meeting (11th Mar 2010)
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
--------------060607060801010208060108
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the previous community meeting.

---

COMMUNITY MEETING

Place: #openvpn-discussion on irc.freenode.net
Date: Thursday, 11th March 2010
Time: 18:00 UTC

Planned meeting topics for this meeting were on this page:

http://www.secure-computing.net/wiki/index.php/OpenVPN/IRC_meetings/Topics-=
2010-03-11


Next meeting next week, same place, same time.


SUMMARY

Decided to include the following patches in "testing":

* [PATCH] On TARGET_LINUX define _GNU_SOURCE if not defined
  - a.k.a. "Gentoo patch"
  - http://thread.gmane.org/gmane.network.openvpn.devel/3303

Decided to ask users to test the following patch on pre-Debian Lenny
distros before giving it an ACK:

* [PATCH] The man page needs dash escaping in UTF-8 environments
  - works on Debian Lenny / Squeeze and Ubuntu 9.10 using UTF8/C locales
  - http://thread.gmane.org/gmane.network.openvpn.devel/3209

Decided to ask our users whether they need support for old autotools
versions. If not, support for old autotools (e.g. the one in RHEL4.x)
can safely be dropped if we wish. Also decided to check out what
benefits moving to newer autotools version would give us. Note that
autotools is required when building OpenVPN from SVN/Git, but not when
building from release tarballs.

Decided to ask author of this patch to fix the issues with this patch:

* NON_CBC_CIPHER bug / [PATCH] Don't ASSERT() on stream cipher
 - http://thread.gmane.org/gmane.network.openvpn.devel/3286
-https://sourceforge.net/tracker/index.php?func=3Ddetail&aid=3D1552062&grou=
p_id=3D48978&atid=3D454721

Decided to wait for additional clarifications to following issue:

* HMAC calculation questions
  - http://thread.gmane.org/gmane.network.openvpn.devel/3279
  - http://thread.gmane.org/gmane.network.openvpn.devel/3294

Discussed this issue in great length:

* Supporting "route-gateway dhcp" on non-Windows
  - http://thread.gmane.org/gmane.network.openvpn.devel/3260/

---

Full chatlog as an attachment


--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

--------------060607060801010208060108
Content-Type: text/plain; charset="utf-8";
 name=openvpn_irc_meeting_chatlog_2010-03-11.txt
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="openvpn_irc_meeting_chatlog_2010-03-11.txt"

11:57 -!- jamesyonan [~jamesyona@...1320...] has joined ##openvpn-discussion
12:00 <@mattock> hi james!
12:01 < dazo> Hi y'all!
12:01 -!- Kas [~Kasx@...1321...] has joined ##openvpn-discussion
12:01 -!- mode/##openvpn-discussion [+v Kas] by ChanServ
12:01 <@mattock> so dazo made a list of todays topics here: http://www.secu=
re-computing.net/wiki/index.php/OpenVPN/IRC_meetings/Topics-2010-03-11
12:01 < vpnHelper> Title: OpenVPN/IRC meetings/Topics-2010-03-11 - Secure C=
omputing Wiki (at www.secure-computing.net)
12:01 <@mattock> btw thanks dazo :)
12:02 < dazo> mattock:  you're welcome :)
12:02 <@mattock> what about this HMAC issue: http://sourceforge.net/mailarc=
hive/forum.php?thread_name=3DCOL113-W51C6B9F7CC25D3F2F3F11EBA330%40phx.gbl&=
forum_name=3Dopenvpn-devel
12:02 < vpnHelper> Title: SourceForge.net: OpenVPN: openvpn-devel (at sourc=
eforge.net)
12:02 < jamesyonan> Hi all
12:03 <@mattock> is it something we should look at
12:03 <@mattock> ?
12:04 < dazo> This person sent me an e-mail directly today ... I asked if s=
he (presume it's a she) knows that not the complete HMAC file is used
12:04 < dazo> (well, I got the mail 3AM my time)
12:05 <@mattock> ok, so things are under control then :)
12:06  * dazo suggests, if possible, that someone with knowledge either giv=
es me needed info or takes direct contact with her
12:06 <@mattock> who has enough knowledge to troubleshoot this?
12:07 < jamesyonan> what exactly is she claiming?  That OpenVPN is computin=
g the HMAC incorrectly?
12:07 <@mattock> james: I assume that's what she means
12:08 < dazo> I understood it a bit different ... that the calculations she=
 does, do not give the expected results .... since OpenVPN do work here, at=
 least, I'm using --tls-auth on 3 different setups myself ....
12:09 < dazo> that's why I'm wondering if she is using the complete content=
s of the tls-auth file .... or just the needed fragments of it
12:11  * dazo sent a reference to the official ovpn faq, about why the stat=
ic key still works even if just a few bytes are changed
12:11 <@mattock> perhaps we should just wait and see what she says
12:11 < dazo> yeah, the information we have is a bit vague, tbh
12:11 <@mattock> her mail is a bit hard to understand, so I think clarifica=
tions are needed
12:12 <@mattock> perhaps we should move on to the ACK/NACK issues
12:12 < dazo> I'll keep the list updated when I get more info
12:12 < dazo> yes please :)
12:12 < jamesyonan> We are just calling the standard HMAC routines in OpenS=
SL.=20
12:13 < dazo> I expected that (I've not looked at the code) ... that's why =
I have the feeling that it is related to using a wrong HMAC key
12:13 < jamesyonan> What she should do is look at the 'work' buffer in open=
vpn_encrypt, just prior to the HMAC calculation, and confirm that it matche=
s her interpretation of the OpenVPN security model
12:13 <@mattock> dazo: that was my initial thought also, given keys are inv=
olved in the hash
12:14 < dazo> jamesyonan:  that's a good pointer!  I'll provide that info!
12:14 <@mattock> ok, on to next issue: [PATCH] On TARGET_LINUX define _GNU_=
SOURCE if not defined ("Gentoo patch")
12:15 <@mattock> ACK or NACK?
12:15 < dazo> that one threw off quite a generic discussion about autotools=
 in general
12:15 <@mattock> dazo: I think we should discuss the autotools issue also, =
but keep it shorter than the email thread :)
12:16 < dazo> jamesyonan:  one question ... Alon says (and I can confirm) t=
hat you don't need to care about autotools versions in the tarballs when yo=
u use 'make dist'
12:16 < jamesyonan> is there a reason why this issue is not properly addres=
sed by AC_GNU_SOURCE?
12:16 < dazo> is there a reason we need to support bootstrapping the source=
 code on older autotools versions?
12:16 -!- d12fk [~quassel@...1322...] has joined ##openvpn-discussion
12:17 < dazo> jamesyonan:  I honestly don't know why AC_GNU_SOURCE is not e=
nough ... my autotools-foo is not high enough yet
12:17 < d12fk> re
12:17 < jamesyonan> dazo: but often OpenVPN is build from subversion direct=
ly, not from the tarball
12:18 < dazo> jamesyonan:  also on such old platforms as RHEL4.6?
12:19 < jamesyonan> I suppose I would ACK then -- it seems trivial enough. =
 Presumably it's been build-tested on a few distros?
12:20 <@mattock> perhaps the autotools issue would fit into our neat "Featu=
re deprecation process"...
12:20 < dazo> I've tested it on RHEL4.6 and Fedora 12, so they are "related=
" .... so I've not done much testing on other ones ... but that's going to =
be tested elsewhere with the testing tree=20
12:20 < dazo> mattock:  I'm not too sure about that .... as this is not a c=
ode related thing ... it's a build related thing ....
12:21 <@mattock> but for users it's a feature (=3Dto be able to build with =
older autotools), right?=20
12:21 < dazo> I can stretch myself to a build-feature ... it's definitely n=
ot an openvpn feature
12:22 <@mattock> true
12:22 < jamesyonan> currently, we only put source files in the svn, not mac=
hine-generated files
12:22 <@mattock> so first we'd ask people if they build OpenVPN from SVN/Gi=
t on Redhat 4.6 or similar
12:23 < dazo> jamesyonan:  and that's the right way to do it, IMHO
12:23 < jamesyonan> so with this approach, the configure.ac needs to be com=
patible with old autotools versions
12:24 < dazo> jamesyonan:  oki ... I'll accept this now ... we can have a m=
ore careful discussion about this topic at a later point
12:24 < d12fk> but wouldn't have ppl who build it on such old RHEL system a=
lso have a more recent Unix somewhere, where they could make a dist tarball?
12:24 <@mattock> d12fk: good point
12:24 <@mattock> btw. what problems does the support for old autotools caus=
e?
12:24 <@mattock> meaning: why are we having this discussion ;)
12:25 < d12fk> old autotoola are buggy, and some nice features are missing
12:25 < dazo> +1
12:26 < dazo> and as Peter Stuge said in the mail thread .... newer version=
s might even give better tarballs for older distroes, just because of less =
bugs
12:26 <@mattock> I suggest we ask people in -users and -devel if they indee=
d build OpenVPN SVN/Git versions with Redhat 4.6 or older
12:27 <@mattock> then see what happens
12:27 < dazo> IMO, I don't see the need for supporting anything else than t=
he latest autotools after the discussion with Alon ... older systems can be=
 compiled, even with autotools not installed ... as long as make dist has b=
een run
12:27 < dazo> mattock:  lets do that
12:27 < jamesyonan> I regularly build on RHEL 4 (4.6) just to test that cha=
nges do not break anything on early Linux versions
12:28 < jamesyonan> what are some of the "nice features" we would get by re=
quiring autotools latest version?
12:28 <@mattock> jamesyonan: but that's not mandatory, right? You could cre=
ate a Redhat 4.6 compatible tarball on another machine with latest autotool=
s installed.
12:28 < d12fk> i honestly doubt that many users build from svn directly, un=
less they are developers themself
12:30 < dazo> jamesyonan:  I'm not necessarily concerned about features rig=
ht now, but there are bug fixes which might complicate things .... but have=
 a colleague who is a autotools expert, I'll drop him an e-mail and ask
12:30 <@mattock> d12fk: I think so too, but I'll send a few mails tomorrow =
to get a better picture
12:30 <@mattock> dazo: good idea
12:30 < jamesyonan> so if we decide to require latest autotools version, do=
es that mean we don't need this patch?
12:31 < dazo> it could actually mean that, to some extent yes
12:31 <@mattock> dazo: so is it a NACK until the autotools issue is settled?
12:31 < dazo> mattock:  agreed!
12:32 <@mattock> ok, I'll send mails to -users and -devel tomorrow, explain=
ing what we'd like to do
12:32 <@mattock> in the true FRP style ;)
12:32 < jamesyonan> But if Gentoo is using it, then presumably their build =
system isn't capable of building the ./configure script on a recent autocon=
f version for older distros?
12:32 < dazo> perfect!
12:33 <@mattock> good point, james
12:33 < dazo> it could be something like that ... I have not gotten into de=
tails ... as this patch was added early in the 2.1_rc cycles
12:33 < dazo> The ./configure script do not depend on autotools at all
12:34 < dazo> it is only needed in the moment the generated scripts notices=
 the autotools source files have changed
12:34 < jamesyonan> so perhaps the existence of this patch means that peopl=
e (i.e. Gentoo team) still need to build from svn with older autotools?
12:35 <@mattock> jamesyonan: you mean that with newer autotools build fails?
12:35 < jamesyonan> dazo: I don't understand... autotools generates ./confi=
gure=20
12:36 < dazo> yes ... and that happens on the host you run autoreconf
12:37 < dazo> then you do 'make dist'  which creates a tarball, including a=
ll generated scripts .... like ./configure .... that tarball can be extract=
ed on a box without any autotools at all, and it will work
12:37 < jamesyonan> dazo: no I'm saying that we should inquire a bit deeper=
 before we assume that people don't need to be able to build from svn sourc=
e on old platforms without duct-tape solutions such as regenerating ./confi=
gure on a newer distro
12:38 <@mattock> let's ask people what they think and go from there
12:38 < jamesyonan> dazo: but I'm talking about the svn co 	autoreconf -i -v
12:38 < jamesyonan> 	./configure
12:38 < jamesyonan> 	make dist
12:38 < jamesyonan> method
12:39 < jamesyonan> i.e. not building tarball as intermediate step
12:39 < dazo> jamesyonan: agreed!  Just a question, when you prepare the ta=
rball for release/distribution .... I presume you use 'make dist' or 'make =
distcheck', right?
12:39 < jamesyonan> yes, sure
12:40 < jamesyonan> but automated build systems often want to build directl=
y from svn
12:41 <@mattock> I'll ask what our users think about this
12:41 < jamesyonan> why don't we accept the patch for now, but float the id=
ea of restricting to latest autoconf version, and see how it flies.=20
12:41 < dazo> what I believe can be a cause of this needed patch in Gentoo,=
 which is why I haven't seen it on my platforms (as I build from the git an=
d svn tree) ... is that the distributed tarball then do have a bug (due to =
the older version) ... which do not make the right usage of AC_GNU_SOURCE .=
... which means, they added a patch to socket.c to get it compiled properly
12:42 <@mattock> jamesyonan: agreed
12:43 <@mattock> ACK the patch + discuss the autotools issue with our users=
? agreed?=20
12:43 < jamesyonan> ACK
12:43 < dazo> ACK
12:44 <@mattock> ok, on to the next issue
12:44 <@mattock> this should be simpler :)
12:44 <@mattock> [PATCH] The man page needs dash escaping in UTF-8 environm=
ents
12:45 < dazo> to summarize it .... in openvpn.8, all -- is changed to \-\- =
... for proper UTF-8 escaping .... but, I'm not sure how this influences no=
n-utf8 environments
12:45 <@mattock> I assume the Debian fix has not caused any problems with n=
on-UTF8 encodings
12:46 < jamesyonan> this is probably necessary, but it would be nice if we =
could re-source the man page source as a more human-readable document
12:46 < jamesyonan> are there automated tools that could convert the existi=
ng source to something like docbook?
12:46 < dazo> mattock:  that's often default distro settings .... if Debian=
 switched to utf-8 and introduced this one ... they might not have ran this=
 on non-utf8 in Debian after that switch at all
12:47 <@mattock> dazo: I'll check what happens on my Debian box
12:47 < dazo> jamesyonan:  I don't know ... but I know it is the other way =
around
12:47 <@mattock> perhaps you could discuss the next issue while I test this?
12:48 < cron2> re
12:48 < dazo> jamesyonan:  I presume this will be a one-time-job ... I'd pr=
esume copy-paste from xman or something like that is just as quick and effi=
cient
12:48 < cron2> evening planning changed, I'm here after all :)
12:48 < dazo> \o/
12:48 < dazo> NON_CBC_CIPHER bug / [PATCH] Don't ASSERT() on stream cipher
12:49 <@mattock> hi cron2!
12:49 < dazo> http://thread.gmane.org/gmane.network.openvpn.devel/3286
12:49 < vpnHelper> Title: Gmane Loom (at thread.gmane.org)
12:49 < dazo> (next topic)
12:49 < cron2> hi mattock, dazo, james, d12fk
12:50 < jamesyonan> So basically the assertion is bypassed when mode !=3D E=
VP_CIPH_CBC_MODE
12:50 < dazo> yeah=20
12:51 < jamesyonan> wouldn't it make more sense to modify the assertion so =
it makes sense for all modes?
12:51 < dazo> my concern is that this is hitting more than just stream ciph=
ers .... so that !=3D  EVP_CIPH_CBC_MODE  is not the right solution
12:52 <@mattock> regarding the man-page UTF8 fix
12:52 < dazo> "And we found the bug:
12:52 < dazo> function EVP_CipherFinal() returns 0, when cipher has
12:52 < dazo> block_size =3D=3D 1(stream cipher). So hear is the patch to
12:52 < dazo> fix the bug.
12:52 < dazo> "
12:52 <@mattock> seems to work on both fi_FI.UTF8 and C locales
12:52 < dazo> jamesyonan:  ^^
12:52 <@mattock> searching with less as the pages, e.g.
12:52 <@mattock> /--dev-type
12:52 < jamesyonan> Agreed.  The proper fix should be to assert the correct=
 outlen value for any cipher mode.
12:53 <@mattock> finds everything correctly regardless of the locale
12:53 <@mattock> using Debian testing, ~2 weeks old
12:53 < jamesyonan> mattock:  did you test on old linux versions?
12:54 < dazo> jamesyonan:  I don't follow you now .... the original version=
 does assert() check on all cipher modes, which hurts stream cipher .... th=
e patch does only assert() check when mode =3D=3D EVP_CIPH_CBC_MODE
12:54 <@mattock> jamesyonan: nope, Ubuntu 9.10 is the oldest I got
12:55 < dazo> mattock:  jamesyonan: RHEL4.6 is UTF-8 by default
12:55 < jamesyonan> dazo: the point of the assert is to verify that EVP_Cip=
herFinal returns an outlen that makes sense to us
12:56 <@mattock> man page seems to work on Ubuntu 9.10 with both UTF8 and C=
 locales
12:56 <@mattock> I can't do more testing than that
12:56 < jamesyonan> we want to establish that outlen makes sense regardless=
 of whether EVP_CIPH_CBC_MODE is being used or not
12:57 < dazo> yes ... and then we're back at the starting point, without th=
is patch, aren't we?
12:57 < dazo> -	  ASSERT (outlen =3D=3D iv_size);
12:57 < dazo> +	  if (mode =3D=3D EVP_CIPH_CBC_MODE)
12:57 < dazo> +            ASSERT (outlen =3D=3D iv_size);
12:57 < dazo> (the patch itself)
12:58 < dazo> outlen !=3D iv_size when a stream cipher is used, that's the =
core issue .... so, then this assertion needs to be modified then, and not =
only do this check when mode =3D=3D EVP_CIPH_CBC_MODE
13:00 < jamesyonan> what is outlen when a stream cipher is used?
13:01 < dazo> "function EVP_CipherFinal() returns 0, when cipher has block_=
size =3D=3D 1(stream cipher)."
13:01 < dazo> that's what the commit log says
13:01 < dazo> so I understand that as outlen is set to 0, in this case
13:01 <@mattock> Debian Lenny (stable) man pages seem to work with UTF8 and=
 C, too
13:02 < jamesyonan> well then we should ASSERT(outlen=3D=3D0) in this case
13:03 < jamesyonan> mattock: can someone test that the man page changes doe=
sn't break early linux versions
13:03 < dazo> jamesyonan:  yeah, I can agree to that one .... which ciphers=
 are stream modes then?
13:04 < jamesyonan> maybe there is an OpenSSL flag that indicates that?
13:04 <@mattock> jamesyonan: I'll send mail to the mailinglists and ask
13:05 <@mattock> [TESTING NEEDED]
13:05 <@mattock> that way we've at least done our best to avoid any problem=
s with old distros
13:06  * dazo need to dig deep into OpenSSL then to figure out that then
13:06 < dazo> jamesyonan:  I'll suggest we NACK this patch, and we'll get e=
ither the patch submitter to look at it, or I'll put it into a TODO list
13:07 <@mattock> dazo: preferably let the submitter handle it
13:07 <@mattock> if he's available
13:07 < jamesyonan> +1
13:07 <@mattock> I would not like dazo's TODO-list to grow too long
13:07 < dazo> agreed, but it was submitted in 2006 .... so he might just ig=
nore us now
13:07 <@mattock> dazo: perhaps it's worth the try anyways
13:08 < dazo> mattock:  I was thinking about a public TODO list, where peop=
le could take tasks ;-)
13:08 <@mattock> good idea, actually
13:08  * dazo got a way too long personal TODO list already :)
13:08 <@mattock> I think people often have difficulty knowing _how_ to help=
, even if they're willing
13:08 < dazo> yup!
13:08 <@mattock> what do you think about sending TESTING requests directly =
to -users ml?
13:09 < dazo> +1
13:09 <@mattock> or rather, both mailinglists
13:09 <@mattock> to reach widest possible audience
13:09 < jamesyonan> OpenSSL defines EVP_CIPH_STREAM_CIPHER
13:09 <@mattock> I don't think a couple of mails a week hurt anyone
13:10 -!- rob0 [~rob0@...1323...] has joined ##openvpn-discussion
13:10 < jamesyonan> this can be used to determine if a stream cipher is bei=
ng used
13:10 < rob0> oh I'm late :)
13:10 <@mattock> rob0: welcome!
13:10 < dazo> jamesyonan:  good one! I'll write it down .... and I'll respo=
nd with this info to the sf.net tracker=20
13:10 < cron2> reb0: 70 minutes :-) - but welcome anyway!
13:11 < rob0> :)
13:11 < rob0> (I thought it was 1900)
13:11 <@mattock> dazo: so the cipher issue is settled (for now)?
13:11 < cron2> rob0: in MET, it is :)
13:11 < jamesyonan> In general, I think it's a good idea to support non-CBC=
 cipher modes
13:11 < dazo> mattock:  yup!
13:12 <@mattock> ok, a brief summary at this point...
13:12 < cron2> rob0: we moved the meeting to "one hour earlier" two weeks a=
go, to better accomodate dazo's schedule
13:12 <@mattock> ACK the Gentoo patch, ask for old autotools support in ml=
=20
13:12 <@mattock> the man page UTF8 patch: ask users to test on older distro=
s (pre-Debian Lenny)
13:13 <@mattock> cipher bug is handled by dazo
13:13 <@mattock> should we try to cover a couple more?
13:14 <@mattock> oh, and the HMAC issue is waiting for more info from Jessi=
ca
13:14 <@mattock> what about this: "An update on the --passtos for tagged et=
hernet frames"
13:14 < dazo> mattock:  I'd like to hand-over the next phases of the --pass=
tos patch ... I got in contact with the patch developer ... and I have a "t=
est script" ... how to test docs ....=20
13:14 < dazo> somebody up to follow up that one further?
13:15 < dazo> (the patch submitter is using the patch in a bigger environme=
nt with some 100 clients, if I understood it correctly)
13:16 <@mattock> dazo: what should be done next?
13:16 < dazo> mattock:  Development TODO list - http://www.secure-computing=
.net/wiki/index.php/OpenVPN/Development-TODO
13:16 < vpnHelper> Title: OpenVPN/Development-TODO - Secure Computing Wiki =
(at www.secure-computing.net)
13:16 <@mattock> I mean with --passtos patch :)
13:16 < dazo> mattock:  somebody should test out the test documentation I g=
ot ... put it on a wiki ... and ask for testers
13:17 <@mattock> where's the test documentation? could I do the job (=3Ddoe=
s it require programming in C :)
13:17 < dazo> the --passtos patch are in the git tree ... but not merged in=
to allmerged yet ... we wanted some separated testing on it first, to see/c=
heck that it works and doesn't break anything for people not using tagged e=
thernet frames and/or --passtos
13:18 <@mattock> ok, I can organize the testing
13:18 < dazo> mattock:  I'll mail it to you .... no C programming ... it lo=
oks pretty easy, with example config files, tcpdump examples etc etc
13:18 <@mattock> dazo: ok
13:18 <@mattock> I'll do the documentation and send testing requests to ml's
13:19  * dazo mails testing docs to mattock=20
13:19 <@mattock> we'd have this last one (before SF.net tracker stuff): Sup=
porting "route-gateway dhcp" on non-Windows
13:19 <@mattock> rob0: the topics are here: http://www.secure-computing.net=
/wiki/index.php/OpenVPN/IRC_meetings/Topics-2010-03-11
13:19 < vpnHelper> Title: OpenVPN/IRC meetings/Topics-2010-03-11 - Secure C=
omputing Wiki (at www.secure-computing.net)
13:20 < dazo> here jamesyonan must have been flooded by mails :)
13:20 < d12fk> i have no real opinion, but the strong feeling that this sho=
uld be "fixed" by the distributions or it might break more than it fixes
13:21 <@mattock> d12fk: I tend to agree
13:21 <@mattock> implementing a DHCP client in OpenVPN would cause problems=
 if other DHCP clients are running (which is often the case)
13:22 < dazo> I tend to agree as well .... except ... I worry it will be a =
maintenance hell for OpenVPN to have a flexible enough solution to make thi=
s work with all kind of different solutions each distribution uses
13:22 <@mattock> I don't think anybody in the ml had a really good, generic=
 solution to this problem
13:22 < cron2> mattock: on the ML, there are people that know how to do cro=
ss-platform portability, and people that know their own teeny little operat=
ing island...
13:22 < dazo> that's the thing ... we don't want to introduce a DHCP client=
 for all interfaces .... just for the TAP device being created for openvpn
13:22 < cron2> and the teeny little island people all assume that the teeny=
 little island way of doing things is "so easy that everbody must see this"
13:23 < rob0> Is this "route-gateway dhcp" thing only for tap, or also for =
tun?
13:23 < cron2> dazo: not just "distributions".  "Operating systems" as well=
 (*BSD, MacOS, Solaris)
13:23 <@mattock> and "other" operating system distributions (DragonflyBSD, =
PC-BSD or whatever)=20
13:24 <@mattock> tons and tons of different DHCP approaches
13:24 < dazo> when OpenVPN acts as a DHCP client .... it will not care abou=
t other devices on the box ... that way, it will be rather restricted
13:24 < dazo> but, the disadvantage .... what to do with /etc/resolv.conf u=
pdates?
13:24 < rob0> IIUC in Slackware Linux, the trigger for the rc.inet1 script =
(which configures interfaces) is sent by udevd.
13:25 < dazo> Many distributions (Fedora, RHEL, Novell SuSE, openSuSE, Ubun=
tu) uses NetworkManager
13:25 < jamesyonan> What if we implement an internal DHCP client within Ope=
nVPN, but have it only activate on platforms known to not implement automat=
ic binding between the TAP interface and a DHCP client
13:25 < rob0> Also, some folks might be running dnsmasq or similar, and not=
 want any changes to resolv.conf ...
13:25 < dazo> jamesyonan: I believe that's basically the vast majority of *=
nix ....
13:25 <@mattock> is there any real disadvantage for letting OS/distribution=
 guys handle the integration? After all, they all know their own environmen=
t so integration should not be a big chore. Compared to what we might encou=
nter
13:26 < jamesyonan> The internal DHCP client would translate attributes rec=
eived from the DHCP server into route, ifconfig, and dhcp-option
13:26 <@mattock> rob0: for example me
13:26 < dazo> mattock:  then I would suggest them to use --up script hook .=
... and OpenVPN don't need to be used
13:26 < dazo> s/used/changed/
13:26 < cron2> mattock: how will you get those OS/distribution guys todo th=
at?
13:27 < jamesyonan> then the dhcp-options would follow the normal "foreign =
option" pathway within OpenVPN that is already defined for Mac OS X and oth=
er non-Windows OSes
13:27 < rob0> Maybe the documentation could provide a few distro-specific u=
p scripts, and that's as good as it can be.
13:27 <@mattock> cron2: I guess we should just make it as easy for them as =
possible (document, provide examples etc)
13:27 <@mattock> as rob0 suggested
13:28 <@mattock> provided that the distro guys _would_ indeed do the integr=
ation with external DHCP clients - what benefits would an internal OpenVPN =
DHCP client provide
13:28 < rob0> I could do one for Slackware, but it might take a week or mor=
e to get a round tuit.
13:28 <@mattock> compared to that
13:29 < dazo> then somebody needs to maintain those scripts .... what to do=
 when it breaks, the maintainer don't respond and nobody else comes up with=
 a fix ?  we stop supporting it?
13:29 < rob0> yeah, that's about it, unfortunately
13:30 <@mattock> so no good solutions, eh :|
13:30 < cron2> mattock: adapting to ever-changing distributions and operati=
ng systems will always fall back to the package maintainer
13:30 < jamesyonan> dazo: are you familiar with the "foreign-option pathway=
" for etc/resolv.conf updates?  Tunnelblick uses it when dhcp-option direct=
ives are pushed=20
13:30 < dazo> jamesyonan:  I have not looked at that one, tbh=20
13:31 < dazo> I believe that's similar to what Debian might use, on second =
thought
13:31 <@mattock> cron2: so you think we should let them handle this issue?
13:31  * dazo looks up a long
13:31 < dazo> *link
13:31 < cron2> jamesyonan: where is that documented?  It's not in the openv=
pn.8 man page
13:31 < cron2> mattock: no, I find adaption to "the linux fancy of the week=
" too painful
13:33 < cron2> mattock: well.  What I wanted to say is: if we leave that to=
 the distro and OS maintainers, some of them will do a good job, and others=
 won't do anything.  So you have a long list of "this feature works on OS X=
, Y and Z, but not A and B".
13:33 < dazo> http://www.phocean.net/2006/12/07/openvpn-and-dns-on-a-linux-=
client.html ... the last script on the page
13:33 < vpnHelper> Title: Phocean.net =EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD =
OpenVPN and DNS on a linux client (at www.phocean.net)
13:33 < cron2> Eventually, Z will change their setup to use DHCP client V i=
nstead of W, and the scripts will break.  Then who will adapt?
13:33 <@mattock> cron2: agreed, it's going to be painful... but if the dist=
ro's DHCP clients (e.g. NetworkManager, dhclient) autodetect the OpenVPN ne=
twork adapter they might break things for the built-in OpenVPN DHCP client =
anyways
13:34 <@mattock> that's the impression I got from the ml discussions
13:35 < jamesyonan> cron2: foreign-option is briefly described in the man p=
age
13:35 < jamesyonan> at the end of dhcp-option section
13:35 < cron2> mattock: if the distro's DHCP client starts messing with Ope=
nVPN's interfaces, things will break in really exciting ways
13:35 < dazo> exactly .... and all this, is why I think it is a better solu=
tion in the end to have a simple DHCP client inside OpenVPN which only care=
s about the TAP device it has configured .... and with the upside, support =
for TUN devices might be closer as well - if the server side can act as a D=
HCP relay
13:36 < cron2> jamesyonan: it's spelled foreign_option here, so my search d=
idn't find it.  Got it now, thanks.
13:36 < dazo> cron2:  that's a good point
13:36 < cron2> mattock: even if you have statically configured tun/tap devi=
ces within OpenVPN - and then the distro goes ahead and removes that and do=
es DHCP.  Or whatever it feels like doing.
13:37 <@mattock> so a built-in DHCP client is the least bad solution?
13:37 < rob0> Could we be headed toward a split of openvpnd and openvpnc se=
rver/client?
13:38 < dazo> mattock:  in my opinion, yes
13:39 <@mattock> and it's worth the trouble I assume?
13:39 < jamesyonan> I'm not sure that splitting makes sense because there i=
s so much shared code.  Of course if you just want a client or server-only =
build, you can use build options for that.
13:39 < dazo> mattock:  if we do that, we can at least document that no DHC=
P clients should be run on the TAP device when the internal DHCP client is =
enabled ... that way, people who try  that will fail - and it's not our fau=
lt
13:40 <@mattock> dazo: sounds like a good approach
13:40 <@mattock> so what to do about this then? what concrete steps to take?
13:41 < dazo> I believe jamesyonan asked the question on the ML to get some=
 feedback ... and we've summarised it here now ... so, I'd probably hand it=
 back to jamesyonan again for the next steps :)
13:41  * cron2 agrees
13:42 <@mattock> yeah, I was wondering where this issue originated from :)
13:42 < dazo> jamesyonan was did a brave move .... and probably got a full =
inbox as a result :)
13:42 < jamesyonan> I think this is an important feature, because it really=
 allows for zero-configuration TAP-based VPNs
13:43 <@mattock> only ~35 mails
13:43 < dazo> agreed!  And it has been missed!
13:43 <@mattock> who shall get to work?
13:43 <@mattock> :)
13:43 <@mattock> dazo: you're excluded, you have too much work as it is :)
13:43 < dazo> lol
13:44 < dazo> \o/
13:44  * dazo is happy!
13:44 < jamesyonan> well I think the ML discussion was a good exercise beca=
use it shows that leveraging on the distro DHCP client is not a panacea.
13:45 <@mattock> yeah, it was a really good discussion
13:46 <@mattock> if we don't do anything concrete right now, I suggest I'll=
 write a short summary of the ml discussions and this discussion... so that=
 when somebody starts working on this he knows what is the best approach
13:46 < dazo> jamesyonan:  and you feel you now know enough to know which a=
pproach you will go for?
13:47 < jamesyonan> yeah, I'm definitely leaning towards the internal DHCP =
client approach
13:47 <@mattock> jamesyonan: is this something you're going to be implement=
ing yourself?
13:47 < jamesyonan> it's definitely something I'm considering
13:48  * dazo would suggest putting all such tasks which has not been start=
ed to the Developer-TODO page ... if somebody wants a challenge, that's whe=
re to look
13:48 <@mattock> ok, I'll refrain myself from writing a lengthy summary of =
the findings, then
13:48 <@mattock> dazo: agreed - I can write a _short_ summary there :)
13:49 < dazo> mattock:  yeah ... just describe the feature we want .... the=
n refer to discussions on ML and in this irc log ....
13:49 <@mattock> will do
13:49 <@mattock> I think we should leave SF.net patch tracker issues aside =
(again)
13:49 < dazo> mattock:  I'll also suggest the ML discussions to be linked a=
gainst gmane.org ... it's way more organised and easier to read, IMHO
13:50 <@mattock> ok, I'll do that
13:50 <@mattock> it's a cleaner and faster interface
13:50 < dazo> mattock:  yeah .... I'm waiting for the community server ... =
with Trac ;-)
13:50 < dazo> (for TODO/Roadmap features)
13:50 <@mattock> me too :)
13:51 < dazo> I think that concludes today, or?
13:51 <@mattock> it should be up _really_ soon (when my Apache2 private key=
 arrives)
13:51 <@mattock> dazo: agreed
13:52 < dazo> Thanks a lot, guys, for a great meeting again!
13:52 <@mattock> I'll summarize this meeting tomorrow, as usual
13:52 < d12fk> see you next week then
13:52 <@mattock> with links to gmane
13:52 <@mattock> see you all later!
13:52 < dazo> c'ya!
13:52 < jamesyonan> bye!
13:52 < cron2> good night :) and bye
13:52 < d12fk> take care

--------------060607060801010208060108--

