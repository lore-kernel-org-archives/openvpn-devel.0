Message-ID: <4FC8852A.3080604@...515...>
Date: Fri, 01 Jun 2012 12:02:34 +0300
From: =?UTF-8?B?U2FtdWxpIFNlcHDDpG5lbg==?= <samuli@...515...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060908090602050700050906"
Subject: [Openvpn-devel] Summary of the IRC meeting (29th Mar 2012)
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
--------------060908090602050700050906
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's a summary of an _unofficial_ but important IRC meeting held on
29th Mar 2012. Better later than never...

---

COMMUNITY MEETING

Place: #openvpn-devel on irc.freenode.net
Date: Thursday 29th Mar 2012
Time: 18:00 UTC


SUMMARY

Andj, cron2, dazo, jamesyonan, krzee, mattock and zocker participated in
this meeting.

--

Discussed whether MSVC buildsystem could scrapped altogether. Jamesyonan
wanted to keep the option open, in case mingw_w64 starts lagging behind
in Windows header file support.

--

Discussed how to separate subproject Git repos (e.g. easy-rsa and
tap-windows) from the main openvpn Git repo. There were two alternatives:

1) Regenerate the Git trees without the unneeded code and put a pointer
to the original openvpn.git commit ID to the first commit message. This
reduces Git repo site significantly, but makes some Git operations more
manual and thus harder.

2) Base all repos on openvpn.git and simply remove the unnecessary files
using a standard commit. This retains all the history at the cost of
repository size.

Decided to to use 2) for tap-windows and 1) for the rest. So, only
tap-windows and openvpn are duplicates, and the rest start from scratch.

--

Discussed the "[PATCH 1/3] Migrated x509_get_subject to use of the
garbage collector" patch:

<http://thread.gmane.org/gmane.network.openvpn.devel/5401/focus=3D5400>

Jamesyonan gave this patch an ACK.

--

Discussed the "[PATCH 3/3] Migrated x509_get_sha1_hash to use the
garbage collector" patch:

<http://thread.gmane.org/gmane.network.openvpn.devel/5401/focus=3D5402>

Dazo gave this patch an ACK.

--

Discussed the "[PATCH 2/3] Migrated x509_get_serial to use the garbage
collector" patch:

<http://thread.gmane.org/gmane.network.openvpn.devel/5401/focus=3D5403>

Dazo gave this patch an ACK.

--

Discussed the "Log level of management interface: patch from 2009" patch:

<http://thread.gmane.org/gmane.network.openvpn.devel/5590/focus=3D6134>

Decided to NACK this patch, as current implementation makes most sense,
and unlike it seems at first sight, it does not fill the logs with
useless messages.

--

Discussed the "[PATCH 1/2] Added support for new PolarSSL 1.1 RNG" patch:

<http://thread.gmane.org/gmane.network.openvpn.devel/5689>

Due to security issues with havege on certain VM implementations decided
to ACK this patch only if

- PolarSSL 1.1+ is made a requirement
- Standalone havege support is removed

PolarSSL 1.1+ supports alternative entropy sources which this patch
makes use of.

--

Discussed the "[PATCH 2/2] Added a configuration option to enable
prediction resistance in the PolarSSL random number generator." patch:

<http://thread.gmane.org/gmane.network.openvpn.devel/5689>

Jamesyonan gave this patch an ACK.

--

Discussed OpenVPN Technologies, Inc. OpenVPN Android client briefly:

<http://swupdate.openvpn.net/beta-downloads/OpenVPN-RC1.apk>

It runs on Android 4.0 and later, and uses the Android 4 VPN API. The
code is not yet open source, but jamesyonan hopes to change that at some
point.

--

Had a discussion regarding OpenVPN and meshing with zocker, the
maintainer of PeerVPN. Due to the unstructured nature of the discussion,
look at the full chatlog for details; the discussion starts at 21:51:57.

---

Full chatlog as an attachment

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock



--------------060908090602050700050906
Content-Type: text/x-log;
 name="openvpn_irc_meeting_chatlog_2012-03-29.log"
Content-Disposition: attachment;
	filename="openvpn_irc_meeting_chatlog_2012-03-29.log"
Content-Transfer-Encoding: quoted-printable

[20:08:46] <dazo> cron2: these patches are from andj ;)
[20:08:46] <mattock> hi jamesyonan!
[20:08:50] <dazo> hey!!
[20:08:53] <dazo> long time :)
[20:08:56] <jamesyonan> hi guys
[20:08:58] <cron2> hi jamesyonan :)
[20:09:14] <dazo> Then I suggest discussing git trees first
[20:09:27] <mattock> jamesyonan: one quickie (hopefully)
[20:09:48] <dazo> mattock: that's fine for you?
[20:09:58] <mattock> do you have any special need to build OpenVPN with V=
isual Studio, provided that signing and everything works?
[20:10:09] <mattock> as opposed to mingw_w64
[20:10:14] <mattock> +gcc
[20:10:25] <mattock> dazo: I'll have a look
[20:10:39] <jamesyonan> yeah, we build the AS version of OpenVPN with VS
[20:10:55] <mattock> dazo: misunderstood you, it's fine
[20:11:10] <mattock> I mean feature-vise?
[20:11:23] <mattock> does VS provide something extra that mingw_w64 can't=
?
[20:11:23] <dazo> jamesyonan: just out of curiosity ... any reason to do =
so?  given that mingw64 is maintained
[20:11:55] <jamesyonan> in the past, there were cases where mingw wasn't =
up-to-date with MS header files
[20:11:58] <mattock> Alon did create two buildsystem: "generic" which use=
s mingw_w64 and "msvc", which, well uses Visual Studio toolchain
[20:12:40] <dazo> http://mingw-w64.sourceforge.net/ ... just fyi
[20:12:42] <vpnHelper> Title: GCC for both x64 & x86 Windows! - MinGW-w64=
 (at mingw-w64.sourceforge.net)
[20:12:57] <mattock> so, we have both options (gcc/msvc) for Windows now
[20:13:07] <mattock> very good work so far on Alon's part
[20:13:48] <mattock> dazo: maybe you could discuss your plans on the Git =
trees?
[20:13:49] <dazo> considering mingw64 is also part of cygwin ... it kind =
of got some real users, esp. as Red Hat is behind cygwin
[20:14:00] <dazo> Okay ... git trees
[20:14:27] <mattock> dazo: I'm not rushing on this :)
[20:14:58] <dazo> right now, the openvpn.git and openvpn-testing.git does=
 not carry tap-win32, install-win32 and easy-rsa any more ... Alon has sp=
lit them out, and have done something with a new installer which takes ca=
re of packaging it all together
[20:15:06] <mattock> but I think we may want to consider if we really nee=
d the MSVC buildsystem... but then again, if it does not give us (=3DAlon=
) much trouble
[20:15:08] <dazo> that all, is a sane approach in my eyes
[20:15:08] <mattock> keeping it around won't hurt much
[20:15:26] <mattock> sounds good also
[20:15:38] <dazo> What Alon has also done, is to provide 3 new git repos =
... for each of these trees=20
[20:15:44] <dazo> but!
[20:15:59] <dazo> The problem I see with these trees, are that they have =
been mangled and rebuilt
[20:16:16] <jamesyonan> I've had problems in the past where mingw wasn't =
being maintained or where it lagged behind MSVC in terms of supporting fu=
ll windows API
[20:16:21] <dazo> when you check them out, you get only what you'd expect=
 ... but it carries the history back to the beginning of the git history
[20:16:27] <dazo> That
[20:16:32] <mattock> jamesyonan: the "msvc" buildsystem should work in th=
ose cases
[20:16:39] <jamesyonan> so I think it's a good idea to keep the VC option=
 open
[20:16:49] <mattock> ok, makes sense
[20:17:05] <dazo> That's ideal, kind of ... except that if you check the =
git commit references against the official git tree we have ... they don'=
t match, which is because the git tree has been rebuilt, without many fil=
es=20
[20:17:36] <dazo> so the chain of git commits gives new sha values .... w=
hich means, we can't easily check the authenticity of these new git trees
[20:17:51] <dazo> So, I'm suggesting two alternative approaches
[20:18:49] <dazo> 1) To check out the git commit from openvpn.git before =
Alon kicks out these parts ... and copy these files into a new tree, star=
t with a fresh git history and in that commit message tell which git comm=
it these files comes from in the openvpn.git tree
[20:19:03] <dazo> The disadvantage here is that we don't carry the comple=
te git history
[20:19:31] <dazo> Alternative 2) is to clone the openvpn.git ... delete a=
ll the files we don't need ... and make a git commit based on that
[20:19:43] <cron2> what's the drawback of 2)?
[20:19:53] <dazo> disadvantage here, is that the git repo gets bigger ...=
 advantage, complete history
[20:20:06] <cron2> ah, it retains all the old stuff, of course
[20:20:08] <mattock> a lot bigger repo
[20:20:19] <mattock> all the stuff from the distant past, basically
[20:20:30] <dazo> yeah ... I'm kind of leaning towards 1) ... but I am no=
t against 2) at all
[20:20:36] * cron2 abstains
[20:20:42] <mattock> I'd say 1)
[20:20:55] <dazo> jamesyonan: do you have any thoughts about this?
[20:20:56] <mattock> as we have the manual link to the complete history a=
nyways
[20:21:12] <dazo> exactly, and that can easily be verified with diff
[20:21:34] <krzee> 1 sounds more logical given the history can be manuall=
y verified still
[20:21:43] <jamesyonan> what is the repo size difference between includin=
g the old history vs. not?
[20:21:57] * dazo checks
[20:23:23] <dazo> roughly 4.5MB
[20:23:36] <dazo> (that's on tap-win32)
[20:23:51] <dazo> the new tap-win32, based on 1) will be approx 250kb
[20:24:03] <dazo> the complete current openvpn.git tree is about 5MB
[20:24:26] <jamesyonan> well are there reasonable things you might want t=
o do with the repo that you now can't because the history isn't there?
[20:25:35] <cron2> bisect to find a certain change that causes problems
[20:25:40] <dazo> if you want to check what changed from v2.1, v2.2 and v=
2.3 ... that's harder with alternative 1) ... as you'll have to check out=
 the files from the openvpn.git tree, and do a tree-diff against tap-win3=
2.git
[20:26:22] <dazo> cron2++
[20:27:23] <cron2> but since this is fairly well tested, and we seem to h=
ave found the single bug that went into v2.2.0, I think neither is a real=
ly serious problem
[20:27:24] <krzee> =85whats the real downside with #2?  is there anything=
 wrong with an oversized git?
[20:27:44] <jamesyonan> agreed -- why not just keep the history then if j=
ust increases the repo size by a few MB?
[20:28:07] <dazo> The crucial part here is of course the tap-win32 tree .=
... the easy-rsa and install-win32 trees are not changing much at all, an=
d those changes will probably never require reading the history
[20:28:22] <dazo> it'll be ~4-5MB per tree ...=20
[20:28:26] <mattock> maybe use 2) for tap-win32 and 1) for the rest?
[20:28:37] <dazo> that's probably most sensible
[20:29:16] <mattock> if all are fine with that, maybe review the patches =
next?
[20:31:43] <dazo> krzee: no, not anything really ... except duplication o=
f data ... and if you want to pull down and build the complete windows pa=
ckage yourself, you need to pull down 4 git trees ... where 3 of them are=
 duplications of one ... so it'll multiply in download
[20:32:15] <dazo> (so that'll probably be something like 15-20MB in downl=
oad, instead of probably something like 7-8MB)
[20:32:55] <mattock> but if only tap-win32 is a duplicate, then it's 4,5 =
+ 4,5 + 0,5 + 0,5 or so
[20:33:02] <mattock> which makes it round 10 :)
[20:33:10] <dazo> yeah
[20:33:19] <mattock> that's not so bad I think
[20:33:25] <dazo> far better than 20 :)
[20:33:32] <mattock> also, the TAP driver is only needed on Windows
[20:33:38] <dazo> ack
[20:33:40] <mattock> so, for *NIX it's ~6MB
[20:33:45] <dazo> yupp
[20:34:12] <mattock> although with the new buildsystem even some non-craz=
y person might even try building for Windows :P
[20:34:27] <mattock> anyways, I guess this is where we left off: http://t=
hread.gmane.org/gmane.network.openvpn.devel/5401/focus=3D5400
[20:34:29] <vpnHelper> Title: Gmane Loom (at thread.gmane.org)
[20:34:37] <dazo> yupp :)
[20:40:00] <mattock> any comments anyone?
[20:40:07] <mattock> or even an ACK :)
[20:40:14] <mattock> I abstain myself
[20:40:49] <jamesyonan> patch seems reasonable
[20:41:03] <dazo> jamesyonan: you checked all three?
[20:41:38] <jamesyonan> one thing to be careful of though -- never use fr=
ee to free something that OpenSSL malloced for you
[20:41:54] <jamesyonan> I didn't look enough in detail at the patch to se=
e if it's doing this
[20:41:59] <dazo> yeah, that's the openssl_free() which should be used=20
[20:42:11] <jamesyonan> and note that gc_new and friends will always use =
free
[20:42:20] <dazo> oh, good point
[20:43:36] <dazo> patch 1/3, which targets x509_get_subject() ... uses me=
mcpy() to copy data over to a buffer allocated by gc_new() ... that's the=
 pointer being returned
[20:44:55] <dazo> and the openssl allocated buffers are free'd by openssl=
 functions
[20:49:57] <dazo> patch 3/3 seems fine to me
[20:51:12] <mattock> all patches ok?
[20:51:18] * dazo is looking at 2/3
[20:51:20] <mattock> oh, 2/3 was last
[20:53:04] <dazo> 2/3 looks also fine to me
[20:57:32] <mattock> any more we need to look at?
[20:59:13] <dazo> there is this discussion ... http://thread.gmane.org/gm=
ane.network.openvpn.devel/5590/focus=3D6134
[20:59:15] <vpnHelper> Title: Gmane Loom (at thread.gmane.org)
[21:00:13] <mattock> looking...
[21:00:27] <mattock> ah yes, that one
[21:00:37] <mattock> jamesyonan: what's your take on that one?
[21:00:42] <dazo> (and I have two more patches from andj after that ... t=
hen I think we're pretty much taken all community patches which is not fr=
om Alon)
[21:02:01] <mattock> dazo: how many patches from Alon are still lacking a=
n ACK?
[21:02:08] <dazo> those two last ones
[21:02:15] <cron2> hundreds
[21:02:19] <dazo> heh :)
[21:02:22] <jamesyonan> right, that was basically to aid in debugging so =
that the log file would show management interface commands that had been =
executed
[21:02:53] <dazo> okay ... so we probably don't want that patch then
[21:03:16] <krzee> actually that could be useful for everyone making a gu=
i
[21:03:32] <krzee> web interfaces and whatnot
[21:03:39] <jamesyonan> yeah, I would tend to say that in most cases, the=
 managment interface commands are not going to be verbose enough that the=
y would bloat a log file
[21:03:56] <dazo> agreed
[21:04:11] <krzee> what verb will those show up in?
[21:04:13] <mattock> ok, current approach is good
[21:04:24] <jamesyonan> 3 I believe
[21:04:29] <krzee> cool =3D]
[21:04:30] <dazo> currently it is 3
[21:04:57] <dazo> (james lowered it from 7 to 3 ... and michael wanted to=
 bumb it up to 7 again, which we nack now)
[21:05:06] <krzee> ild think at least 6
[21:05:24] <dazo> btw. michael answered my privately, that there's no har=
d feelings if we nack it
[21:05:34] <krzee> 3 =3D normal, 5 =3D debug firewall, 6 =3D same as 5 bu=
t READ/WRITE over R/W
[21:06:03] <dazo> well, in production, you usually want to log which comm=
ands are sent via the management interface ... so having it at 3 makes se=
nse
[21:06:08] <cron2> +1
[21:06:23] <dazo> if you don't want it, set verb 2 ... as you probably do=
n't want a lot of other things as well
[21:06:26] <krzee> hmm, ya i guess thats true
[21:06:44] <jamesyonan> I think the basic idea is that info that can be v=
ery useful for troubleshooting and is not so verbose as to introduce bloa=
ted log files should be emitted at verbosity levels of 4 or below
[21:06:45] <krzee> i was thinking it would mostly be for debug when writi=
ng an interface, but i guess it could be useful overall too
[21:06:46] <andj> evening
[21:06:56] <dazo> hey!
[21:07:00] <mattock> hi andj!
[21:07:06] <mattock> nice to have you here!
[21:07:24] <andj> thanks, been a bit busy lately
[21:07:45] <dazo> makes you feel alive, doesn't it ;-)
[21:07:52] <andj> :)
[21:07:59] <dazo> (unless it lasts so long you wish to be dead :p)
[21:08:45] <dazo> okay ... last patches to review from andj  :)
[21:08:45] <dazo> http://thread.gmane.org/gmane.network.openvpn.devel/568=
9
[21:08:48] <vpnHelper> Title: Gmane Loom (at thread.gmane.org)
[21:09:02] <andj> ah, well timed :)
[21:09:14] <mattock> ah, nice!
[21:09:38] <dazo> andj: I've pushed out some of your patches already ... =
the x509 and gc patches are acked today ... and then these polarssl patch=
es ... have I forgotten anything from you then?
[21:09:42] <andj> This patch adds the new entropy gathering mechanism and=
 DRBG in PolarSSL
[21:09:54] <andj> I think that's it
[21:10:02] <dazo> cool! :)
[21:10:25] <andj> I'll double check once everything is in, by rebasing my=
 stack somewhere during the next few days
[21:10:40] <dazo> perfect
[21:12:28] <andj> Anyway, this is a reasonably large patch, and adds supp=
ort for the new PolarSSL DRBG. That, in turn uses three entropy sources: =
hardclock(), Havege, and platform entropy (/dev/urandom).
[21:13:31] <andj> Further, instead of having a separate RNG per connectio=
n (or struct tls_root_ctx), there's a singleton RNG instance for the whol=
e of OpenVPN
[21:14:41] * dazo hopes james is still with us for this review
[21:14:53] <jamesyonan> yeah, I'm still here
[21:15:19] <andj> Finally, the DRBG is personalised, by using a hash of t=
he certificate, the pid, the time, and its location in memory
[21:16:25] <andj> The RNG in OpenVPN-NL is slightly different: it uses /d=
ev/random instead of /dev/urandom, changing the default PolarSSL behaviou=
r
[21:16:38] <andj> as a platform entropy source
[21:17:25] <dazo> and DRBG is used if PolarSSL 1.1 is available, otherwis=
e havege is used?
[21:18:05] <jamesyonan> I don't think havege should ever be used by itsel=
f
[21:18:20] <andj> yeah, PolarSSL 1.0 doesn't support anything else
[21:18:30] <andj> Havege is fine on bare metal PCs
[21:18:52] <jamesyonan> yeah, but it doesn't work on certain VM implement=
ations
[21:19:33] <andj> yeah, due to the virtualisation of the rdtsc instructio=
n...
[21:19:45] <jamesyonan> I think you should either require PolarSSL versio=
n to be >=3D 1.1 or use a different RNG
[21:20:04] <andj> PolarSSL <1.1 only has havege
[21:20:23] <dazo> we could enforce polarssl 1.1 or newer, though
[21:20:41] <mattock> andj: any thoughts on that?
[21:20:46] <jamesyonan> =08standalone havege has essentially been withdra=
wn because of security issues
[21:20:51] <mattock> that'd solve the problem at least
[21:20:59] <andj> True, but I would like to leave the support in for a li=
ttle while, allowing people the choice
[21:21:20] <andj> Then again, it's a  risk for people using VMs
[21:21:50] <jamesyonan> look -- if we include it, then it becomes our sec=
urity issue as well
[21:22:21] <dazo> I got polarssl 1.1 pushed to fedora ... and I can try t=
o get that into EPEL ... that will result in RHEL/CentOS/ScientificLinux =
getting 1.1 ... Not sure what the deb world uses
[21:22:22] <andj> True, I'll see about yanking <1.1 support once I've got=
 my development PC then
[21:22:57] <andj> (which is tomorrow or this weekend)
[21:23:11] <andj> I'll hand that in in a separate patch
[21:23:30] <andj> to allow an ack of the 1.1 code to continue now
[21:23:44] <dazo> perfect!
[21:25:23] <dazo> andj: patch 2/2 ... --enable-prediction-resistance ... =
is that depending on 1/2, or can we take that one separately?
[21:25:47] <andj> It's dependent, doesn't mean we can't review it though,=
 same for 1/2 :)
[21:26:18] <mattock> dazo: debian/ubuntu also has obsolete PolarSSL versi=
on
[21:26:22] <andj> Is there a partial ack for 1/2?
[21:27:37] <dazo> mattock: I saw some Wheezy references with 1.1
[21:27:37] <jamesyonan> sure, DRBG is fine as an RNG
[21:27:56] <mattock> hmm. wheezy, that's the current testing/unstable?
[21:28:06] * dazo dunno
[21:28:14] <dazo> http://pkgs.org/search/?keyword=3Dpolarssl
[21:28:18] <vpnHelper> Title: Search Results for polarssl (at pkgs.org)
[21:28:24] <jamesyonan> and having havege as an entropy source is okay as=
 long as it's combined with other sources, as your patch apparently does
[21:28:26] <mattock> testing I mean, unstable is always "sid"
[21:28:56] <mattock> ah, wheezy is "current+1"
[21:29:04] <andj> jamesyonan: that's default PolarSSL >=3D1.1 behaviour
[21:29:15] <jamesyonan> great
[21:30:01] <mattock> debian testing and unstable already have polarssl 1.=
1.1: http://packages.debian.org/search?keywords=3Dpolarssl&searchon=3Dnam=
es&suite=3Dtesting&section=3Dall
[21:30:04] <vpnHelper> Title: Debian -- Package Search Results -- polarss=
l (at packages.debian.org)
[21:30:28] <andj> about 2/2 then: prediction resistance is a feature for =
people with more entropy than they know what to do with
[21:30:30] <mattock> and if we want to provide OpenVPN packages with Pola=
rSSL for older distros backporting those should not be a big deal
[21:32:42] <mattock> so what ended up being the ACK status for these two =
patches?
[21:35:28] <jamesyonan> acked with the precondition that standalone haveg=
e support be withdrawn
[21:35:36] <mattock> ok
[21:35:48] <andj> and the prediction resistance one?
[21:35:52] <mattock> dazo: +1 for the ACK system :P
[21:35:59] <dazo> :)
[21:36:22] <jamesyonan> ack for prediction resistance
[21:36:27] <andj> cool
[21:36:51] <andj> (perhaps a topic for later) Anyone ever looked at http:=
//www.featvpn.com/#about ?
[21:36:53] <vpnHelper> Title: FEAT VPN - OpenVPN on Android without root =
(at www.featvpn.com)
[21:37:14] <cron2> andj: you missed all the fun.  OpenVPN tech has releas=
ed their own android openvpn client today
[21:37:16] <dazo> goodie!  andj, you will rework patch 1/2 to enforce pol=
arssl 1.1 without havege?
[21:37:28] <andj> dazo: sure
[21:37:33] <dazo> thx!
[21:37:46] <dazo> then I'll just hold back until new patches comes
[21:37:55] <andj> cron2: I did, where can I find it? :)
[21:37:58] <jamesyonan> FEAT VPN is a clever hack that lets OpenVPN run o=
n Android 2
[21:38:08] <mattock> andj: there's also an official OpenVPN client for An=
droid now
[21:38:29] <dazo> http://swupdate.openvpn.net/beta-downloads/OpenVPN-RC1.=
apk
[21:38:32] <dazo> andj: ^^=20
[21:38:46] <jamesyonan> But we've released our Android client (under Open=
VPN Tech.) that runs on Android 4 and higher and uses the new Android 4 V=
PN API
[21:38:51] <mattock> no need for clever hacks anymore afaik
[21:40:03] <andj> jamesyonan, mattock: awsome
[21:40:09] <andj> awesome even :)
[21:40:13] <andj> Is it open source? :)
[21:40:16] <mattock> :)
[21:40:39] <mattock> no clue, but jamesyonan will know
[21:40:49] <andj> I'd _really_ like to build an OpenVPN-NL version for An=
droid
[21:41:00] <jamesyonan> no, not open source yet
[21:41:09] <krzee> andj++
[21:41:10] <mattock> yet as in "it will be"? :P
[21:41:29] * andj is getting more interested by the minute :p
[21:41:32] <mattock> before somebody else writes an alternative GUI, that=
 is
[21:41:39] <mattock> using the Android VPN API
[21:41:44] <dazo> if it is open sourced at this point, I'm sure that woul=
d get quite some attention
[21:41:50] <krzee> andj, speaking of ovpn-nl, any word on blowfish being =
in polarssl?
[21:42:06] <jamesyonan> I'd like to see it be open source at some point, =
but not yet
[21:42:13] <krzee> ild like to change over, but i dont trust aes so im st=
icking to openssl til polar supports bf
[21:42:27] <mattock> jamesyonan: ok
[21:43:12] <krzee> mattock, odds are that fries is already working on an =
alternative gui=85 he came in here talking about his desire to do so a bi=
t of time back
[21:43:32] <andj> About PolarSSL: The maintainer is a little busy right n=
ow, I'll ask him next time I see him...
[21:43:59] <andj> Fox-IT is look into it as well, we're quite interested =
in OpenVPN-NL for android
[21:44:04] <dazo> andj: would it help if we file a ticket in polarssl's t=
rac?
[21:44:26] <mattock> krzee: ok, using the Android VPN API?
[21:44:55] <krzee> no idea
[21:45:54] <andj> dazo: you could try, but I know it's on Paul's todo lis=
t
[21:46:31] <dazo> andj: I don't want to push him ... but to provide some =
evidence that there is work in progress, that might be helpful ... that's=
 what I thought
[21:46:56] <dazo> (or at least, that it is planned and some people would =
like it)
[21:47:27] <andj> dazo: go for it, at the very least it would provide a w=
ay of tracking progress
[21:48:35] <andj> Anyway, congratulations on the Android RC!
[21:48:53] <krzee> was featvpn coded by people in here?  there was recent=
-ish talk about ideas on how to accomplish that
[21:49:02] <andj> Do we have any more patches to review?
[21:49:09] <dazo> krzee: nope, not afaik
[21:49:14] <andj> I'd never heard of it until recently
[21:49:28] <krzee> very cool
[21:49:49] <andj> I wonder if they've modified the Android source code?
[21:49:59] <andj> scrap android there
[21:50:04] <andj> (getting tired)
[21:50:09] <andj> and replace it by OpenVPN
[21:50:11] <krzee> i wonder why people like the featvpn team and that pee=
rvpn guy dont just join this channel and contribute instead of forking=85=
 especially now that the dev team is all organized and stuffs
[21:50:20] <dazo> mattock: might be worth checking out of featvpn is infr=
inging the GPL licence ... they don't provide any source code, and we kno=
w they probably use openvpn under the hood (unless they've re-implemented=
 the openvpn protocol)
[21:50:35] <andj> http://www.featvpn.com/open-source-licenses
[21:50:36] <vpnHelper> Title: Open Source Licenses | FEAT VPN (at www.fea=
tvpn.com)
[21:51:55] <mattock> might be worth a shot
[21:51:57] <zocker> hi
[21:52:07] <krzee> oh shit its tobias
[21:52:11] <krzee> i didnt see you there
[21:52:20] <krzee> speaking of the peervpn guy!
[21:52:20] <mattock> dazo: are we done with the patches for today?
[21:52:25] <mattock> it's getting kind of late
[21:52:27] <dazo> yeah, I'd say so
[21:52:27] <zocker> krzee: I'm the "peervpn guy"
[21:52:30] <zocker> ;)
[21:52:37] <krzee> =3D]
[21:52:40] <krzee> welcome!
[21:53:14] <andj> hi
[21:53:22] <zocker> and peervpn isn't really an openvpn fork ^^
[21:53:41] * dazo looked at the peervpn code, and can testify to that :)
[21:53:41] <krzee> ya, i misspoke on that one, dazo looked at it and said=
 it was totally fresh code
[21:54:17] <dazo> zocker: so, have you tried to look at the openvpn code?
[21:55:08] <zocker> i think i looked at it a long time ago to find out ho=
w to open a tap device
[21:55:21] <zocker> but that was  like 3 years ago or so
[21:55:42] <dazo> okay, you got that much scared :)
[21:56:18] <zocker> haha
[21:56:55] <andj> btw: the source code for FeatVPN is available at http:/=
/www.featvpn.com/#howto=20
[21:56:56] <vpnHelper> Title: FEAT VPN - OpenVPN on Android without root =
(at www.featvpn.com)
[21:57:03] <dazo> anyhow ... topology mesh is something users do ask for =
in openvpn .... however, based on what I've quickly seen ... implementing=
 it into openvpn won't be trivial, but not impossible
[21:57:08] <andj> in the introduction
[21:57:21] <dazo> or maybe 'mode mesh' is more appropriate
[21:57:37] <krzee> hmm, ya mode mesh does make more sense
[21:58:34] <dazo> and one important feature, would be auto config of ipv4=
 addresses ... and some kind of authentication as well, against a configu=
red server
[21:59:00] <andj> dazo: is that necessary if you use a PKI?
[21:59:07] <krzee> ild assume auth should still be certs
[21:59:10] <krzee> exactly
[21:59:19] <krzee> all we lose there is the server verification
[21:59:20] <dazo> andj: what about those who want username/password auth?
[21:59:27] <andj> as long as everyone trusts the same CA
[21:59:35] <krzee> but since its a mesh, its not so much for end users an=
yways
[21:59:48] <krzee> dazo, you expect password auth on a mesh?
[21:59:48] <andj> dazo: bleh, username password is so 1900s :)
[22:00:09] <dazo> I'm probably seeing mesh from a different perspective .=
... where you have client-to-client connections in a mesh fashion
[22:00:15] <krzee> dazo, password auth is for setups with end-users, end-=
users wont be in a mesh normally
[22:00:28] <krzee> ahh
[22:00:36] <krzee> his way of handling it, they all connect to eachother
[22:00:37] <dazo> and also a server which can do the authentication, and =
to block unwanted users
[22:01:04] <krzee> check out his docs, its a pretty cool way of doing it
[22:01:05] <dazo> yeah, I know ... so that "peer-to-peer" connections wou=
ld kick in after the authentication part
[22:01:09] <krzee> ya
[22:01:11] <andj> dazo: you'd still need some sort of auth token system t=
hen
[22:01:19] <dazo> yeah
[22:01:21] <krzee> ild assume pki is enough there
[22:01:34] <krzee> you just make a pki that is specific to the mesh
[22:02:10] <dazo> the other advantage here, is that assigning IP addresse=
s would be somewhat simpler, as one server instance got control ... other=
wise, you'll need to do some arp discovery=20
[22:02:24] <dazo> large scale mesh with manual ip address config won't sc=
ale well
[22:02:41] <krzee> yep, totally agreed
[22:03:01] <krzee> although full mesh doesnt scale well in general
[22:03:09] <krzee> but ya
[22:03:14] <dazo> fair point
[22:04:00] <dazo> but again, with a central auth point ... that one can c=
ontrol the size of the mesh too, so it doesn't go beyond its limits
[22:04:15] <krzee> true
[22:04:53] <krzee> there needs to be more than 1 central auth point tho
[22:04:57] <krzee> for the same mesh
[22:05:06] <krzee> otherwise you lose the entire point of the mesh, redun=
dancy
[22:05:14] <dazo> good point!
[22:05:39] * dazo ponders=20
[22:05:40] <zocker> krzee: you would still have the advantage of handling=
 less traffic on the central server
[22:05:54] <krzee> true
[22:05:55] <zocker> but yeah more auth servers would be probably better ;=
)
[22:06:06] <krzee> your program handles more than 1 auth server=85 doesnt=
 it?
[22:06:17] <krzee> seemed to me that it did when i was looking it over
[22:06:19] <zocker> there isn't really an "auth server"
[22:06:30] <krzee> well initial connection server ;]
[22:06:46] <zocker> yes but thats just for bootstrapping
[22:06:48] <krzee> what i keep calling auth is really just PKI anyways
[22:06:53] <dazo> if ... it would be possible to enable mesh together wit=
h normal openvpn mode ... so that clients which does not support mesh cou=
ld access other mesh-able clients via the server .... like client-to-clie=
nt today
[22:07:21] <krzee> dazo, sounds more complicated than necessary...
[22:07:36] <krzee> mesh mode for your infrastructure=85 then a normal ent=
rance node of openvpn in server mode
[22:07:50] <krzee> on a machine(s) in the mesh
[22:07:56] <dazo> good point
[22:08:04] * dazo flushes that idea
[22:08:19] <zocker> right now its just a shared key for authentication, t=
he protocol also supports sort of ACLs to control who may connect or not =
but that is not implemented yet
[22:08:31] <krzee> ive given this thought as im currently building a netw=
ork that could use this feature!
[22:08:44] <krzee> well its built, i just need to setup ospf now
[22:08:47] <dazo> :)
[22:08:53] <andj> zocker: do you have periodic rekeying of the data chann=
el and that sort of thing?
[22:08:54] <krzee> (since theres no mode mesh ;])
[22:09:27] <zocker> andj: no, key is negotiated once on session setup, bu=
t won't be renegotiated
[22:09:56] <zocker> thought about implementing it, but decided its too mu=
ch added complexity for too little benefit
[22:09:59] <krzee> zocker, well PKI and rekeying hourly (forward security=
) will be another cool feature that ovpn brings =3D]
[22:10:14] <andj> ah, cool, then there's a mutual learning sort of thing =
:)
[22:10:32] <krzee> andj, his app only runs on linux as well
[22:11:03] <zocker> jep, have to figure that one out as well, especially =
windows ;)
[22:11:10] <krzee> so gaining support for solaris/bsd/windows is pretty c=
ool for him too
[22:11:43] <andj> anyway, got to run, the idea of merging mesh networking=
 into OpenVPN would be pretty cool!
[22:11:44] <andj> nn
[22:11:59] <krzee> as do i, ill be right back very quickly tho
[22:12:08] <krzee> just driving home
[22:12:49] <dazo> I just fear the current state of openvpn will not make =
mesh'ing easy ... due to the socket mess ... however, if this would inclu=
de cleaning up socket.c and the tcp/udp connection code .... this would r=
eally be a great effort and yet another good reason to do so
[22:14:24] <dazo> zocker: I hope you understand that mesh is something we=
'd like to see ... but it's not a shortcut to implement it ... it'll requ=
ire some efforts ... however, you won't be completely alone in that job, =
though
[22:16:10] <zocker> i'm not sure if i would have the time for doing that =
anyway, i would probably first need to invest a lot of time to see how op=
envpn works internally
[22:16:46] *** Quits: krzee (nobody@...1423.../community/support/krzee) (Pin=
g timeout: 244 seconds)
[22:17:44] * cron2 goes to bed
[22:18:04] <dazo> well, we can sure try to help out as much as possible t=
o help the understanding part ... even I would enjoy that, as there are m=
any parts I still haven't touched yet
[22:19:02] <dazo> however, maybe we should start thinking about openvpn3 =
too for real ... we have a roadmap ready ... and we plan to move the 2.x =
series into that direction, by modularising the 2.x code base more and mo=
re
[22:19:23] <dazo> https://community.openvpn.net/openvpn/wiki/RoadMap
[22:19:24] <vpnHelper> Title: RoadMap =E2=80=93 OpenVPN Community (at com=
munity.openvpn.net)
[22:21:01] <zocker> "For the creative minds, in theory, it could be possi=
ble to write a socket module which would send data as HTTP requests, to t=
rick itself through strict proxies. Or as DNS requests."
[22:21:08] <zocker> nice, i'm playing with that idea too ;)
[22:22:29] <dazo> now, the current openvpn base isn't much modularised ..=
. the ssl layer is the best modularisation we have yet
[22:22:34] <zocker> yeah more generic code would be beneficial, my code f=
or example doesn't care for the transport layer, as long as it is packet =
oriented
[22:27:58] * dazo need to run ... getting late
[22:28:07] <dazo> thx all for a good meeting :)
[22:28:08] *** Joins: krzee (nobody@...1423.../community/support/krzee)
[22:28:08] *** ChanServ sets mode: +v krzee
[22:33:10] <krzee> zocker, if you're playing with dns tunneling, it may b=
e worth your time to look at iodine
[22:33:20] <krzee> which is coded by Yarrick on IRCnet in #iodine
[22:33:38] <zocker> tried that, didn't work too good for me
[22:33:46] <zocker> i use dns2tcp with openvpn tcp mode instead
[22:33:52] <krzee> iodine didnt work good for you?
[22:33:56] <zocker> works like a charm ;)
[22:33:57] <krzee> its always worked for me
[22:34:08] <krzee> well always did, i havnt used it in awhile
[22:34:19] <krzee> whoaaa
[22:34:23] <krzee> tcp over tcp over dns
[22:34:29] <krzee> your connection must have loooved you
[22:34:30] <krzee> LOL
[22:34:42] <zocker> it works surprisingly well
[22:34:56] <zocker> and kinda fucked internet is better than no internet
[22:35:01] <krzee> totally
[22:35:26] <zocker> i also only need it at german train stations, and dns=
2tcp is easier to set up -> less work=20
[22:36:33] <zocker> i think this is a germany-only problem anyway
[22:36:47] <zocker> other countries just offer free APs, like argentina w=
here i am now
[22:37:47] <zocker> or they use WEP ;)
[22:38:25] *** Joins: krzie (nobody@...1423.../community/support/krzee)
[22:38:25] *** ChanServ sets mode: +v krzie
[22:38:26] <dazo> w00t!?!  wep is crackable!??!?? :-P
[22:38:34] <krzie> grrr
[22:38:40] *** Quits: krzee (nobody@...1423.../community/support/krzee) (Rea=
d error: Connection reset by peer)
[22:38:41] <krzie> [16:35]  <zocker> i also only need it at german train =
stations, and dns2tcp is easier to set up -> less work=20
[22:38:44] <krzie> [16:36]  <krzee> oh shit, on the t-mobile hotspots?
[22:38:47] <krzie> [16:36]  <krzee> (thats what i recently saw at FRA)
[22:38:48] <krzie> [16:37]  <krzee> i never got dns tunneling to work on =
t-mobile hotspots=85 if your way works im switching!
[22:38:51] <krzie> [16:37]  <krzee> in the defense of simplicity, all i d=
id to start iodine was run my script
[22:38:54] <krzie> last i saw before i dropped
[22:39:05] <krzie> and the script im referring to is at: http://dev.kryo.=
se/iodine/wiki/TipsAndTricks
[22:39:09] <vpnHelper> Title: TipsAndTricks =E2=80=93 iodine (at dev.kryo=
.se)
[22:40:03] <zocker> jep, on the t-mobile hotspots
[22:40:31] <krzie> oh man=85 all these yrs i just figured i couldnt dnstu=
n through those
[22:40:39] <zocker> i don't even know how you can charge money for this s=
hit, internet access that anyone nearby can sniff & do other finny things
[22:41:07] <zocker> s/finny/funny
[22:41:24] <krzie> or finny things!
[22:41:31] * krzie looks at mattock out there in .fi
[22:41:47] <zocker> haha
[22:41:48] *** dazo is now known as dazo_afk
[22:46:01] <zocker> but like i said, germany only problem
[22:46:05] <zocker> i'm sitting right now in a public park in a small tow=
n and it has free wifi :-)
[22:46:20] <zocker> develeoping country beats developed country ^^
[22:46:43] <krzie> thats awesome
[22:46:59] <krzie> you just called nl developing?
[22:47:12] <krzie> shit when i went out there it looked pretty well devel=
oped to me
[22:47:15] <zocker> i'm in argentina
[22:47:18] <krzie> ohhh
[22:47:23] <krzie> ok then ;]

--------------060908090602050700050906--

