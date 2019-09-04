From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <596f0202-4908-6657-373e-ce6b7346b8e5@...515...>
Message-ID: <9501a49b-8361-4316-ae56-696c8de40b8c@...515...>
Date: Wed, 4 Sep 2019 14:11:02 +0300
MIME-Version: 1.0
In-Reply-To: <596f0202-4908-6657-373e-ce6b7346b8e5@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="4bWm32oLQhTSfZLAzfY5XjqCFpjGJQW08"
Subject: [Openvpn-devel] Summary of the community meeting (4th September
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
--4bWm32oLQhTSfZLAzfY5XjqCFpjGJQW08
Content-Type: multipart/mixed; boundary="DEDAMq80kHb8FIdYqnNUkVP7KRy61kQo5";
 protected-headers="v1"
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Message-ID: <9501a49b-8361-4316-ae56-696c8de40b8c@...515...>
Subject: Summary of the community meeting (4th September 2019)
References: <596f0202-4908-6657-373e-ce6b7346b8e5@...515...>
In-Reply-To: <596f0202-4908-6657-373e-ce6b7346b8e5@...515...>

--DEDAMq80kHb8FIdYqnNUkVP7KRy61kQo5
Content-Type: multipart/mixed;
 boundary="------------6BDF4A12198AF04FFA8CC1DA"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------6BDF4A12198AF04FFA8CC1DA
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Wednesday 4th September 2019
Time: 11:30 CEST (9:30 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2019-09-04>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

dazo, lev, mattock, ordex, plaisthos, rozmansi and syzzer participated
in this meeting.

---

Discussed HLK testing. As pointed out by rozmansi all of the tests don't
have to pass on the same HLK clients, and not all of the tests require a
physical HLK client. Therefore the following setup could possibly work
around the odd issues in mattock's physical HLK environment (possibly
related underlying network drivers):

- Virtualized HLK controller (Server 2016, already present)
- One physical HLK client (already present)
- One physical HLK support machine (already present)
- One virtual HLK client (for E2EPerf test, needs to be created)
- One virtual HLK support machine (for E2EPerf test, needs to be created)

This way E2EPerf traffic could run in fully virtualized environment and
thus avoid physical network/network driver-related problems.

Rozmansi also noted that Windows 10 1809 can be used for the majority of
the tests. Windows Server 2019 and Server 2019 Core is needed to pass a
couple of Server-specific tests only. Possibly those Server 2019 tests
could be run on virtual machines: this would circumvent the "Windows
Server 2019 driver support on real computers is poor" issue.

Agreed that at some point, maybe OpenVPN 2.6, it could be possible to
drop tap support altogether.

Also agreed that the main goal for tap-windows6 now is to get rid of the
unneeded HLK-testing complexity currently required for getting WHQL
certification.

---

Discussed the option of having tap emulation in OpenVPN. Basically it
would just allow connecting a tun client to tap server. Obviously
tap-specific features would not work, but basic connectivity would be there.

--

Full chatlog attached.

--------------6BDF4A12198AF04FFA8CC1DA
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2019-09-04.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2019-09-04.txt"


(12:44:38) mattock: mkay back at my computer
(12:45:23) mattock: seems like we don't have a topic list for today, prob=
ably I forgot to send the invitation
(12:45:43) mattock: in any case, I can give a brief update of everyone's =
favorite topic
(12:46:43) ordex: hi
(12:46:48) ordex: yeah
(12:46:49) ordex: :D
(12:47:06) mattock: to rule out the possibility of local issues in my phy=
sical HLK test environment (E2EPerf test) I've repeatedly tried to downlo=
ad the Virtual HLK but even getting it downloaded is a challenge
(12:47:30) mattock: the download seems to stop at 20GB even though the fi=
le size is claimed to be 31.5GB
(12:48:20) mattock: I also started fixing the EC2 HLK environment just so=
 that I could test E2EPerf
(12:48:25) mattock: that is in progress
(12:48:40) ordex: is e2etest a required step for the certification ?
(12:48:43) mattock: yes
(12:48:55) ordex: and we haven't passed that in the physical env ?
(12:49:01) mattock: and it is known to pass - several people have made it=
 pass in the past without any special trickery
(12:49:01) ordex: so you're trying to use the virtua env ?
(12:49:19) mattock: yes, to verify that the environment is to blame
(12:49:36) mattock: and then figure out what is the difference between wo=
rking virtual environment and non-working physical environment
(12:49:44) ordex: oh ok
(12:49:51) ordex: because we don't really know why it fails, right ?
(12:50:01) mattock: at this point I'm blaming the underlying network driv=
ers in Windows Server 2019 (they're the stock drivers), but I could be wr=
ong
(12:50:02) ordex: don't we get any feedback about the failure ?
(12:50:15) mattock: exactly, there is thousands of lines of debug logs bu=
t nothing useful
(12:50:36) lev__: are all those troubles because of tap?
(12:50:40) mattock: packet capture logs show lots of TCP-related errors (=
duplicate ACKs and such)
(12:51:20) mattock: I'm not sure what the problem is, but the logs don't =
show anything useful
(12:51:49) mattock: except that possibly the backchannel connection (=3Dt=
he one going to the "corporate network") stops working at some point for =
unknown reasons
(12:52:08) mattock: anyways, I need to make the test pass in some environ=
ment so that I can compare
(12:52:20) mattock: EC2 seems the path of least resistance, given the iss=
ues with VHLK
(12:53:12) lev__: do you think we can speed up this process by dropping t=
ap support?
(12:53:12) mattock: also, as rozmansi kindly pointed out that ARM64 with =
secure boot requires WHQL/HLK-tested drivers
(12:53:35) mattock: lev__: we had that discussions in the past and agree =
we really can't / should not at this point
(12:54:42) mattock: anyways, the HLK testing environment will need to gro=
w over time, and in my opinion we should do our best to outsource it once=
 we get the first HLK-tested release out
(12:54:54) mattock: otherwise my HLK workload will only increase over tim=
e
(12:55:05) mattock: something I'm not really looking forward to
(12:55:16) mattock: HLK is a huge timesink if/when something does not wor=
k as intended
(12:55:24) rozmansi: mattock1: _any_ windows with secure boot require WHQ=
L drivers. :(
(12:55:29) mattock: ah hi
(12:55:33) rozmansi: hi
(12:55:34) mattock: that's even worse then
(12:55:45) mattock: rozmansi: now that you're here
(12:55:53) rozmansi: you mentioned my name an I got a notification - didn=
't know there's a meeting today :(
(12:55:59) mattock: what is the correct file size for the VHLK 1809 vhdx =
file?
(12:56:17) mattock: my downloads stop at 20GB and converting to vdi forma=
t fails at 30%
(12:56:29) mattock: download is supposed to 31.5GB according to the brows=
er
(12:56:41) rozmansi: dunno, haven't saved it :) but I didn't have _any_ i=
ssues downloading it. More than once.
(12:56:56) mattock: interesting
(12:57:01) mattock: I'm using Linux though :)
(12:57:20) rozmansi: Maybe microsoft.com is alergic to linux. :(
(12:57:27) mattock: I would not be surprised
(12:57:44) mattock: though the download seems also allergic to Microsoft =
Edge (or Microsoft Edge is allergic to large downloads)
(12:57:45) rozmansi: i've used firefox on windows
(12:57:58) mattock: I'm now downloading it on Chrome on Windows ARM64
(12:58:04) rozmansi: microsoft doesn't eat its own cooking
(12:58:19) ordex: I can download it too and ship you a pendrive if you th=
ink it makes sense :D
(12:58:25) rozmansi: for the most of the time MSDN worked worst with Inte=
rnet Explorer
(12:58:32) mattock: ordex: I hate to say but that might actually make sen=
se lol :)
(12:58:44) mattock: rozmansi: I was unable to start the download using IE=

(12:58:57) ordex: mattock1: have you tried from a different internet conn=
ection ?
(12:59:00) ordex: i.e. home vs office ?
(12:59:06) ordex: maybe it's some provider thing too
(12:59:13) rozmansi: another thing: vhdx can be converted to .vdi and run=
 by VirtualBox.
(12:59:16) mattock: though it was on Server 2016 so all the security stuf=
f got in the middle
(12:59:17) ordex: that kills long lasting connections..because it must be=
 wrong !!
(12:59:23) syzzer: mattock1, rozmansi: I'm mostly clueless regarding the =
whole windows driver signing, but a colleague of mine told me yesterday t=
hat you can often avoid the difficult parts by marking the driver as "dem=
and_start=E2=80=9D instead of "boot_start"
(12:59:33) syzzer: maybe this rings a bell for you guys?
(12:59:53) mattock: rozmansi: yes, I tried that, but the file seemed inco=
mplete and hence the conversion stopped at 30%
(12:59:53) syzzer: (since you're talking about secure boot requirements)
(12:59:57) mattock: at 20GB
(13:00:43) mattock: ordex: I'm not 100% sure, but I can try a mobile conn=
ection
(13:00:44) mattock: anyways
(13:01:17) rozmansi: syzzer: nope, I don't think so... the tap-windows6 i=
s not a PnP device that could trigger a demand_start driver. It's a virtu=
al device that is not "plugged in".
(13:01:46) syzzer: ah, okay. and chaging that is not easier than fighting=
 the test setup?
(13:01:51) mattock: one more question to our resident Windows expert
(13:02:04) mattock: one of the problems with physical Windows Server 2019=
 instances is driver support
(13:02:37) mattock: do you know if it is possible to completely disable t=
he driver signing requirement on Server 2019 and if yes, would standard W=
indows 10 drivers work ok on it?
(13:03:15) mattock: to rule out issues with the stock (network) drivers t=
hat Windows Server 2019 is using out of the box
(13:03:26) rozmansi: mattock1: you already did `bcdedit /set testsigning =
on`, right?
(13:03:54) mattock: yes, but I mean disabling the signing requirement alt=
ogether
(13:04:18) mattock: so that I could install, say, Lenovo's Windows 10 eth=
ernet card drivers for the HLK client computer
(13:04:34) mattock: without importing Lenovo's driver signing cert into t=
he certificate store
(13:04:52) rozmansi: that should work
(13:05:15) rozmansi: win10 1809 release and winsrv2019 are one and the sa=
me core
(13:05:25) rozmansi: maybe your server has secure boot enabled?
(13:05:46) mattock: the HLK client is a fairly recent (~1 year old) Lenov=
o Thinkcentre, and the support machine is pretty old Thinkpad L420, and m=
ost of the devices don't have driver support at all
(13:05:57) mattock: I have to check those details
(13:06:26) dazo: [thinking a bit forward] The more I see this tap-windows=
6 fighting ... I begin to wonder if we really need to replace it with a p=
roper plain tun driver .... and for those needing to connect to a TAP bas=
ed server, that we emulate TAP instead in OpenVPN ... we will loose those=
 doing bridging or depending on OSI Layer 2/Ethernet frames on Windows - =
but how big is this user base?
(13:07:17) ordex: you mean tap emulation won't work when using windows ?
(13:08:23) dazo: ordex: that would mean the driver would need TAP mode.  =
But if it is a plain TUN driver, OpenVPN can remove the Ethernet frame an=
d pass the TCP/IP packet directly to the tun driver
(13:08:35) ordex: ah ok
(13:08:46) ordex: but wouldn't this probem also exist on linux then ?
(13:09:03) dazo: it's the TAP mode in the driver making this certificatio=
n explode in complexity on Windows
(13:09:21) rozmansi: mattock1: you can use Windows 10 1809 to do majority=
 of the tests. You need a Windows Server 2019 and Server 2019 Core to pas=
s some Server-specific tests only. But those are like two or three test I=
IRC. And probably they'd run on a virtual Windows Server 2019 too.
(13:09:24) ordex: or we keep the linux side as it is now without changing=
 anything ?
(13:09:40) dazo: ordex: well, the TAP emulation could work on all platfor=
ms .... Some Android/iOS users would probably like this feature too
(13:09:59) ordex: dazo: what would tun+emulation be useful for actually? =
if you lose all the advantages of L2 ?
(13:10:00) rozmansi: mattock1: you don't need to pass _all_ tests on the =
same test machines.
(13:10:03) dazo: ordex: but the primary goal is to get rid of the TAP com=
plexity in the tap-windows6 certification
(13:10:17) ordex: yap yap, I agree with gettind rid of the complexity
(13:10:25) dazo: ordex: to support those servers configured with TAP
(13:10:39) ordex: ok, so just to allow the connection to a tap server
(13:10:41) ordex: okok
(13:10:52) dazo: yeah
(13:11:22) dazo: it won't be feature complete compared to a full blown TA=
P setup ... but at least you can connect and pass traffic
(13:11:49) mattock: rozmansi: yes, that is a thought that also came to mi=
nd - pass e2eperf virtualized, then merge the results with the physical H=
LK results
(13:12:08) mattock: but I still need a HLK environment where e2eperf test=
 passes
(13:12:30) mattock: which is doable, but VHLK and EC2 are both fighting b=
ack, so I have to force them to comply
(13:12:53) mattock: I have to say that HLK has proven a tough foe to beat=
 lol :D
(13:13:12) ordex: dazo: yap yap okok
(13:13:24) rozmansi: mattock1: you don't even need to merge. Just put som=
e physical Windows 10 1809 boxes and some virtual Server 2019 into the sa=
me network controlled by the same WHLK controller. And when you schedule =
tests, you can pick which computer to schedule which test.
(13:13:46) rozmansi: VHLK =3D=3D HLK where controller is virtual
(13:15:28) mattock: rozmansi: hmm, that might work, especially if I had t=
his setup:
(13:15:28) mattock: - virtual controller
(13:15:28) mattock: - virtual client + virtual support machine
(13:15:28) mattock: - physical client (+ physical support machine)
(13:16:22) mattock: that way e2eperf test would go through virtualized ne=
twork
(13:16:27) mattock: would/could
(13:16:35) mattock: anyways, more things to try out
(13:16:38) rozmansi: for HLK you need:
(13:16:38) rozmansi: - one Windows Server !!!2016!!! - can be physical or=
 virtual. If virtual, Microsoft has already prepared a box you can use. I=
t's called VHLK.
(13:16:38) rozmansi: - test computers that must all match 1809 - be physi=
cal or virtual. Some test require physical, most work on virtual just fin=
e)
(13:17:03) mattock: yes, my controller is already 2016 and it is virtuali=
zed
(13:17:13) mattock: it has always been
(13:17:24) rozmansi: then you _dont_ need VHLK download
(13:17:44) rozmansi: you'll just get another server 2016 with HLK control=
ler pre-installed.
(13:18:09) mattock: yeah, it is probably redundant anyways, as installing=
 HLK is not very difficult
(13:18:13) mattock: the controller
(13:18:32) mattock: anyways I think we can move on if there are other top=
ics
(13:20:21) rozmansi: dazo: is dropping support for tap-windows6 viable fo=
r 2.5 Windows release?
(13:20:53) dazo: rozmansi: no, I think that's too early, unfortunately ..=
=2E but for 2.6 we should definitely consider it
(13:21:23) rozmansi: dazo: thanks. This means I need to make a proper dri=
ver installer for MSI packages for 2.5 then.
(13:21:49) dazo: We can discuss this on the Hackathon ... might be I'm ju=
st too pessimistic in regards to 2.5 :)
(13:25:38) mattock: meeting concluded or something else to discuss?
(13:26:28) mattock2 ha abbandonato la stanza (quit: Quit: IRC for Sailfis=
h 0.9).
(13:31:05) mattock: writing the summary
(13:31:09) ***syzzer is off for lunch :)
(13:31:20) mattock: have a good one!

--------------6BDF4A12198AF04FFA8CC1DA--

--DEDAMq80kHb8FIdYqnNUkVP7KRy61kQo5--

--4bWm32oLQhTSfZLAzfY5XjqCFpjGJQW08
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAl1vm8YACgkQKVhNn0CG
RXht/Af+LLkMwdSv8/XaUd4+PR/7ggy7NZeeWLm8/wSDoPTrVtRvfRzeeFhiiiYs
I9a7FY5t8B9fKoVxWaAk/OYeDO4RoyxClU+9EgoF8I9LVjjqjtD70FJPquYr2UnC
NXC1JsUuF/NsARqKAZiD7NAvNcrUhIZh1h6OwVsWjnsPVshm1+pQGQ/XLP8tEZjL
sNQDyK9nMIwJ/ZfPRRwNkfOeDzT3u+G0TX0OIHymanAUqPGBxkbzYNEuRQtZCzJy
xokWXIFVsPc1wQrPwp4TAtLDnSCPbCVP0u4T/0clIz5bPWHdXmfJBoe0lbvYAEf5
x7XXHpl1Dko5etEd+GLkgw2N4xkD5A==
=qbZ8
-----END PGP SIGNATURE-----

--4bWm32oLQhTSfZLAzfY5XjqCFpjGJQW08--

