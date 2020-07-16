Date: Thu, 16 Jul 2020 21:24:35 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200716192435.GG1431@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="TzA8ANzSGsUwRw80"
Content-Disposition: inline
Subject: [Openvpn-devel] summary of the community discussion on 2020-07-16
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--TzA8ANzSGsUwRw80
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

since Samuli is still hiding somewhere on a beach, it's my pleasure
to serve as a stand-in and bring you today's minutes...

Summary:

 - man page integration: patch set on the list, cron2 will skim-and-merge
   tomorrow'ish
 - list of deprecated options in the wiki: we have patches for OpenSSL 1.0.1
   and --key-method v1, and we need patches for=20

          --no-replay
          --ifconfig-pool-linear
          --client-cert-not-required

 - ns-cert-type depreciation was moved from 2.5 to 2.6 or later
 - async-client-connect patchset is on v7 now, half of it is merged,
   rest of it is being tested and will go in "tomorrowish"

 - timeline: aim at "having all patches in by Wednesday, then go about
   testing even harder and decide on alpha/beta/final release schedule"

 - server test framework - cron2 was allowed to brag a bit
 - plugin collection - cron2 wants to collect information about OpenVPN
   plugins (what plugins exists, where to find them, ...) in the wiki
 - auth-token and network manager "NM has a long backlog of issues" (quote)

 - side discussion about /30 support in OpenVPN on Windows, see=20
   trac #1302


Full chat log:

20:07  * cron2 wakes up ordex and plaisthos
20:07 < plaisthos> I am already awake
20:08 < dazo> For the man-page stuff ... I'm massaging the vrf documentatio=
n.=20=20
              Mostly looks good, but just doing some style changes and movi=
ng=20
              the --bind-dev option description into the VPN network config=
=20
              section (while keeping the example understandable)
20:08 < cron2> cool, thanks
20:08 < plaisthos> how much review does that need right now?
20:08 < dazo> other than that ... I would say these patches should be fine =
to=20
              be merged
20:09 < plaisthos> It is non-code so I am okay with doing less review than=
=20
                   normal
20:09 < cron2> so we "merge what is on the list"?  And you send further=20
               integration as it comes along?
20:10 < cron2> (like all the patches from wiscii, and plaisthos 6/6 v7)
20:10 < dazo> yeah ... but we have a challenge with one of the patches ....=
 ML=20
              puts them into a quarantine due to the size of it
20:10 < dazo> and I don't have access to the ML admin pages
20:10 < plaisthos> who has the list admin pw?
20:10 < cron2> which one?
20:10 < plaisthos> only samuli?
20:10 < dazo> I think so
20:10 < plaisthos> dazo: did you try OpenVPN2019?
20:10 < cron2> ah, 05 is missing
20:10 < plaisthos> or maybe OpenVPN2005? ;)
20:11 < dazo> yeah
20:11 < cron2> I have 01..04, 06..16
20:11 < dazo> plaisthos: :-P
20:11 < cron2> what is in 05?
20:11 < dazo> 05 is missing ... splitting it up into sections
20:11 < dazo> https://gitlab.com/dazo/openvpn/-/commit/c4d2d70c204f4cbda398=
387d

20:12 < dazo> patch 2/16 could need some extra testing and review ... as th=
at=20
              does some autoconf/automake tweaks, other than that it is=20
              basically just patching .rst files)
20:13 < cron2> maybe you could change 01 to introduce all the individual fi=
les,=20
               instead of introducing one big file and then splitting it ri=
ght=20
               away in the next patch?
20:13 < plaisthos> hm lets not try make a lot of extra work
20:13 < cron2> or just poke mattock, he should read SMS :-) to give you the=
=20
               password
20:14 < dazo> that's going to be a lot of work ... because the conversion w=
as=20
              pretty messy ... and getting the .8 file into .rst is needed=
=20
              before starting to chop it up into pieces
20:15 < dazo> if we need to split up the .8 file first ... it almost means=
=20
              re-doing everything from scratch
20:15 < cron2> huh?
20:15 < cron2> just squash "make a .rst" and "split the .rst into lots of s=
mall=20
               .rst"
20:16 < cron2> we do not really need the intermediate "all in one .rst" in =
our=20
               tree, do we?
20:16 < cron2> (it's a bit messy as 03 and 04 change the big file)
20:16 < cron2> but yeah, otherwise, just find the list password from mattoc=
k :)
20:16 < dazo> ahh, so you mean to squash most of this into fewer commits ..=
.=20
              that's fine ... but that patch will again be rejected by the =
ML
20:17 < cron2> dazo: if the "introduce the big fat file" can go through,=20
               "introduce the same amount in lots of small files" should be=
 fine
20:17 < dazo> the problem with 5/16 is this line:   doc/openvpn.8.rst=20=20=
=20=20=20=20=20=20=20=20=20
              | 5614 +----------------
20:17 < cron2> the "split one big file into lots of small files" patch is=20
               *twice* the size
20:17 < dazo> right ... I can try to move the removal of openvpn.8 into a=20
              separate commit
20:17 < plaisthos> r make split and the remove two comments %)
20:17 < plaisthos> 5a and 5b
20:18 < cron2> removal of openvpn.8 is a different commit already
20:18 < cron2> 01 is "introduce .rst"
20:18 < dazo> meh ... right
20:18 < cron2> 02 is "remove .8"
20:18 < cron2> bout about ~200k
20:18 < cron2> 05 is "split .rst into small pieces" which makes ~400k
20:18 < cron2> because all the content is in the diff twice
20:19 < cron2> yeah, what plaisthos says should also work (send 05a, 05b, a=
nd I=20
               can squash them back togehter if we really want that)
20:19 < dazo> alright ... so ... I'll keep all the man-section/*.rst files =
as=20
              is .... submit the first few patches, then a patch adding the=
=20
              man-sections/*.rst files and then a separate patch changing=20
              openvpn.8.rst into a small one
20:20 < cron2> 05a, 05b :)
20:20 < dazo> yeah, that's basically what will happen :)
20:21 < dazo> alright ... so I'll fix that ... and get most of this squashe=
d to=20
              fewer commits
20:22 < cron2> good, and then fire it over and can get myself busy with mer=
ging
20:23 < cron2> next?
20:23 < cron2> https://community.openvpn.net/openvpn/wiki/DeprecatedOptions
20:24 < cron2> can we have a quick look here and see what we have for 2.5 a=
nd=20
               what is left to do?
20:24 < plaisthos> There is massive commit from me that deals with cipher a=
nd=20
                   bf-cbc
20:24 < plaisthos> you guys can read the commit and say if that is good or =
not
20:25 < cron2> is it on the list already?  or one of last week's?
20:25 < plaisthos> 19:59:07 <plaisthos>=20
https://github.com/schwabe/openvpn/commit/988aa2f78c5f7c0efb1bb080e9e015544=
41b0

20:25 < vpnHelper> Title: Rework NCP compability logic and drop BF-CBC supp=
ort=20
                   by default \u00b7 schwabe/openvpn@...2569... \u00b7 GitH=
ub (at=20
                   github.com)
20:26 < cron2> the page states "To be removed in: OpenVPN v2.6" as goal for=
=20
               removal of BF-CBC (et al)?
20:26 < plaisthos> I think I said 2.6 a few times when I meant 2.5 in teh=20
                   commit message
20:27 < cron2> not looking at the commit (not sure we have time for that du=
ring=20
               the meeting) but at the DeprecatedOptions page
20:27 < cron2> that says "2.6"
20:28 < plaisthos> by default in this context means when you specify no=20
                   --cipher in the config in p2mp mode
20:28 < cron2> I can't remember when we discussed this and what we decided,=
 so=20
               I'm just going through that list
20:28 < dazo> what plaisthos is proposing is a step into such a complete=20
              deprecation in 2.6 ... basically supporting it in 2.5, but no=
t=20
              having it as default
20:28 < cron2> ah, so it's something else than removing the ciphers totally?
20:28 < dazo> yeah
20:28 < cron2> can we please sort of stick to the agenda?
20:29 < dazo> it's kinda related to DeprecatedOptions though ;-)
20:30 < cron2> I'm trying to figure out what is left in work items for 2.5,=
=20
               going through this list...  not saying we do not want the ot=
her=20
               patch, but it's a bit orthogonal
20:30 < cron2> I see --ifconfig-pool-linear, --client-cert-not-required and=
=20
               --ns-cert-type there with "To be removed in: OpenVPN v2.5
20:31 < cron2> (but not gone yet, or "no patch on the list yet").  Anything=
=20
               else?
20:31 < plaisthos> for key-method 1  I have a patch on the mailing list
20:31 < cron2> yes (thanks), and syzzer already requested MOAR OF THIS :-)
20:32 < dazo> for the DeprecatedOptions stuff ... I see we need to remote=20
              --key-method, --no-replay and possibly --ifconfig-pool-linear=
 ...=20
              still going through the list
20:32 < cron2> key-method is on the list.  yeah, --no-replay.
20:32 < cron2> many others already gone \o/
20:33 < dazo> plaisthos: what about the --ns-cert-type ... did that add som=
e=20
              ugly issues with AS?
20:33 < plaisthos> yeah
20:33 < plaisthos> published AS still use only ns-cert
20:33 < cron2> so we bump that to 2.6?
20:33 < dazo> That would be good
20:34 < plaisthos> looking at the pace that customers upgrade probably 2.7=
=20
20:34 < dazo> It will anyhow enforce itself into removal with time now, as=
=20
              OpenSSL 1.1.1 doesn't even support this
20:34 < dazo> (iirc)
20:34 < plaisthos> well
20:34 < plaisthos> you cannot check for ns-cert server anymore
20:35 < cron2> I think it's mutating into a no-op due to the SSL libraries=
=20
               ignoring it
20:35 < plaisthos> but you can check for ns-server or eku server
20:35 < dazo> ahh, right
20:36 < dazo> so ... the summary is, need removal patches for key-method,=20
              no-replay and ifconfig-pool-linear, while ns-cert-type remova=
l=20
              will be postponed to 2.7 ... right?
20:37 < cron2> and client-cert-not-required
20:37 < cron2> yes
20:38 < dazo> ahh, right, missed that one
20:38 < dazo> I can get those patches out this today or tomorrow
20:38 < cron2> any objections on that one from AS side?  I think AS *always=
*=20
               does certs?
20:38 < dazo> I think so too
20:39 < plaisthos> no=20
20:39 < plaisthos> most installations do certs but always in OpenVPN produc=
ts=20
                   there are obscure optionss to be configured
20:40 < cron2> I wonder why this sounds so familiar
20:41 < plaisthos> but client-cert-not-required on server side is not a pro=
blem
20:41 < plaisthos> the mess on client side is a different topic and we shou=
ld=20
                   not have that discussion right now
20:41 < dazo> :)
20:42 < cron2> good.  Next!
20:42 < dazo> async-cc!
20:42 < cron2> async-cc - when I wrote that agenda, we were still in discus=
sion=20
               on the right format or shape of v7.  I think we are nearly t=
here=20
               - 5 code patches, 1 doc patch, and my test server says "up t=
o=20
               code patch 4, things do not break anything"
20:43 < cron2> 1/6 even has an ACK already :)
20:43 < cron2> I'll work on adding some sort of connect plugin to my setup =
and=20
               see if I can break things in interesting ways :-)
20:43 < dazo> sounds good!
20:44 < cron2> unless ordex or plaisthos want to add more, this brings us to
20:44 < cron2> timeline!
20:44 < cron2> I think we should be able to have "everything in" by mid of =
next=20
               week if we keep up the pace
20:45 < plaisthos> I really want the NCP patch in too
20:45 < cron2> it depends to some extent on "chocolate and diet coke" strea=
ming=20
               to plaisthos
20:45 < plaisthos> to get that cipher/BF-CBC mess resolved
20:45 < cron2> now is the time, indeed
20:45 < plaisthos> it lacks only a bit of testing and sending it to the ml =
from=20
                   my side
20:45 < plaisthos> but the general approach needs to be okay with everybody
20:45 < cron2> and then review :)  (and we need openssl 1.0.1 v2 and key-me=
thod=20
               v2 from you)
20:46 < cron2> I wonder what I need to send to Delft to get more syzzer time
20:46 < cron2> when is lev__ coming back?  dazo?
20:47 < plaisthos> the other v2 are ready but not yet send to list
20:47 < cron2> ah, cool
20:47 < dazo> cron2: I've heard next week
20:47 < cron2> so I think next week we really need to test this from all an=
gles=20
               (and I hope Lev__ has some new ideas we've not explored yet =
-=20
               like async-push stuff)
20:48 < plaisthos> so who looks at dazo's patch and acks it?
20:48  * cron2 needs to test and merge the fast-push stuff ("you get soup=20
          without asking!")
20:48 < cron2> plaistos: the manpage stuff?
20:48 < plaisthos> conversation to rst
20:49 < cron2> I feel it's on my plate to "skim through and ack-merge"
20:49 < cron2> wiscii has actually *read* all the stuff and sent language f=
ixes
20:49 < plaisthos> cron2: okay thanks
20:49 < cron2> so ordex is free to review and complain about whitespace :)
20:50 < dazo> wiscii has done a realy good job on the language side ... I'm=
=20
              sure more things will surface, as it's an enormous amount of =
text=20
              ... but what he has picked on so far has been really good
20:50 < cron2> so I would say: "aim at getting everything in by wednesday, =
and=20
               then decide on timelines for alpha, beta, final release, and=
=20
               test plan for msi etc"?
20:51 < dazo> sounds like a plan
20:51 < cron2> \o/
20:51 < cron2> next - two short info points from my side
20:52 < cron2> - server test framework - I need to brag about this! - this =
has=20
               become really sophisticated in the last weeks.  I am now tes=
ting=20
               with 2.2, 2.3-enable-small, 2.3, 2.4 and master clients, and=
=20
               excercising quite a bit of code including async-auth plugin,=
=20
               auth *failure*, ccd/ ccd/DEFAULT, --client-connect script
20:52 < cron2> enough bragging :)
20:52 < plaisthos> :)
20:52 < dazo> nice!
20:53 < cron2> - plugin collection: I found out that I have no idea and we =
have=20
               no list about "what plugins do exist, where are they found, =
what=20
               do they do?" so I started to ask on the list
20:53 < cron2> I did not get much feedback yet (basically, one, from the=20
               mozilla folks)
20:53 < plaisthos> I am not even sure even one plugin for connect v2 exists
20:54 < cron2> I plan to have this in a wiki page which could then also hav=
e=20
               "how to build a plugin?" documentation or link to the=20
               documentation we have
20:54 < cron2> oh, yes, and I intend to do a connect and connect v2 plugin =
for=20
               "sample/" to actually excercise these code paths on the serv=
er=20
               rig
20:54 < dazo> I can certainly help with plug-in documentation .... I might =
not=20
              have a time enough to drive that alone, but can certainly=20
              contribute
20:55 < cron2> dazo: if you know about other plugins than I already have,=20
               please reply to the mail on the -devel list
20:55 < cron2> I'll do the wiki page then and mail it around
20:56 < cron2> (dazo has an ACK on 12/16 \o/ )
20:56 < cron2> so - if one of you has anything on plugins, feel free to jus=
t=20
               throw my way, I'll collect.
20:56 < cron2> next
20:56 < cron2> auth-token and network manager and suspend/resume
20:57 < cron2> this is not 2.5 material but something I wonder how to tackle
20:57 < dazo> I thought we had a wiki page with plugins mattock collected a=
ges=20
              ago ... but might have been removed as it was out-of-date
20:57 < plaisthos> still on my todo list but since it is a bugfix this can =
also=20
                   go into 2.5.1
20:57 < cron2> if you do network manager with openvpn, it will kill the pro=
cess=20
               on suspend, and restart it on resume
20:57 < cron2> plaisthos: I think this is something else (or maybe not)
20:58 < dazo> yes ... that's a NM "artefact" ... iirc, this requires quite =
some=20
              general NM refactoring, iirc
20:58 < cron2> so if I understand the flow of things right, the new openvpn=
=20
               instance has no way to use the token handed to the old insta=
nce,=20
               which means "re-enter 2FA".  Am I interpreting this correct?=
  Is=20
               there a way to fix NM here?
20:58 < plaisthos> well then, still this is my plan for auth-token fix :D
20:58 < dazo> as it tears down all VPNs when the physical network devices a=
re=20
              shutdown
20:58 < cron2> plaisthos: oh, this is on your radar? nice :)
20:59  * cron2 is silent and waits for the wonders to happen :-)
20:59 < dazo> I discussed this with thaller (NM developer) a couple of year=
s ago
20:59 < cron2> (my intention was to bounce this at dazo, who is rumored to =
have=20
               good ties to the NM folks and see if something can be fixed=
=20
               there)
21:00 < dazo> thaller is available on #nm here on FreeNode though :-P
21:01 < ordex> meh I forgot again due to dinner
21:01 < ordex> sorry
21:01 < dazo> those italians and their dinners! :-P
21:01 < ordex> :-P
21:01  * ordex studies the backlog
21:03 < cron2> dazo: so what was the result of that discussion?
21:04 < plaisthos> I will send the rest of my patch as patch set tommorrow
21:04 < dazo> cron2: that NM has a long backlog of issues needing to be fix=
ed=20
              ....
21:04 < cron2> it will be a busy day for me :)
21:04 < dazo> cron2: which distro did you last test this suspend/resume iss=
ue=20
              on?
21:06 < cron2> I'm not using NM, but I will ask the colleague who complaine=
d to=20
               me yesterday
21:07 < cron2> dazo: 21:06 < mme> fc31+32
21:07 < dazo> I have some patches pending for openvpn3-linux which will do =
the=20
              proper suspend/resume automatically as NM switches between=20
              offline/online mode ... and I need to set aside some time to =
at=20
              least provide a start/stop of VPN sessions via NM for=20
              openvpn3-linux
21:08 < dazo> okay, that is definitely recent enough ... so then that=20
              disconnect stuff is related to NM tearing down all VPNs when =
the=20
              network link is stopped
21:10 < cron2> yes
21:13 < cron2> so
21:13  * cron2 does the mattock
21:13 < cron2> "anything else, we're 13 minutes over time?"
21:13 < dazo> :)
21:13 < plaisthos> anyone want to read the commit message and comment on it=
? ;)
21:14 < dazo> Not on my side ... I have enough to pick at on my plate
21:14 < dazo> plaisthos: I'll try to have a look tomorrow
21:14 < plaisthos> thanks
21:14 < cron2> you need wiscii there :-)
21:14 < dazo> hehehe :)
21:14 < cron2> "It also us to finally drop ..."
21:14 < plaisthos> yeah I will also need to proof read it
21:15 < dazo> cron2: regarding the /30 issue ....=20
              https://community.openvpn.net/openvpn/ticket/1302
21:15 < dazo> hahaha ... just spotted the "keywords" for this ticket .... :=
-P
21:15 < cron2> plaisthos: there's 2.5s that want to be 2.4, and 2.6 that wa=
nts=20
               to be 2.5
21:16 < plaisthos> I know :/
21:16 < cron2> otherwise, from a quick glance, sounds okayish
21:17 < cron2> dazo: well, it's possible that /30 on *windows* does not wor=
k=20
               with tapv9
21:17 < cron2> because you need a 3rd IP address for the "I pretend to be a=
=20
               DHCP server"
21:19 < dazo> it is claimed to work with OpenVPN Connect though ... which u=
ses=20
              the same tap-windows6 driver .... I do vaguely remember some=
=20
              discussions about it, might be lev__ was involved in fixing s=
ome=20
              of it ... but my memory is fading
21:19 < cron2> your folks should really know to include log files with rele=
vant=20
               bits ("PUSH_REPLY")...
21:19 < dazo> hahahaha
21:20 < dazo> yeah ....
21:20 < cron2> and maybe relevant parts from the server config...
21:20 < dazo> I'll slap novaflash for that ... but it might be what he rece=
ived=20
              from the user
21:20 < cron2> if connect can do that, show us the logs :-)
21:20 < dazo> IIRC, it's an OpenVPN Cloud user
21:21 < cron2> yeah, but novaflash could just lab it and test it himself - =
I=20
               have seen him use windows! live on zoom!
21:22 < cron2> anyway, thanks for the relayed report, let's see if there is=
=20
               more data
21:23 < cron2> (this bug report is too cloudy, it needs to have more materi=
al=20
               to work with!)


--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--TzA8ANzSGsUwRw80
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfEKlyAAoJEB2Cnv7KVigSIxML/318/AlX4Mk/NqbGF/z2StHX
jmYtFzoKVozcKtjUVAt/sOMk1gQ7/3iADQv3mmXEyex4u8FQKlNgXyr67e3wSVXQ
qu1e0jo8+0EpupKM3ypyNaIypeMq/dd3/ZjfxCF4bd3isBwV9J0xpb81FwGL0hrD
n1CAEVshYKNsJhcdxt5MemRBFco7XOJh5dAQYjeDqOupdVq9b+Gaz5abQBw/4KDN
EE3XN1FZZ6aaikGTY0Sa/4X1XqBXrRSb5s9+jnoF7V+WrgDtkSLNKveVaJuLtTI2
bhhU9D/FALhP7QtlREIHC6ZCkUF3vcmZZa3INGz1mJ7W+dTNi8qh8/AmXP86k8Iu
l+EtR/bLHBjbMEaayliXtVmuBEvr4B2Y0nKzx/lJlCHZlM0ect9NtRP76MxaRHSk
96rMCotW5UmNLVF0rCRmKeEj6xINCcyQb3WtmdhmGf1ZFeJW0MDCuAmrvp852pC0
edQfHvCRItTthS5ty8dHfN5nCmwTSa0yo4hcBldtIw==
=8S+t
-----END PGP SIGNATURE-----

--TzA8ANzSGsUwRw80--

