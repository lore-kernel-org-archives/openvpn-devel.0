From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <6cc03a83-47e6-cedb-254b-f445972788f5@...515...>
Message-ID: <b9c984d6-bcde-0d0e-349d-3a586600b668@...515...>
Date: Thu, 29 Nov 2018 10:03:11 +0200
MIME-Version: 1.0
In-Reply-To: <6cc03a83-47e6-cedb-254b-f445972788f5@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Joyt5q5mcXjBVDPwv9JeiqyWbJVHfE8oA"
Subject: [Openvpn-devel] Summary of the community meeting (Wed,
 28th Nov 2018)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Joyt5q5mcXjBVDPwv9JeiqyWbJVHfE8oA
Content-Type: multipart/mixed; boundary="h0PGjyIXY3tJrbIfG9G1K5NTty0xLIBDe";
 protected-headers="v1"
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <b9c984d6-bcde-0d0e-349d-3a586600b668@...515...>
Subject: Summary of the community meeting (Wed, 28th Nov 2018)
References: <6cc03a83-47e6-cedb-254b-f445972788f5@...515...>
In-Reply-To: <6cc03a83-47e6-cedb-254b-f445972788f5@...515...>

--h0PGjyIXY3tJrbIfG9G1K5NTty0xLIBDe
Content-Type: multipart/mixed;
 boundary="------------44151DA33F28B88E263F133B"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------44151DA33F28B88E263F133B
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Wednesday 28th November 2018
Time: 11:30 CET (10:30 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2018-11-28>

The next meeting has not been scheduled yet.

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, dazo, ordex, plaisthos and rozmansi participated in this meeting.

--

Talked about tap-windows6 HLK testing. Stephen Stair is working on it,
and it looks promising, though progress is a bit slow due to other
projects getting in the way.

--

Discussed OSTIF's proposal to security audit the changes between OpenVPN
2.4.0 and 2.5.0. Agreed that auditing the new code paths would be
beneficial. In particular these paths:

- tls-crypt v2
- vlan patches
- Refactored ifconfig handling

Agreed that the audit should target OpenVPN 2.5.0, i.e. the already
stabilized codebase.

--

Had a discussion about --fragment. Agreed that if we can fix internal
fragmentation without needing a change in frame format then we can
definitely deprecate --fragment in the long-term. Also noted that lack
of tun-mtu support on Windows might be for historic reasons and might
not apply to tap-windows6. Also questioned whether the default MTU of
1500 is the best possible choice.

--

Full chatlog attached.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


--------------44151DA33F28B88E263F133B
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2018-11-28.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2018-11-28.txt"

<rozmansi> hello
<cron2> good morning
<cron2> so, meeting time!
<dazo> hey!
<lev__> hello
<rozmansi> hi
<cron2> looking at the agenda, we need mattock and ordex for most of it..=
=2E
<cron2> I can do the tap-windows6 HLK testing update - "Stephen Stair is =
working on it, and it looks promising, though progress is a bit slow due =
to other projects getting in the way"
<cron2> tls-crypt-v2 is done (all patches related to this have been ACKed=
 and merged)
<plaisthos> hello
<cron2> moin :)
<dazo> Actually, we have a couple things which needs to be discussed too =
=2E.. but don't want to "steal" the time from other topics on the list, i=
f they can be taken first
<dazo> (keywords: --fragment and --mssfix )
<cron2> well, we can discuss 1. and mattock can pick up from IRC log... (=
security-auditing, OSTIF)
<dazo> sounds good
<cron2> there will be quite a bit of new code - tls-crypt v2, vlan patche=
s, async client-connect, sitnl, plus refactoring changes
<cron2> so I think an audit on those parts would be good
<cron2> focus on "new code", obviously :)
<dazo> in regards to sec audit of tls-crypt-v2 would be mostly appropriat=
e, perhaps also vlan patches as well ... but not sure it makes much sense=
 to have a security audit on async client-connect, sitnl and non-crypto r=
elated stuff
<dazo> it basically depends on what kind of sec audit we expect
<cron2> async client-connect maybe not so, but if you can trick a server-=
pushed ifconfig string into a bug in the sitnl stuff, that might be an at=
tack angle against a client
<dazo> also considering that cov-scans have not revealed anything in the =
general code quality
<cron2> so everything that touches "network packets" or "coming from PUSH=
_REPLY"
<cron2> yes
<dazo> good point ... but iirc, the netlink API is fairly strict here, an=
d that would more be a kernel issue than a sitnl issue
<dazo> ordex: ^^^=20
<cron2> for the netlink bits, yes, but since it's refactoring the whole i=
fconfig stuff, and we're still calling "sudo ifconfig $user_supplied_stri=
ng" on other platforms...
<cron2> (I do not think there is an attack angle since we only pass 32bit=
 IP addresses, not "strings")
<dazo> ahh, yeah, my scope was limited to netlink only ... but yeah, you'=
re right on the the places we do execve() stuff
<plaisthos> tls crypt is a different beast from the rest
<ordex> sorry overlooked the meeting email
<plaisthos> the rest a "normal" auditor can do
<plaisthos> for tls-crypt you need someone you can understand well enough=
 to also look if tls-crypt as crypto implementation is solid=20
<plaisthos> "This xor encryption does not have any buffer overflows and a=
lso does not allow remote code execution" is pretty pointless :D
<dazo> :-P
<ordex> so we got a audit request from OSTIF (sorry I have missed that)
<dazo> iiuc, more like OSTIF asks us if it makes sense to do so
<ordex> oh ok
<ordex> we also have sitnl coming - I am wondering if it makes sense to w=
ait for that ?
<ordex> and vlan patches too
<cron2> yes
<ordex> but I thinkit would make sense to also wait for some tetsing to b=
e done, so maybe we can wait for when a full 2.5 release is out ?
<dazo> we know that 2.4.0 is good ... we don't believe we've done it (muc=
h) worse in the releases since that one .... so I think we can wait until=
 2.5.0 is out and then fix things as they appear
<cron2> +1
<ordex> +1
<ordex> also because by releaseing beta/rc versions we might have bug rep=
ort from users, which we can fix beforehand and avoid wasting ostif time =
on that. i.e. OSTIF should join after the "stabilization" phase. so what =
dazo says :)
<ordex> *reportS
<rozmansi> have to catch another meeting... take care, bye.
<ordex> bye!
<ordex> I think this meeting is somewhat finishing anyway .. ? :D
<dazo> so anything else on the sec-audit/OSTIF front?
<cron2> not from me
<cron2> dazo: have you seen the uncrustify-git-commit-thingie that plaist=
hos found?
<dazo> I've seen the discussion ... and it makes sense on conceptual leve=
l ... but haven't looked at that approach in detail
<dazo> but for that to work, we anyhow need to have a reasonable uncrust =
config we can use
<cron2> where's the 2.4.0 config we had?
<dazo> it's in dev-tools/uncrustify.conf ... but we might want to adjust =
it somewhat
* rozmansi has quit (Ping timeout: 256 seconds)
<dazo> so that it doesn't change anything in our current code base ..... =
or that we do another round of uncrusting our current code
<cron2> this is one of our biggest issues right now - large patch sets fr=
om plaisthos and ordex that get sent back after 2+ weeks for style issues=

<dazo> yupp
<dazo> for new code/files, this the current config can be used ... but if=
 it starts modifying lines not being modified by the patch, then we have =
real challenge
<cron2> right
<ordex> yeah
<plaisthos> for the client-connect patch I did a "make uncrustify clean" =
commit to be able to use uncrustify during my repase
<cron2> which can be a bit problematic if it changes context in a way tha=
t "git am" fails later on
<plaisthos> cron2: was only in unrelated code but yes
<cron2> (I do not think this very likely)
<cron2> indeed
<dazo> these are the changes our current uncrustify config wants on the l=
atest git master .... http://termbin.com/y9yt
<cron2> huh
<dazo> (I only took .c and .h files)
<cron2> did we leave out sample-plugins last time?
<dazo> it seems so :/
<cron2> because these changes are all unambiguously (sp?) agreed...
<dazo> and lz4 stuff too
<cron2> well, the lz4 has the "we do as little changes as possible on imp=
ort" disadvantage
<cron2> (so it can be diff'ed to upstream releases)
<dazo> agreed, this was just a simple test .... for f in $(git ls-files |=
 grep -E \\.[hc]\$ | grep -v "vendor/"); do echo "=3D=3D=3D=3D=3D=3D=3D=3D=
=3D> $f"; uncrustify -c dev-tools/uncrustify.conf  --no-backup -l C -p de=
bug.uncr $f; echo; echo; done;
<cron2> huh
<cron2> we left in changes to crypto.c which do not have {}
<dazo> but we're really sloppy about curly braces :-P
<cron2> -        ret =3D false;;
<cron2> huh
<cron2> so, looking at these diffs (excluding compat-lz4*) I would say "w=
e should apply them, via patch-on-the-list, and apply the pre-commit-hook=
 ASAP!!"
<cron2> -                fprintf(fp, "%"PRIi64".%06ld %x %s%s%s%s",
<cron2> +                fprintf(fp, "%" PRIi64 ".%06ld %x %s%s%s%s",
<cron2> these ones I can live with either way...
<cron2> but it's only a few
<dazo> most of this is really fair changes ... I don't disagree at all
<cron2> adding extra blank lines before #endif if that wraps only a singl=
e line (forward.h) looks a bit silly, so that option might need tweaking
<cron2> -#endif
<cron2> +#endif /* if P2MP */
<cron2> haha, there we go :)
<dazo> ;-)
<dazo> just looking at these ones: =20
<dazo>      bool error; /* if true, fatal TCP error has occurred,
<dazo> -                *  requiring that connection be restarted */
<dazo> +                 *  requiring that connection be restarted */
<dazo> I think that we should have the closing */ on a separate line in t=
he multi-line approach ... then all the * would be aligned too
<dazo> oh, this one actually aligns it ... anyhow I think I saw one which=
 did the opposite
<cron2> this might have been tab/space related
<dazo> yeah, could be
<dazo> +    |MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA384 )
<dazo> this looks wrong ... shouldn't it be: | MBEDTLS_X509_ID_FLAG(MBEDT=
LS_MD_SHA384)   ?
<cron2> the PRIi64 change is new - this is all "old code", so I think you=
 have a newer uncrustify version :-)
<dazo> uncrustify-0.64-1.el7.x86_64
<dazo> I don't recall what we used last time, but I don't think it's that=
 much newer :)
<cron2> but it does change new things :-)
<dazo> yeah, it does
<cron2> some of the code is just new and wasn't uncrustified (so, shame o=
n us) but other stuff has been there longer
<plaisthos> cron2: yeah there is also the oddity that if you add lines to=
 a short #ifdef section the #endif gets further away and then uncrusity a=
dds the comment
<dazo> oh the config has been updated since the run we had
<dazo> commit 4cd4899e8
<dazo> that shouldn't change that much though ...=20
<cron2> right, but that commit also includes the changes effected by this=

<dazo> I wonder if we've just done lots of changes since jan 2017 and not=
 been picky enough on the coding style :)
<plaisthos> probably the latter
<cron2> half of the brackets is "new code".  But we forgot the samples in=
 the first run.
<cron2> plus, new uncrustify :-)=20
<plaisthos> someone needed to point out to me that I could just run uncru=
stify on my commits before commiting because for some reason that never o=
ccured to me
<dazo> :)
<dazo> plaisthos: trust me, I'll enforce this on openvpn3-linux too :-P
<dazo> (just need to wrap up a reasonable config for it there as well)
<plaisthos> dazo: openvpn3 linux is different mess to begin with, since y=
ou are constantly switching from GNU style+linux style mix to OpenVPN C s=
tyle with random C++ style=20
<dazo> plaisthos: no no no ... *my* code is everything outside the core l=
ibrary ... the core library we can't do much about now :-P
<plaisthos> dazo: yes but when working on the code I am switched from cor=
e to openvpn3-linux back and forth
<dazo> we need to trick james to use a more reasonable coding style as we=
ll ... and enforce uncrustify runs on *commit* time for him :-P
<dazo> yeah, that's a real challenge, I see that
<cron2> can you make a video of that?  I want to see this ;-)
<dazo> :-D
<plaisthos> dazo: the more modern code of James more closely follows Linu=
x coding+what emacs automatically does
<plaisthos> so it is like writing linux style but with GNU identation rul=
es
<plaisthos> and tab is 8 instead of 4
<dazo> unfortunately ... I've experienced slight changes styles in emacs =
on upgrades as well :/
<dazo> so .... okay ... that's coding style
<dazo> tls-crypt-v2 update?  isn't that done?
<dazo> ordex ?
<cron2> the update is "the open patches have been merged", done
<dazo> cool!
<dazo> sitnl patches is being reviewed by plaisthos, I believe  (and I'll=
 follow up on the struct argv patches too)
<dazo> vlan patches?
<cron2> stuck somewhere between ordex and plaisthos, I assume, and neithe=
r wants to talk about it?
<plaisthos> cron2: my last information was that you and ordex somehow mag=
ically produce some patchset that I can review
<plaisthos> and I would do the same with client-connect for one of you tw=
o to review
<ordex> dazo: yes tls-crypt-v2 is done=20
<ordex> yes, for sitnl I have to provide a new patchset - it is WIP
<dazo> goodie :)
<dazo> So can we take a quick discussion about --fragment and --mssfix no=
w? ... primarily to just get the ball starting to roll
<cron2> I've seen the patches, but I admit I have no answers.  So I reall=
y need to read into this (and for the --fragment frame stuff, I need syzz=
er)
<dazo> right, we're actually going a bit further ... we want to deprecate=
 --fragment in a longer term
<cron2> if we can fix internal fragmentation without needing a change in =
frame format, I'm all for it
<dazo> we've looked into what to do in OpenVPN 3 .... and the complexity =
of --fragment is not really wanted  (packet re-assembly)
<dazo> so what we're doing is to make --mssfix better
<cron2> you can't avoid fragmentation if you need to carry big UDP packet=
s
<dazo> which covers TCP packets inside the tunnel
<cron2> mssfix will only help TCP, nothing else...
<cron2> exactly
<dazo> and then send ICMP packet too big responses otherwise
<cron2> this will not work for real-world traffic in the general case
<dazo> the ICMP responses would be inside the tunnel though
<plaisthos> To get cron2 up to speed
<cron2> it will still not work.  If the UDP-generating application isn't =
interested in the ICMP packet too bigs, it will still send out too-big UD=
P packets
<dazo> yes please :)
<plaisthos> we had an internal discussion. And the main goal is to make t=
he packets inside the tunnel small enough or use --fragment. --fragment i=
s a horrible option that we try to elimiate as much possible
<cron2> if we reduce tun-mtu today, it would achieve the same thing (make=
 the linux stack generate ICMP ptb)
<plaisthos> so for makeing the packets small you can either lower the tun=
-mtu or do workaround like mssfix
<plaisthos> James decided a few years ago that *always* tun-mtu 1500 and =
mssfix is the best solution=20
<cron2> "small enough packets" is best, but it will not be possible to do=
 in the general case...  unfortunately
<plaisthos> the windows tap driver does always 1500 unless you do some ma=
nual configuration, tun-mtu is ignored on windows
<dazo> (the windows tun-mtu stuff might be for historic reasons, where it=
 was needed to recreate the tun device to change the MTU ... not sure if =
that has improved since then)
<cron2> as a workaround for this, generating the ICMP ptb locally might b=
e better than "silently lose packets", I'm with you there :-)
<plaisthos> and current result is that we do mssfix to vpn udp packets lo=
wer than outer mtu and hope that for bigger packets udp fragmentation doe=
s not break
<cron2> understood (and it does, unfortunately)
<plaisthos> yes on my network udp fragemnts break, have no dig into what =
breaks them
<dazo> and we also consider that TCP is mostly used inside the tunnels ..=
=2E. and modern based applications UDP often will account for MTU issues =
and "fix" this on their own
<cron2> we can assume that in a non-trivial subset of use cases, external=
 UDP fragments will not work.  So that's something to avoid.
<cron2> dazo: the key word is "often", but I've seen enough cases where i=
t didn't work, so --fragment was indeed very useful to fix that.  Which i=
s annyoing as it needs state for reassembly, there is complex code and ma=
ny bugs lurking.
<dazo> but that does not mean it will help UDP cases where the senders ju=
st assume it will work and not bother checking if it really works
<cron2> like, DNS with DNSSEC, unfortunately...
<dazo> yeah, I'm fully with you on that
<dazo> yikes
<cron2> a typical DNS response can be close to 1500 bytes these days, if =
you have a few records and all the signatures...
<plaisthos> cron2: but doesn't have that a 1280 limit?
<dazo> right ... but I've seen a growth of DNS queries moved over to TCP =
too
<cron2> plaisthos: that's the minimum IPv6 packet size that a network mus=
t transport
<cron2> dazo: which is one way to cope if UDP doesn't give a reply, yes
<plaisthos> oh right it just depends on udp fragmentation
<plaisthos> dazo: fallback to tcp=20
<dazo> but I'm not saying we're happy about this ... and we do want to ma=
ke this "just work" ... but implementing --fragment is just too intrusive=
 as it is in openvpn 2 today
<cron2> for DNS it is complicated (EDNS0 maximum packet size, truncation,=
 tcp fallback, broken firewalls, ...)
<plaisthos> you mean in openvpn3
<dazo> so we just want to start the discussion with the community to come=
 up with something which can work reasonably well or better
<cron2> dazo: I understand, and accept the reasoning
<dazo> plaisthos: I meant implementing --fragment in openvpn 3 as it is i=
n openvpn 2 today, is too intrusive
<cron2> I wonder how we can get this tested in a meaningful way... it nee=
ds exposure to lots of funny stuff inside the tunnel to see what works an=
d what breaks, and why
<cron2> like, does QUIC cope if you have an openvpn tunnel with a small i=
nside MTU, because it is tunneld through an OpenVPN tunnel through an IPS=
EC tunnel, or so
<plaisthos> but based on our discussion here and if do not implement some=
thing like --fragment in oepnvpn3 we only have the option to lower tun-mt=
u to something that fits and declare networks that support 1280+vpn overh=
ead as broken and openvpn(3) ccannot work on them
<cron2> "that do not"
<plaisthos> yes not support 1280+overhead
<dazo> lev__ is the one digging into the --mssfix and ICMP ptb responses =
for openvpn3 ... this will appear in openvpn3-linux plus there is an ugly=
 reference client in the openvpn3 project as well (test/ovpncli/cli.cpp) =
=2E... so this would be a way to test things as it evolves
<cron2> yep
<dazo> another aspect with tun-mtu ... we don't want to reduce it unless =
strictly needed ... so we'd like to have 1500 as the default where it wor=
ks, but if it doesn't - ideally OpenVPN should detect this itself and pot=
entially reduce it dynamically
<plaisthos> I never got the reason why we want 1500 as default
<plaisthos> it is a stupid choice for non tap
<dazo> That I don't know either ... just following James in this case
<plaisthos> it makes perfect sense on tap devices but for tun I am really=
 not convinced. And the windows tap driver is not up to the task is reall=
y a lame excuse
<plaisthos> James argument for 1500 only works in a world where mssfix ac=
tually works for nearly all traffic
<dazo> for the win-tap driver, we need to see if things have changed ther=
e .... with the old win-tap driver, I have no doubt this was a real issue=
 .... with tap-windows6, I'm not so sure any more
<cron2> I'm fairly sure you can set the MTU on windows as well. It's just=
 that nobody bothered yet to figure out how (do you need an ioctl to the =
driver, is there an API call to windows, do you call netsh?)
<cron2> anyway.  Thanks for the update, I actually need to make the next =
meeting now...
<dazo> sure, lets call it a meeting ... and we'll send mattock the scroll=
back :)


--------------44151DA33F28B88E263F133B--

--h0PGjyIXY3tJrbIfG9G1K5NTty0xLIBDe--

--Joyt5q5mcXjBVDPwv9JeiqyWbJVHfE8oA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAlv/nUAACgkQKVhNn0CG
RXh4mwgAhPgsAcb5rFT3A7iQJj3ZQ/1iX2IdYfV0UScsbRow3FL5SIYyKlxhUPZW
Rz57P7kj/1GVgzFsAtY/6i5bcyosaQvP+M/hpsqV5/fhiMQzH5eyREEigsIJqMF7
MSwulDu4YXpIUIj5Ul976ThH/Iy1orQnqv60vY/XxkMd6gBgPbRdOs6ntf8oD6LZ
4cb98WDOnjVABb3ZaYg1RkWJ08F97QqCuw8DsqFL5wQj6tkH7NfqaROrOZWvKlRz
S0MCuHpkloYc1MboNF43zlbhNalZH0z7p06Az6TG3er0Ye4Ehb0MEVuWAUo2kKhP
yxlu0U4ZRjKkuuOqspRO74xe79d9Gg==
=tZW0
-----END PGP SIGNATURE-----

--Joyt5q5mcXjBVDPwv9JeiqyWbJVHfE8oA--

