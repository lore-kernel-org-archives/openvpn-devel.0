Date: Wed, 22 Jul 2020 12:44:54 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200722104454.GL1431@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="/iAb24HMtwETXBAs"
Content-Disposition: inline
Subject: [Openvpn-devel] summary of the community meeting @ 2020-07-22
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--/iAb24HMtwETXBAs
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Good morning,

we had a nice meeting today, and here's the summary and chatlog:

 - 2.5 release is nicely taking shape, most features are in, and the
   code in master is very well tested already

 - we agree on renaming --ncp-ciphers to --data-ciphers, to make clear
   that this is not a debugging aid anymore but "the!" control switch
   to set (to-be-negotiated) data channel ciphers in the future.

 - we broke WolfSSL with the "nonconditional AEAD" patch, which was
   unintended but "we really require AEAD in 2.5 to be always available"

 - remaining bugs/warts for "must be in 2.5.0!" are to be tracked in TRAC=20
   with "milestone 2.5.0"

   - warts that are slightly annoying but not as urgent get set to
     "milestone 2.5.1" ("fix after initial release")


 - tentative release schedule (which looks doable)
=20
    * 2.5_beta1 on August 05
    * 2.5.0     on September 10



Slightly redacted chatlog:

11:31 < ordex> aloha
11:32 < dazo> \o/
11:33 -!- dazo changed the topic of #openvpn-meeting to: Agenda at=20
          https://community.openvpn.net/openvpn/wiki/Topics-2020-07-22
11:35 < cron2> and indeed there it is :-)
11:36 < cron2> I've put a few things on the agenda so we can decide how to =
move=20
               onwards
11:36 < dazo> lets start on the top :)
11:36 < cron2> first, thank you all for amazing work in the last weeks - we=
're=20
               in pretty good shape for the release (though some odd corner=
s=20
               remain)
11:36 < ordex> yeehaaa!
11:37 < cron2> I totally love my newfound understanding of the plugin APIs =
:-)
11:37 < cron2> next thing: decided on "do we want to rename ncp-ciphers to=
=20
               data-ciphers" - this is a bit more than "just code review",=
=20
               which is why I put it here
11:38 < cron2> the patch is fine, and it also accepts the old option as com=
pat=20
               alias, so it won't break anything
11:38 < ordex> imho, it makes the real goal of the directive more clear
11:38 < ordex> to the users and to us
11:38 < cron2> "the new real goal" :-) - but yes, I agree
11:38 < plaisthos> ncp-ciphers was a good and fitting name when it was=20
                   introduced and --cipher was still king of the hill
11:39 < dazo> yeah, I agree to the renaming --ncp-ciphers ... NCP itself is=
=20
              more a technical detail which users don't really need to care=
=20
              about ... --data-ciphers describes better what it does
11:39 < ordex> yap yap, what dazo says
11:39 < ordex> ncp is really an "under the hood detail"
11:39 < plaisthos> but moving forward (esp. when my ncp v2.5 patch gets in)=
,=20
                   data-ciphers is only thing that remains
11:40 < cron2> good :-) - nobody objects, make it so (I'll review, ACK, mer=
ge=20
               later)
11:40 < dazo> I would probably prefer to see a INFO (or WARNING?) when=20
              --ncp-cipehers is used, educate them to move to --data-cipher=
s so=20
              we in can remove --ncp-ciphers in the future and only have=20
              --data-ciphers
11:40 < cron2> you need to excuse me for ~10 minutes - family business=20
               (collison, unavoidable)
11:42 < plaisthos> dazo: I don't think we should remove ncp-ciphers
11:42 < dazo> why?
11:43 < plaisthos> it is an alias that does not complicate code and giving=
=20
                   people the opportunity to have config that are also=20
                   compatible with 2.4 is more important than forcing peopl=
e to=20
                   a bit nicer sounding option
11:43 < ordex> true, but we also don't want to carry legacy things for deca=
des,=20
               no ? I think it would be nice to get rid of it at some point=
?=20
               like any other deprecate doption
11:43 < dazo> Right, I'm not saying removing NOW ... But more in line of 2.=
8 or=20
              something like that ... but that we already now just add a=20
              INFO/WARN to tell users to switch to --data-ciphers whenever=
=20
              --ncp-ciphers is spotted
11:44 < plaisthos> dazo: as compromise, we can keep it around as long as we=
=20
                   kept udp-mtu as an alias for tun-mtu ;)
11:44 < ordex> from the user perspective, there is no difference between=20
               ncp-cipher and anyother option we deprecate, I think >
11:44 < ordex> ?
11:44 < ordex> :D
11:44 < plaisthos> udp-mtu is an alias for link-mtu, sorry
11:44 < dazo> I was not aware of udp-mtu at all
11:45 < plaisthos> see
11:45 < plaisthos> ncp-cipher will fall out of use eventually anyway
11:45 < ordex> hehe
11:45 < plaisthos> and both data-ciphers and ncp-ciphers are not as necessa=
ry=20
                   as --cipher
11:45 < plaisthos> since they will always have good deafults
11:46 < plaisthos> since we can slowly add and remove cipher in versions
11:47 < dazo> That's what I really dislike about openvpn ... we have so man=
y=20
              options with no good overview of many of them ... we should a=
void=20
              leaving things behind like that  (udp-mtu got switched to=20
              link-mtu in 1.5_beta1!)
11:47 < syzzer> +1 on --data-ciphers
11:48 < dazo> Had udp-mtu had a warning to switch to link-mtu ... it would =
be=20
              clearer why we had that option and we could actually kick it =
out=20
              and have a cleaner code
11:48 < syzzer> and +1 on keeping --ncp-ciphers around for now. Options tha=
t=20
                actually add complexity is what hurts us, not aliases.
11:48 < syzzer> we might want to consider adding --data-ciphers as an alias=
 to=20
                2.4 too though
11:49 < syzzer> makes it easier for people to use the new name
11:49 < dazo> I really agree to have --ncp-ciphers as an alias to=20
              --data-ciphers (or vice versa, doesn't matter) .... but I rea=
lly=20
              want to improve the code cleanliness for the future too
11:51 < syzzer> We all agree like 99%. It's just that I believe plain alias=
es=20
                add neglegible complexity :)
11:52 < cron2> re
11:52  * plaisthos is with syzzer on this
11:53 < plaisthos> but let's postpone the "deprecate aliases" discussion
11:53 < plaisthos> because that affects a lot more optiosn than just=20
                   ncp/data-ciphers
11:54 < cron2> indeed.  I suggest we collect aliases on the "deprecated=20
               options" page as well, and decide when and what to do about =
it=20
               next meeting?
11:55 < dazo> I'm fine with that
11:55 < plaisthos> I peronsally think the effort deprecating them etc is no=
t=20
                   worth what we gain
11:55 < plaisthos> deprecation udp-mtu would gain us nothing but makes a lo=
t of=20
                   effort
11:55 < cron2> I'm curious how many we have and what effort it would be
11:55 < dazo> patch already on the way to the ML ... didn't take that much=
=20
              effort ;-)
11:56 < cron2> where's the dazo that always rejects anything that might=20
               people's running configs?
11:56 < cron2> "break"
11:57 < dazo> :-P
11:57 < ordex> "his was changed in
11:57 < ordex> OpenVPN 1.5_beta1 (release July 2003)"
11:57 < dazo> For aliases the effort shouldn't be big ... as they already h=
ave=20
              a 100% compatible replacement ... so it's more the aspect of=
=20
              defining a process to review alias options to clean up
11:57 < ordex> :p
11:57 < cron2> seriously: the change is trivial, but usually it's you worry=
ing=20
               about "someone might have this in an old config and they are=
 not=20
               aware because it always worked"
11:58 < dazo> I know ... but as long as there is a reasonable transition pe=
riod=20
              ... and users are informed about it in advance, I'm fine with=
=20
              cleaning up stuff
11:59 < plaisthos> can we postpone the discussion for time and move on with=
 2.5=20
                   release?
11:59 < ordex> dazo is getting compromised
11:59 < dazo> agreed
11:59 < ordex> yeah=20
11:59 < cron2> yes, as we agreed already
11:59 < plaisthos> I am drafting a reply to your udp-mtu patch on the mail =
to=20
                   give my perspective
11:59 < cron2> so, NCP rework patch - I do not want to discuss this *now*, =
but=20
               I'm searching for a review victim^Wvolunteer
12:00 < dazo> plaisthos: it's less efforts to just ACK it :-P
12:00 < cron2> syzzer: this is really your territory :-)
12:01  * syzzer was afk for 5 mins. Reading backlog...
12:01 < plaisthos> testing is for everyone :P
12:03 < cron2> I'm happy to whack the patch from all sides, but I'd really =
love=20
               to have someone who understands crypto sanity-check code and=
=20
               concept.
12:03 < ordex> I think having syzzer read that patch would be nice too :)
12:03 < cron2> syzzer: if you do not object very quickly, I'll assume that =
is a=20
               lazy-ACK on volunteering *cough* :-)
12:03 < syzzer> yeah, I'll try to review it. Stare-at-code should work. Tes=
ting=20
                from others is very welcome.
12:04 < cron2> lev__: can you hit your testbed with it?
12:04 < dazo> plaisthos: in the .rst file .... it should not be a space bet=
ween=20
              the "--option" line and the block below
12:05 < cron2> dazo: if the content is OK otherwise, I can fix whitespace o=
n=20
               the fly
12:05 < cron2> and typos
12:06 < lev__> I think I can
12:06 < cron2> cool :-)
12:06 < lev__> what patch exactly is that
12:06 < dazo> sounds good! ... side-note: I'll try to update the README.man=
=20
              file with recommended styling for our .rst files
12:06 < cron2> lev__: https://patchwork.openvpn.net/patch/1291/
12:06 < vpnHelper> Title: [Openvpn-devel,9/9] Rework NCP compability logic =
and=20
                   drop BF-CBC support by default - Patchwork (at=20
                   patchwork.openvpn.net)
12:06 < cron2> dazo: +1
12:07 < cron2> so.
12:07 < ordex> \o/
12:08 < cron2> 1.3. -> how do we track "small things we find at testing"?  =
I=20
               currently track stuff that I find during ACK-and-merge in my=
=20
               mailbox, but that does not scale well.  Not sure the=20
               "StatusOfOpenVPN25" page is ideally suited for that, so I=20
               suggest using trac more active, with "milestone 2.5.0" for "=
must=20
               be fixed!" patches, and maybe "milestone 2.5.1" for "yeah, t=
his=20
               sucks, but it can be done after=20
12:08 < cron2> release"
12:09 < syzzer> +1
12:09 < dazo> Sounds reasonable
12:09 < ordex> yeah using trac sounds meaningful
12:10 < dazo> Would be good to have the patchwork link into the trac ticket=
s,=20
              though ... so it's easy to find the related patches
12:10 < ordex> I think if we all agree on that, it could easily become a wa=
y to=20
               coordinate and oversee the status of the project
12:10 < ordex> we can add a field I guess
12:10 < dazo> ordex++
12:10 < ordex> or just add the link manually
12:10 < plaisthos> implicit declaration of function 'CRYPTO_memcmp' is inva=
lid=20
                   in C99
12:10 < plaisthos> ah dman
12:10 < dazo> I don't care how ... just that it is there :-)
12:11 < ordex> yeah
12:11 < plaisthos> and EVP_CIPH_FLAG_AEAD_CIPHER
12:11 < plaisthos> also undefined
12:11 < plaisthos> the latter is worrying
12:11 < cron2> plaisthos playing with WolfSSL again
12:12 < plaisthos> first time actually
12:12 < plaisthos> but it does not compile at the moment ...
12:12 < ordex> I think last time I tested that (?)
12:12 < plaisthos> yeah
12:12 < plaisthos> but the removal of OpenSSL 1.0.1 breaks it
12:12 < ordex> yeah
12:12 < plaisthos> not
12:13 < plaisthos> actually that we assume that AEAD API is always there br=
eaks=20
                   it
12:13 < ordex> so for 1.3 it seems there is agreement in trying to use trac=
 ?
      [ redacted ]
12:13 < cron2> ordex: yup.  I'll summarize this accordingly.
12:13 < ordex> thanks
12:13 < ordex> 1.4 !
12:14 < cron2> [ vaction dates ]
12:16 < cron2> so how do we organize "MSI building" (mattock), "reasonable =
test=20
               period", "release" around that?
12:16 < ordex> probably we should target mid august for the release ?
12:17 < cron2> that is a bit short on "get people to test", if we can only =
have=20
               a MSI installer by Aug 5 or so
12:17 < lev__> MSI building is mostly automated, except for signing
12:17 < cron2> lev__: can you generate signed MSIs?  Or only mattock?
12:17 < lev__> I can do that for testing purposed (already did for testing =
my=20
               installer fix)
12:18 < lev__> not sure about signing, but if needed I can ask mattock=20
12:18 < ordex> cron2: but we can still release the beta (or rc1) for mid au=
gust=20
               and then we let people test ? or that's not what was planned=
 ?
12:18 < cron2> ordex: yeah, beta/rc1, but not "2.5.0 release in mid August"
12:18 < cron2> I thought you wanted the full release then
12:18 < cron2> so, my suggestion would be:
12:18 < dazo> I will also be partially away next week and the following wee=
k=20
              ... but I will pay attention to e-mails and can step in if th=
ere=20
              are some urgent things requiring my attention
12:18 < cron2> - we test internally and fix like crazy :-)
12:19 < ordex> :D
12:19 < cron2> - when mattock returns, we release rc1/beta/whateveryoucalli=
t,=20
               with signed MSIs
12:19 < cron2> (that would be "August 5")
12:19 < cron2> then we test more and solicit as much feedback as we can
12:19 < cron2> and aim for formal release like "September 10" or so
12:20 < ordex> that sounds like a plan
12:20 < ordex> even though you may not have enough time to chime in ?
12:20 < cron2> I do not want the actual release to happen while I'm not the=
re=20
12:21 < cron2> but "read bug reports and tell people that it's their own=20
               fault", I can do remotely
12:21 < ordex> :D
12:22 < plaisthos> I am on my way to lunch in 5 minutes
12:22  * ordex is typing from the dining table :>
12:23  * cron2 just ate some leftovers from the fridge :)
12:23 < ordex> ok, so can we agree on the schedule proposed by cron2 ?
12:23 < cron2> anyway, plaisthos, syzzer, dazo: any amendments?
12:23 < ordex> dazo: ^
12:23 < cron2> can we get QA folks to do some creative testing, like "git=20
               master client against 2.3 servers, older AS builds, ..."?
12:24 < dazo> No, that's fine ... I would say the code quality of git maste=
r is=20
              of beta quality ... so I would recommend that we just jump in=
to=20
              beta releases
12:24 < cron2> especially "against old AS" would be interesting, as this ca=
n be=20
               "modified old 2.3"
12:24 < cron2> dazo: so we do "beta1" and then "2.5.0" (unless something=20
               serious is found)?
12:24 < dazo> which means we branch of the 2.5 branch and starts the code=20
              freeze phase for that branch
12:25 < ordex> sounds good
12:25 < dazo> Yeah, beta1 ... if we see we need to fix anything, then that =
will=20
              be either beta2 or rc1, depending on the issue
12:26 < dazo> or if we go straight from beta2 -> 2.5.0 ... that's also poss=
ible=20
              ... as long as we are satisfied with the code
12:26 < cron2> do we want a "rc" release?
12:26 < dazo> Not necessarily ... I would say that depends on what the beta=
=20
              cycle reveals
12:26 < plaisthos> I don't want to force syzzer to be the blocker in review=
ing=20
                   the ncp patch
12:27 < cron2> when do we want to branch release/2.5?  at "2.5_beta1" or at=
=20
               "rc1"?  I hear mixed signals
12:27 < plaisthos> so it would be good if ordex or dazo or lev can help to =
that
12:27 < plaisthos> anyway off to lunch
12:27 < cron2> yes
12:27 < cron2> enjoy :)
12:27 < plaisthos> (I don't want to put that burden on syzzer I mean)
12:27 < ordex> cron2: I think after we have merged the latest bits on the m=
l ?=20
               i.e. by mid august ?
12:28  * dazo need to run in 5 minutes too
12:28 < ordex> (or earlier if we manage)
12:28 < cron2> ordex: there will always be bits to merge
12:28 < cron2> at some point we'll merge more bits to "master" and=20
               "release/2.5" :-)
12:28 < ordex> cron2: once we branch off i expect no new features in=20
               release/2.5 for a bit
12:28 < cron2> I think it makes sense to branch release/2.5 the moment we=20
               change version.m4 to be "something with a name"
12:28 < cron2> ordex: features are all in.  From now on, only bugfixes.
12:29 < ordex> well --ncp-ciphers -> --data-ciphers is not in yet :p
12:29 < ordex> anyway
12:29 < cron2> except for those two, yes :)
12:29 < ordex> how about branching off once these 2 ncp things are in ?
12:29 < cron2> and small featurettes and cleanup, of course
12:30 < ordex> and version.m4 is modified
12:30 < dazo> once we have all features we wants ... we can branch off, I'd=
 say
12:30 < cron2> version.m4 is modified at 2.5_beta1 release, which happens a=
t=20
               August 5
12:30 < dazo> "code freeze" to me means "bug fixes only" :)
12:30 < ordex> yeah
12:30 < cron2> yes
12:30 < ordex> let's branch off on aug 5th then
12:30 < dazo> yeah .... Aug 5 is a good time
12:30 < syzzer> I'll try to review the rework NCP patch this afternoon
12:31 < syzzer> should work
12:31 < ordex> syzzer: that'd be nice ! I'll check the patch too
12:31 < cron2> syzzer: thanks
12:31 < ordex> just to offer another half-eye
12:31 < cron2> I have updated the StatusOfOpenVPN25 page with the new timli=
ne
12:31 < syzzer> ordex: yes, very welcome. You'll look at the code an a=20
                different way.
12:32 < ordex> yeah
12:32 < ordex> ok
12:32 < cron2> ordex will complain about missing whitespace and added blank=
=20
               lines, and totally miss the travis explosions :-)  (but that=
 is=20
               good, travis can look for itself)
12:32 < ordex> it seems the schedule is settled!
12:32 < syzzer> Nice!
12:33 < ordex> anything else? or can we all jump into lunch ?
12:33 < cron2> nothing on the agenda (except patch review)
12:33 < cron2> and that is being worked on
12:34 < ordex> cool
12:35 < ordex> I will jump out then
12:35 < cron2> enjoy :)
12:35 < cron2> I'll send a summary soon, leaving out the exact vacation dat=
es
12:36 < ordex> thanks a lot
12:37 < dazo> thx!
12:37 < lev__> thanks!

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--/iAb24HMtwETXBAs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfGBilAAoJEB2Cnv7KVigS2zsL/3b6jv3pBnHJArblx7uZQvHP
OQNnB1nlAOrh9JHsKwYpTc98H2G2KgAljPwoPI+kvXghwXiDZlLJIVFKdZA5nrqy
/Rym4lyzEw9PuryLZjpSLYsAmVWA35AQvr2yj4b6wL9Ym1ysR2yBTFSCHYLiopXo
1oy1zyH4Z/h/SDT2K4b4k47KcNn/mJw0DX4EHStiDkw5Y6RHX/9mG77JxAkE8693
7opzMUrPwIJb+oTBCmYPlnwPnIjJOUHvW5Xva75F8h/ldEW25cXlB5QBg8OQ/+57
WNe1OkLtg343YxKGufYe3Vg4XcPzQDkYWrEg7nl0j+Mkc/FJryxG13CLT9u2l+lh
O/K25e97GE/YAPdobxomrlHghWxi1yVFDN2wbwAqBHB01H0X1xmCd7vANz4ss2V6
WSugicgCXP+EHpOstySbRzazZebP+QXZsgpKurHVNOo7Zt2HevjTaBkNp+o6MHhk
gn/BFfwrQfx1LnupHXqMoZXpZdDEt/WE5O8EfeubAw==
=OqIc
-----END PGP SIGNATURE-----

--/iAb24HMtwETXBAs--

