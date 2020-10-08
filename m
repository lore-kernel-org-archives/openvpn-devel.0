From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <4bf0a788-1a6a-34a8-7ecf-587d23c3eb6b@...515...>
Message-ID: <3b28a122-cf64-103f-770e-999533c355b0@...515...>
Date: Thu, 8 Oct 2020 22:19:06 +0300
MIME-Version: 1.0
In-Reply-To: <4bf0a788-1a6a-34a8-7ecf-587d23c3eb6b@...515...>
Content-Type: multipart/mixed; boundary="------------F7E65590F1BD95959CD20DA9"
Content-Language: en-US
Subject: [Openvpn-devel] Summary of the community meeting (8th October 2020)
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
--------------F7E65590F1BD95959CD20DA9
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Thu 8th October 2020
Time: 20:00 CEST (18:00 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2020-10-08>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, dazo, mattock and yanv participated in this meeting.

---

Daynix Computing LTD has developed automation framework (hck-ci) for
running Windows HCK/HLK certification tests with sponsoring for Red Hat
to get virtio-win HCK/HLK tested:

<https://github.com/hck-ci>

Daynix is offering to let the OpenVPN project use their hck-ci
installation to test tap-windows6. This would allow them to generalize
their CI to work with drivers other than virtio-win as well and OpenVPN
project would benefit from getting proper Windows driver testing.
Potentially OpenVPN project could run its own test setup, but there's
not much need for it.

What we would have to do is create the base Windows images that will be
used in the test runs:

<https://github.com/HCK-CI/HLK-Setup-Scripts>

Some older documentation is here:

<https://github.com/daynix/VirtHCK>

The provisioning of the base Windows images could use some improvement.
At the moment the base images "go sour" when the evaluation licenses
expire. Building them from scratch would solve this problem.

Mattock will take a closer look at this next week.

The Daynix guys will start hanging out at #openvpn-devel to help us out
with any issues that may arise.

--

Noted that the https://openvpn.net website can't be modified until
Monday or Tuesday as the Wordpress instances are being upgraded. This
postpones the next 2.5 release slightly.

--

Full chatlog attached

--------------F7E65590F1BD95959CD20DA9
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2020-10-08.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2020-10-08.txt"

(21:02:20) mattock: hello
(21:02:49) mattock: meeting time
(21:02:53) mattock: anyone else? :)
(21:03:20) yanv: hello
(21:04:34) mattock: hi!
(21:08:53) yanv: I was invited by Samuli Sepp=EF=BF=BDnen to discuss poss=
ibility for automation of HLK\HCK tests of the OpenVPN drivers. We develo=
ped automation framework for the certification https://github.com/hck-ci =
and run it virtio-win drivers: https://github.com/virtio-win/kvm-guest-dr=
ivers-windows/pull/502.
(21:08:53) yanv: I wanted to see if it can be useful for your project as =
well.
(21:08:54) vpnHelper: Title: HCK-CI =C2=B7 GitHub (at github.com)
(21:09:30) mattock: that me
(21:09:41) yanv: :)
(21:09:51) mattock: it is surprisingly quiet today
(21:10:07) mattock: anyhow, I will write a summary so even if nobody else=
 pops in here they can see all this
(21:10:39) mattock: yanv: what kind of test rigs do you have?
(21:10:42) mattock: all virtual?
(21:10:50) yanv: Yes
(21:10:56) mattock: ok
(21:11:04) yanv: We are working to enable it to run on the physical machi=
nes as well
(21:11:20) yanv: in general the part that automates the test runs can do =
it already today
(21:11:20) mattock: in our case it seemed necessary to use real hardware =
to be able to pass all the tests
(21:11:46) mattock: but we're not at this point really interested in HLK =
except for actual (regression) test purposes
(21:11:55) yanv: but we don't have the part that will re-provision the ma=
chines before the test execution (it is better to run on the clean machin=
es and not ones that executed tests before)
(21:12:26) mattock: on what are the test VMs running on? VMWare, EC2, Azu=
re?
(21:12:27) Pippin_ [Pippin_@...2315.../vpn/protonvpn/pippin/x-75792076] =C3=A8=
 entrato nella stanza.
(21:12:35) yanv: QEMU\KVM
(21:12:41) mattock: ok, that should work as well
(21:12:45) yanv: Because we developed in to test virtio drivers
(21:12:59) mattock: is there any provisioning code in place?
(21:13:03) yanv: But then we changed it to be genreic
(21:13:04) mattock: or just manually installed KVM hosts
(21:13:14) mattock: +1 for the generic part :)
(21:13:18) yanv: The hosts are manual installed
(21:13:44) mattock: I've done my share of Windows automation with Puppet =
and Powershell DSC
(21:13:55) mattock: I actually do have some Puppet code that sets up HLK =
nodes
(21:14:05) yanv: also the initial preparation of the images is out of the=
 scope now (the installation of the test kit).
(21:14:31) mattock: here: https://github.com/Puppet-Finland/puppet-hlk
(21:14:33) vpnHelper: Title: GitHub - Puppet-Finland/puppet-hlk: A Puppet=
 module for setting up Windows Hardware Lab Kit (HLK) controllers and cli=
ents (at github.com)
(21:14:51) yanv: +1 > here: https://github.com/Puppet-Finland/puppet-hlk
(21:14:52) vpnHelper: Title: GitHub - Puppet-Finland/puppet-hlk: A Puppet=
 module for setting up Windows Hardware Lab Kit (HLK) controllers and cli=
ents (at github.com)
(21:15:12) yanv: I saw it, can be a great idea to integrate it together.
(21:15:42) mattock: yeah, I think reprovisioning the test nodes makes per=
fect sense
(21:15:46) mattock: HLK beats them to death
(21:16:03) yanv: In any case, we use snapshots during the tests. So there=
 are definitions of the platforms (which OS, which Kit to use, etc), then=
 there is device under test definitions.
(21:16:41) mattock: ok
(21:16:53) yanv: the automation deployed the drivers to the VMs and confi=
gures the HLK or HCK studio machine pool and then test project.
(21:17:13) yanv: It execute tests either by MS playlist or by the definit=
ions of white\black lists of the tests
(21:17:46) mattock: how does it report back the results?
(21:19:10) yanv: there is monitoring of the runs (so you get intermediate=
 results for the running tests), we also can apply filters at the end of =
the test runs. Later the results are extracted (hlkx or hckx package) and=
 also we parse the package to unpack individual result (can be useful for=
 the people that don't have specific studio version installed , but want =
to see the results)
(21:19:58) yanv: Example: https://www.dropbox.com/sh/rp7fqrlcutcd5dz/AADG=
-lq2eqFSyDc7qsTtlhoDa?dl=3D0&lst=3D
(21:19:59) vpnHelper: Title: Dropbox - NetKVM-Win10_1903x64_q35-2020_08_2=
6_03_54_11 - Simplify your life (at www.dropbox.com)
(21:20:14) yanv: You can see their results for NDIS miniport test run on =
Windows 10
(21:20:26) mattock: oh that's nice
(21:21:20) mattock: would be useful to us
(21:21:26) yanv: Currently we upload results to DropBox, but plugin for o=
ther services can be developed
(21:21:36) mattock: I suppose the CI tracks a Git repository and builds o=
n every commit?
(21:21:37) yanv: also there is an update of github PR
(21:21:41) yanv: yes
(21:21:56) mattock: it handles queuing of the jobs etc.?
(21:22:03) mattock: jobs =3D commits to test
(21:22:16) yanv: we have also a definition of what devices to tests depen=
ding on the directory stricter.
(21:22:35) yanv: the queuing actually handled by Jenkins.
(21:22:42) mattock: ok
(21:22:49) mattock: that's good enough
(21:23:12) mattock: btw. zx2c4 in here is the main Wireguard/Wintun devel=
oper
(21:23:24) yanv: so auto_hck executed with command line that specifies de=
vice\platform\commit hash
(21:23:31) mattock: wintun could probably benefit from the same CI treatm=
ent as tap-windows6
(21:24:59) yanv: Trigger file example: https://github.com/HCK-CI/AutoHCK/=
blob/master/triggers.yml.example
(21:25:00) vpnHelper: Title: AutoHCK/triggers.yml.example at master =C2=B7=
 HCK-CI/AutoHCK =C2=B7 GitHub (at github.com)
(21:25:03) dazo: hey! sorry!  time flew away
(21:25:08) mattock: hi dazo!
(21:25:21) mattock: good to have you here!
(21:26:58) yanv: hi dazo
(21:27:57) ***dazo catches up on the scrollback
(21:30:32) mattock: yanv: now, we obviously would like tap-windows6 (and =
wintun) to be tested by HCK_CI
(21:30:43) mattock: are there any missing pieces at your end for that?
(21:31:10) mattock: anything we could help you guys with to make this hap=
pen?
(21:32:26) yanv: so now there is a certain coupling between device and dr=
iver. because part of the device info is used to configure the VM that wi=
ll be the test client.
(21:32:36) yanv: this is something we are working now to resolve
(21:33:36) yanv: we did run tests for non-plug and play drivers (filesyst=
em mini filters) with our system, but it is not 100% yet
(21:34:16) yanv: another thing is the initial VMs provisioning. it can be=
 interested to integrate with the work you did with chef
(21:34:44) mattock: puppet, but yes
(21:34:55) yanv: sorry, my bad... puppet
(21:35:29) mattock: for me it would be fairly straightforward to help out=
 with the VM provisioning, to return the favor
(21:36:17) mattock: install the basic HLK client stuff on the node, test =
certificates, all that
(21:37:05) mattock: puppet would probably not be even required, most of i=
t is powershell mixed with some powershell dsc
(21:37:07) yanv: actually now we install  test certificates before the ru=
n. but it works both way.
(21:37:20) mattock: yeah
(21:38:06) mattock: the HLK controller is a long-living instance I suppos=
e?
(21:38:11) mattock: not wiped out on every run
(21:38:12) yanv: and now we have Jenkins that trigger the runs. if you wa=
nt to use something else, some configuration can be required.
(21:38:31) yanv: no, the idea is to run self-contained test setups.
(21:38:43) mattock: ok
(21:38:55) yanv: so that means , if you have powerful enough host, you ca=
n run several setups in parallel
(21:39:07) mattock: ok, that makes sense
(21:39:37) mattock: so each driver/environment would have its own set of =
HLK controllers and clients
(21:39:41) yanv: so atuo-hck starts "setup" that contains controller mach=
ine + at least one client (two for network devices)
(21:39:55) yanv: it also configures linux bridge (or ovs)
(21:40:29) yanv: no, the images can be shared
(21:40:45) mattock: ok
(21:40:45) yanv: during actual test run, we will use snapshots
(21:41:36) yanv: https://www.dropbox.com/sh/rp7fqrlcutcd5dz/AADG-lq2eqFSy=
Dc7qsTtlhoDa?dl=3D0&lst=3D
(21:41:37) vpnHelper: Title: Dropbox - NetKVM-Win10_1903x64_q35-2020_08_2=
6_03_54_11 - Simplify your life (at www.dropbox.com)
(21:41:38) mattock: so essentially the provisioning of the VMs would crea=
te the base image which can be snapshotted
(21:41:43) yanv: sorry, wrong link
(21:41:51) yanv: https://github.com/HCK-CI/AutoHCK/blob/master/lib/engine=
s/hcktest/platforms.json
(21:41:52) vpnHelper: Title: AutoHCK/platforms.json at master =C2=B7 HCK-=
CI/AutoHCK =C2=B7 GitHub (at github.com)
(21:42:07) yanv: check the sample definition file for the platforms
(21:42:22) yanv: so for each os + test KIT you need to create base images=

(21:42:49) yanv: the image names are used by convention of OS + kit type =
+ kit version
(21:43:17) yanv: For example:
(21:43:17) yanv:  "name": "Win7x86",
(21:43:17) yanv:     "kit": "HCK",
(21:43:17) yanv:     "st_image": "HCK.qcow2",
(21:43:17) yanv:     "clients": {
(21:43:17) yanv:       "c1": {
(21:43:19) yanv:         "name": "CL1",
(21:43:21) yanv:         "cpus": "2",
(21:43:25) yanv:         "memory": "2G",
(21:43:26) mattock: I start to see why you'd want to automate the  base i=
mage creation / provisioning
(21:43:27) yanv:         "winrm_port": "4002",
(21:43:29) yanv:         "image": "HCK-C1-Win7x86.qcow2"
(21:43:31) yanv:       },
(21:43:33) yanv:       "c2": {
(21:43:35) yanv:         "name": "CL2",
(21:43:37) yanv:         "cpus": "2",
(21:43:39) yanv:         "memory": "2G",
(21:43:41) yanv:         "winrm_port": "4003",
(21:43:43) yanv:         "image": "HCK-C2-Win7x86.qcow2"
(21:43:45) yanv:       }
(21:43:47) yanv:     }
(21:43:49) yanv:   },
(21:43:50) mattock: you have quite a few platforms covered there
(21:44:31) mattock: does this allow you to get signatures from Microsoft =
that cover all the currently supported Windows versions?
(21:44:32) yanv: Actually once you created the base images you use then "=
forever". The problem is that Win10, is no longer 1 OS :) There are new k=
its releases with new builds
(21:44:44) mattock: yep
(21:44:54) yanv: yes, that was the idea.
(21:45:13) mattock: we never had such grand plans, lack of resources :D
(21:45:36) yanv: the project was supported by Red Hat for virtio-win driv=
ers :)
(21:45:38) mattock: we operated on a false premise ("You need HLK to pass=
 to get signatures for Windows Server 2016+")
(21:45:42) mattock: :P
(21:45:56) mattock: I had a hunch this is not a pure volunteer effort :D
(21:45:57) yanv: although they don't use it for certification, but it is =
used for upstream CI
(21:46:40) mattock: anyhow, "we are interested", so what do you propose f=
or the next steps?
(21:47:11) yanv: some pieces we created before RH support. it started as =
a way for developer to run isolated test setups: https://github.com/dayni=
x/VirtHCK
(21:47:12) vpnHelper: Title: GitHub - daynix/VirtHCK: QEMU-KVM Virtual En=
vironment for Running Microsoft HCK Tests (at github.com)
(21:48:18) yanv: I guess the question is where do you want to run the tes=
ts :) if it is on your servers, we need to help you to bring up the CI, p=
robably with some changes in the engine.
(21:48:34) yanv: we can run it on our servers as a best effort as well.
(21:48:36) mattock: I really don't mind you running the tests
(21:48:43) mattock: and best effort is more than enough
(21:49:06) mattock: the code is open source and it changes rarely, so our=
 commits should not tax your system too much
(21:49:17) mattock: recently we've had "many" commits - like <10 in a mon=
th
(21:49:22) mattock: but that's very uncommon
(21:49:32) mattock: usually we have none in months
(21:49:32) yanv: so we can see what drivers exactly you have, start from =
win10 or windows server 2016\2019 (pick one) and get your help for initia=
l image creation
(21:49:55) mattock: +1
(21:50:02) yanv: for us it will be a good change to test the system more =
and make it more generic
(21:50:23) mattock: is the "initial image creation" documented somewhere?=

(21:50:29) yanv: yes
(21:51:24) yanv: actually it is partially scripted. https://github.com/HC=
K-CI/HLK-Setup-Scripts
(21:51:25) vpnHelper: Title: GitHub - HCK-CI/HLK-Setup-Scripts: Helper sc=
ripts to configure VMs needed for HLK/HCK setup to be used with AutoHCK (=
at github.com)
(21:53:17) mattock: I'll note that down
(21:54:13) yanv: Older docs:
(21:54:13) yanv: https://github.com/daynix/VirtHCK/wiki#Checklist_for_a_N=
ew_Controller_VM
(21:54:14) yanv: https://github.com/daynix/VirtHCK/wiki#Checklist_for_a_N=
ew_Client_VM
(21:54:14) vpnHelper: Title: Home =C2=B7 daynix/VirtHCK Wiki =C2=B7 GitHu=
b (at github.com)
(21:54:15) vpnHelper: Title: Home =C2=B7 daynix/VirtHCK Wiki =C2=B7 GitHu=
b (at github.com)
(21:56:03) mattock: I'll go through the documentation next week
(21:56:15) mattock: the Windows images you are using are the evalution im=
ages, correct?
(21:57:42) yanv: yes and no. depending for what. for virtio-win CI we hav=
e licenses from Red Hat. for development and internal testing, those are =
evaluation images
(21:58:18) mattock: when you restore from snapshot the evaluation counter=
 resets, right?
(21:58:39) mattock: that is, the images won't go "sour" over time?
(22:00:36) yanv: actually, you are right, they will go "sour" overtime...=
 because Windows will also check the date...
(22:01:00) yanv: yes, more reasons to have image provisioning automation
(22:01:20) mattock: I need to take a closer look at the provisioning part=

(22:01:31) mattock: perhaps I can improve it in the process as well
(22:02:14) mattock: I'm stretched pretty thin, but I will try to move thi=
s forward, starting with just one  target platform
(22:02:27) mattock: we're 2 minutes overtime
(22:02:39) mattock: plus it is getting late (EEST timezone here)
(22:03:02) mattock: if you hang around at #openvpn-devel perhaps I can po=
ke you with questions occasionally?
(22:03:50) mattock: what I'm trying to ask is: "can you hang around at #o=
penvpn-devel so that I can ask questions when needed?" :D
(22:04:26) yanv: no problem, I will also add Basil (he is mainly maintain=
ing HCK_CI) now to the email thread we have and ask him to join #openvpn-=
devel as well
(22:04:33) mattock: ok great!
(22:04:49) mattock: I'll also try to inquire if I could get somebody else=
 involved from our side
(22:04:55) dazo: mattock: just a quick recap on the 2.5 release ... what =
is missing here now?
(22:05:24) mattock: dazo: nothing afaik, but our website is in read-only =
mode due to Wordpress upgrade until Monday/Tuesday
(22:05:39) mattock: so, I can't _publish_ the release tomorrow as planned=

(22:05:52) dazo: mattock: good ... I saw some comments on tagging rc3 ...=
=2E so I was wondering why another rc cycle
(22:06:02) dazo: is there still outstanding issues we know about?
(22:06:33) mattock: I believe it is rc3 instead of 2.5.0 as the Windows p=
art still feels a bit wobbly
(22:06:40) mattock: though it is getting into a pretty good shape
(22:07:06) mattock: and the Windows code is evenly distributed between di=
fferent projects including openvpn itself
(22:07:28) dazo: "feels a bit wobbly" is a poor metric though :-P .... I =
would say that if we do not have any known issues or expect to see any is=
sues, it should be 2.5.0
(22:07:35) mattock: I would prefer having the tapctl.exe and msica stuff =
in another repo
(22:07:49) mattock: well that is a fair argument :P
(22:07:50) dazo: yeah, that's something we'll fix after the 2.5.0 release=

(22:08:12) mattock: personally I don't care if it is 2.5-rc3 or 2.5.0
(22:08:30) mattock: you can fight this out with cron2, or maybe I just mi=
sremembered the version number :)
(22:08:53) dazo: so, unless something really shows up before it's time to=
 tag ... I would vote for 2.5.0 now
(22:09:05) mattock: ok with me
(22:09:11) dazo: good :)
(22:09:14) mattock: yanv: one quick question
(22:09:23) yanv: yes
(22:09:39) mattock: who is "we" - that is, who should I attribute hck-ci =
to?
(22:09:57) yanv: Daynix Computing LTD.
(22:10:11) yanv: And mainly Basil Salman and me (Yan Vugenfirer)
(22:10:11) mattock: ok, that's what I thought but I wanted to be sure
(22:11:27) mattock: ok I think we're done for today
(22:12:23) cron2: re
(22:12:41) yanv: bye all
(22:13:14) mattock: oh cron2 made it to the summary
(22:13:15) mattock: bye!
(22:13:55) yanv ha abbandonato la stanza ("Leaving").

--------------F7E65590F1BD95959CD20DA9
Content-Type: application/pgp-keys;
 name="pEpkey.asc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="pEpkey.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----

mQENBF9XbKwBCADAEsX9sF+0PauqVCIX5SzteYzz2/awfjio7R4A7yGOkCPyFZui
ryItvJ9Oh21Woq2DW41JNZ16BR+3gJnWZ2wjKrYORXkk6Cq2mGfs1VHkikOXGeKh
G0kmNgewOB2xrbk27VvhALeUBRlbHF5w1XqGekm1tB/a8OThiyLA/jCzTf8LGSCq
rZoeg/DSvUNoOIuz/VzKvPRBNrvBgGfoR4qMmg5m6OaneaPckCuT58eNDMOGW3SD
f1wk31xBaqHNV2VMAyFuioxl3oyWdjp0dwdvgop+/l/8TJ/gUWqfQ8k5sik40Vlr
LrTwlR5+2/zOutJIy2N4T3xvz/4W6AthWe5BABEBAAG0JVNhbXVsaSBTZXBww6Ru
ZW4gPHNhbXVsaUBvcGVudnBuLm5ldD6JAVQEEwEIAD4WIQTUwk9SkPxedAa+noMq
Bow1gbDSfQUCX1dsrQIbAwUJAeEzgAULCQgHAgYVCgkICwIEFgIDAQIeAQIXgAAK
CRAqBow1gbDSfU62CACJBr2t6bor5THu7nx6NMTV2ubtsUYyHiLD4FeMXgRDSMhV
1GPJwSVF7qg1yNShlqco04Hykp/hDP83CG6ivZC21QACcVaUnRfACDETBGZ5ciUi
gLwjknDR9sQ9azOoqPp+bNBrlLWiQdYw7nyuNUYYGXQkv2stj7Rb11fR8IkWhIky
2VK8n5ppd3Al1nTNWxZkrTBgCO/JYXSWaZXFydwOPQxlzIBBeUoM3yoVxCP7qypu
ZbVQrDSX9L4LAFIBtgWaEBc2a2ocdlrwcQTovC8CWbg/b+0cG0FUsCuRhH4hsZOI
UiOwGGku2uLH5+JNKNDYgNmWgBZhV6wl59X4iZqguQENBF9XbKwBCADuoJFZ4PwJ
aCXWadIuuhy7pn+Gu7og85UGbb0xuI2mPtzR83V2qur/LeY8OnQSMSyy5n3ZBim5
noTe7la+9v/sYX+CC9Zj9KXXkTYiwDWtg+Pvwwjooee/ea336/kYaQSn1L2KHOJW
SgkQlfvM5FIvekQRvJ7scHn0o1tXKCtKVAOP9XIZdl2Dp+QGtKRAwJRFUiyd5oMq
7vY2x0YJoRS9Looq/+iqYNM+9zU0CjRNSXzfnKxBzSOVLtYBDFsud2LCt0bE5Gky
RFBq6cbJUt6aQInzzxVPW7kzEGKHi25AeCZ5UkX07eIGLwNO7PAX7A6YmsbF4Xbd
21sZEbb6EBVtABEBAAGJATwEGAEIACYWIQTUwk9SkPxedAa+noMqBow1gbDSfQUC
X1dsrAIbDAUJAeEzgAAKCRAqBow1gbDSfQe7CACZ6GI+rgKsIuXzhbyafZALyk55
d7I/6iFYNhCYUrVSOT187fhu1F/NTMCvcgQiOly+vvi9Xnw1JJTHVRSAmSMtCz/i
pM8mwU9HHQpHaN6adLdPsfhqsQM3/rGpQ6eGaNimfiQygA1YESvQIUC/edYw3ItF
4LOGu0Eyl5fbXV17ei21BzYiSrqtoBVfS0/G6p9fhP6j8w6OmpIc+ugSY/JmHNMb
NAjg6BR4Uuib/XeMIhtm57UmZqtJzBN0K61exQ2dJTvVdQ4X7wIqB73q3oNLJqJ1
kCZgoaLwFQhBMvRgh8zmk3Xm45RrmJAuPtgT4lzD1QcH0HZLkQFeI5QuHNC8
=3DqMWb
-----END PGP PUBLIC KEY BLOCK-----

--------------F7E65590F1BD95959CD20DA9--

