References: <a059f803-84d4-c211-55f8-d6698c9d03c1@...515...>
 <22ff855c-13e0-1445-3c26-1b69a48db5ae@...277...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <72d219d0-929b-fbaa-ebc8-5f6256c9a371@...515...>
Date: Wed, 30 May 2018 15:25:31 +0300
MIME-Version: 1.0
In-Reply-To: <22ff855c-13e0-1445-3c26-1b69a48db5ae@...277...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="UEefKQGVNLndAgjf4sJCvuCfmSdWJ9PbS"
Subject: Re: [Openvpn-devel] Summary of the community meeting (Wed,
 30th May 2018)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli.seppanen@...277...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UEefKQGVNLndAgjf4sJCvuCfmSdWJ9PbS
Content-Type: multipart/mixed; boundary="SGRNGmeV9aXbEe0tG4mKcHWQA57tJZnii";
 protected-headers="v1"
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
To: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli.seppanen@...277...>,
 openvpn-devel@lists.sourceforge.net
Message-ID: <72d219d0-929b-fbaa-ebc8-5f6256c9a371@...515...>
Subject: Re: Summary of the community meeting (Wed, 30th May 2018)
References: <a059f803-84d4-c211-55f8-d6698c9d03c1@...515...>
 <22ff855c-13e0-1445-3c26-1b69a48db5ae@...277...>
In-Reply-To: <22ff855c-13e0-1445-3c26-1b69a48db5ae@...277...>

--SGRNGmeV9aXbEe0tG4mKcHWQA57tJZnii
Content-Type: multipart/mixed;
 boundary="------------1E378D7A91C94577E66A9375"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------1E378D7A91C94577E66A9375
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Forgot the full chatlog...

Il 30/05/2018 15:23, Samuli Sepp=E4nen ha scritto:
> Hi,
>=20
> Here's the summary of the IRC meeting.
> ---
>=20
> COMMUNITY MEETING
>=20
> Place: #openvpn-meeting on irc.freenode.net
> Date: Wednesday 30th May 2018
> Time: 11:30 CET (9:30 UTC)
>=20
> Planned meeting topics for this meeting were here:
>=20
> <https://community.openvpn.net/openvpn/wiki/Topics-2018-05-23>
>=20
> The next meeting has not been scheduled yet.
>=20
> Your local meeting time is easy to check from services such as
>=20
> <http://www.timeanddate.com/worldclock>
>=20
> SUMMARY
>=20
> cron2, lev, mattock and syzzer participated in this meeting.
>=20
> --
>=20
> Talked about OpenVPN 2 code formatting guidelines, in particular whether
> we should have whitespace after cast. Noted that we don't have a rule
> for that in Uncrustify. As dazo and ordex both have strong feelings
> about this and were not present it was decided to postpone this topic.
>=20
> --
>=20
> Discussed the upcoming tap-windows6 release. Mattock has created several
> Windows Server instances in EC2 (2008r2, 2012r2, 2016) for the purposes
> of testing tap-windows6. Windows 7 and (physical) Windows 10 instances
> will be created later. A new tap-windows6 builder instance is already
> functional and works with jkunkee's tap-windows6 patches. Mattock will
> grant cron2 access to it through the community VPN.
>=20
> Mattock will also look into creating a couple of additional Windows
> instances where test-signed drivers are allowed. This is done to avoid
> having to switch test-signing on and off. This helps testing pre-release
> versions of tap-windows6.
>=20
> Tap-windows6 (and later OpenVPN) smoketesting will be automated using
> Powershell Remoting (via SSH or WinRM) and openvpn-windows-test.
> Smoketesting will include tap-windows6 installation/loading into kernel
> as well as Authenticode signatures tests. Lev volunteered to help in
> this test automation work.
>=20
> Agreed that release date on 20th June 2018 is still reasonable.
>=20
> ---
>=20
> Noted that NDIS 6.30 support which jkunkee's patchset brings to
> tap-windows6 would allow us to create a proper tun driver for Windows.
>=20
> --
>=20
> Full chatlog attached.
>=20


--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

--------------1E378D7A91C94577E66A9375
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2018-05-30.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2018-05-30.txt"

(12:29:11) mattock: hi
(12:29:46) cron2_: early bird :)
(12:29:47) cron2_: ho!
(12:30:20) syzzer: morning :)
(12:30:37) lev__: hello
(12:31:24) mattock: any topics besides tap-windows6? :P
(12:31:45) lev__: whitespace after cast
(12:32:01) cron2_: since syzzer is here, this makes sense :)
(12:32:08) cron2_: if dazo shows up, CVE...
(12:34:17) mattock: whitespace after cast first?
(12:34:37) cron2_: ok
(12:35:48) syzzer: sure
(12:35:54) syzzer: I don't care :)
(12:36:58) syzzer: we our company we seem to be converging to no-space-be=
tween-cast-and-variable, so that would be slightly easier for me
(12:37:08) lev__: so, shall we decide if we put whitespace after cast or =
not, then add an option to uncrustify
(12:37:28) syzzer: but otherwise, I leave this to the people with an opin=
ion and will follow what you decide :)
(12:38:10) syzzer: hm, no ordex around?
(12:38:10) ***cron2_ tends to use either way depending on "what is casted=
 and does it help readability"... so if we decide something, I'll have to=
 adjust
(12:38:41) syzzer: I recall he has an opinion about this
(12:39:31) cron2_: he wrote about using uncrustify sp_after_cast option, =
but it wasn't totally clear if this was "if we go there, here's the optio=
n" or "we should do this"...
(12:39:49) cron2_: mattock: do you have some sort of internal messenger t=
o find dazo and ordex?
(12:40:20) lev__: dazo told that he will be mostly offline during those d=
ays
(12:40:43) lev__: (just sent a message to ordex)
(12:42:20) mattock: ordex said he can't make this meeting
(12:42:25) cron2_: oh
(12:43:35) lev__: so he has refered to this one https://raw.githubusercon=
tent.com/uncrustify/uncrustify/master/documentation/htdocs/ben.cfg.txt=20
(12:44:05) lev__: sp_after_cast =3D remove
(12:44:29) cron2_: how intuitively named :)
(12:44:48) cron2_: but if dazo and ordex are not here, we should postpone=
 this one... both have strong feelings
(12:48:43) cron2_: (as a side note, NordVPN's mail provider really is an =
abomination from hell wrt PGP...)
(12:48:45) mattock: sounds good to me
(12:49:06) lev__: ok lets postpone
(12:49:07) ***cron2_ just received a plain mail telling me to "pick up a =
secure mail from https://hushmail.com/.../"
(12:51:44) mattock: tap-windows6 next?
(12:53:31) cron2_: yep
(12:53:57) mattock: ok, update from my end
(12:54:16) mattock: I've setup a bunch of Windows Servers for testing/smo=
ketesting tap-windows6
(12:54:29) mattock: plus a new build instance that works with jkunkee's P=
Rs
(12:55:08) mattock: I will push the guys at the office to setup at least =
one Windows 7 instances and one really strict Windows 10 instance
(12:55:26) mattock: win10 will be a real PC (fresh install of rev.1607 + =
secure boot on)
(12:55:29) ***cron2_ is totally amazed :)
(12:55:59) mattock: they're all in Puppet and in total control
(12:56:15) mattock: I intend to look into Powershell remoting also, so th=
at we can trigger smoketests on each of them automatically
(12:56:25) mattock: basically to run openvpn-windows-test
(12:56:46) cron2_: that would be a major milestone forward
(12:56:48) mattock: yeah
(12:56:58) lev__: mattock: let me know if you need any help with scriptin=
g
(12:57:21) mattock: lev__: if you feel like writing Powershell that'd be =
great!
(12:57:34) mattock: I'm pretty good with it nowadays, but more hands is a=
lways good
(12:58:02) mattock: I can probably also grant access to some of these ins=
tances to select community developers
(12:58:18) mattock: as needed
(12:59:18) mattock: the nodes are also disposable, so if they break they =
can be rebuilt easily
(12:59:47) mattock: so my plan for going forward is to look into the "att=
estation signing" thing to get an idea what it requires as far as testing=
 is concerned
(12:59:58) mattock: then I will look more into the test automation part
(13:00:18) mattock: we will also need changes to the Windows installer (a=
ttestation signed drivers won't work on Windows 7/8 afaik)
(13:00:39) mattock: all of this can be tested using the test instances
(13:01:00) lev__: how do we build https://github.com/OpenVPN/tap-windows6=
 ? we could probably setup build job on our internal CI
(13:01:01) vpnHelper: Title: GitHub - OpenVPN/tap-windows6: Windows TAP d=
river (NDIS 6) (at github.com)
(13:01:07) mattock: we may also need a couple of instances where test-sig=
ned drivers are allowed (for tap-windows6 tests)
(13:01:25) cron2_: lev__: well, this is what mattock is doing right now :=
)
(13:01:55) mattock: lev__: we could also use Appveyor on GitHub
(13:02:00) mattock: for basic CI
(13:02:32) mattock: it can also generate artefacts from the builds
(13:02:47) mattock: I haven't used it myself, but chipitsine has added su=
pport for it to openvpn-build at least
(13:05:49) cron2_: so - is it realistic to aim for June20 for the next re=
lease?
(13:06:17) mattock: at the moment it looks like
(13:06:47) cron2_: NordVPN wants to release next week, but I have no idea=
 whether they can get the signing right...
(13:07:06) cron2_: VyprVPN has not talked to me again, and neither has Ci=
sco
(13:07:16) mattock: is NordVPN big?
(13:07:29) mattock: if not, I'm pretty sure they don't have Win10 signing=
 in order
(13:07:38) cron2_: no idea.  they have a nice and shiny web site...
(13:08:01) lev__: mattock: how about our own Connect client? Isn't it als=
o "customer" of tap driver ?=20
(13:08:03) cron2_: they managed to sign the "last" tap6 driver themselves=
, but that might have been "the old rules, and the old certificates"
(13:08:10) cron2_: lev__: as far as I know, yes
(13:08:33) mattock: lev__: we should definite reuse the new Windows test =
framework for our products
(13:08:39) cron2_: who is maintaining "Connect for windows" these days?
(13:09:05) mattock: I may have to create separate tap-windows6 drivers fo=
r Connet
(13:09:08) mattock: Connect
(13:09:20) lev__: cron2_: I produce builds at least
(13:09:20) mattock: that's just for a minor name change
(13:09:36) mattock: which makes it rather silly tbh, but maybe it is unav=
oidable
(13:09:45) lev__: and fix some bugs
(13:09:46) cron2_: mattock: why?
(13:10:08) mattock: so that Connect's tap-windows6 driver can co-exist wi=
th community version
(13:10:18) mattock: i.e. uninstall does not remove the community version
(13:10:29) cron2_: that makes installer maintenance way easier indeed
(13:11:20) lev__: mattock: can this be a build parameter ?
(13:11:41) mattock: changing the name is not a problem, except that then =
we need new signatures
(13:13:34) syzzer: we should really look into using the VPN API on W10+
(13:14:11) syzzer: although that will be more limited that the current ta=
p-windows I guess
(13:14:56) lev__: syzzer: we are working on it internally
(13:15:09) lev__: and API is not exactly production quality
(13:18:14) syzzer: that's too bad...
(13:21:28) mattock: when the API matures a bit people may actually be abl=
e to use it
(13:21:31) cron2_: just as a side note (so that it has been said) - newer=
 NDIS versions (I think 6.30) also support non-ethernet drivers - so we c=
ould have proper tun driver...
(13:21:55) mattock: jkunkee's patchset adds NDIS 6.30 support (for arm64 =
primarily)
(13:22:08) cron2_: yes, but still "ethernet only"
(13:22:14) mattock: yep
(13:22:28) cron2_: (because the "real tun mode" thing is a much bigger ch=
ange)
(13:22:53) cron2_: but in that context I've tried to find out what the di=
ffence is between NDIS versions, and found that you can have different me=
dia types now, ethernet just being one of them
(13:26:36) mattock: anyways, do we have anything more about tap-windows6?=

(13:26:44) mattock: June 20th seems reasonable at the moment
(13:26:55) mattock: lots of test automation work ahead and bureaucratic p=
ains with Microsoft
(13:27:05) mattock: lev and I can tackle those
(13:27:27) mattock: cron2: I'll try to get the tapbuilder instance into c=
ommunity VPN tomorrow
(13:28:31) cron2_: mattock: thanks :-)
(13:28:32) mattock: cron2: any clue what operating systems we should have=
 "test-signing enable" instances for?
(13:28:49) cron2_: I'll keep poking dazo about the CVE and trying to coor=
dinate with other VPN providers...
(13:29:21) cron2_: wrt "test-signing enable" - those are the ones that te=
st the unsigned driver?
(13:29:24) mattock: yes
(13:29:30) mattock: for patch development purposes
(13:29:57) mattock: the other test instances would be closer to end-user =
experience and would allow testing signatures as well
(13:30:05) cron2_: I think we must have W7, W10/latest, and maybe the cor=
responding server instances
(13:30:18) mattock: is this tied to NDIS version?
(13:30:27) cron2_: if it works on W7 and W10, 8.0 and 8.1 "should" be fin=
e
(13:30:48) mattock: I could check which server instances have roughly the=
 same setup
(13:30:56) mattock: setting up those in EC2 is the easiest approach for m=
e
(13:31:06) mattock: otherwise I need to coordinate with the guys at the o=
ffice and that may take a bit of time
(13:31:24) cron2_: yeah
(13:31:41) mattock: anyways, we have a fairly solid plan moving forward
(13:31:43) mattock: meeting concluded?
(13:31:53) cron2_: time is over (read: kids are complaining that they are=
 hungry - holiday here, so kids @ home).  syzzer: short question - how's =
your time availabilty for reviews?
(13:32:02) cron2_: I have a few simple things that have crypto bits...
(13:32:27) cron2_: this one especially: https://patchwork.openvpn.net/pat=
ch/329/
(13:32:28) vpnHelper: Title: [Openvpn-devel] Pass the hash without the Di=
gestInfo header to NCryptSignHash() - Patchwork (at patchwork.openvpn.net=
)
(13:32:33) cron2_: mattock: yes
(13:35:27) mattock: =C2=A0\o/
(13:35:31) mattock: roughly on time :)
(13:36:46) mattock: I will write the summary later, got stuck at lunch

--------------1E378D7A91C94577E66A9375--

--SGRNGmeV9aXbEe0tG4mKcHWQA57tJZnii--

--UEefKQGVNLndAgjf4sJCvuCfmSdWJ9PbS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAlsOmDsACgkQKVhNn0CG
RXiuOwgAvMCGe6tZyG4skydE4pCtfKcFAhhbDrpFCy4uTAvHDvzlCFcY4V0cP7Cn
x/55KX/2VIjcm9d3oALGVNFaTm3Be7MpSdVAcd0GTse2aDlNzpjdq0rVHPhlNy4x
RQfRIJIg+Bf6iAdn1jDE3IA5JsQQSM+CpABHIE0S1gO1IgnzQTOaLQ0NcbDK5U88
ATbt9l5SgdTMQMNyM36O0OLgmSor56W057d+tS62VASW0nQgiAr6W8Kz+CoJ/97d
P2KXKVIB3vg4/0tOKohbfYNiqKabXIqAyBzyKB1biTioncGPIlOAo54bjPpoC+El
6kc8mpAYIFwIpyjxF6rSDcq3cSioaA==
=OhIC
-----END PGP SIGNATURE-----

--UEefKQGVNLndAgjf4sJCvuCfmSdWJ9PbS--

