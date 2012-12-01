Message-ID: <BAY173-W165A6BA815A8E0BD58ED5FF9420@...512...>
Content-Type: multipart/alternative;
	boundary="_da811ac6-cf01-4074-9acb-3cdc1f82c4b5_"
From: marcia discacciati <marcia_disca@...160...>
Date: Sat, 1 Dec 2012 08:25:15 -0200
In-Reply-To: <mailman.67275.1354279066.2177.openvpn-devel@lists.sourceforge.net>
References: <mailman.67275.1354279066.2177.openvpn-devel@lists.sourceforge.net>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Openvpn-devel Digest, Vol 78, Issue 6
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--_da811ac6-cf01-4074-9acb-3cdc1f82c4b5_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


"help"



> From: openvpn-devel-request@lists.sourceforge.net
> Subject: Openvpn-devel Digest, Vol 78, Issue 6
> To: openvpn-devel@lists.sourceforge.net
> Date: Fri, 30 Nov 2012 12:37:46 +0000
>=20
> Send Openvpn-devel mailing list submissions to
> 	openvpn-devel@lists.sourceforge.net
>=20
> To subscribe or unsubscribe via the World Wide Web, visit
> 	https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> or, via email, send a message with subject or body 'help' to
> 	openvpn-devel-request@lists.sourceforge.net
>=20
> You can reach the person managing the list at
> 	openvpn-devel-owner@lists.sourceforge.net
>=20
> When replying, please edit your Subject line so it is more specific
> than "Re: Contents of Openvpn-devel digest..."
>=20
>=20
> Today's Topics:
>=20
>    1. Re: [PATCH] Avoid recursion in	virtual_output_callback_func()
>       (David Sommerseth)
>    2. Re: [PATCH] Properly require --key even if
>       defined(MANAGMENT_EXTERNAL_KEY) (David Sommerseth)
>    3. Re: [PATCH] doc/management-notes.txt: fix typo (David Sommerseth)
>    4. Re: [PATCH] The get_default_gateway() function uses warn()
>       instead of msg() (David Sommerseth)
>    5. Summary of the IRC meeting (29th Nov 2012) (Samuli Sepp?nen)
>=20
>=20
> ----------------------------------------------------------------------
>=20
> Message: 1
> Date: Thu, 29 Nov 2012 22:16:54 +0100
> From: David Sommerseth <openvpn.list@...1114...>
> Subject: Re: [Openvpn-devel] [PATCH] Avoid recursion in
> 	virtual_output_callback_func()
> To: openvpn-devel@lists.sourceforge.net
> Message-ID: <50B7D0C6.60503@...1114...>
> Content-Type: text/plain; charset=3D"iso-8859-1"
>=20
> On 16/11/12 12:02, David Sommerseth wrote:
> > From: David Sommerseth <davids@...1347...>
> >=20
> > This solves a SEGV situation when using the management API while OpenVPN
> > is closing down.
> >=20
> > The situation happens when the management socket has closed and OpenVPN
> > tries to write an error about this to the management socket.  What happ=
ens
> > is that
> >=20
> >  virtual_output_callback_func() is called, which then calls
> >  -> man_output_list_push_finalize()
> >     -> man_output_standalone()
> >        -> man_write()  <-- this does the socket write
> >           -> man_io_error()
> >              -> x_msg()
> >                 -> virtual_output_print()
> >                    -> virtual_output_callback_func() (recursion start)
> >=20
> > virtual_output_callback_func() do have a mechanism to avoid recursion,
> > but that did not keep the recurse counter when man_output_list_push_fin=
alize()
> > is called.
> >=20
> > This patch just reorganise the recursion block to also keep the counter=
 while
> > calling the other functions from virtual_output_callback_func()
> >=20
> > Signed-off-by: David Sommerseth <davids@...1347...>
> > ---
> >  src/openvpn/manage.c |   15 ++++++++-------
> >  1 file changed, 8 insertions(+), 7 deletions(-)
>=20
> Applied to master and beta/2.3 branches
>=20
> commit b2b66179f6dcc37de9582d5c3044f0357dda3df3 (master)
> commit 5541ea21691b5b39adc4bd3e1ff1af86a050c71d (beta/2.3)
> Author: David Sommerseth <davids@...1347...>
> Date:   Fri Nov 16 12:02:06 2012 +0100
>=20
>     Avoid recursion in virtual_output_callback_func()
>=20=20=20=20=20
>     Signed-off-by: David Sommerseth <davids@...1347...>
>     Acked-by: Gert Doering <gert@...1296...>
>     Message-Id: 1353063726-25113-1-git-send-email-dazo@...384...
>     URL: http://article.gmane.org/gmane.network.openvpn.devel/7130
>=20
>=20
> --=20
> kind regards,
>=20
> David Sommerseth
>=20
> -------------- next part --------------
> A non-text attachment was scrubbed...
> Name: signature.asc
> Type: application/pgp-signature
> Size: 262 bytes
> Desc: OpenPGP digital signature
>=20
> ------------------------------
>=20
> Message: 2
> Date: Thu, 29 Nov 2012 22:16:57 +0100
> From: David Sommerseth <openvpn.list@...1114...>
> Subject: Re: [Openvpn-devel] [PATCH] Properly require --key even if
> 	defined(MANAGMENT_EXTERNAL_KEY)
> To: openvpn-devel@lists.sourceforge.net
> Message-ID: <50B7D0C9.5070909@...1114...>
> Content-Type: text/plain; charset=3D"iso-8859-1"
>=20
> On 26/11/12 15:33, Arne Schwabe wrote:
> > When specifying --tls-client --cert ... without a --key (or --pkcs11) o=
ption,
> > OpenVPN should complain: "You must define private key file (--key)...".=
 Ensure
> > that this works even when compiling with MANAGMENT_EXTERNAL_KEY.
> >=20
> > Also fix the other instance where this logic is broken
> >=20
> > Orginal-Patch-by: Found by Joachim Schipper <joachim.schipper@...1783...=
.>
> > Signed-off-by: Arne Schwabe <arne@...1227...>
> > ---
> >  src/openvpn/options.c |    4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> Applied to master and beta/2.3
>=20
> commit feca0900dd00577779ab02f2e52b41eb3dab935f (master)
> commit 9447858c38c5cf51265c7eab3445d7d5fb4f7bba (beta/2.3)
> Author: Arne Schwabe <arne@...1227...>
> Date:   Mon Nov 26 15:33:09 2012 +0100
>=20
>     Properly require --key even if defined(MANAGMENT_EXTERNAL_KEY)
>=20=20=20=20=20
>     Orginal-Patch-by: Found by Joachim Schipper <joachim.schipper@...1784...=
...>
>     Signed-off-by: Arne Schwabe <arne@...1227...>
>     Acked-by: Gert Doering <gert@...1296...>
>     Message-Id: 1353940389-31075-1-git-send-email-arne@...1227...
>     URL: http://article.gmane.org/gmane.network.openvpn.devel/7143
>     Signed-off-by: David Sommerseth <davids@...1347...>
>=20
>=20
> --=20
> kind regards,
>=20
> David Sommerseth
>=20
> -------------- next part --------------
> A non-text attachment was scrubbed...
> Name: signature.asc
> Type: application/pgp-signature
> Size: 262 bytes
> Desc: OpenPGP digital signature
>=20
> ------------------------------
>=20
> Message: 3
> Date: Thu, 29 Nov 2012 22:17:01 +0100
> From: David Sommerseth <openvpn.list@...1114...>
> Subject: Re: [Openvpn-devel] [PATCH] doc/management-notes.txt: fix
> 	typo
> To: openvpn-devel@lists.sourceforge.net
> Message-ID: <50B7D0CD.7070607@...1114...>
> Content-Type: text/plain; charset=3D"iso-8859-1"
>=20
> On 26/11/12 15:31, Joachim Schipper wrote:
> > Signed-off-by: Joachim Schipper <joachim.schipper@...1435...>
> > ---
> >  doc/management-notes.txt |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> Thanks!  Applied to master and beta/2.3 branches
>=20
> commit 5dfdb7c010c5a32a0ec51d9266748c641cd24dba (master)
> commit 376e1432b3ce0c5fc715cfc0f9a9ea7b733b4cc0 (beta/2.3)
> Author: Joachim Schipper <joachim.schipper@...1435...>
> Date:   Mon Nov 26 15:31:45 2012 +0100
>=20
>     doc/management-notes.txt: fix typo
>=20=20=20=20=20
>     Signed-off-by: Joachim Schipper <joachim.schipper@...1435...>
>     Acked-by: Gert Doering <gert@...1296...>
>     Message-Id: 1CED409804E2164C8104F9E623B08B901323D0B184@...1436...
>     URL: http://article.gmane.org/gmane.network.openvpn.devel/7141
>     Signed-off-by: David Sommerseth <davids@...1347...>
>=20
>=20
> --=20
> kind regards,
>=20
> David Sommerseth
>=20
> -------------- next part --------------
> A non-text attachment was scrubbed...
> Name: signature.asc
> Type: application/pgp-signature
> Size: 262 bytes
> Desc: OpenPGP digital signature
>=20
> ------------------------------
>=20
> Message: 4
> Date: Thu, 29 Nov 2012 22:17:05 +0100
> From: David Sommerseth <openvpn.list@...1114...>
> Subject: Re: [Openvpn-devel] [PATCH] The get_default_gateway()
> 	function uses warn() instead of msg()
> To: openvpn-devel@lists.sourceforge.net
> Message-ID: <50B7D0D1.1090403@...1114...>
> Content-Type: text/plain; charset=3D"iso-8859-1"
>=20
> On 29/11/12 14:16, David Sommerseth wrote:
> > From: David Sommerseth <davids@...1347...>
> >=20
> > A report on #openvpn pointed out that in his setup three warnings
> > appeard on the console when starting up.
> >=20
> >     $ sudo /usr/local/etc/rc.d/openvpn restart
> >     Stopping openvpn.
> >     Waiting for PIDS: 33031.
> >     Starting openvpn.
> >     openvpn: writing to routing socket: No such process
> >     openvpn: writing to routing socket: No such process
> >     openvpn: writing to routing socket: No such process
> >     $
> >=20
> > This setup is on FreeBSD using jails with strict access to the
> > routing table.
> >=20
> > After looking at the code path, this error was found in the BSD
> > sections for get_default_gateway().  But it was using the warn()
> > call instead of msg(M_WARN|M_ERRNO, ...) which causes these
> > warnings to go to stderr instead of the log file.
> >=20
> > The warning string is also slightly modified to better explain
> > what fails.
> >=20
> > Reported-by: Thomas Steen Rasmussen <thomas@...1782...>
> > Tested-by: Thomas Steen Rasmussen <thomas@...1782...>
> > Signed-off-by: David Sommerseth <davids@...1347...>
> > ---
> >  src/openvpn/route.c |    4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
>=20
> Applied to master and beta/2.3 branches
>=20
> commit b3f19cc4bec6978a128f5af3ab22d8cfa954b064 (master)
> commit 28d9e57638d66fde792a53a3eb6391ddb8bb426f (beta/2.3)
> Author: David Sommerseth <davids@...1347...>
> Date:   Thu Nov 29 14:16:12 2012 +0100
>=20
>     The get_default_gateway() function uses warn() instead of msg()
>=20=20=20=20=20
>     Reported-by: Thomas Steen Rasmussen <thomas@...1782...>
>     Tested-by: Thomas Steen Rasmussen <thomas@...1782...>
>     Signed-off-by: David Sommerseth <davids@...1347...>
>     Acked-by: Gert Doering <gert@...1296...>
>     Message-Id: 1354194972-5388-1-git-send-email-dazo@...384...
>     URL: http://article.gmane.org/gmane.network.openvpn.devel/7149
>=20
>=20
> --=20
> kind regards,
>=20
> David Sommerseth
>=20
> -------------- next part --------------
> A non-text attachment was scrubbed...
> Name: signature.asc
> Type: application/pgp-signature
> Size: 262 bytes
> Desc: OpenPGP digital signature
>=20
> ------------------------------
>=20
> Message: 5
> Date: Fri, 30 Nov 2012 14:37:28 +0200
> From: Samuli Sepp?nen <samuli@...515...>
> Subject: [Openvpn-devel] Summary of the IRC meeting (29th Nov 2012)
> To: "openvpn-devel@lists.sourceforge.net"
> 	<openvpn-devel@lists.sourceforge.net>
> Message-ID: <50B8A888.40109@...515...>
> Content-Type: text/plain; charset=3D"utf-8"
>=20
> Hi,
>=20
> Here's the summary of the previous IRC meeting.
>=20
> ---
>=20
> COMMUNITY MEETING
>=20
> Place: #openvpn-devel on irc.freenode.net
> Date: Thursday 29th Nov 2012
> Time: 18:00 UTC
>=20
> Planned meeting topics for this meeting were on this page:
>=20
> <https://community.openvpn.net/openvpn/wiki/Topics-2012-11-29>
>=20
> Next meeting will be announced in advance, but will probably be on the sa=
me
> weekday and at the same time. Your local meeting time is easy to check
> from services such as
>=20
> <http://www.timeanddate.com/worldclock>
>=20
> or with
>=20
> $ date -u
>=20
>=20
> SUMMARY
>=20
> cron2, dazo, ecrist, krzee, jamesyonan, mattock, novaflash, plaisthos,
> raidz and swg0101 participated in this meeting.
>=20
> --
>=20
> Started the meeting with short round of introductions. Some were not
> formally introduced, but are included here. On the community side:
>=20
> - cron2: The OpenVPN IPv6+BSD+Solaris developer, buildbot farmer (Germany)
> - dazo:  master of plugins and git, does patch management, cleanups and
> lots of other good work (Norway)
> - d12fk: develops the new openvpn-gui for Windows (Germany)
> - ecrist: takes care of forums, easy-rsa maintenance, #openvpn channel,
> etc. (Unites States)
> - krzee: takes care of the forums and IRC with ecrist; a mystical figure
> (somewhere in the Caribbean)
> - plaisthos: did the Android port; in charge of overhauling the socket.c
> code (Germany)
>=20
> On the company side:
>=20
> - jamesyonan: Father of OpenVPN (United States/Colorado)
> - mattock: Community manager, server administrator, does OSS releases,
> testing, etc. (Finland)
> - novaflash: Support technician (Netherlands)
> - raidz: Support engineer, network engineer, and janitor (United
> States/California)
> - swg0101: Support and development (United States)
>=20
> A few non-participants were also mentioned:
>=20
> - andj: Added polarssl support to openvpn and is maintaining that part
> (Netherlands)
> - juanjo: The other IPv6 guy who we seldom see (from where?)
>=20
> ---
>=20
> Jamesyonan gave a short introduction of the new C++ codebase:
>=20
> - about 30K lines of C++ code
> - an object-oriented rethinking of openvpn from the ground up
> - design similar to original OpenVPN 3.0:
> <http://community.openvpn.net/openvpn/wiki/RoadMap>
> - is very modular in the sense that SSL/crypto libraries, transport
> protocols, etc. can be modularized
> - fairly prototypical/incomplete at this stage; only the client-side has
> been implemented
> - has been tested against Access Server (based on OpenVPN 2.1.x) and
> OpenVPN 2.3* servers
> - is 100% protocol compatible with 2.x branches
> - has most 2.x's options
> - is being used in the OpenVPN tech android client and the upcoming iOS
> client
> - may (at some point) supplant the 2.x branch, but that'll probably take
> at least 1-2 years
>=20
> Some more technical tidbits:
>=20
> - core leverages on Boost Asio as it's async i/o layer
> - C++ is really ready for prime time in system programming / networking
> space
> - C++ 2003 that's used seems to work very well on different compilers
> - C++ static polymorphism (templates) is great for network programming
> where we have small objects that have polymorphic properties, such as
> IPv4 vs IPv6 addresses
>=20
> ---
>=20
> Discussed open sourcing the C++ codebase:
>=20
> According to jamesyonan, the plan is to release this probably under GPL
> within the next couple months, but the company needs the ability to
> relicense the C++ core because of (Apple) app store issues. It was
> agreed that having OpenVPN on that platform is a must. To accomplish
> this, relicensing the codebase is necessary. The consensus was that this
> can be done in a way that's acceptable to all parties, without resorting
> to the classic "copyright handover" scheme, which was not ok for everyone.
>=20
> The alternative would be to release the C++ codebase under a permissive
> license (e.g. BSD), but that would allow companies such as Apple or
> Microsoft to "steal" it. This was not seen as a good option, either.
>=20
> ---
>=20
> Discussed the role of OpenVPN 2.3 within the company:
>=20
> The company is planning to migrate the Access Server to OpenVPN 2.3*.
> Before the meeting mattock had already managed to get the Access Server
> running with OpenVPN-2.3-rc1 in a few hours, with only few minor
> modifications. Tests run by raidz during the meeting revealed no further
> issues. More details will follow later.
>=20
> ---
>=20
> Discussed having a joint company/community meeting in FOSDEM
> (https://fosdem.org/2013). Most of the present developers seem to be
> coming, but nobody has dared book the flights or hotel yet.
>=20
> ---
>=20
> Decided to arrange a second meeting next Thursday at the same time. The
> meeting will focus on helping James move to 2.3 and Git (from 2.1.x and
> SVN).
>=20
> ---
>=20
> Full chatlog as an attachment
>=20
> --=20
> Samuli Sepp?nen
> Community Manager
> OpenVPN Technologies, Inc
>=20
> irc freenode net: mattock
>=20
>=20
> -------------- next part --------------
> mattock_ 20.14.15
> ah, finally
> damn empathy 20.14.17
> it disconnected without saying anything 20.14.33
> everyone set? 20.14.46
>=20=20
> dazo 20.14.49
> heh ... been talking for your self?=20=09
>=20
> mattock_ 20.14.51
> yeah=09
>=20
> krzee 20.14.52
> *is here from work, so in and out depending on how busy it is*=09
>=20
> mattock_ 20.14.53
>=20=09
>=20
> ecrist 20.15.13
> *too*=09
>=20
> dazo 20.15.30
> d12fk might appear as well, but I don't think we should wait for him now =
... we're 15 min past already=09
>=20
> mattock_ 20.15.34
> ok, so here are today's topics: https://community.openvpn.net/openvpn/wik=
i/Topics-2012-11-29=09
>=20
> vpnHelper 20.15.35
> Title: Topics-2012-11-29 ? OpenVPN Community (at community.openvpn.net)=09
>=20
> dazo 20.15.50
> everyone from the company present?=09
>=20
> novaflash 20.16.05
> i am present=09
>=20
> raidz 20.16.10
> here=09
>=20
> novaflash 20.16.13
> james appears to be present as well, and raidz as well=09
>=20
> raidz 20.16.16
> jamesyonan=09
>=20
> cron2 20.16.23
>  /whois novaflash?=09
>=20
> novaflash 20.16.30
> an idiot
> i mean.. err.. 20.16.32
>=20=20
> raidz 20.16.37
> introduce yourself johan=09
>=20
> novaflash 20.16.38
> one of the support techs at openvpn technologies=09
>=20
> cron2 20.16.51
> (sorry if I missed the introduction, I'm not always paying close attentio=
n)=09
>=20
> novaflash 20.17.00
> that's okay i don't think i ever did introduce myself here
> i just sort of sidled in 20.17.07
> sneakily 20.17.11
>=20=20
> cron2 20.17.18
> now done  - welcome to the secret society=09
>=20
> novaflash 20.17.31
> *does secret handshake*=09
>=20
> mattock_ 20.17.59
> novaflash: btw. where do you live? besides the IRC channel, that is...=09
>=20
> novaflash 20.18.08
> i'm in the netherlands=09
>=20
> mattock_ 20.18.20
> yeah, I thought so=09
>=20
> cron2 20.18.35
> fun.  So how big is OpenVPN tech?=09
>=20
> novaflash 20.18.41
> so i usually am the one answering tickets and questions in #openvpn-as wh=
ile raidz and co and dreaming of unicorns and fairies=09
>=20
> raidz 20.18.59
> there are about 7 of us cron2=09
>=20
> novaflash 20.19.01
> 7 billion people working in the company at the moment!=09
>=20
> raidz 20.19.04
> we are a small bunch=09
>=20
> cron2 20.19.46
> I assumed so, but sometimes you guess wrong, and that sounded like "havin=
g support force round the world, in all time zones!!"=20=09
>=20
> dazo 20.19.54
> So, raidz, novaflash, jamesyonan and mattock_ are the company guys here n=
ow, right?=09
>=20
> raidz 20.19.58
> hahaha=09
>=20
> novaflash 20.20.12
> *checks list of nicks in the channel*
> yes. 20.20.14
> i think so 20.20.31
>=20=20
> raidz 20.20.39
> correct dazo=09
>=20
> mattock_ 20.20.40
> raidz: have you ever formally introduced yourself?=09
>=20
> novaflash 20.20.56
> introduce yourself raidz=09
>=20
> raidz 20.20.58
> I have a feeling people recognize me, but in case you don't:=09
>=20
> cron2 20.21.02
> I think he has
> he's the one breaking stuff @ company all day 20.21.15
>=20=20
> raidz 20.21.17
> I am OpenVPN's support engineer, network engineer, and janitor=09
>=20
> cron2 20.21.23
> what I said=09
>=20
> raidz 20.21.29
> We wear a lot of hats around here=20
> exactly cron2! 20.21.38
>=20=20
> novaflash 20.21.51
> raidz is selling himself short, he's also a ladies man - with a girl on e=
ach finger=09
>=20
> raidz 20.22.03
> not anymore! Just 1 now!=09
>=20
> mattock_ 20.22.13
> shall I give a "flash introduction" of the community guys?=09
>=20
> novaflash 20.22.14
> oh what a tragic accident, just one finger?=09
>=20
> dazo 20.22.23
> mattock_: makes sense=09
>=20
> mattock_ 20.22.30
> ok=09
>=20
> raidz 20.22.31
> mattock_: I think I know most of the people in here, but I think it would=
 be nice
> in case any of us don't 20.22.39
>=20=20
> cron2 20.22.50
> +1=09
>=20
> mattock_ 20.23.20
> andj added polarssl support to openvpn and is maintaining that part... li=
ves in Netherlands=09
>=20
> krzee 20.23.28
> are the corp guys here?  (besides james / mattock)=09
>=20
> mattock_ 20.23.41
> cron2 is one of the IPv6 guys, from Germany=09
>=20
> cron2 20.23.44
> *points krzee at "20 lines up"*=09
>=20
> novaflash 20.23.45
> krzee: james, mattock, me, raidz.=09
>=20
> krzee 20.23.57
> oh whoa, i didnt know you were corp=20=09
>=20
> mattock_ 20.23.59
> then there's the other IPv6 guy who we don't see much (juanjo)=09
>=20
> novaflash 20.24.09
> krzee: surprise=09
>=20
> raidz 20.24.12
> krzee: we are pretty much it, I am not sure if Francis will make it or no=
t, I don't think he knows how to use IRC
> 20.24.18
>=20=20
> cron2 20.24.21
> *g*=09
>=20
> mattock_ 20.24.22
> d12fk: is developing the new openvpn-gui for Windows and is also from Ger=
many=20=09
>=20
> krzee 20.24.27
> heh=09
>=20
> novaflash 20.24.31
> good, keep it that way, because i say way too many crazy shit on IRC=09
>=20
> mattock_ 20.24.47
> ecrist is taking care of forums, easy-rsa maintenance, #openvpn channel, =
etc. and is from the States=09
>=20
> raidz 20.24.49
> I thought cron2 was the ipv6 guy mattock_=09
>=20
> mattock_ 20.25.00
> ender can introduce himself=20
> raidz: he's one of them, the active one 20.25.07
>=20=20
> novaflash 20.25.08
> raidz: that's what he said=09
>=20
> cron2 20.25.16
> raidz: I did "IPv6 payload", juanjo did "IPv6 transport"=09
>=20
> novaflash 20.25.22
> ahh.=09
>=20
> mattock_ 20.25.24
> keitsi can also introduce himself=20=20=09
>=20
> plaisthos 20.25.28
> sup=09
>=20
> cron2 20.25.29
> both together form "IPv6 support"=20
> keitsi? 20.25.35
>=20=20
> mattock_ 20.25.48
> krzee is also working on forums and IRC like krzee, and I believe he's cu=
rrently somewhere in the Caribbean=20=09
>=20
> raidz 20.25.48
> ahh=09
>=20
> plaisthos 20.25.54
> I managed to get here a bit earlier (reading backlog now)=09
>=20
> cron2 20.26.10
> and plaisthos is the community janitor=09
>=20
> mattock_ 20.26.27
> plaisthos has done the Android port of OpenVPN and has been pretty active=
 here
> that's it I guess 20.26.32
>=20=20
> cron2 20.26.34
> cleaning up some damp and smelly stuff inside socket.c=20=09
>=20
> krzee 20.26.49
> <-- pirate of the caribbean ;]=09
>=20
> raidz 20.26.56
> Nice to re-meet/meet you all!=09
>=20
> mattock_ 20.27.04
> plaisthos: +5 for cleaning up the scary parts=09
>=20
> cron2 20.27.05
> and dazo is the master of plugins and git=09
>=20
> novaflash 20.27.17
> plaisthos is arne schwabe?=09
>=20
> mattock_ 20.27.19
> ah yes, did I somehow manage to skip dazo
> ? 20.27.24
>=20=20
> cron2 20.27.25
> easy to overlook=09
>=20
> mattock_ 20.27.29
> uh=09
>=20
> cron2 20.27.32
> novaflash: yes=09
>=20
> novaflash 20.27.36
> gotcha=09
>=20
> plaisthos 20.27.37
> novaflash: yes=09
>=20
> novaflash 20.27.40
> gotcha=09
>=20
> mattock_ 20.27.41
> also from Germany?=09
>=20
> dazo 20.27.42
> I'd like to add that plaisthos is also in charge of overhauling the often=
 feared socket.c code=20=09
>=20
> raidz 20.27.42
> how did you manage to skip dazo?!=09
>=20
> krzee 20.27.50
> +5 more for how awesome plaisthos's android client is=09
>=20
> dazo 20.27.59
> *considers to get grumpy on mattock_ *=09
>=20
> cron2 20.28.05
> raidz: he's hardly saying anything on IRC these days, so we tend to forge=
t him=09
>=20
> raidz 20.28.11
> ouch=09
>=20
> mattock_ 20.28.14
> so, dazo is taking care of patch management, cleaning up the codebase and=
 in general doing lots of good work
> from Norway 20.28.18
>=20=20
> cron2 20.28.21
> or maybe mattock's IRC client is just ignoring dazo=09
>=20
> novaflash 20.28.37
> poor dazo=09
>=20
> dazo 20.28.42
> heh ... too much noise from me=20=09
>=20
> krzee 20.28.43
> from norway by way of .cz
> 20.28.46
> L'utente swg0101 ? entrato nella stanza 20.28.51=09
>=20
> novaflash 20.28.56
> i hope some of openvpn's donations go to dazo's mental healthcare. those =
pills can't be cheap.=09
>=20
> plaisthos 20.28.58
> *is from germany*=09
>=20
> novaflash 20.28.59
> oh hello swg0101=09
>=20
> raidz 20.29.01
> oh, here is one more company guy: swg0101=09
>=20
> swg0101 20.29.05
> hey...=09
>=20
> mattock_ 20.29.07
> hi swg0101=09
>=20
> swg0101 20.29.15
> everyone is coughing here so I stepped away for a bit
> now hopefully I don't get sick 20.29.34
>=20=20
> mattock_ 20.29.44
> swg0101: you're from somewhere near San Francisco?
> Bay area 20.29.48
>=20=20
> swg0101 20.29.52
> in Davis=09
>=20
> cron2 20.29.54
> swg0101: so what are you doing?=09
>=20
> novaflash 20.30.02
> yes and he's got brains the size of my balls. wait that didn't come out q=
uite right...=09
>=20
> swg0101 20.30.05
> I am doing cronjobs... haha, jk=20=09
>=20
> cron2 20.30.25
> *has the feeling that "cronjobs" means work*=09
>=20
> novaflash 20.30.33
> he's in support and development - he figures out the really gritty proble=
ms some of our clients have and proposes fixes=09
>=20
> krzee 20.30.40
> swg0101, im from the bay originally=09
>=20
> swg0101 20.30.48
> yes, krzee is krzee=09
>=20
> mattock_ 20.30.56
> krzee has no real name afaik
> he's just krzee 20.31.00
>=20=20
> swg0101 20.31.08
> you are krzee=09
>=20
> krzee 20.31.10
> this is true, krzee is my name=20=09
>=20
> mattock_ 20.31.13
> I don't think he has an email address, either
> 20.31.18
>=20=20
> novaflash 20.31.18
> you're all a little krzee=09
>=20
> mattock_ 20.31.31
> mkay, are we done with introductions?=09
>=20
> krzee 20.31.34
> the publishing company of JJK's book didnt like that i have no real name =
lol=09
>=20
> swg0101 20.31.35
> so what are we talking about?=20=09
>=20
> mattock_ 20.31.42
> swg0101: https://community.openvpn.net/openvpn/wiki/Topics-2012-11-29=09
>=20
> vpnHelper 20.31.43
> Title: Topics-2012-11-29 ? OpenVPN Community (at community.openvpn.net)=09
>=20
> novaflash 20.31.44
> the topics are here
> https://community.openvpn.net/openvpn/wiki/Topics-2012-11-29 20.31.45
>=20=20
> swg0101 20.32.03
> fun stuff=20=09
>=20
> novaflash 20.32.12
> i am seeing openvpn c++ here, i think it that's different from what openv=
pn has been up till now?
> i assume it was python before and now c++ ? 20.32.23
>=20=20
> mattock_ 20.32.30
> james could probably start by explaining what the C++ thingy is, and what=
 should we do about it
> jamesyonan: shall you do the honors? 20.32.58
>=20=20
> jamesyonan 20.33.12
> yes, basically I've been working for a while on a new openvpn core that m=
ight (at some point) supplant the 2.x branch
> it's fairly prototypical at this stage 20.33.27
> it's ~ 30K lines of C++ code 20.33.42
>=20=20
> swg0101 20.33.53
> jamesyonan: is that the core that you are working on that allows for diff=
erent transport protocols on top of OpenVPN?=09
>=20
> jamesyonan 20.34.07
> yes, among other things=09
>=20
> swg0101 20.34.12
> very interesting=09
>=20
> jamesyonan 20.34.49
> it is very modular in the sense that SSL/crypto libraries, transport prot=
ocols, etc. can be modularized=09
>=20
> krzee 20.34.55
> is it being built with the 3.0 roadmap in mind?
> sounds like a yes ^ 20.35.00
>=20=20
> jamesyonan 20.35.17
> basically yes, but it's still incomplete at this point
> right now it's just a client 20.35.27
>=20=20
> krzee 20.35.48
> (for anyone not familiar, http://community.openvpn.net/openvpn/wiki/RoadM=
ap )=09
>=20
> vpnHelper 20.35.51
> Title: RoadMap ? OpenVPN Community (at community.openvpn.net)=09
>=20
> jamesyonan 20.35.53
> it's being used in the OpenVPN tech android client and the upcoming iOS c=
lient=09
>=20
> novaflash 20.36.20
> neat.=09
>=20
> cron2 20.36.30
> hah, he said the word=09
>=20
> raidz 20.36.41
>=20=09
>=20
> novaflash 20.36.57
> supercallifragilisticexpialidocious then=09
>=20
> krzee 20.37.18
> hows it licensed?=09
>=20
> jamesyonan 20.37.58
> the plan is to release this probably under GPL within the next couple mon=
ths=09
>=20
> mattock_ 20.38.31
> jamesyonan: I would suggest "in FOSDEM"=09
>=20
> novaflash 20.38.45
> i am not familiar with fosdem?=09
>=20
> mattock_ 20.39.07
> you could give an introduction of it there=09
>=20
> cron2 20.39.10
> that's an open source conference in brussels, early february=09
>=20
> dazo 20.39.11
> novaflash: http://fosdem.org/2012/=09
>=20
> plaisthos 20.39.15
> jamesyonan: with a contributer agreement? So you can merge changes to iOS=
 and the android client base?=09
>=20
> mattock_ 20.39.16
> https://fosdem.org/2013/=09
>=20
> vpnHelper 20.39.19
> Title: fosdem.org (at fosdem.org)
> Title: FOSDEM 2013 - Home (at fosdem.org) 20.39.21
>=20=20
> jamesyonan 20.39.25
> but bear in mind that this is a new code base, and is still far from bein=
g a drop-in replacement for 2.x=09
>=20
> novaflash 20.40.19
> so, FOSDEM is an event, not a license type?=09
>=20
> mattock_ 20.40.24
> yeah=20=09
>=20
> krzee 20.40.25
> novaflash, correct=09
>=20
> novaflash 20.40.28
> righto
> when i went to the frontpage i saw beer mentioned 20.40.41
> so they've got me sold 20.40.44
>=20=20
> cron2 20.41.03
> .nl->brussels is a nice train trip, andj and jjk did this last year=09
>=20
> novaflash 20.41.14
> jan just keizer?
> yes i don't think brussels is too far, it can be done 20.41.30
>=20=20
> jamesyonan 20.41.44
> you guys are lucky that you have trains=09
>=20
> cron2 20.41.45
> novaflash: yeah, we all met last year at fosdem, first ever face-to-face =
meeting.  Very goood.=09
>=20
> dazo 20.41.47
> what is this rumour about "contributor agreement"?=09
>=20
> novaflash 20.42.12
> jamesyonan: europe is interesting in that it has so much stuff so close t=
ogether.=09
>=20
> cron2 20.42.21
> dazo: well, it's a logical consequence: you can't release iOS code under =
GPL - so if that code is open sourced, and you want people to be able to co=
ntribute back, you need them to accept re-releasing it under a non-GPL lice=
nse=09
>=20
> mattock_ 20.42.51
> there are other ways to handle the copyright ownership issues which iOS r=
equires=09
>=20
> novaflash 20.42.52
> hm. apple restricting GPL eh?=09
>=20
> mattock_ 20.42.55
> none of them are pretty=09
>=20
> cron2 20.42.57
> (stupid Apple and Microsoft store license shit, but we *need* OpenVPN on =
these platforms)=09
>=20
> mattock_ 20.43.17
> so we need to somehow minimize damages to everyone involved=09
>=20
> cron2 20.43.20
> novaflash: Apple store requires "receiver must not modify", GPL requires =
"receiver must receive source and all rights to modify".  Incompatible=09
>=20
> novaflash 20.43.30
> gotcha.=09
>=20
> jamesyonan 20.43.36
> right, basically we need the ability to relicense the C++ core because of=
 app store issues=09
>=20
> krzee 20.43.37
> openvpn on native ios will be a pretty fat win=09
>=20
> mattock_ 20.43.45
> there are other options besides contributor agreements
> but some version of openvpn needs to "compatible" with iOS policies 20.44=
.13
>=20=20
> plaisthos 20.44.16
> BSD license but I can understand if OpenVPN Corp does not want a BSD lice=
nsed OpenVN core=09
>=20
> novaflash 20.44.24
> perhaps if we promise to bring Steve Jobs back to life, Apple will allow =
us a more flexible licensing method.=09
>=20
> mattock_ 20.44.28
> plaisthos: exactly=09
>=20
> dazo 20.44.47
> well, I can understand that argument ... from a business perspective ....=
 I can even agree to a kind of contributor agreement that permits re-licens=
ing to Apple and Microsoft stores ... but if the agreement requires copyrig=
ht handover, then I'm fairly sceptical and will probably drop out instantly=
=09
>=20
> jamesyonan 20.45.09
> no, we're certainly not asking for copyright handover=09
>=20
> cron2 20.45.25
> the agreement would need to be worded carefully to keep the GPL stuff GPL=
ed, and just permit extra licensing=09
>=20
> jamesyonan 20.45.34
> we just need the ability to relicense if necessary=09
>=20
> dazo 20.45.47
> fair enough=09
>=20
> cron2 20.45.48
> *is fine with that*=09
>=20
> mattock_ 20.46.38
> nobody really _wants_ those pesky agreement and bureaucracy... they basic=
ally hurt everyone (in our situation)=09
>=20
> dazo 20.46.39
> jamesyonan: when you have a draft ready, I can check if the GPL lawyer at=
 my work have time to review it and comment it=09
>=20
> novaflash 20.46.47
> the open source project must of course be kept intact, and not have some =
apple/microsoft bozos stealing it all.
> mattock_: yeah agreed. but best to have it covered. 20.47.11
>=20=20
> jamesyonan 20.47.22
> dazo: sure=09
>=20
> mattock_ 20.47.46
> dazo: oh yes, you have GPL lawyers at RedHat=20=09
>=20
> novaflash 20.48.14
> that's pretty supercallifragilisticexpialidocious=09
>=20
> mattock_ 20.48.46
> jamesyonan: perhaps you could share a word about the architecture of the =
C++ codebase... it should help limit the scope of any copyright ownership i=
ssues=09
>=20
> swg0101 20.48.48
> dazo works at RH?=20=09
>=20
> dazo 20.48.50
>  mattock_ yeah, Richard Fontana is quite into this stuff=09
>=20
> mattock_ 20.48.51
> yes=09
>=20
> dazo 20.48.53
> swg0101: I do=09
>=20
> swg0101 20.48.59
> interesting
> security team? 20.49.07
>=20=20
> novaflash 20.49.20
> dazo: he will now try to obtain your company secrets by squeezing your br=
ain like a lemon.=09
>=20
> swg0101 20.49.37
> easy peasy lemon squeezy so they call=09
>=20
> jamesyonan 20.49.38
> no, as long as openvpn is under GPL, none of the big guys can really stea=
l it=09
>=20
> dazo 20.49.59
> swg0101: actually, no ... openvpn is one of my spare time projects ... I'=
m doing real time kernel QA and development of related test tools=09
>=20
> jamesyonan 20.50.24
> ok, let me give a short primer on the new C++ code base=09
>=20
> dazo 20.50.38
> +1=09
>=20
> mattock_ 20.50.53
> jamesyonan: that's a valid point... companies like Apple would probably s=
teal the code the very instant it was released under a BSD license=09
>=20
> raidz 20.51.07
> ^^^=09
>=20
> jamesyonan 20.52.00
> right, BSD license would allow any company to create a proprietary fork=09
>=20
> novaflash 20.52.21
> GPL with permissions in specific cases for relicensing would still seem t=
o be the best option=09
>=20
> jamesyonan 20.52.30
> but I don't see that this could be done with GPL
> and I think we've seen cases in the past, where the big guys have tried t=
o shred the GPL 20.53.29
> MS called it a "cancer" at one point 20.53.40
> but I think it has proved it's resiliancy at preventing proprietary forks=
 20.54.06
>=20=20
> dazo 20.54.06
> yupp=09
>=20
> novaflash 20.54.19
> if microsoft hates it, i love it already=09
>=20
> krzee 20.54.45
> http://en.wikipedia.org/wiki/Viral_license    "The term is most often use=
d to describe the GPL, which requires that any derivative work also be lice=
nsed with the GPL."=09
>=20
> vpnHelper 20.54.46
> Title: Viral license - Wikipedia, the free encyclopedia (at en.wikipedia.=
org)=09
>=20
> jamesyonan 20.55.57
> so the C++ core is basically an object-oriented rethinking of openvpn fro=
m the ground up
> the core leverages on Boost Asio as it's async i/o layer 20.56.38
>=20=20
> mattock_ 20.57.08
> http://www.boost.org/doc/libs/1_52_0/doc/html/boost_asio.html=09
>=20
> jamesyonan 20.57.09
> rather than sort of roll it's own async i/o layer as the 2.x branch does=
=09
>=20
> vpnHelper 20.57.10
> Title: Boost.Asio - 1.52.0 (at www.boost.org)=09
>=20
> jamesyonan 20.57.35
> Asio is really great
> C++ is an interesting animal 20.58.29
>=20=20
> dazo 20.59.01
> heh ... that's a nice way to put it=09
>=20
> mattock_ 20.59.12
> I've heard everyone loves C++
> 20.59.15
>=20=20
> cron2 20.59.22
> interesting way to word it... (I've never liked C++, especially from a sy=
sadmin perspective it's higly annoying that half the source doesn't compile=
 with half the compilers...)=09
>=20
> novaflash 20.59.29
> i've heard it's better than B++=09
>=20
> jamesyonan 20.59.32
> I would have to say that I was originally very sceptical that C++ would b=
e a good systems programming language=09
>=20
> swg0101 20.59.35
> lol
> x++ 20.59.42
> ; 20.59.51
>=20=20
> jamesyonan 21.00.15
> but here are some of the points that won me over...
> I remember back in maybe '06 I gave C++ a trial run for a network project=
 I was working on 21.01.05
> I used whatever gcc was current at the time, linked in boost Asio, and ra=
n some benchmarks 21.01.35
> this was a very simple server app, sort of like a very basic HTTP server =
21.01.54
> it's a program that would have been 60KB written in C but it ended up lin=
king at 600KB in C++ and being several times slower than equivalent C 21.02=
.49
>=20=20
> cron2 21.03.22
> now *that* doesn't truly convince me yet=20=09
>=20
> krzee 21.03.31
> lol=09
>=20
> jamesyonan 21.03.37
> then several years layer, maybe around '11 I gave C++ another shot
> this time I used the latest boost and gcc 4.6 21.04.03
> what I discovered is that some really serious optimization work had gone =
into gcc (and LLVM as well) 21.05.06
>=20=20
> plaisthos 21.05.14
> *outs himself as C++ programmer too*=09
>=20
> jamesyonan 21.05.55
> for example, the compiler people figured out a really cool way to deal wi=
th C++ exceptions so that they didn't incur any overhead unless they are th=
rown=09
>=20
> cron2 21.06.09
> plaisthos: if you ever need a new job, one of my customers is doing quite=
 a lot of C++ and Java=20=09
>=20
> raidz 21.07.09
>=20=09
>=20
> jamesyonan 21.07.28
> I was quite amazed that I could write very clean, abstracted network code=
 using gcc 4.6 + boost asio and the code size had come down to ~ 60 KB and =
the compiler seemed to really factor out all the abstraction so the resulti=
ng generated code was very efficient=09
>=20
> plaisthos 21.07.38
> llvm guys also figured out how to give you good error messages (:=09
>=20
> jamesyonan 21.08.36
> yes, llvm is looking good, but it still seems slightly behind gcc on gene=
rating fast code from C++
> but in any event, I think C++ is really ready for prime time in the kind =
of system programming / networking space that openvpn is in 21.09.18
> some other things I like about modern C++ ... 21.09.43
> it's a very-well standardized language across the different major compile=
rs, i.e. gcc, llvm, visual studio, etc. 21.10.30
>=20=20
> mattock_ 21.10.49
> hmm, even visual studio... that's something=09
>=20
> jamesyonan 21.10.49
> now granted, I am using C++ 2003 for this project -- haven't ventured int=
o '11 yet
> I wrote ~20K lines before I even tested it on visual studio 21.11.17
> and I think it took under a couple hours to get it building and running w=
ith VS 21.11.51
>=20=20
> cron2 21.12.12
> that is definitely a plus=09
>=20
> novaflash 21.12.32
> yeah a C plus plus (groan)=09
>=20
> jamesyonan 21.12.36
> so let me get into some of the features of C++ that I think make it well-=
suited for use as a basis for OpenVPN
> C++ is one of the few languages that supports both static and dynamic pol=
ymorphism 21.13.21
> dynamic polymorphism via virtual functions 21.14.03
> and static polymorphism via templates 21.14.18
>=20=20
> ecrist 21.15.36
> are you suggesting a switch, completely, from C to C++?=09
>=20
> jamesyonan 21.15.44
> templates are great for network programming, because we have a lot of cas=
es where we have small objects that have polymorphic properties, such as IP=
v4 vs IPv6 addresses
> I think it makes a lot of sense for OpenVPN 3 to be C++ 21.16.16
>=20=20
> ecrist 21.16.32
> http://www.joelonsoftware.com/articles/fog0000000069.html=09
>=20
> vpnHelper 21.16.33
> Title: Things You Should Never Do, Part I - Joel on Software (at www.joel=
onsoftware.com)=09
>=20
> jamesyonan 21.16.38
> but I think the 2.x branch should remain in C=09
>=20
> ecrist 21.17.25
> dazo pointed me to that doc=09
>=20
> mattock_ 21.17.39
> ecrist, dazo: complements, excellent article=20=09
>=20
> ecrist 21.17.49
> I'd be afraid 3 would never be released=09
>=20
> cron2 21.18.11
> *tends to agree on both extents - "rewriting 2.x into C++" is likely to b=
e more effort than "doing it fresh from the start and adding features on th=
e go"*
> or so 21.18.14
>=20=20
> ecrist 21.18.14
> and what did potentially get released would be riddled with bugs that wer=
e already solved, or simply not a problem, in our current code base=09
>=20
> jamesyonan 21.18.21
> I think it's an interesting article, but I disagree with it=09
>=20
> novaflash 21.18.27
> ecrist; at the moment jamesyonan has a prototypical version that is alrea=
dy functioning in c++ as the client in android and now ios.
> or when it is released anyways (for iOS i mean) 21.18.41
>=20=20
> ecrist 21.18.56
> novaflash: I'm aware=09
>=20
> jamesyonan 21.19.05
> yes, the C++ core is already in production=09
>=20
> cron2 21.19.25
> what you can't do is "stop 2.x, rewrite everything, and stall until 3.x i=
s ready" - *that* would be a major mistake=09
>=20
> ecrist 21.19.26
> but untested relative to the community code base=09
>=20
> cron2 21.19.33
> ecrist: no, it works nicely=09
>=20
> jamesyonan 21.20.00
> well actually the C++ core, because it's only a client, ALWAYS connects t=
o an OpenVPN 2.x server=09
>=20
> cron2 21.20.04
> ecrist: I've given it enough beating that I would be happy for my custome=
rs to use it, against a 2.3RC1 server
> and what james says 21.20.32
>=20=20
> jamesyonan 21.20.48
> cron2 has worked with us on testing the new iOS client=09
>=20
> cron2 21.20.49
> jamesyonan: do you test C++ -> 2.1/AS or vs. 2.3?=09
>=20
> jamesyonan 21.21.03
> both=09
>=20
> krzee 21.21.27
> from our previous talks, a lot of 3.0 would need to be re-write anyways=09
>=20
> cron2 21.21.36
> yeah=09
>=20
> novaflash 21.21.41
> the OpenVPN Android client that jamesyonan made is capable of working for=
 both the open source server and the access server=09
>=20
> raidz 21.21.59
> same goes for ios=09
>=20
> krzee 21.22.00
> to account for making it modular, which sounds to be a lot of what this n=
ew core aims for=09
>=20
> jamesyonan 21.22.15
> yes, the new C++ core is 100% protocol compatible with 2.x branch=09
>=20
> ecrist 21.22.27
> is it feature-complete?=09
>=20
> jamesyonan 21.22.55
> no, it doesn't have all of the 2.x options
> but it has most of them 21.23.17
>=20=20
> raidz 21.23.25
> jamesyonan: will it have them all?=09
>=20
> plaisthos 21.23.35
> Having worked with the socket.c code I must say I would not aim at having=
 all options
> some of them are very disruptive 21.23.46
>=20=20
> cron2 21.23.47
> *expected that comment *=09
>=20
> jamesyonan 21.24.06
> it could -- right now I believe fragment option is not implemented
> yeah, the new code base doesn't even have a socket.c-like source file 21.=
24.52
> because Asio handles the i/o layer 21.25.06
>=20=20
> ecrist 21.25.19
> what about the MTU and mssfix bits?=09
>=20
> plaisthos 21.25.19
>=20
> I got to get going 21.25.32
> have to leave you guys 21.25.45
>=20=20
> novaflash 21.25.47
> bye plaisthos=20=09
>=20
> swg0101 21.25.51
> cya=09
>=20
> jamesyonan 21.25.51
> mssfix isn't there now, but it's on my short list of things to add
> bye plaisthos 21.26.04
>=20=20
> cron2 21.26.51
> james: I did mssfix for IPv6 today.  If you're working on that, you might=
 want to look at it  - haven't sent the patch yet, but it's working on our =
corp VPN server
> http://public.greenie.net/gert/misc/ipv6-mss-diff2.txt 21.26.59
>=20=20
> jamesyonan 21.27.11
> cool=09
>=20
> plaisthos 21.27.15
> jamesyonan: One last question before I go. My client is currently named "=
OpenVPN for Android". At the time I first named the client I did not give i=
t much thought. I have later realized that the name might sound  "official"=
. If you do not like this I can change the name=09
>=20
> jamesyonan 21.27.59
> no, I don't think that's really necessary=09
>=20
> raidz 21.28.18
> plaisthos: Love your client btw=20=09
>=20
> jamesyonan 21.28.29
> we tend to brand the OpenVPN Tech products with "OpenVPN Connect" anyway=
=09
>=20
> novaflash 21.29.11
> and in future releases of access server we'll probably have links to the =
openvpn tech versions for android and ios anyways
> at least, that's what i'd expect 21.29.19
>=20=20
> plaisthos 21.29.31
> raidz: thanks
> jamesyonan: okay thanks bye 21.29.40
>=20=20
> jamesyonan 21.29.55
> see ya=09
>=20
> mattock_ 21.30.11
> jamesyonan: you mentioned that the C++ codebase is still very far from be=
ing a replacement for 2.x
> so we'll be living with the original code for quite a while 21.30.27
>=20=20
> novaflash 21.30.37
> 2.* will continue=09
>=20
> cron2 21.30.59
> mattock_: it has no server side yet=09
>=20
> jamesyonan 21.31.07
> yes, it's much closer to being a client-side replacement, but the server =
side will take more development=09
>=20
> mattock_ 21.31.15
> today I tried merging some of your SVN patches to Git, and it wasn't pret=
ty=09
>=20
> jamesyonan 21.31.34
> snappy?=09
>=20
> mattock_ 21.31.44
> I think we're past the point where we "should move" to 2.3, and are in "n=
eed to move a.s.a.p."
> yes, that and all others actually 21.31.50
> snappy is probably the worst of the bunch 21.31.59
>=20=20
> novaflash 21.32.11
> the new compressor?=09
>=20
> mattock_ 21.32.17
> yep=09
>=20
> novaflash 21.32.34
> ironic that a name like snappy should take much time to get integrated.=09
>=20
> jamesyonan 21.33.06
> snappy is really great though -- I don't know if you've looked through th=
e source=09
>=20
> swg0101 21.33.15
> Google's implementation?=09
>=20
> jamesyonan 21.33.22
> this is what google uses company-wide as its main compressor=09
>=20
> swg0101 21.33.46
> would be curious to see if it makes good performance differences
> perhaps with aes-ni 21.33.54
>=20=20
> mattock_ 21.36.34
> jamesyonan: can you port the patches I sent you for 2.3?
> I could then do more testing with 2.3 with those patches included 21.36.45
>=20=20
> jamesyonan 21.37.02
> the snappy patch?=09
>=20
> mattock_ 21.37.22
> all of the patches, except r8129
> that one was fairly trivial to port 21.37.32
> the first problem is that files have been moved around 21.37.41
> e.g. 21.37.44
> init.c -> src/openvpn/init.c 21.37.50
> that's trivial, but doesn't do the trick anymore, too many changes/cleanu=
ps in 2.3 21.38.10
> so manual merging is necessary for all patches 21.38.31
>=20=20
> jamesyonan 21.38.31
> ok, I'll take a look at it=09
>=20
> mattock_ 21.39.22
> jamesyonan: how is your 2.3-fu? meaning, should we arrange a meeting wher=
e we take a look at what's exactly has change since 2.1.x?=09
>=20
> jamesyonan 21.39.25
> yes, we are planning to migrate to 2.3 for the next version of AS=09
>=20
> mattock_ 21.39.45
> in fact, I did some tests on openvpn 2.3-rc1 and AS, and got the thing ru=
nning=09
>=20
> novaflash 21.39.47
> AS 1.9?=20=09
>=20
> jamesyonan 21.39.53
> yes, that would make sense=09
>=20
> mattock_ 21.39.54
> with fairly minimal modifications=09
>=20
> cron2 21.39.58
> mattock: oh, that's cool=09
>=20
> jamesyonan 21.40.05
> novaflash: yes=09
>=20
> novaflash 21.40.18
> neat. i mean, cool.=09
>=20
> mattock_ 21.40.26
> I thank dazo for keeping Git in sync with SVN for this long... for the mi=
ssing patches, I don't blame him for dropping the ball=20
> Alon's buildsystem work made merging much more difficult 21.40.55
>=20=20
> dazo 21.41.07
> heh ... no it just got too complicated to merge it in for me ... well, I =
could do it ... but it would require a lot of analysing of each conflict=09
>=20
> mattock_ 21.41.35
> jamesyonan: "yes, that would make sense" ... was this a response to the m=
eeting suggestion?=09
>=20
> dazo 21.41.43
> on the plus side ... alons build system now works fairly well on cross-co=
mpiles and cross-platform stuff, I htink=09
>=20
> jamesyonan 21.41.47
> yes=09
>=20
> cron2 21.41.47
> *grumbles quietly about the build system accident^Wrevolution*=09
>=20
> mattock_ 21.41.53
> dazo: yes, that's correct, it's pretty good
> best buildsystem so far 21.42.17
>=20=20
> cron2 21.42.18
> some parts are great, but rearranging all the source tree was... "more re=
ligious than useful"=09
>=20
> mattock_ 21.42.44
> ...maybe if we rebuilt another buildsystem from scratch, then we could fi=
x all the problems in the current one?=20=09
>=20
> dazo 21.43.13
> cron2: to some extent, I can agree ... but the "everything in root dir" w=
as also quite chaotic too=09
>=20
> mattock_ 21.43.27
> I think the new layout is quite nice=09
>=20
> cron2 21.43.30
> it's not so much the build system, as the "other changes"=20
> *hates it every time I look at stuff* 21.43.39
> src/openvpn/ is just overdoing it for a single program, "src/" is fully f=
ine, and "everything in toplevel dir" was good enough for me 21.44.14
> but we digress - damage has been done, and it's easy to oppose something =
in hindsight 21.44.31
>=20=20
> mattock_ 21.45.49
> jamesyonan: as C++ codebase is not going to go server anytime soon, so wh=
at about 2.4?
> moving AS to 2.3 should be _fairly_ painless 21.46.06
> then we have 2.4 release cycle coming up 21.46.15
> what is our strategy regarding it? 21.46.24
> "what drives us forward with 2.4" 21.47.06
>=20=20
> jamesyonan 21.47.18
> yes, don't see the C++ codebase as altering the evolution of 2.x branch f=
or a least another year or two
> my attitude is that the C++ codebase should prove itself in multiple area=
s before it is embraced en-mass 21.49.03
>=20=20
> mattock_ 21.49.16
> will 2.4 be mostly about cleanups/stabilization, or do we (=3Dthe project=
) have some other agenda?=09
>=20
> dazo 21.51.11
> well, plaisthos does a lot of code clean-up in socket.c ... and we have a=
 lot of other clean-ups as well ... and it might be we try to modularise ot=
her things better as well=09
>=20
> mattock_ 21.51.33
> I'm thinking of removing rarely used options=09
>=20
> dazo 21.51.34
> but some important things I hope we can sort out with 2.4 is listening to=
 multiple ports and protocols=09
>=20
> mattock_ 21.51.40
> i.e. historic baggage=09
>=20
> novaflash 21.51.54
> multiple cores? *hopeful*=09
>=20
> cron2 21.51.56
> mattock: what you consider historic baggage might be the reason why peopl=
e are using OpenVPN...=20=09
>=20
> mattock_ 21.52.10
> cron2: I hear you complaining about too many options=20
> but you're right 21.52.20
>=20=20
> dazo 21.52.29
> novaflash: nope, that won't fit into 2.4 .... going from single thread to=
 multi-thread requires a too massive change now=09
>=20
> mattock_ 21.52.30
> so we'd need to identify what's just baggage, and what's being used=09
>=20
> cron2 21.52.41
> indeed, we have way too many options, but sometimes you find yourself in =
a corner and all that helps is one of the more obscure options...=09
>=20
> mattock_ 21.52.51
> lol=20=09
>=20
> novaflash 21.53.06
> dazo: i have to admit, knowing how openvpn works, it's best to leave the =
multi core handling outside of it=09
>=20
> jamesyonan 21.53.28
> why not preserve the options in 2.x branch and let 3.x be testing ground =
for removal of obsolete options=09
>=20
> cron2 21.53.28
> dazo: oh, if someone comes along and finds a way to split encryption, dec=
ryption, crypto, and "the rest" into a handful of threads, I might be open =
to take a closer look...=09
>=20
> mattock_ 21.53.32
> actually, I don't think not having multiple threads is that bad=09
>=20
> cron2 21.53.39
> s/crypto/compression/
> well, it limits performance... 21.53.54
>=20=20
> novaflash 21.54.10
> maybe not but it'd only really be of much use in very large deployments (=
where people use multiple openvpn processes anyways) and on systems with ve=
ry low power but dual core cpu systems like atom systems.=09
>=20
> dazo 21.54.15
> cron2: true ... but there's this nasty thing called CPU caching as well .=
.. so to make that optimal, that will require some nasty analysing too=09
>=20
> jamesyonan 21.54.23
> the C++ core supports multiple threads, HOWEVER, you really can't do fine=
 grained threading and expect to see a performance gain=09
>=20
> mattock_ 21.54.25
> one can have multiple processes, which, while heavier than threads are ad=
equate=09
>=20
> cron2 21.54.39
> my goals for 2.4 is "code overhaul to integrate IPv6 more nicely" (it's b=
olted-on right now - working but ugly)=09
>=20
> novaflash 21.54.44
> agree with mattock_ .
> cron2: seconded, ipv6 is hot right now 21.55.00
>=20=20
> dazo 21.55.07
> and the things with threading ... you loose performance instantly in the =
moment you have more high loaded threads than CPU cores available=09
>=20
> cron2 21.55.12
> dazo: well, that speaks for "two threads" (one for incoming, one for outg=
oing packets)...=09
>=20
> dazo 21.55.21
> cron2: agreed=20=09
>=20
> cron2 21.55.36
> and you don't loose if you do not synchronize around too much...  (maybe =
a 3rd thread for handshaking)
> but I'm not writing it - not enough experience with writing threaded code=
 to feel comfortable about doing this in a security product 21.56.08
>=20=20
> mattock_ 21.56.09
> we actually have one more important topic today:
> "Joint company/community meeting in FOSDEM in Bruessels" 21.56.19
> jamesyonan: we insist you come there 21.56.35
>=20=20
> novaflash 21.56.38
> perhaps it's best to take small but important steps with 2.*, and big ste=
ps in 3 ?=09
>=20
> cron2 21.56.39
> novaflash: it's in, and it's working, but it's missing some bells and whi=
stles, and needs polishing=09
>=20
> novaflash 21.56.50
> mattock_: that would be so cool, having james here=09
>=20
> jamesyonan 21.56.56
> yes, I'm going to try to be there=09
>=20
> cron2 21.57.06
> cool=09
>=20
> dazo 21.57.12
> I'm trying to get the bookings done this or next week=09
>=20
> novaflash 21.57.32
> mattock_: do you know the exact date and shit?=09
>=20
> mattock_ 21.57.53
> jamesyonan: if we can open source the C++ codebase by then, then your sho=
uld _definitely_ be there and give a presentation of it=09
>=20
> cron2 21.58.04
> novaflash: all on fosdem.org/2013/=09
>=20
> jamesyonan 21.58.09
> yes, that's what I'm thinking=09
>=20
> dazo 21.58.14
> novaflash: February 2-3=09
>=20
> novaflash 21.58.23
> ah thanks, neato
> oh hell! 21.58.38
>=20=20
> mattock_ 21.58.39
> also, the company should offer a nice dinner for everyone involved in the=
 project=09
>=20
> novaflash 21.58.40
> it's belgium!
> beer! 21.58.48
>=20=20
> mattock_ 21.58.50
>=20=09
>=20
> jamesyonan 21.59.03
> sure, great idea=09
>=20
> novaflash 21.59.05
> okay, yes, i'm okay now.=09
>=20
> mattock_ 21.59.17
> novaflash: that is most correct=09
>=20
> dazo 21.59.17
> novaflash: I've been told that in Germany 7 beers counts as a dinner ...=
=09
>=20
> novaflash 21.59.17
> i'll buy you guys some beer=09
>=20
> cron2 21.59.25
> *will bring warmer shoes this time*=09
>=20
> dazo 21.59.35
> *too*=09
>=20
> novaflash 21.59.36
> cron2: did you go naked again?=09
>=20
> cron2 22.00.12
> novaflash: nah, but last year they had a huge amount of snow, and the hea=
ting in the university buildings was... not up to it=09
>=20
> novaflash 22.00.19
> yikes=09
>=20
> mattock_ 22.00.21
> was there any heating?=09
>=20
> novaflash 22.00.39
> yes, the beamer was on=09
>=20
> cron2 22.00.40
> mattock: if you bring in 1000 open source zealots, there *is* heat.  But =
it wasn't enough=09
>=20
> dazo 22.00.59
> it's the first conference I've been to where I saw plenty of geeks hackin=
g in thick jackets ... not t-shirts=20=09
>=20
> novaflash 22.01.15
> note to self: don't go naked
> so um what's next on the agenda? 22.02.58
>=20=20
> mattock_ 22.03.20
> hmm, I guess we're mostly done=09
>=20
> cron2 22.03.41
> we just need confirmation that dazo is happy and will now end his strike=
=09
>=20
> novaflash 22.03.51
> he's on strike?=09
>=20
> dazo 22.03.51
> hehe=20=09
>=20
> mattock_ 22.04.07
> definitely=09
>=20
> novaflash 22.04.13
> perhaps he needs a good ole whipping=09
>=20
> cron2 22.04.27
> *whips dazo with lots of ACKs*
> on strings 22.04.29
>=20=20
> mattock_ 22.04.36
> or "in strings"?=09
>=20
> novaflash 22.04.46
> i am getting a very odd image here now
> of cron2 in g-string 22.04.54
>=20=20
> cron2 22.04.55
> *doesn't want to know*=09
>=20
> novaflash 22.04.56
> whipping dazo=09
>=20
> mattock_ 22.04.57
> oh my, all of this will go to the mailing list=09
>=20
> dazo 22.04.58
> jamesyonan: would it be possible to get you more visible on the -devel ma=
iling list?  Like just giving "ACK" or "NACK" to patches which makes sense =
... doesn't need to too often but a few times every month when there are so=
me un-reviewed patches would help=09
>=20
> mattock_ 22.05.13
> +1=09
>=20
> novaflash 22.05.18
> mattock_: just delete everything i said then=09
>=20
> mattock_ 22.05.22
> we've missed you
> novaflash: the trust must not me tampered with 22.05.29
> oops 22.05.32
> truth 22.05.33
>=20=20
> novaflash 22.05.42
> mattock_: but that typo will MAGICALLY be repaired?=09
>=20
> mattock_ 22.05.46
> no=09
>=20
> novaflash 22.05.50
> heh=09
>=20
> jamesyonan 22.05.51
> I think that's a good idea, I just need to scale better=09
>=20
> novaflash 22.05.54
> okay good then.=09
>=20
> cron2 22.06.20
> jamesyonan: you need to reimplement yourself using C++ and Boost, obvious=
ly=20=09
>=20
> mattock_ 22.06.22
> jamesyonan: I think moving to 2.3 will help... raidz is running a test su=
ite with 2.3-rc1 atm=09
>=20
> dazo 22.06.47
> jamesyonan: I think we're fairly good now ... cron2 have done a good job =
reviewing stuff ... but I do know we have some stuff which needs to be revi=
ewed for 2.4=09
>=20
> novaflash 22.06.55
> mattock_: i got your test suite forwarded and am going to give it a shot =
too=09
>=20
> jamesyonan 22.06.56
> no, I think I need to go quantum=09
>=20
> mattock_ 22.07.02
> we need to communicate with the community devs using the "normal" methods=
 to be effective=09
>=20
> dazo 22.07.05
> (which is rather old stuff ... but I'll summarise it on a wiki first)=09
>=20
> mattock_ 22.07.33
> the "weekly meeting with James" worked initially, but quite often it crea=
ted lot of delay=09
>=20
> dazo 22.07.47
> and I know plaisthos will come with some socket.c clean-up too=09
>=20
> novaflash 22.07.50
> jamesyonan: remove your GPL license and let us fork you a couple of times=
 so there's more of you to spread around=09
>=20
> mattock_ 22.08.30
> there's also the option of stopping all the interesting side-projects?
> I'm constantly struggling with that myself 22.08.43
> 22.08.48
>=20=20
> dazo 22.09.21
> *would like to reduce the openvpn side-project, so he could focus more on=
 his own eurephia project *=09
>=20
> mattock_ 22.09.44
> dazo: how's the openvpn linux gui side-project going?=20=09
>=20
> jamesyonan 22.09.44
> it's easier for me to spend a couple hours a week with undivided attentio=
n than to multitask off-and-on into community discussions=09
>=20
> dazo 22.09.53
> oh true
> GUI programming is a mess 22.10.03
> even GTK 22.10.11
>=20=20
> novaflash 22.10.19
> dazo is developing a gui for linux? awesome!=09
>=20
> dazo 22.10.32
> I've took over the maintenance of gopenvpn=20
> the previous maintainer didn't have much time for it any more 22.10.46
>=20=20
> jamesyonan 22.11.17
> dazo: have you looked at SRP ( http://en.wikipedia.org/wiki/Secure_Remote=
_Password_protocol )?=09
>=20
> vpnHelper 22.11.18
> Title: Secure Remote Password protocol - Wikipedia, the free encyclopedia=
 (at en.wikipedia.org)=09
>=20
> cron2 22.11.40
> dazo: is that a useful thing to have, gopenvpn, as to "make the integrati=
on in NM better" (as everybody seems to go to NM anyway)=09
>=20
> mattock_ 22.12.01
> jamesyonan: we haven't had "classic" IRC meeting on Thursdays for a while=
, because things have worked fine without them=09
>=20
> dazo 22.12.31
> cron2: NM is useful for "I just need one VPN tunnel" .... but I usually u=
se 3 in parallel, and gopenvpn is somewhat closer in behaviour to the Windo=
ws GUI .... using real config files=09
>=20
> cron2 22.12.56
> dazo: ah, so NM cannot do multiple tunnels?  Indeed, that would be a good=
 reason for "something better"=09
>=20
> dazo 22.13.12
> jamesyonan: nope ... but that looks interesting (at least if I don't have=
 to go to deep on the mathematics=20=09
>=20
> cron2 22.13.17
> *is confused by graphical stuff*=09
>=20
> dazo 22.13.32
> cron2: and if NM looses the wireless for a second ... it disconnects/stop=
s all VPN tunnels=09
>=20
> mattock_ 22.13.36
> jamesyonan: it'd be great if you could, say, check openvpn-devel list 2-3=
 times a week and then immediately close the email client=20=09
>=20
> dazo 22.13.43
> that's my second big complaint about NM=09
>=20
> mattock_ 22.13.58
> that strategy saves my nerves and improves my focus=20=20=09
>=20
> dazo 22.14.01
> (to fix that, it seems the core NM needs to be reworked)=09
>=20
> cron2 22.14.15
> mattock: and you compensate by hanging in IRC all day=20=09
>=20
> dazo 22.14.21
> hehe=09
>=20
> mattock_ 22.14.27
> well, yes... but I hate email more than I hate IRC
> email =3D> somebody wants me to do something 22.14.46
>=20=20
> novaflash 22.14.55
> as it appears that the main agenda points have been handled (unless our i=
llustrious leaders indicate otherwise) i am going to go get some things sor=
ted here and head off to bed.=09
>=20
> mattock_ 22.15.04
> novaflash: good idea=09
>=20
> cron2 22.15.08
> dazo: seems we really need to sit together with d12fk @FOSDEM to sort out=
 the privilege separation / gui / service stuff
> that should happen "soon" now... 22.15.16
> novaflash: good night 22.15.24
>=20=20
> mattock_ 22.15.36
> and we should book the flights / hotels soon, before the prices start cli=
mbing up=09
>=20
> dazo 22.15.59
> cron2: agreed ...  that's 2.4 material
> and if jamesyonan will be present at FOSDEM ... it would be natural to ga=
in from his experience there as well 22.16.30
>=20=20
> mattock_ 22.16.39
> oh, one more thing
> I want to set a time when James comes here to be moved to wonderful world=
 of Git and 2.3.x 22.17.01
> jamesyonan: please pick a date and time 22.17.25
>=20=20
> jamesyonan 22.17.46
> yes, I do like git, but I'm still stuck with svn for now=09
>=20
> mattock_ 22.17.47
> I can take care of the Git part, I've been dazo's apprentice
> how do we get you unstuck? how can we help? 22.18.04
>=20=20
> cron2 22.18.12
> "rpm -e svn"=09
>=20
> jamesyonan 22.18.26
> rpm: not found=09
>=20
> mattock_ 22.18.33
> uh=09
>=20
> dazo 22.18.40
> heh=09
>=20
> cron2 22.18.49
> jamesyonan: now I think dazo will stop talking to you...!=09
>=20
> dazo 22.19.07
> hmmmm=20=09
>=20
> jamesyonan 22.19.17
> actually I use mac most of the time=09
>=20
> mattock_ 22.19.49
> jamesyonan: next Thursday, same time, same place?=09
>=20
> jamesyonan 22.19.53
> sure=09
>=20
> mattock_ 22.20.02
> ok, excellent
> I think we're done, then 22.20.18
> any objections? 22.20.58
>=20=20
> cron2 22.21.49
> *is fine*=09
>=20
> jamesyonan 22.22.23
> fine here=09
>=20
> ecrist 22.22.24
> none from me=09
>=20
> mattock_ 22.23.07
> nice!=09
>=20
> dazo 22.23.08
> *is fine*=09
>=20
> mattock_ 22.23.25
> ok, next meeting next week this time
> I'll send a summary tomorrow 22.23.36
>=20=20
> dazo 22.23.41
> thx all!=09
>=20
> mattock_ 22.26.54
> good night!
> or midday, or whatever 22.27.00
>=20
> ------------------------------
>=20
> -------------------------------------------------------------------------=
-----
> Keep yourself connected to Go Parallel:=20
> TUNE You got it built. Now make it sing. Tune shows you how.
> http://goparallel.sourceforge.net
>=20
> ------------------------------
>=20
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20
>=20
> End of Openvpn-devel Digest, Vol 78, Issue 6
> ********************************************
=20=09=09=20=09=20=20=20=09=09=20=20=

--_da811ac6-cf01-4074-9acb-3cdc1f82c4b5_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style><!--
.hmmessage P
{
margin:0px;
padding:0px
}
body.hmmessage
{
font-size: 10pt;
font-family:Tahoma
}
--></style></head>
<body class=3D'hmmessage'><div dir=3D'ltr'>
"help"<div><br></div><div><br></div><div><br><br><div><div id=3D"SkyDrivePl=
aceholder"></div>&gt; From: openvpn-devel-request@lists.sourceforge.net<br>=
&gt; Subject: Openvpn-devel Digest, Vol 78, Issue 6<br>&gt; To: openvpn-dev=
el@lists.sourceforge.net<br>&gt; Date: Fri, 30 Nov 2012 12:37:46 +0000<br>&=
gt; <br>&gt; Send Openvpn-devel mailing list submissions to<br>&gt; 	openvp=
n-devel@lists.sourceforge.net<br>&gt; <br>&gt; To subscribe or unsubscribe =
via the World Wide Web, visit<br>&gt; 	https://lists.sourceforge.net/lists/=
listinfo/openvpn-devel<br>&gt; or, via email, send a message with subject o=
r body 'help' to<br>&gt; 	openvpn-devel-request@lists.sourceforge.net<br>&g=
t; <br>&gt; You can reach the person managing the list at<br>&gt; 	openvpn-=
devel-owner@lists.sourceforge.net<br>&gt; <br>&gt; When replying, please ed=
it your Subject line so it is more specific<br>&gt; than "Re: Contents of O=
penvpn-devel digest..."<br>&gt; <br>&gt; <br>&gt; Today's Topics:<br>&gt; <=
br>&gt;    1. Re: [PATCH] Avoid recursion in	virtual_output_callback_func()=
<br>&gt;       (David Sommerseth)<br>&gt;    2. Re: [PATCH] Properly requir=
e --key even if<br>&gt;       defined(MANAGMENT_EXTERNAL_KEY) (David Sommer=
seth)<br>&gt;    3. Re: [PATCH] doc/management-notes.txt: fix typo (David S=
ommerseth)<br>&gt;    4. Re: [PATCH] The get_default_gateway() function use=
s warn()<br>&gt;       instead of msg() (David Sommerseth)<br>&gt;    5. Su=
mmary of the IRC meeting (29th Nov 2012) (Samuli Sepp?nen)<br>&gt; <br>&gt;=
 <br>&gt; -----------------------------------------------------------------=
-----<br>&gt; <br>&gt; Message: 1<br>&gt; Date: Thu, 29 Nov 2012 22:16:54 +=
0100<br>&gt; From: David Sommerseth &lt;openvpn.list@...1114...&gt;<br>&gt;=
 Subject: Re: [Openvpn-devel] [PATCH] Avoid recursion in<br>&gt; 	virtual_o=
utput_callback_func()<br>&gt; To: openvpn-devel@lists.sourceforge.net<br>&g=
t; Message-ID: &lt;50B7D0C6.60503@...1114...&gt;<br>&gt; Content-Type: text=
/plain; charset=3D"iso-8859-1"<br>&gt; <br>&gt; On 16/11/12 12:02, David So=
mmerseth wrote:<br>&gt; &gt; From: David Sommerseth &lt;davids@...1347...&g=
t;<br>&gt; &gt; <br>&gt; &gt; This solves a SEGV situation when using the m=
anagement API while OpenVPN<br>&gt; &gt; is closing down.<br>&gt; &gt; <br>=
&gt; &gt; The situation happens when the management socket has closed and O=
penVPN<br>&gt; &gt; tries to write an error about this to the management so=
cket.  What happens<br>&gt; &gt; is that<br>&gt; &gt; <br>&gt; &gt;  virtua=
l_output_callback_func() is called, which then calls<br>&gt; &gt;  -&gt; ma=
n_output_list_push_finalize()<br>&gt; &gt;     -&gt; man_output_standalone(=
)<br>&gt; &gt;        -&gt; man_write()  &lt;-- this does the socket write<=
br>&gt; &gt;           -&gt; man_io_error()<br>&gt; &gt;              -&gt;=
 x_msg()<br>&gt; &gt;                 -&gt; virtual_output_print()<br>&gt; =
&gt;                    -&gt; virtual_output_callback_func() (recursion sta=
rt)<br>&gt; &gt; <br>&gt; &gt; virtual_output_callback_func() do have a mec=
hanism to avoid recursion,<br>&gt; &gt; but that did not keep the recurse c=
ounter when man_output_list_push_finalize()<br>&gt; &gt; is called.<br>&gt;=
 &gt; <br>&gt; &gt; This patch just reorganise the recursion block to also =
keep the counter while<br>&gt; &gt; calling the other functions from virtua=
l_output_callback_func()<br>&gt; &gt; <br>&gt; &gt; Signed-off-by: David So=
mmerseth &lt;davids@...1347...&gt;<br>&gt; &gt; ---<br>&gt; &gt;  src/openv=
pn/manage.c |   15 ++++++++-------<br>&gt; &gt;  1 file changed, 8 insertio=
ns(+), 7 deletions(-)<br>&gt; <br>&gt; Applied to master and beta/2.3 branc=
hes<br>&gt; <br>&gt; commit b2b66179f6dcc37de9582d5c3044f0357dda3df3 (maste=
r)<br>&gt; commit 5541ea21691b5b39adc4bd3e1ff1af86a050c71d (beta/2.3)<br>&g=
t; Author: David Sommerseth &lt;davids@...1347...&gt;<br>&gt; Date:   Fri N=
ov 16 12:02:06 2012 +0100<br>&gt; <br>&gt;     Avoid recursion in virtual_o=
utput_callback_func()<br>&gt;     <br>&gt;     Signed-off-by: David Sommers=
eth &lt;davids@...1347...&gt;<br>&gt;     Acked-by: Gert Doering &lt;gert@...220...=
..1296...&gt;<br>&gt;     Message-Id: 1353063726-25113-1-git-send-email-daz=
o@...384...<br>&gt;     URL: http://article.gmane.org/gmane.network.openvpn=
.devel/7130<br>&gt; <br>&gt; <br>&gt; -- <br>&gt; kind regards,<br>&gt; <br=
>&gt; David Sommerseth<br>&gt; <br>&gt; -------------- next part ----------=
----<br>&gt; A non-text attachment was scrubbed...<br>&gt; Name: signature.=
asc<br>&gt; Type: application/pgp-signature<br>&gt; Size: 262 bytes<br>&gt;=
 Desc: OpenPGP digital signature<br>&gt; <br>&gt; -------------------------=
-----<br>&gt; <br>&gt; Message: 2<br>&gt; Date: Thu, 29 Nov 2012 22:16:57 +=
0100<br>&gt; From: David Sommerseth &lt;openvpn.list@...1114...&gt;<br>&gt;=
 Subject: Re: [Openvpn-devel] [PATCH] Properly require --key even if<br>&gt=
; 	defined(MANAGMENT_EXTERNAL_KEY)<br>&gt; To: openvpn-devel@...1357...=
rge.net<br>&gt; Message-ID: &lt;50B7D0C9.5070909@...1114...&gt;<br>&gt; Con=
tent-Type: text/plain; charset=3D"iso-8859-1"<br>&gt; <br>&gt; On 26/11/12 =
15:33, Arne Schwabe wrote:<br>&gt; &gt; When specifying --tls-client --cert=
 ... without a --key (or --pkcs11) option,<br>&gt; &gt; OpenVPN should comp=
lain: "You must define private key file (--key)...". Ensure<br>&gt; &gt; th=
at this works even when compiling with MANAGMENT_EXTERNAL_KEY.<br>&gt; &gt;=
 <br>&gt; &gt; Also fix the other instance where this logic is broken<br>&g=
t; &gt; <br>&gt; &gt; Orginal-Patch-by: Found by Joachim Schipper &lt;joach=
im.schipper@...1435...&gt;<br>&gt; &gt; Signed-off-by: Arne Schwabe &lt;arn=
e@...1227...&gt;<br>&gt; &gt; ---<br>&gt; &gt;  src/openvpn/options.c |    =
4 ++--<br>&gt; &gt;  1 file changed, 2 insertions(+), 2 deletions(-)<br>&gt=
; <br>&gt; Applied to master and beta/2.3<br>&gt; <br>&gt; commit feca0900d=
d00577779ab02f2e52b41eb3dab935f (master)<br>&gt; commit 9447858c38c5cf51265=
c7eab3445d7d5fb4f7bba (beta/2.3)<br>&gt; Author: Arne Schwabe &lt;arne@...1386...=
227...&gt;<br>&gt; Date:   Mon Nov 26 15:33:09 2012 +0100<br>&gt; <br>&gt; =
    Properly require --key even if defined(MANAGMENT_EXTERNAL_KEY)<br>&gt; =
    <br>&gt;     Orginal-Patch-by: Found by Joachim Schipper &lt;joachim.sc=
hipper@...1435...&gt;<br>&gt;     Signed-off-by: Arne Schwabe &lt;arne@...1386...=
227...&gt;<br>&gt;     Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>&g=
t;     Message-Id: 1353940389-31075-1-git-send-email-arne@...1227...<br>&gt=
;     URL: http://article.gmane.org/gmane.network.openvpn.devel/7143<br>&gt=
;     Signed-off-by: David Sommerseth &lt;davids@...1347...&gt;<br>&gt; <br=
>&gt; <br>&gt; -- <br>&gt; kind regards,<br>&gt; <br>&gt; David Sommerseth<=
br>&gt; <br>&gt; -------------- next part --------------<br>&gt; A non-text=
 attachment was scrubbed...<br>&gt; Name: signature.asc<br>&gt; Type: appli=
cation/pgp-signature<br>&gt; Size: 262 bytes<br>&gt; Desc: OpenPGP digital =
signature<br>&gt; <br>&gt; ------------------------------<br>&gt; <br>&gt; =
Message: 3<br>&gt; Date: Thu, 29 Nov 2012 22:17:01 +0100<br>&gt; From: Davi=
d Sommerseth &lt;openvpn.list@...1114...&gt;<br>&gt; Subject: Re: [Openvpn-=
devel] [PATCH] doc/management-notes.txt: fix<br>&gt; 	typo<br>&gt; To: open=
vpn-devel@lists.sourceforge.net<br>&gt; Message-ID: &lt;50B7D0CD.7070607@...1186...=
.1114...&gt;<br>&gt; Content-Type: text/plain; charset=3D"iso-8859-1"<br>&g=
t; <br>&gt; On 26/11/12 15:31, Joachim Schipper wrote:<br>&gt; &gt; Signed-=
off-by: Joachim Schipper &lt;joachim.schipper@...1435...&gt;<br>&gt; &gt; -=
--<br>&gt; &gt;  doc/management-notes.txt |    2 +-<br>&gt; &gt;  1 file ch=
anged, 1 insertion(+), 1 deletion(-)<br>&gt; <br>&gt; Thanks!  Applied to m=
aster and beta/2.3 branches<br>&gt; <br>&gt; commit 5dfdb7c010c5a32a0ec51d9=
266748c641cd24dba (master)<br>&gt; commit 376e1432b3ce0c5fc715cfc0f9a9ea7b7=
33b4cc0 (beta/2.3)<br>&gt; Author: Joachim Schipper &lt;joachim.schipper@...1186...=
.1435...&gt;<br>&gt; Date:   Mon Nov 26 15:31:45 2012 +0100<br>&gt; <br>&gt=
;     doc/management-notes.txt: fix typo<br>&gt;     <br>&gt;     Signed-of=
f-by: Joachim Schipper &lt;joachim.schipper@...1435...&gt;<br>&gt;     Acke=
d-by: Gert Doering &lt;gert@...1296...&gt;<br>&gt;     Message-Id: 1CED4098=
04E2164C8104F9E623B08B901323D0B184@...1436...<br>&gt;     URL: http://artic=
le.gmane.org/gmane.network.openvpn.devel/7141<br>&gt;     Signed-off-by: Da=
vid Sommerseth &lt;davids@...1347...&gt;<br>&gt; <br>&gt; <br>&gt; -- <br>&=
gt; kind regards,<br>&gt; <br>&gt; David Sommerseth<br>&gt; <br>&gt; ------=
-------- next part --------------<br>&gt; A non-text attachment was scrubbe=
d...<br>&gt; Name: signature.asc<br>&gt; Type: application/pgp-signature<br=
>&gt; Size: 262 bytes<br>&gt; Desc: OpenPGP digital signature<br>&gt; <br>&=
gt; ------------------------------<br>&gt; <br>&gt; Message: 4<br>&gt; Date=
: Thu, 29 Nov 2012 22:17:05 +0100<br>&gt; From: David Sommerseth &lt;openvp=
n.list@...1114...&gt;<br>&gt; Subject: Re: [Openvpn-devel] [PATCH] The get_=
default_gateway()<br>&gt; 	function uses warn() instead of msg()<br>&gt; To=
: openvpn-devel@lists.sourceforge.net<br>&gt; Message-ID: &lt;50B7D0D1.1090=
403@...1114...&gt;<br>&gt; Content-Type: text/plain; charset=3D"iso-8859-1"=
<br>&gt; <br>&gt; On 29/11/12 14:16, David Sommerseth wrote:<br>&gt; &gt; F=
rom: David Sommerseth &lt;davids@...1347...&gt;<br>&gt; &gt; <br>&gt; &gt; =
A report on #openvpn pointed out that in his setup three warnings<br>&gt; &=
gt; appeard on the console when starting up.<br>&gt; &gt; <br>&gt; &gt;    =
 $ sudo /usr/local/etc/rc.d/openvpn restart<br>&gt; &gt;     Stopping openv=
pn.<br>&gt; &gt;     Waiting for PIDS: 33031.<br>&gt; &gt;     Starting ope=
nvpn.<br>&gt; &gt;     openvpn: writing to routing socket: No such process<=
br>&gt; &gt;     openvpn: writing to routing socket: No such process<br>&gt=
; &gt;     openvpn: writing to routing socket: No such process<br>&gt; &gt;=
     $<br>&gt; &gt; <br>&gt; &gt; This setup is on FreeBSD using jails with=
 strict access to the<br>&gt; &gt; routing table.<br>&gt; &gt; <br>&gt; &gt=
; After looking at the code path, this error was found in the BSD<br>&gt; &=
gt; sections for get_default_gateway().  But it was using the warn()<br>&gt=
; &gt; call instead of msg(M_WARN|M_ERRNO, ...) which causes these<br>&gt; =
&gt; warnings to go to stderr instead of the log file.<br>&gt; &gt; <br>&gt=
; &gt; The warning string is also slightly modified to better explain<br>&g=
t; &gt; what fails.<br>&gt; &gt; <br>&gt; &gt; Reported-by: Thomas Steen Ra=
smussen &lt;thomas@...1782...&gt;<br>&gt; &gt; Tested-by: Thomas Steen Rasm=
ussen &lt;thomas@...1782...&gt;<br>&gt; &gt; Signed-off-by: David Sommerset=
h &lt;davids@...1347...&gt;<br>&gt; &gt; ---<br>&gt; &gt;  src/openvpn/rout=
e.c |    4 ++--<br>&gt; &gt;  1 file changed, 2 insertions(+), 2 deletions(=
-)<br>&gt; &gt; <br>&gt; <br>&gt; Applied to master and beta/2.3 branches<b=
r>&gt; <br>&gt; commit b3f19cc4bec6978a128f5af3ab22d8cfa954b064 (master)<br=
>&gt; commit 28d9e57638d66fde792a53a3eb6391ddb8bb426f (beta/2.3)<br>&gt; Au=
thor: David Sommerseth &lt;davids@...1347...&gt;<br>&gt; Date:   Thu Nov 29=
 14:16:12 2012 +0100<br>&gt; <br>&gt;     The get_default_gateway() functio=
n uses warn() instead of msg()<br>&gt;     <br>&gt;     Reported-by: Thomas=
 Steen Rasmussen &lt;thomas@...1782...&gt;<br>&gt;     Tested-by: Thomas St=
een Rasmussen &lt;thomas@...1782...&gt;<br>&gt;     Signed-off-by: David So=
mmerseth &lt;davids@...1347...&gt;<br>&gt;     Acked-by: Gert Doering &lt;g=
ert@...1296...&gt;<br>&gt;     Message-Id: 1354194972-5388-1-git-send-email=
-dazo@...384...<br>&gt;     URL: http://article.gmane.org/gmane.network.ope=
nvpn.devel/7149<br>&gt; <br>&gt; <br>&gt; -- <br>&gt; kind regards,<br>&gt;=
 <br>&gt; David Sommerseth<br>&gt; <br>&gt; -------------- next part ------=
--------<br>&gt; A non-text attachment was scrubbed...<br>&gt; Name: signat=
ure.asc<br>&gt; Type: application/pgp-signature<br>&gt; Size: 262 bytes<br>=
&gt; Desc: OpenPGP digital signature<br>&gt; <br>&gt; ---------------------=
---------<br>&gt; <br>&gt; Message: 5<br>&gt; Date: Fri, 30 Nov 2012 14:37:=
28 +0200<br>&gt; From: Samuli Sepp?nen &lt;samuli@...515...&gt;<br>&gt; Sub=
ject: [Openvpn-devel] Summary of the IRC meeting (29th Nov 2012)<br>&gt; To=
: "openvpn-devel@lists.sourceforge.net"<br>&gt; 	&lt;openvpn-devel@...1466...=
urceforge.net&gt;<br>&gt; Message-ID: &lt;50B8A888.40109@...515...&gt;<br>&=
gt; Content-Type: text/plain; charset=3D"utf-8"<br>&gt; <br>&gt; Hi,<br>&gt=
; <br>&gt; Here's the summary of the previous IRC meeting.<br>&gt; <br>&gt;=
 ---<br>&gt; <br>&gt; COMMUNITY MEETING<br>&gt; <br>&gt; Place: #openvpn-de=
vel on irc.freenode.net<br>&gt; Date: Thursday 29th Nov 2012<br>&gt; Time: =
18:00 UTC<br>&gt; <br>&gt; Planned meeting topics for this meeting were on =
this page:<br>&gt; <br>&gt; &lt;https://community.openvpn.net/openvpn/wiki/=
Topics-2012-11-29&gt;<br>&gt; <br>&gt; Next meeting will be announced in ad=
vance, but will probably be on the same<br>&gt; weekday and at the same tim=
e. Your local meeting time is easy to check<br>&gt; from services such as<b=
r>&gt; <br>&gt; &lt;http://www.timeanddate.com/worldclock&gt;<br>&gt; <br>&=
gt; or with<br>&gt; <br>&gt; $ date -u<br>&gt; <br>&gt; <br>&gt; SUMMARY<br=
>&gt; <br>&gt; cron2, dazo, ecrist, krzee, jamesyonan, mattock, novaflash, =
plaisthos,<br>&gt; raidz and swg0101 participated in this meeting.<br>&gt; =
<br>&gt; --<br>&gt; <br>&gt; Started the meeting with short round of introd=
uctions. Some were not<br>&gt; formally introduced, but are included here. =
On the community side:<br>&gt; <br>&gt; - cron2: The OpenVPN IPv6+BSD+Solar=
is developer, buildbot farmer (Germany)<br>&gt; - dazo:  master of plugins =
and git, does patch management, cleanups and<br>&gt; lots of other good wor=
k (Norway)<br>&gt; - d12fk: develops the new openvpn-gui for Windows (Germa=
ny)<br>&gt; - ecrist: takes care of forums, easy-rsa maintenance, #openvpn =
channel,<br>&gt; etc. (Unites States)<br>&gt; - krzee: takes care of the fo=
rums and IRC with ecrist; a mystical figure<br>&gt; (somewhere in the Carib=
bean)<br>&gt; - plaisthos: did the Android port; in charge of overhauling t=
he socket.c<br>&gt; code (Germany)<br>&gt; <br>&gt; On the company side:<br=
>&gt; <br>&gt; - jamesyonan: Father of OpenVPN (United States/Colorado)<br>=
&gt; - mattock: Community manager, server administrator, does OSS releases,=
<br>&gt; testing, etc. (Finland)<br>&gt; - novaflash: Support technician (N=
etherlands)<br>&gt; - raidz: Support engineer, network engineer, and janito=
r (United<br>&gt; States/California)<br>&gt; - swg0101: Support and develop=
ment (United States)<br>&gt; <br>&gt; A few non-participants were also ment=
ioned:<br>&gt; <br>&gt; - andj: Added polarssl support to openvpn and is ma=
intaining that part<br>&gt; (Netherlands)<br>&gt; - juanjo: The other IPv6 =
guy who we seldom see (from where?)<br>&gt; <br>&gt; ---<br>&gt; <br>&gt; J=
amesyonan gave a short introduction of the new C++ codebase:<br>&gt; <br>&g=
t; - about 30K lines of C++ code<br>&gt; - an object-oriented rethinking of=
 openvpn from the ground up<br>&gt; - design similar to original OpenVPN 3.=
0:<br>&gt; &lt;http://community.openvpn.net/openvpn/wiki/RoadMap&gt;<br>&gt=
; - is very modular in the sense that SSL/crypto libraries, transport<br>&g=
t; protocols, etc. can be modularized<br>&gt; - fairly prototypical/incompl=
ete at this stage; only the client-side has<br>&gt; been implemented<br>&gt=
; - has been tested against Access Server (based on OpenVPN 2.1.x) and<br>&=
gt; OpenVPN 2.3* servers<br>&gt; - is 100% protocol compatible with 2.x bra=
nches<br>&gt; - has most 2.x's options<br>&gt; - is being used in the OpenV=
PN tech android client and the upcoming iOS<br>&gt; client<br>&gt; - may (a=
t some point) supplant the 2.x branch, but that'll probably take<br>&gt; at=
 least 1-2 years<br>&gt; <br>&gt; Some more technical tidbits:<br>&gt; <br>=
&gt; - core leverages on Boost Asio as it's async i/o layer<br>&gt; - C++ i=
s really ready for prime time in system programming / networking<br>&gt; sp=
ace<br>&gt; - C++ 2003 that's used seems to work very well on different com=
pilers<br>&gt; - C++ static polymorphism (templates) is great for network p=
rogramming<br>&gt; where we have small objects that have polymorphic proper=
ties, such as<br>&gt; IPv4 vs IPv6 addresses<br>&gt; <br>&gt; ---<br>&gt; <=
br>&gt; Discussed open sourcing the C++ codebase:<br>&gt; <br>&gt; Accordin=
g to jamesyonan, the plan is to release this probably under GPL<br>&gt; wit=
hin the next couple months, but the company needs the ability to<br>&gt; re=
license the C++ core because of (Apple) app store issues. It was<br>&gt; ag=
reed that having OpenVPN on that platform is a must. To accomplish<br>&gt; =
this, relicensing the codebase is necessary. The consensus was that this<br=
>&gt; can be done in a way that's acceptable to all parties, without resort=
ing<br>&gt; to the classic "copyright handover" scheme, which was not ok fo=
r everyone.<br>&gt; <br>&gt; The alternative would be to release the C++ co=
debase under a permissive<br>&gt; license (e.g. BSD), but that would allow =
companies such as Apple or<br>&gt; Microsoft to "steal" it. This was not se=
en as a good option, either.<br>&gt; <br>&gt; ---<br>&gt; <br>&gt; Discusse=
d the role of OpenVPN 2.3 within the company:<br>&gt; <br>&gt; The company =
is planning to migrate the Access Server to OpenVPN 2.3*.<br>&gt; Before th=
e meeting mattock had already managed to get the Access Server<br>&gt; runn=
ing with OpenVPN-2.3-rc1 in a few hours, with only few minor<br>&gt; modifi=
cations. Tests run by raidz during the meeting revealed no further<br>&gt; =
issues. More details will follow later.<br>&gt; <br>&gt; ---<br>&gt; <br>&g=
t; Discussed having a joint company/community meeting in FOSDEM<br>&gt; (ht=
tps://fosdem.org/2013). Most of the present developers seem to be<br>&gt; c=
oming, but nobody has dared book the flights or hotel yet.<br>&gt; <br>&gt;=
 ---<br>&gt; <br>&gt; Decided to arrange a second meeting next Thursday at =
the same time. The<br>&gt; meeting will focus on helping James move to 2.3 =
and Git (from 2.1.x and<br>&gt; SVN).<br>&gt; <br>&gt; ---<br>&gt; <br>&gt;=
 Full chatlog as an attachment<br>&gt; <br>&gt; -- <br>&gt; Samuli Sepp?nen=
<br>&gt; Community Manager<br>&gt; OpenVPN Technologies, Inc<br>&gt; <br>&g=
t; irc freenode net: mattock<br>&gt; <br>&gt; <br>&gt; -------------- next =
part --------------<br>&gt; mattock_ 20.14.15<br>&gt; ah, finally<br>&gt; d=
amn empathy 20.14.17<br>&gt; it disconnected without saying anything 20.14.=
33<br>&gt; everyone set? 20.14.46<br>&gt;  <br>&gt; dazo 20.14.49<br>&gt; h=
eh ... been talking for your self? 	<br>&gt; <br>&gt; mattock_ 20.14.51<br>=
&gt; yeah	<br>&gt; <br>&gt; krzee 20.14.52<br>&gt; *is here from work, so i=
n and out depending on how busy it is*	<br>&gt; <br>&gt; mattock_ 20.14.53<=
br>&gt; 	<br>&gt; <br>&gt; ecrist 20.15.13<br>&gt; *too*	<br>&gt; <br>&gt; =
dazo 20.15.30<br>&gt; d12fk might appear as well, but I don't think we shou=
ld wait for him now ... we're 15 min past already	<br>&gt; <br>&gt; mattock=
_ 20.15.34<br>&gt; ok, so here are today's topics: https://community.openvp=
n.net/openvpn/wiki/Topics-2012-11-29	<br>&gt; <br>&gt; vpnHelper 20.15.35<b=
r>&gt; Title: Topics-2012-11-29 ? OpenVPN Community (at community.openvpn.n=
et)	<br>&gt; <br>&gt; dazo 20.15.50<br>&gt; everyone from the company prese=
nt?	<br>&gt; <br>&gt; novaflash 20.16.05<br>&gt; i am present	<br>&gt; <br>=
&gt; raidz 20.16.10<br>&gt; here	<br>&gt; <br>&gt; novaflash 20.16.13<br>&g=
t; james appears to be present as well, and raidz as well	<br>&gt; <br>&gt;=
 raidz 20.16.16<br>&gt; jamesyonan	<br>&gt; <br>&gt; cron2 20.16.23<br>&gt;=
  /whois novaflash?	<br>&gt; <br>&gt; novaflash 20.16.30<br>&gt; an idiot<b=
r>&gt; i mean.. err.. 20.16.32<br>&gt;  <br>&gt; raidz 20.16.37<br>&gt; int=
roduce yourself johan	<br>&gt; <br>&gt; novaflash 20.16.38<br>&gt; one of t=
he support techs at openvpn technologies	<br>&gt; <br>&gt; cron2 20.16.51<b=
r>&gt; (sorry if I missed the introduction, I'm not always paying close att=
ention)	<br>&gt; <br>&gt; novaflash 20.17.00<br>&gt; that's okay i don't th=
ink i ever did introduce myself here<br>&gt; i just sort of sidled in 20.17=
.07<br>&gt; sneakily 20.17.11<br>&gt;  <br>&gt; cron2 20.17.18<br>&gt; now =
done  - welcome to the secret society	<br>&gt; <br>&gt; novaflash 20.17.31<=
br>&gt; *does secret handshake*	<br>&gt; <br>&gt; mattock_ 20.17.59<br>&gt;=
 novaflash: btw. where do you live? besides the IRC channel, that is...	<br=
>&gt; <br>&gt; novaflash 20.18.08<br>&gt; i'm in the netherlands	<br>&gt; <=
br>&gt; mattock_ 20.18.20<br>&gt; yeah, I thought so	<br>&gt; <br>&gt; cron=
2 20.18.35<br>&gt; fun.  So how big is OpenVPN tech?	<br>&gt; <br>&gt; nova=
flash 20.18.41<br>&gt; so i usually am the one answering tickets and questi=
ons in #openvpn-as while raidz and co and dreaming of unicorns and fairies	=
<br>&gt; <br>&gt; raidz 20.18.59<br>&gt; there are about 7 of us cron2	<br>=
&gt; <br>&gt; novaflash 20.19.01<br>&gt; 7 billion people working in the co=
mpany at the moment!	<br>&gt; <br>&gt; raidz 20.19.04<br>&gt; we are a smal=
l bunch	<br>&gt; <br>&gt; cron2 20.19.46<br>&gt; I assumed so, but sometime=
s you guess wrong, and that sounded like "having support force round the wo=
rld, in all time zones!!" 	<br>&gt; <br>&gt; dazo 20.19.54<br>&gt; So, raid=
z, novaflash, jamesyonan and mattock_ are the company guys here now, right?=
	<br>&gt; <br>&gt; raidz 20.19.58<br>&gt; hahaha	<br>&gt; <br>&gt; novaflas=
h 20.20.12<br>&gt; *checks list of nicks in the channel*<br>&gt; yes. 20.20=
.14<br>&gt; i think so 20.20.31<br>&gt;  <br>&gt; raidz 20.20.39<br>&gt; co=
rrect dazo	<br>&gt; <br>&gt; mattock_ 20.20.40<br>&gt; raidz: have you ever=
 formally introduced yourself?	<br>&gt; <br>&gt; novaflash 20.20.56<br>&gt;=
 introduce yourself raidz	<br>&gt; <br>&gt; raidz 20.20.58<br>&gt; I have a=
 feeling people recognize me, but in case you don't:	<br>&gt; <br>&gt; cron=
2 20.21.02<br>&gt; I think he has<br>&gt; he's the one breaking stuff @ com=
pany all day 20.21.15<br>&gt;  <br>&gt; raidz 20.21.17<br>&gt; I am OpenVPN=
's support engineer, network engineer, and janitor	<br>&gt; <br>&gt; cron2 =
20.21.23<br>&gt; what I said	<br>&gt; <br>&gt; raidz 20.21.29<br>&gt; We we=
ar a lot of hats around here <br>&gt; exactly cron2! 20.21.38<br>&gt;  <br>=
&gt; novaflash 20.21.51<br>&gt; raidz is selling himself short, he's also a=
 ladies man - with a girl on each finger	<br>&gt; <br>&gt; raidz 20.22.03<b=
r>&gt; not anymore! Just 1 now!	<br>&gt; <br>&gt; mattock_ 20.22.13<br>&gt;=
 shall I give a "flash introduction" of the community guys?	<br>&gt; <br>&g=
t; novaflash 20.22.14<br>&gt; oh what a tragic accident, just one finger?	<=
br>&gt; <br>&gt; dazo 20.22.23<br>&gt; mattock_: makes sense	<br>&gt; <br>&=
gt; mattock_ 20.22.30<br>&gt; ok	<br>&gt; <br>&gt; raidz 20.22.31<br>&gt; m=
attock_: I think I know most of the people in here, but I think it would be=
 nice<br>&gt; in case any of us don't 20.22.39<br>&gt;  <br>&gt; cron2 20.2=
2.50<br>&gt; +1	<br>&gt; <br>&gt; mattock_ 20.23.20<br>&gt; andj added pola=
rssl support to openvpn and is maintaining that part... lives in Netherland=
s	<br>&gt; <br>&gt; krzee 20.23.28<br>&gt; are the corp guys here?  (beside=
s james / mattock)	<br>&gt; <br>&gt; mattock_ 20.23.41<br>&gt; cron2 is one=
 of the IPv6 guys, from Germany	<br>&gt; <br>&gt; cron2 20.23.44<br>&gt; *p=
oints krzee at "20 lines up"*	<br>&gt; <br>&gt; novaflash 20.23.45<br>&gt; =
krzee: james, mattock, me, raidz.	<br>&gt; <br>&gt; krzee 20.23.57<br>&gt; =
oh whoa, i didnt know you were corp 	<br>&gt; <br>&gt; mattock_ 20.23.59<br=
>&gt; then there's the other IPv6 guy who we don't see much (juanjo)	<br>&g=
t; <br>&gt; novaflash 20.24.09<br>&gt; krzee: surprise	<br>&gt; <br>&gt; ra=
idz 20.24.12<br>&gt; krzee: we are pretty much it, I am not sure if Francis=
 will make it or not, I don't think he knows how to use IRC<br>&gt; 20.24.1=
8<br>&gt;  <br>&gt; cron2 20.24.21<br>&gt; *g*	<br>&gt; <br>&gt; mattock_ 2=
0.24.22<br>&gt; d12fk: is developing the new openvpn-gui for Windows and is=
 also from Germany 	<br>&gt; <br>&gt; krzee 20.24.27<br>&gt; heh	<br>&gt; <=
br>&gt; novaflash 20.24.31<br>&gt; good, keep it that way, because i say wa=
y too many crazy shit on IRC	<br>&gt; <br>&gt; mattock_ 20.24.47<br>&gt; ec=
rist is taking care of forums, easy-rsa maintenance, #openvpn channel, etc.=
 and is from the States	<br>&gt; <br>&gt; raidz 20.24.49<br>&gt; I thought =
cron2 was the ipv6 guy mattock_	<br>&gt; <br>&gt; mattock_ 20.25.00<br>&gt;=
 ender can introduce himself <br>&gt; raidz: he's one of them, the active o=
ne 20.25.07<br>&gt;  <br>&gt; novaflash 20.25.08<br>&gt; raidz: that's what=
 he said	<br>&gt; <br>&gt; cron2 20.25.16<br>&gt; raidz: I did "IPv6 payloa=
d", juanjo did "IPv6 transport"	<br>&gt; <br>&gt; novaflash 20.25.22<br>&gt=
; ahh.	<br>&gt; <br>&gt; mattock_ 20.25.24<br>&gt; keitsi can also introduc=
e himself  	<br>&gt; <br>&gt; plaisthos 20.25.28<br>&gt; sup	<br>&gt; <br>&=
gt; cron2 20.25.29<br>&gt; both together form "IPv6 support" <br>&gt; keits=
i? 20.25.35<br>&gt;  <br>&gt; mattock_ 20.25.48<br>&gt; krzee is also worki=
ng on forums and IRC like krzee, and I believe he's currently somewhere in =
the Caribbean 	<br>&gt; <br>&gt; raidz 20.25.48<br>&gt; ahh	<br>&gt; <br>&g=
t; plaisthos 20.25.54<br>&gt; I managed to get here a bit earlier (reading =
backlog now)	<br>&gt; <br>&gt; cron2 20.26.10<br>&gt; and plaisthos is the =
community janitor	<br>&gt; <br>&gt; mattock_ 20.26.27<br>&gt; plaisthos has=
 done the Android port of OpenVPN and has been pretty active here<br>&gt; t=
hat's it I guess 20.26.32<br>&gt;  <br>&gt; cron2 20.26.34<br>&gt; cleaning=
 up some damp and smelly stuff inside socket.c 	<br>&gt; <br>&gt; krzee 20.=
26.49<br>&gt; &lt;-- pirate of the caribbean ;]	<br>&gt; <br>&gt; raidz 20.=
26.56<br>&gt; Nice to re-meet/meet you all!	<br>&gt; <br>&gt; mattock_ 20.2=
7.04<br>&gt; plaisthos: +5 for cleaning up the scary parts	<br>&gt; <br>&gt=
; cron2 20.27.05<br>&gt; and dazo is the master of plugins and git	<br>&gt;=
 <br>&gt; novaflash 20.27.17<br>&gt; plaisthos is arne schwabe?	<br>&gt; <b=
r>&gt; mattock_ 20.27.19<br>&gt; ah yes, did I somehow manage to skip dazo<=
br>&gt; ? 20.27.24<br>&gt;  <br>&gt; cron2 20.27.25<br>&gt; easy to overloo=
k	<br>&gt; <br>&gt; mattock_ 20.27.29<br>&gt; uh	<br>&gt; <br>&gt; cron2 20=
.27.32<br>&gt; novaflash: yes	<br>&gt; <br>&gt; novaflash 20.27.36<br>&gt; =
gotcha	<br>&gt; <br>&gt; plaisthos 20.27.37<br>&gt; novaflash: yes	<br>&gt;=
 <br>&gt; novaflash 20.27.40<br>&gt; gotcha	<br>&gt; <br>&gt; mattock_ 20.2=
7.41<br>&gt; also from Germany?	<br>&gt; <br>&gt; dazo 20.27.42<br>&gt; I'd=
 like to add that plaisthos is also in charge of overhauling the often fear=
ed socket.c code 	<br>&gt; <br>&gt; raidz 20.27.42<br>&gt; how did you mana=
ge to skip dazo?!	<br>&gt; <br>&gt; krzee 20.27.50<br>&gt; +5 more for how =
awesome plaisthos's android client is	<br>&gt; <br>&gt; dazo 20.27.59<br>&g=
t; *considers to get grumpy on mattock_ *	<br>&gt; <br>&gt; cron2 20.28.05<=
br>&gt; raidz: he's hardly saying anything on IRC these days, so we tend to=
 forget him	<br>&gt; <br>&gt; raidz 20.28.11<br>&gt; ouch	<br>&gt; <br>&gt;=
 mattock_ 20.28.14<br>&gt; so, dazo is taking care of patch management, cle=
aning up the codebase and in general doing lots of good work<br>&gt; from N=
orway 20.28.18<br>&gt;  <br>&gt; cron2 20.28.21<br>&gt; or maybe mattock's =
IRC client is just ignoring dazo	<br>&gt; <br>&gt; novaflash 20.28.37<br>&g=
t; poor dazo	<br>&gt; <br>&gt; dazo 20.28.42<br>&gt; heh ... too much noise=
 from me 	<br>&gt; <br>&gt; krzee 20.28.43<br>&gt; from norway by way of .c=
z<br>&gt; 20.28.46<br>&gt; L'utente swg0101 ? entrato nella stanza 20.28.51=
	<br>&gt; <br>&gt; novaflash 20.28.56<br>&gt; i hope some of openvpn's dona=
tions go to dazo's mental healthcare. those pills can't be cheap.	<br>&gt; =
<br>&gt; plaisthos 20.28.58<br>&gt; *is from germany*	<br>&gt; <br>&gt; nov=
aflash 20.28.59<br>&gt; oh hello swg0101	<br>&gt; <br>&gt; raidz 20.29.01<b=
r>&gt; oh, here is one more company guy: swg0101	<br>&gt; <br>&gt; swg0101 =
20.29.05<br>&gt; hey...	<br>&gt; <br>&gt; mattock_ 20.29.07<br>&gt; hi swg0=
101	<br>&gt; <br>&gt; swg0101 20.29.15<br>&gt; everyone is coughing here so=
 I stepped away for a bit<br>&gt; now hopefully I don't get sick 20.29.34<b=
r>&gt;  <br>&gt; mattock_ 20.29.44<br>&gt; swg0101: you're from somewhere n=
ear San Francisco?<br>&gt; Bay area 20.29.48<br>&gt;  <br>&gt; swg0101 20.2=
9.52<br>&gt; in Davis	<br>&gt; <br>&gt; cron2 20.29.54<br>&gt; swg0101: so =
what are you doing?	<br>&gt; <br>&gt; novaflash 20.30.02<br>&gt; yes and he=
's got brains the size of my balls. wait that didn't come out quite right..=
.	<br>&gt; <br>&gt; swg0101 20.30.05<br>&gt; I am doing cronjobs... haha, j=
k 	<br>&gt; <br>&gt; cron2 20.30.25<br>&gt; *has the feeling that "cronjobs=
" means work*	<br>&gt; <br>&gt; novaflash 20.30.33<br>&gt; he's in support =
and development - he figures out the really gritty problems some of our cli=
ents have and proposes fixes	<br>&gt; <br>&gt; krzee 20.30.40<br>&gt; swg01=
01, im from the bay originally	<br>&gt; <br>&gt; swg0101 20.30.48<br>&gt; y=
es, krzee is krzee	<br>&gt; <br>&gt; mattock_ 20.30.56<br>&gt; krzee has no=
 real name afaik<br>&gt; he's just krzee 20.31.00<br>&gt;  <br>&gt; swg0101=
 20.31.08<br>&gt; you are krzee	<br>&gt; <br>&gt; krzee 20.31.10<br>&gt; th=
is is true, krzee is my name 	<br>&gt; <br>&gt; mattock_ 20.31.13<br>&gt; I=
 don't think he has an email address, either<br>&gt; 20.31.18<br>&gt;  <br>=
&gt; novaflash 20.31.18<br>&gt; you're all a little krzee	<br>&gt; <br>&gt;=
 mattock_ 20.31.31<br>&gt; mkay, are we done with introductions?	<br>&gt; <=
br>&gt; krzee 20.31.34<br>&gt; the publishing company of JJK's book didnt l=
ike that i have no real name lol	<br>&gt; <br>&gt; swg0101 20.31.35<br>&gt;=
 so what are we talking about? 	<br>&gt; <br>&gt; mattock_ 20.31.42<br>&gt;=
 swg0101: https://community.openvpn.net/openvpn/wiki/Topics-2012-11-29	<br>=
&gt; <br>&gt; vpnHelper 20.31.43<br>&gt; Title: Topics-2012-11-29 ? OpenVPN=
 Community (at community.openvpn.net)	<br>&gt; <br>&gt; novaflash 20.31.44<=
br>&gt; the topics are here<br>&gt; https://community.openvpn.net/openvpn/w=
iki/Topics-2012-11-29 20.31.45<br>&gt;  <br>&gt; swg0101 20.32.03<br>&gt; f=
un stuff 	<br>&gt; <br>&gt; novaflash 20.32.12<br>&gt; i am seeing openvpn =
c++ here, i think it that's different from what openvpn has been up till no=
w?<br>&gt; i assume it was python before and now c++ ? 20.32.23<br>&gt;  <b=
r>&gt; mattock_ 20.32.30<br>&gt; james could probably start by explaining w=
hat the C++ thingy is, and what should we do about it<br>&gt; jamesyonan: s=
hall you do the honors? 20.32.58<br>&gt;  <br>&gt; jamesyonan 20.33.12<br>&=
gt; yes, basically I've been working for a while on a new openvpn core that=
 might (at some point) supplant the 2.x branch<br>&gt; it's fairly prototyp=
ical at this stage 20.33.27<br>&gt; it's ~ 30K lines of C++ code 20.33.42<b=
r>&gt;  <br>&gt; swg0101 20.33.53<br>&gt; jamesyonan: is that the core that=
 you are working on that allows for different transport protocols on top of=
 OpenVPN?	<br>&gt; <br>&gt; jamesyonan 20.34.07<br>&gt; yes, among other th=
ings	<br>&gt; <br>&gt; swg0101 20.34.12<br>&gt; very interesting	<br>&gt; <=
br>&gt; jamesyonan 20.34.49<br>&gt; it is very modular in the sense that SS=
L/crypto libraries, transport protocols, etc. can be modularized	<br>&gt; <=
br>&gt; krzee 20.34.55<br>&gt; is it being built with the 3.0 roadmap in mi=
nd?<br>&gt; sounds like a yes ^ 20.35.00<br>&gt;  <br>&gt; jamesyonan 20.35=
.17<br>&gt; basically yes, but it's still incomplete at this point<br>&gt; =
right now it's just a client 20.35.27<br>&gt;  <br>&gt; krzee 20.35.48<br>&=
gt; (for anyone not familiar, http://community.openvpn.net/openvpn/wiki/Roa=
dMap )	<br>&gt; <br>&gt; vpnHelper 20.35.51<br>&gt; Title: RoadMap ? OpenVP=
N Community (at community.openvpn.net)	<br>&gt; <br>&gt; jamesyonan 20.35.5=
3<br>&gt; it's being used in the OpenVPN tech android client and the upcomi=
ng iOS client	<br>&gt; <br>&gt; novaflash 20.36.20<br>&gt; neat.	<br>&gt; <=
br>&gt; cron2 20.36.30<br>&gt; hah, he said the word	<br>&gt; <br>&gt; raid=
z 20.36.41<br>&gt; 	<br>&gt; <br>&gt; novaflash 20.36.57<br>&gt; supercalli=
fragilisticexpialidocious then	<br>&gt; <br>&gt; krzee 20.37.18<br>&gt; how=
s it licensed?	<br>&gt; <br>&gt; jamesyonan 20.37.58<br>&gt; the plan is to=
 release this probably under GPL within the next couple months	<br>&gt; <br=
>&gt; mattock_ 20.38.31<br>&gt; jamesyonan: I would suggest "in FOSDEM"	<br=
>&gt; <br>&gt; novaflash 20.38.45<br>&gt; i am not familiar with fosdem?	<b=
r>&gt; <br>&gt; mattock_ 20.39.07<br>&gt; you could give an introduction of=
 it there	<br>&gt; <br>&gt; cron2 20.39.10<br>&gt; that's an open source co=
nference in brussels, early february	<br>&gt; <br>&gt; dazo 20.39.11<br>&gt=
; novaflash: http://fosdem.org/2012/	<br>&gt; <br>&gt; plaisthos 20.39.15<b=
r>&gt; jamesyonan: with a contributer agreement? So you can merge changes t=
o iOS and the android client base?	<br>&gt; <br>&gt; mattock_ 20.39.16<br>&=
gt; https://fosdem.org/2013/	<br>&gt; <br>&gt; vpnHelper 20.39.19<br>&gt; T=
itle: fosdem.org (at fosdem.org)<br>&gt; Title: FOSDEM 2013 - Home (at fosd=
em.org) 20.39.21<br>&gt;  <br>&gt; jamesyonan 20.39.25<br>&gt; but bear in =
mind that this is a new code base, and is still far from being a drop-in re=
placement for 2.x	<br>&gt; <br>&gt; novaflash 20.40.19<br>&gt; so, FOSDEM i=
s an event, not a license type?	<br>&gt; <br>&gt; mattock_ 20.40.24<br>&gt;=
 yeah 	<br>&gt; <br>&gt; krzee 20.40.25<br>&gt; novaflash, correct	<br>&gt;=
 <br>&gt; novaflash 20.40.28<br>&gt; righto<br>&gt; when i went to the fron=
tpage i saw beer mentioned 20.40.41<br>&gt; so they've got me sold 20.40.44=
<br>&gt;  <br>&gt; cron2 20.41.03<br>&gt; .nl-&gt;brussels is a nice train =
trip, andj and jjk did this last year	<br>&gt; <br>&gt; novaflash 20.41.14<=
br>&gt; jan just keizer?<br>&gt; yes i don't think brussels is too far, it =
can be done 20.41.30<br>&gt;  <br>&gt; jamesyonan 20.41.44<br>&gt; you guys=
 are lucky that you have trains	<br>&gt; <br>&gt; cron2 20.41.45<br>&gt; no=
vaflash: yeah, we all met last year at fosdem, first ever face-to-face meet=
ing.  Very goood.	<br>&gt; <br>&gt; dazo 20.41.47<br>&gt; what is this rumo=
ur about "contributor agreement"?	<br>&gt; <br>&gt; novaflash 20.42.12<br>&=
gt; jamesyonan: europe is interesting in that it has so much stuff so close=
 together.	<br>&gt; <br>&gt; cron2 20.42.21<br>&gt; dazo: well, it's a logi=
cal consequence: you can't release iOS code under GPL - so if that code is =
open sourced, and you want people to be able to contribute back, you need t=
hem to accept re-releasing it under a non-GPL license	<br>&gt; <br>&gt; mat=
tock_ 20.42.51<br>&gt; there are other ways to handle the copyright ownersh=
ip issues which iOS requires	<br>&gt; <br>&gt; novaflash 20.42.52<br>&gt; h=
m. apple restricting GPL eh?	<br>&gt; <br>&gt; mattock_ 20.42.55<br>&gt; no=
ne of them are pretty	<br>&gt; <br>&gt; cron2 20.42.57<br>&gt; (stupid Appl=
e and Microsoft store license shit, but we *need* OpenVPN on these platform=
s)	<br>&gt; <br>&gt; mattock_ 20.43.17<br>&gt; so we need to somehow minimi=
ze damages to everyone involved	<br>&gt; <br>&gt; cron2 20.43.20<br>&gt; no=
vaflash: Apple store requires "receiver must not modify", GPL requires "rec=
eiver must receive source and all rights to modify".  Incompatible	<br>&gt;=
 <br>&gt; novaflash 20.43.30<br>&gt; gotcha.	<br>&gt; <br>&gt; jamesyonan 2=
0.43.36<br>&gt; right, basically we need the ability to relicense the C++ c=
ore because of app store issues	<br>&gt; <br>&gt; krzee 20.43.37<br>&gt; op=
envpn on native ios will be a pretty fat win	<br>&gt; <br>&gt; mattock_ 20.=
43.45<br>&gt; there are other options besides contributor agreements<br>&gt=
; but some version of openvpn needs to "compatible" with iOS policies 20.44=
.13<br>&gt;  <br>&gt; plaisthos 20.44.16<br>&gt; BSD license but I can unde=
rstand if OpenVPN Corp does not want a BSD licensed OpenVN core	<br>&gt; <b=
r>&gt; novaflash 20.44.24<br>&gt; perhaps if we promise to bring Steve Jobs=
 back to life, Apple will allow us a more flexible licensing method.	<br>&g=
t; <br>&gt; mattock_ 20.44.28<br>&gt; plaisthos: exactly	<br>&gt; <br>&gt; =
dazo 20.44.47<br>&gt; well, I can understand that argument ... from a busin=
ess perspective .... I can even agree to a kind of contributor agreement th=
at permits re-licensing to Apple and Microsoft stores ... but if the agreem=
ent requires copyright handover, then I'm fairly sceptical and will probabl=
y drop out instantly	<br>&gt; <br>&gt; jamesyonan 20.45.09<br>&gt; no, we'r=
e certainly not asking for copyright handover	<br>&gt; <br>&gt; cron2 20.45=
.25<br>&gt; the agreement would need to be worded carefully to keep the GPL=
 stuff GPLed, and just permit extra licensing	<br>&gt; <br>&gt; jamesyonan =
20.45.34<br>&gt; we just need the ability to relicense if necessary	<br>&gt=
; <br>&gt; dazo 20.45.47<br>&gt; fair enough	<br>&gt; <br>&gt; cron2 20.45.=
48<br>&gt; *is fine with that*	<br>&gt; <br>&gt; mattock_ 20.46.38<br>&gt; =
nobody really _wants_ those pesky agreement and bureaucracy... they basical=
ly hurt everyone (in our situation)	<br>&gt; <br>&gt; dazo 20.46.39<br>&gt;=
 jamesyonan: when you have a draft ready, I can check if the GPL lawyer at =
my work have time to review it and comment it	<br>&gt; <br>&gt; novaflash 2=
0.46.47<br>&gt; the open source project must of course be kept intact, and =
not have some apple/microsoft bozos stealing it all.<br>&gt; mattock_: yeah=
 agreed. but best to have it covered. 20.47.11<br>&gt;  <br>&gt; jamesyonan=
 20.47.22<br>&gt; dazo: sure	<br>&gt; <br>&gt; mattock_ 20.47.46<br>&gt; da=
zo: oh yes, you have GPL lawyers at RedHat 	<br>&gt; <br>&gt; novaflash 20.=
48.14<br>&gt; that's pretty supercallifragilisticexpialidocious	<br>&gt; <b=
r>&gt; mattock_ 20.48.46<br>&gt; jamesyonan: perhaps you could share a word=
 about the architecture of the C++ codebase... it should help limit the sco=
pe of any copyright ownership issues	<br>&gt; <br>&gt; swg0101 20.48.48<br>=
&gt; dazo works at RH? 	<br>&gt; <br>&gt; dazo 20.48.50<br>&gt;  mattock_ y=
eah, Richard Fontana is quite into this stuff	<br>&gt; <br>&gt; mattock_ 20=
.48.51<br>&gt; yes	<br>&gt; <br>&gt; dazo 20.48.53<br>&gt; swg0101: I do	<b=
r>&gt; <br>&gt; swg0101 20.48.59<br>&gt; interesting<br>&gt; security team?=
 20.49.07<br>&gt;  <br>&gt; novaflash 20.49.20<br>&gt; dazo: he will now tr=
y to obtain your company secrets by squeezing your brain like a lemon.	<br>=
&gt; <br>&gt; swg0101 20.49.37<br>&gt; easy peasy lemon squeezy so they cal=
l	<br>&gt; <br>&gt; jamesyonan 20.49.38<br>&gt; no, as long as openvpn is u=
nder GPL, none of the big guys can really steal it	<br>&gt; <br>&gt; dazo 2=
0.49.59<br>&gt; swg0101: actually, no ... openvpn is one of my spare time p=
rojects ... I'm doing real time kernel QA and development of related test t=
ools	<br>&gt; <br>&gt; jamesyonan 20.50.24<br>&gt; ok, let me give a short =
primer on the new C++ code base	<br>&gt; <br>&gt; dazo 20.50.38<br>&gt; +1	=
<br>&gt; <br>&gt; mattock_ 20.50.53<br>&gt; jamesyonan: that's a valid poin=
t... companies like Apple would probably steal the code the very instant it=
 was released under a BSD license	<br>&gt; <br>&gt; raidz 20.51.07<br>&gt; =
^^^	<br>&gt; <br>&gt; jamesyonan 20.52.00<br>&gt; right, BSD license would =
allow any company to create a proprietary fork	<br>&gt; <br>&gt; novaflash =
20.52.21<br>&gt; GPL with permissions in specific cases for relicensing wou=
ld still seem to be the best option	<br>&gt; <br>&gt; jamesyonan 20.52.30<b=
r>&gt; but I don't see that this could be done with GPL<br>&gt; and I think=
 we've seen cases in the past, where the big guys have tried to shred the G=
PL 20.53.29<br>&gt; MS called it a "cancer" at one point 20.53.40<br>&gt; b=
ut I think it has proved it's resiliancy at preventing proprietary forks 20=
.54.06<br>&gt;  <br>&gt; dazo 20.54.06<br>&gt; yupp	<br>&gt; <br>&gt; novaf=
lash 20.54.19<br>&gt; if microsoft hates it, i love it already	<br>&gt; <br=
>&gt; krzee 20.54.45<br>&gt; http://en.wikipedia.org/wiki/Viral_license    =
"The term is most often used to describe the GPL, which requires that any d=
erivative work also be licensed with the GPL."	<br>&gt; <br>&gt; vpnHelper =
20.54.46<br>&gt; Title: Viral license - Wikipedia, the free encyclopedia (a=
t en.wikipedia.org)	<br>&gt; <br>&gt; jamesyonan 20.55.57<br>&gt; so the C+=
+ core is basically an object-oriented rethinking of openvpn from the groun=
d up<br>&gt; the core leverages on Boost Asio as it's async i/o layer 20.56=
.38<br>&gt;  <br>&gt; mattock_ 20.57.08<br>&gt; http://www.boost.org/doc/li=
bs/1_52_0/doc/html/boost_asio.html	<br>&gt; <br>&gt; jamesyonan 20.57.09<br=
>&gt; rather than sort of roll it's own async i/o layer as the 2.x branch d=
oes	<br>&gt; <br>&gt; vpnHelper 20.57.10<br>&gt; Title: Boost.Asio - 1.52.0=
 (at www.boost.org)	<br>&gt; <br>&gt; jamesyonan 20.57.35<br>&gt; Asio is r=
eally great<br>&gt; C++ is an interesting animal 20.58.29<br>&gt;  <br>&gt;=
 dazo 20.59.01<br>&gt; heh ... that's a nice way to put it	<br>&gt; <br>&gt=
; mattock_ 20.59.12<br>&gt; I've heard everyone loves C++<br>&gt; 20.59.15<=
br>&gt;  <br>&gt; cron2 20.59.22<br>&gt; interesting way to word it... (I'v=
e never liked C++, especially from a sysadmin perspective it's higly annoyi=
ng that half the source doesn't compile with half the compilers...)	<br>&gt=
; <br>&gt; novaflash 20.59.29<br>&gt; i've heard it's better than B++	<br>&=
gt; <br>&gt; jamesyonan 20.59.32<br>&gt; I would have to say that I was ori=
ginally very sceptical that C++ would be a good systems programming languag=
e	<br>&gt; <br>&gt; swg0101 20.59.35<br>&gt; lol<br>&gt; x++ 20.59.42<br>&g=
t; ; 20.59.51<br>&gt;  <br>&gt; jamesyonan 21.00.15<br>&gt; but here are so=
me of the points that won me over...<br>&gt; I remember back in maybe '06 I=
 gave C++ a trial run for a network project I was working on 21.01.05<br>&g=
t; I used whatever gcc was current at the time, linked in boost Asio, and r=
an some benchmarks 21.01.35<br>&gt; this was a very simple server app, sort=
 of like a very basic HTTP server 21.01.54<br>&gt; it's a program that woul=
d have been 60KB written in C but it ended up linking at 600KB in C++ and b=
eing several times slower than equivalent C 21.02.49<br>&gt;  <br>&gt; cron=
2 21.03.22<br>&gt; now *that* doesn't truly convince me yet 	<br>&gt; <br>&=
gt; krzee 21.03.31<br>&gt; lol	<br>&gt; <br>&gt; jamesyonan 21.03.37<br>&gt=
; then several years layer, maybe around '11 I gave C++ another shot<br>&gt=
; this time I used the latest boost and gcc 4.6 21.04.03<br>&gt; what I dis=
covered is that some really serious optimization work had gone into gcc (an=
d LLVM as well) 21.05.06<br>&gt;  <br>&gt; plaisthos 21.05.14<br>&gt; *outs=
 himself as C++ programmer too*	<br>&gt; <br>&gt; jamesyonan 21.05.55<br>&g=
t; for example, the compiler people figured out a really cool way to deal w=
ith C++ exceptions so that they didn't incur any overhead unless they are t=
hrown	<br>&gt; <br>&gt; cron2 21.06.09<br>&gt; plaisthos: if you ever need =
a new job, one of my customers is doing quite a lot of C++ and Java 	<br>&g=
t; <br>&gt; raidz 21.07.09<br>&gt; 	<br>&gt; <br>&gt; jamesyonan 21.07.28<b=
r>&gt; I was quite amazed that I could write very clean, abstracted network=
 code using gcc 4.6 + boost asio and the code size had come down to ~ 60 KB=
 and the compiler seemed to really factor out all the abstraction so the re=
sulting generated code was very efficient	<br>&gt; <br>&gt; plaisthos 21.07=
.38<br>&gt; llvm guys also figured out how to give you good error messages =
(:	<br>&gt; <br>&gt; jamesyonan 21.08.36<br>&gt; yes, llvm is looking good,=
 but it still seems slightly behind gcc on generating fast code from C++<br=
>&gt; but in any event, I think C++ is really ready for prime time in the k=
ind of system programming / networking space that openvpn is in 21.09.18<br=
>&gt; some other things I like about modern C++ ... 21.09.43<br>&gt; it's a=
 very-well standardized language across the different major compilers, i.e.=
 gcc, llvm, visual studio, etc. 21.10.30<br>&gt;  <br>&gt; mattock_ 21.10.4=
9<br>&gt; hmm, even visual studio... that's something	<br>&gt; <br>&gt; jam=
esyonan 21.10.49<br>&gt; now granted, I am using C++ 2003 for this project =
-- haven't ventured into '11 yet<br>&gt; I wrote ~20K lines before I even t=
ested it on visual studio 21.11.17<br>&gt; and I think it took under a coup=
le hours to get it building and running with VS 21.11.51<br>&gt;  <br>&gt; =
cron2 21.12.12<br>&gt; that is definitely a plus	<br>&gt; <br>&gt; novaflas=
h 21.12.32<br>&gt; yeah a C plus plus (groan)	<br>&gt; <br>&gt; jamesyonan =
21.12.36<br>&gt; so let me get into some of the features of C++ that I thin=
k make it well-suited for use as a basis for OpenVPN<br>&gt; C++ is one of =
the few languages that supports both static and dynamic polymorphism 21.13.=
21<br>&gt; dynamic polymorphism via virtual functions 21.14.03<br>&gt; and =
static polymorphism via templates 21.14.18<br>&gt;  <br>&gt; ecrist 21.15.3=
6<br>&gt; are you suggesting a switch, completely, from C to C++?	<br>&gt; =
<br>&gt; jamesyonan 21.15.44<br>&gt; templates are great for network progra=
mming, because we have a lot of cases where we have small objects that have=
 polymorphic properties, such as IPv4 vs IPv6 addresses<br>&gt; I think it =
makes a lot of sense for OpenVPN 3 to be C++ 21.16.16<br>&gt;  <br>&gt; ecr=
ist 21.16.32<br>&gt; http://www.joelonsoftware.com/articles/fog0000000069.h=
tml	<br>&gt; <br>&gt; vpnHelper 21.16.33<br>&gt; Title: Things You Should N=
ever Do, Part I - Joel on Software (at www.joelonsoftware.com)	<br>&gt; <br=
>&gt; jamesyonan 21.16.38<br>&gt; but I think the 2.x branch should remain =
in C	<br>&gt; <br>&gt; ecrist 21.17.25<br>&gt; dazo pointed me to that doc	=
<br>&gt; <br>&gt; mattock_ 21.17.39<br>&gt; ecrist, dazo: complements, exce=
llent article 	<br>&gt; <br>&gt; ecrist 21.17.49<br>&gt; I'd be afraid 3 wo=
uld never be released	<br>&gt; <br>&gt; cron2 21.18.11<br>&gt; *tends to ag=
ree on both extents - "rewriting 2.x into C++" is likely to be more effort =
than "doing it fresh from the start and adding features on the go"*<br>&gt;=
 or so 21.18.14<br>&gt;  <br>&gt; ecrist 21.18.14<br>&gt; and what did pote=
ntially get released would be riddled with bugs that were already solved, o=
r simply not a problem, in our current code base	<br>&gt; <br>&gt; jamesyon=
an 21.18.21<br>&gt; I think it's an interesting article, but I disagree wit=
h it	<br>&gt; <br>&gt; novaflash 21.18.27<br>&gt; ecrist; at the moment jam=
esyonan has a prototypical version that is already functioning in c++ as th=
e client in android and now ios.<br>&gt; or when it is released anyways (fo=
r iOS i mean) 21.18.41<br>&gt;  <br>&gt; ecrist 21.18.56<br>&gt; novaflash:=
 I'm aware	<br>&gt; <br>&gt; jamesyonan 21.19.05<br>&gt; yes, the C++ core =
is already in production	<br>&gt; <br>&gt; cron2 21.19.25<br>&gt; what you =
can't do is "stop 2.x, rewrite everything, and stall until 3.x is ready" - =
*that* would be a major mistake	<br>&gt; <br>&gt; ecrist 21.19.26<br>&gt; b=
ut untested relative to the community code base	<br>&gt; <br>&gt; cron2 21.=
19.33<br>&gt; ecrist: no, it works nicely	<br>&gt; <br>&gt; jamesyonan 21.2=
0.00<br>&gt; well actually the C++ core, because it's only a client, ALWAYS=
 connects to an OpenVPN 2.x server	<br>&gt; <br>&gt; cron2 21.20.04<br>&gt;=
 ecrist: I've given it enough beating that I would be happy for my customer=
s to use it, against a 2.3RC1 server<br>&gt; and what james says 21.20.32<b=
r>&gt;  <br>&gt; jamesyonan 21.20.48<br>&gt; cron2 has worked with us on te=
sting the new iOS client	<br>&gt; <br>&gt; cron2 21.20.49<br>&gt; jamesyona=
n: do you test C++ -&gt; 2.1/AS or vs. 2.3?	<br>&gt; <br>&gt; jamesyonan 21=
.21.03<br>&gt; both	<br>&gt; <br>&gt; krzee 21.21.27<br>&gt; from our previ=
ous talks, a lot of 3.0 would need to be re-write anyways	<br>&gt; <br>&gt;=
 cron2 21.21.36<br>&gt; yeah	<br>&gt; <br>&gt; novaflash 21.21.41<br>&gt; t=
he OpenVPN Android client that jamesyonan made is capable of working for bo=
th the open source server and the access server	<br>&gt; <br>&gt; raidz 21.=
21.59<br>&gt; same goes for ios	<br>&gt; <br>&gt; krzee 21.22.00<br>&gt; to=
 account for making it modular, which sounds to be a lot of what this new c=
ore aims for	<br>&gt; <br>&gt; jamesyonan 21.22.15<br>&gt; yes, the new C++=
 core is 100% protocol compatible with 2.x branch	<br>&gt; <br>&gt; ecrist =
21.22.27<br>&gt; is it feature-complete?	<br>&gt; <br>&gt; jamesyonan 21.22=
.55<br>&gt; no, it doesn't have all of the 2.x options<br>&gt; but it has m=
ost of them 21.23.17<br>&gt;  <br>&gt; raidz 21.23.25<br>&gt; jamesyonan: w=
ill it have them all?	<br>&gt; <br>&gt; plaisthos 21.23.35<br>&gt; Having w=
orked with the socket.c code I must say I would not aim at having all optio=
ns<br>&gt; some of them are very disruptive 21.23.46<br>&gt;  <br>&gt; cron=
2 21.23.47<br>&gt; *expected that comment *	<br>&gt; <br>&gt; jamesyonan 21=
.24.06<br>&gt; it could -- right now I believe fragment option is not imple=
mented<br>&gt; yeah, the new code base doesn't even have a socket.c-like so=
urce file 21.24.52<br>&gt; because Asio handles the i/o layer 21.25.06<br>&=
gt;  <br>&gt; ecrist 21.25.19<br>&gt; what about the MTU and mssfix bits?	<=
br>&gt; <br>&gt; plaisthos 21.25.19<br>&gt; <br>&gt; I got to get going 21.=
25.32<br>&gt; have to leave you guys 21.25.45<br>&gt;  <br>&gt; novaflash 2=
1.25.47<br>&gt; bye plaisthos 	<br>&gt; <br>&gt; swg0101 21.25.51<br>&gt; c=
ya	<br>&gt; <br>&gt; jamesyonan 21.25.51<br>&gt; mssfix isn't there now, bu=
t it's on my short list of things to add<br>&gt; bye plaisthos 21.26.04<br>=
&gt;  <br>&gt; cron2 21.26.51<br>&gt; james: I did mssfix for IPv6 today.  =
If you're working on that, you might want to look at it  - haven't sent the=
 patch yet, but it's working on our corp VPN server<br>&gt; http://public.g=
reenie.net/gert/misc/ipv6-mss-diff2.txt 21.26.59<br>&gt;  <br>&gt; jamesyon=
an 21.27.11<br>&gt; cool	<br>&gt; <br>&gt; plaisthos 21.27.15<br>&gt; james=
yonan: One last question before I go. My client is currently named "OpenVPN=
 for Android". At the time I first named the client I did not give it much =
thought. I have later realized that the name might sound  "official". If yo=
u do not like this I can change the name	<br>&gt; <br>&gt; jamesyonan 21.27=
.59<br>&gt; no, I don't think that's really necessary	<br>&gt; <br>&gt; rai=
dz 21.28.18<br>&gt; plaisthos: Love your client btw 	<br>&gt; <br>&gt; jame=
syonan 21.28.29<br>&gt; we tend to brand the OpenVPN Tech products with "Op=
enVPN Connect" anyway	<br>&gt; <br>&gt; novaflash 21.29.11<br>&gt; and in f=
uture releases of access server we'll probably have links to the openvpn te=
ch versions for android and ios anyways<br>&gt; at least, that's what i'd e=
xpect 21.29.19<br>&gt;  <br>&gt; plaisthos 21.29.31<br>&gt; raidz: thanks<b=
r>&gt; jamesyonan: okay thanks bye 21.29.40<br>&gt;  <br>&gt; jamesyonan 21=
.29.55<br>&gt; see ya	<br>&gt; <br>&gt; mattock_ 21.30.11<br>&gt; jamesyona=
n: you mentioned that the C++ codebase is still very far from being a repla=
cement for 2.x<br>&gt; so we'll be living with the original code for quite =
a while 21.30.27<br>&gt;  <br>&gt; novaflash 21.30.37<br>&gt; 2.* will cont=
inue	<br>&gt; <br>&gt; cron2 21.30.59<br>&gt; mattock_: it has no server si=
de yet	<br>&gt; <br>&gt; jamesyonan 21.31.07<br>&gt; yes, it's much closer =
to being a client-side replacement, but the server side will take more deve=
lopment	<br>&gt; <br>&gt; mattock_ 21.31.15<br>&gt; today I tried merging s=
ome of your SVN patches to Git, and it wasn't pretty	<br>&gt; <br>&gt; jame=
syonan 21.31.34<br>&gt; snappy?	<br>&gt; <br>&gt; mattock_ 21.31.44<br>&gt;=
 I think we're past the point where we "should move" to 2.3, and are in "ne=
ed to move a.s.a.p."<br>&gt; yes, that and all others actually 21.31.50<br>=
&gt; snappy is probably the worst of the bunch 21.31.59<br>&gt;  <br>&gt; n=
ovaflash 21.32.11<br>&gt; the new compressor?	<br>&gt; <br>&gt; mattock_ 21=
.32.17<br>&gt; yep	<br>&gt; <br>&gt; novaflash 21.32.34<br>&gt; ironic that=
 a name like snappy should take much time to get integrated.	<br>&gt; <br>&=
gt; jamesyonan 21.33.06<br>&gt; snappy is really great though -- I don't kn=
ow if you've looked through the source	<br>&gt; <br>&gt; swg0101 21.33.15<b=
r>&gt; Google's implementation?	<br>&gt; <br>&gt; jamesyonan 21.33.22<br>&g=
t; this is what google uses company-wide as its main compressor	<br>&gt; <b=
r>&gt; swg0101 21.33.46<br>&gt; would be curious to see if it makes good pe=
rformance differences<br>&gt; perhaps with aes-ni 21.33.54<br>&gt;  <br>&gt=
; mattock_ 21.36.34<br>&gt; jamesyonan: can you port the patches I sent you=
 for 2.3?<br>&gt; I could then do more testing with 2.3 with those patches =
included 21.36.45<br>&gt;  <br>&gt; jamesyonan 21.37.02<br>&gt; the snappy =
patch?	<br>&gt; <br>&gt; mattock_ 21.37.22<br>&gt; all of the patches, exce=
pt r8129<br>&gt; that one was fairly trivial to port 21.37.32<br>&gt; the f=
irst problem is that files have been moved around 21.37.41<br>&gt; e.g. 21.=
37.44<br>&gt; init.c -&gt; src/openvpn/init.c 21.37.50<br>&gt; that's trivi=
al, but doesn't do the trick anymore, too many changes/cleanups in 2.3 21.3=
8.10<br>&gt; so manual merging is necessary for all patches 21.38.31<br>&gt=
;  <br>&gt; jamesyonan 21.38.31<br>&gt; ok, I'll take a look at it	<br>&gt;=
 <br>&gt; mattock_ 21.39.22<br>&gt; jamesyonan: how is your 2.3-fu? meaning=
, should we arrange a meeting where we take a look at what's exactly has ch=
ange since 2.1.x?	<br>&gt; <br>&gt; jamesyonan 21.39.25<br>&gt; yes, we are=
 planning to migrate to 2.3 for the next version of AS	<br>&gt; <br>&gt; ma=
ttock_ 21.39.45<br>&gt; in fact, I did some tests on openvpn 2.3-rc1 and AS=
, and got the thing running	<br>&gt; <br>&gt; novaflash 21.39.47<br>&gt; AS=
 1.9? 	<br>&gt; <br>&gt; jamesyonan 21.39.53<br>&gt; yes, that would make s=
ense	<br>&gt; <br>&gt; mattock_ 21.39.54<br>&gt; with fairly minimal modifi=
cations	<br>&gt; <br>&gt; cron2 21.39.58<br>&gt; mattock: oh, that's cool	<=
br>&gt; <br>&gt; jamesyonan 21.40.05<br>&gt; novaflash: yes	<br>&gt; <br>&g=
t; novaflash 21.40.18<br>&gt; neat. i mean, cool.	<br>&gt; <br>&gt; mattock=
_ 21.40.26<br>&gt; I thank dazo for keeping Git in sync with SVN for this l=
ong... for the missing patches, I don't blame him for dropping the ball <br=
>&gt; Alon's buildsystem work made merging much more difficult 21.40.55<br>=
&gt;  <br>&gt; dazo 21.41.07<br>&gt; heh ... no it just got too complicated=
 to merge it in for me ... well, I could do it ... but it would require a l=
ot of analysing of each conflict	<br>&gt; <br>&gt; mattock_ 21.41.35<br>&gt=
; jamesyonan: "yes, that would make sense" ... was this a response to the m=
eeting suggestion?	<br>&gt; <br>&gt; dazo 21.41.43<br>&gt; on the plus side=
 ... alons build system now works fairly well on cross-compiles and cross-p=
latform stuff, I htink	<br>&gt; <br>&gt; jamesyonan 21.41.47<br>&gt; yes	<b=
r>&gt; <br>&gt; cron2 21.41.47<br>&gt; *grumbles quietly about the build sy=
stem accident^Wrevolution*	<br>&gt; <br>&gt; mattock_ 21.41.53<br>&gt; dazo=
: yes, that's correct, it's pretty good<br>&gt; best buildsystem so far 21.=
42.17<br>&gt;  <br>&gt; cron2 21.42.18<br>&gt; some parts are great, but re=
arranging all the source tree was... "more religious than useful"	<br>&gt; =
<br>&gt; mattock_ 21.42.44<br>&gt; ...maybe if we rebuilt another buildsyst=
em from scratch, then we could fix all the problems in the current one? 	<b=
r>&gt; <br>&gt; dazo 21.43.13<br>&gt; cron2: to some extent, I can agree ..=
. but the "everything in root dir" was also quite chaotic too	<br>&gt; <br>=
&gt; mattock_ 21.43.27<br>&gt; I think the new layout is quite nice	<br>&gt=
; <br>&gt; cron2 21.43.30<br>&gt; it's not so much the build system, as the=
 "other changes" <br>&gt; *hates it every time I look at stuff* 21.43.39<br=
>&gt; src/openvpn/ is just overdoing it for a single program, "src/" is ful=
ly fine, and "everything in toplevel dir" was good enough for me 21.44.14<b=
r>&gt; but we digress - damage has been done, and it's easy to oppose somet=
hing in hindsight 21.44.31<br>&gt;  <br>&gt; mattock_ 21.45.49<br>&gt; jame=
syonan: as C++ codebase is not going to go server anytime soon, so what abo=
ut 2.4?<br>&gt; moving AS to 2.3 should be _fairly_ painless 21.46.06<br>&g=
t; then we have 2.4 release cycle coming up 21.46.15<br>&gt; what is our st=
rategy regarding it? 21.46.24<br>&gt; "what drives us forward with 2.4" 21.=
47.06<br>&gt;  <br>&gt; jamesyonan 21.47.18<br>&gt; yes, don't see the C++ =
codebase as altering the evolution of 2.x branch for a least another year o=
r two<br>&gt; my attitude is that the C++ codebase should prove itself in m=
ultiple areas before it is embraced en-mass 21.49.03<br>&gt;  <br>&gt; matt=
ock_ 21.49.16<br>&gt; will 2.4 be mostly about cleanups/stabilization, or d=
o we (=3Dthe project) have some other agenda?	<br>&gt; <br>&gt; dazo 21.51.=
11<br>&gt; well, plaisthos does a lot of code clean-up in socket.c ... and =
we have a lot of other clean-ups as well ... and it might be we try to modu=
larise other things better as well	<br>&gt; <br>&gt; mattock_ 21.51.33<br>&=
gt; I'm thinking of removing rarely used options	<br>&gt; <br>&gt; dazo 21.=
51.34<br>&gt; but some important things I hope we can sort out with 2.4 is =
listening to multiple ports and protocols	<br>&gt; <br>&gt; mattock_ 21.51.=
40<br>&gt; i.e. historic baggage	<br>&gt; <br>&gt; novaflash 21.51.54<br>&g=
t; multiple cores? *hopeful*	<br>&gt; <br>&gt; cron2 21.51.56<br>&gt; matto=
ck: what you consider historic baggage might be the reason why people are u=
sing OpenVPN... 	<br>&gt; <br>&gt; mattock_ 21.52.10<br>&gt; cron2: I hear =
you complaining about too many options <br>&gt; but you're right 21.52.20<b=
r>&gt;  <br>&gt; dazo 21.52.29<br>&gt; novaflash: nope, that won't fit into=
 2.4 .... going from single thread to multi-thread requires a too massive c=
hange now	<br>&gt; <br>&gt; mattock_ 21.52.30<br>&gt; so we'd need to ident=
ify what's just baggage, and what's being used	<br>&gt; <br>&gt; cron2 21.5=
2.41<br>&gt; indeed, we have way too many options, but sometimes you find y=
ourself in a corner and all that helps is one of the more obscure options..=
.	<br>&gt; <br>&gt; mattock_ 21.52.51<br>&gt; lol 	<br>&gt; <br>&gt; novafl=
ash 21.53.06<br>&gt; dazo: i have to admit, knowing how openvpn works, it's=
 best to leave the multi core handling outside of it	<br>&gt; <br>&gt; jame=
syonan 21.53.28<br>&gt; why not preserve the options in 2.x branch and let =
3.x be testing ground for removal of obsolete options	<br>&gt; <br>&gt; cro=
n2 21.53.28<br>&gt; dazo: oh, if someone comes along and finds a way to spl=
it encryption, decryption, crypto, and "the rest" into a handful of threads=
, I might be open to take a closer look...	<br>&gt; <br>&gt; mattock_ 21.53=
.32<br>&gt; actually, I don't think not having multiple threads is that bad=
	<br>&gt; <br>&gt; cron2 21.53.39<br>&gt; s/crypto/compression/<br>&gt; wel=
l, it limits performance... 21.53.54<br>&gt;  <br>&gt; novaflash 21.54.10<b=
r>&gt; maybe not but it'd only really be of much use in very large deployme=
nts (where people use multiple openvpn processes anyways) and on systems wi=
th very low power but dual core cpu systems like atom systems.	<br>&gt; <br=
>&gt; dazo 21.54.15<br>&gt; cron2: true ... but there's this nasty thing ca=
lled CPU caching as well ... so to make that optimal, that will require som=
e nasty analysing too	<br>&gt; <br>&gt; jamesyonan 21.54.23<br>&gt; the C++=
 core supports multiple threads, HOWEVER, you really can't do fine grained =
threading and expect to see a performance gain	<br>&gt; <br>&gt; mattock_ 2=
1.54.25<br>&gt; one can have multiple processes, which, while heavier than =
threads are adequate	<br>&gt; <br>&gt; cron2 21.54.39<br>&gt; my goals for =
2.4 is "code overhaul to integrate IPv6 more nicely" (it's bolted-on right =
now - working but ugly)	<br>&gt; <br>&gt; novaflash 21.54.44<br>&gt; agree =
with mattock_ .<br>&gt; cron2: seconded, ipv6 is hot right now 21.55.00<br>=
&gt;  <br>&gt; dazo 21.55.07<br>&gt; and the things with threading ... you =
loose performance instantly in the moment you have more high loaded threads=
 than CPU cores available	<br>&gt; <br>&gt; cron2 21.55.12<br>&gt; dazo: we=
ll, that speaks for "two threads" (one for incoming, one for outgoing packe=
ts)...	<br>&gt; <br>&gt; dazo 21.55.21<br>&gt; cron2: agreed 	<br>&gt; <br>=
&gt; cron2 21.55.36<br>&gt; and you don't loose if you do not synchronize a=
round too much...  (maybe a 3rd thread for handshaking)<br>&gt; but I'm not=
 writing it - not enough experience with writing threaded code to feel comf=
ortable about doing this in a security product 21.56.08<br>&gt;  <br>&gt; m=
attock_ 21.56.09<br>&gt; we actually have one more important topic today:<b=
r>&gt; "Joint company/community meeting in FOSDEM in Bruessels" 21.56.19<br=
>&gt; jamesyonan: we insist you come there 21.56.35<br>&gt;  <br>&gt; novaf=
lash 21.56.38<br>&gt; perhaps it's best to take small but important steps w=
ith 2.*, and big steps in 3 ?	<br>&gt; <br>&gt; cron2 21.56.39<br>&gt; nova=
flash: it's in, and it's working, but it's missing some bells and whistles,=
 and needs polishing	<br>&gt; <br>&gt; novaflash 21.56.50<br>&gt; mattock_:=
 that would be so cool, having james here	<br>&gt; <br>&gt; jamesyonan 21.5=
6.56<br>&gt; yes, I'm going to try to be there	<br>&gt; <br>&gt; cron2 21.5=
7.06<br>&gt; cool	<br>&gt; <br>&gt; dazo 21.57.12<br>&gt; I'm trying to get=
 the bookings done this or next week	<br>&gt; <br>&gt; novaflash 21.57.32<b=
r>&gt; mattock_: do you know the exact date and shit?	<br>&gt; <br>&gt; mat=
tock_ 21.57.53<br>&gt; jamesyonan: if we can open source the C++ codebase b=
y then, then your should _definitely_ be there and give a presentation of i=
t	<br>&gt; <br>&gt; cron2 21.58.04<br>&gt; novaflash: all on fosdem.org/201=
3/	<br>&gt; <br>&gt; jamesyonan 21.58.09<br>&gt; yes, that's what I'm think=
ing	<br>&gt; <br>&gt; dazo 21.58.14<br>&gt; novaflash: February 2-3	<br>&gt=
; <br>&gt; novaflash 21.58.23<br>&gt; ah thanks, neato<br>&gt; oh hell! 21.=
58.38<br>&gt;  <br>&gt; mattock_ 21.58.39<br>&gt; also, the company should =
offer a nice dinner for everyone involved in the project	<br>&gt; <br>&gt; =
novaflash 21.58.40<br>&gt; it's belgium!<br>&gt; beer! 21.58.48<br>&gt;  <b=
r>&gt; mattock_ 21.58.50<br>&gt; 	<br>&gt; <br>&gt; jamesyonan 21.59.03<br>=
&gt; sure, great idea	<br>&gt; <br>&gt; novaflash 21.59.05<br>&gt; okay, ye=
s, i'm okay now.	<br>&gt; <br>&gt; mattock_ 21.59.17<br>&gt; novaflash: tha=
t is most correct	<br>&gt; <br>&gt; dazo 21.59.17<br>&gt; novaflash: I've b=
een told that in Germany 7 beers counts as a dinner ...	<br>&gt; <br>&gt; n=
ovaflash 21.59.17<br>&gt; i'll buy you guys some beer	<br>&gt; <br>&gt; cro=
n2 21.59.25<br>&gt; *will bring warmer shoes this time*	<br>&gt; <br>&gt; d=
azo 21.59.35<br>&gt; *too*	<br>&gt; <br>&gt; novaflash 21.59.36<br>&gt; cro=
n2: did you go naked again?	<br>&gt; <br>&gt; cron2 22.00.12<br>&gt; novafl=
ash: nah, but last year they had a huge amount of snow, and the heating in =
the university buildings was... not up to it	<br>&gt; <br>&gt; novaflash 22=
.00.19<br>&gt; yikes	<br>&gt; <br>&gt; mattock_ 22.00.21<br>&gt; was there =
any heating?	<br>&gt; <br>&gt; novaflash 22.00.39<br>&gt; yes, the beamer w=
as on	<br>&gt; <br>&gt; cron2 22.00.40<br>&gt; mattock: if you bring in 100=
0 open source zealots, there *is* heat.  But it wasn't enough	<br>&gt; <br>=
&gt; dazo 22.00.59<br>&gt; it's the first conference I've been to where I s=
aw plenty of geeks hacking in thick jackets ... not t-shirts 	<br>&gt; <br>=
&gt; novaflash 22.01.15<br>&gt; note to self: don't go naked<br>&gt; so um =
what's next on the agenda? 22.02.58<br>&gt;  <br>&gt; mattock_ 22.03.20<br>=
&gt; hmm, I guess we're mostly done	<br>&gt; <br>&gt; cron2 22.03.41<br>&gt=
; we just need confirmation that dazo is happy and will now end his strike	=
<br>&gt; <br>&gt; novaflash 22.03.51<br>&gt; he's on strike?	<br>&gt; <br>&=
gt; dazo 22.03.51<br>&gt; hehe 	<br>&gt; <br>&gt; mattock_ 22.04.07<br>&gt;=
 definitely	<br>&gt; <br>&gt; novaflash 22.04.13<br>&gt; perhaps he needs a=
 good ole whipping	<br>&gt; <br>&gt; cron2 22.04.27<br>&gt; *whips dazo wit=
h lots of ACKs*<br>&gt; on strings 22.04.29<br>&gt;  <br>&gt; mattock_ 22.0=
4.36<br>&gt; or "in strings"?	<br>&gt; <br>&gt; novaflash 22.04.46<br>&gt; =
i am getting a very odd image here now<br>&gt; of cron2 in g-string 22.04.5=
4<br>&gt;  <br>&gt; cron2 22.04.55<br>&gt; *doesn't want to know*	<br>&gt; =
<br>&gt; novaflash 22.04.56<br>&gt; whipping dazo	<br>&gt; <br>&gt; mattock=
_ 22.04.57<br>&gt; oh my, all of this will go to the mailing list	<br>&gt; =
<br>&gt; dazo 22.04.58<br>&gt; jamesyonan: would it be possible to get you =
more visible on the -devel mailing list?  Like just giving "ACK" or "NACK" =
to patches which makes sense ... doesn't need to too often but a few times =
every month when there are some un-reviewed patches would help	<br>&gt; <br=
>&gt; mattock_ 22.05.13<br>&gt; +1	<br>&gt; <br>&gt; novaflash 22.05.18<br>=
&gt; mattock_: just delete everything i said then	<br>&gt; <br>&gt; mattock=
_ 22.05.22<br>&gt; we've missed you<br>&gt; novaflash: the trust must not m=
e tampered with 22.05.29<br>&gt; oops 22.05.32<br>&gt; truth 22.05.33<br>&g=
t;  <br>&gt; novaflash 22.05.42<br>&gt; mattock_: but that typo will MAGICA=
LLY be repaired?	<br>&gt; <br>&gt; mattock_ 22.05.46<br>&gt; no	<br>&gt; <b=
r>&gt; novaflash 22.05.50<br>&gt; heh	<br>&gt; <br>&gt; jamesyonan 22.05.51=
<br>&gt; I think that's a good idea, I just need to scale better	<br>&gt; <=
br>&gt; novaflash 22.05.54<br>&gt; okay good then.	<br>&gt; <br>&gt; cron2 =
22.06.20<br>&gt; jamesyonan: you need to reimplement yourself using C++ and=
 Boost, obviously 	<br>&gt; <br>&gt; mattock_ 22.06.22<br>&gt; jamesyonan: =
I think moving to 2.3 will help... raidz is running a test suite with 2.3-r=
c1 atm	<br>&gt; <br>&gt; dazo 22.06.47<br>&gt; jamesyonan: I think we're fa=
irly good now ... cron2 have done a good job reviewing stuff ... but I do k=
now we have some stuff which needs to be reviewed for 2.4	<br>&gt; <br>&gt;=
 novaflash 22.06.55<br>&gt; mattock_: i got your test suite forwarded and a=
m going to give it a shot too	<br>&gt; <br>&gt; jamesyonan 22.06.56<br>&gt;=
 no, I think I need to go quantum	<br>&gt; <br>&gt; mattock_ 22.07.02<br>&g=
t; we need to communicate with the community devs using the "normal" method=
s to be effective	<br>&gt; <br>&gt; dazo 22.07.05<br>&gt; (which is rather =
old stuff ... but I'll summarise it on a wiki first)	<br>&gt; <br>&gt; matt=
ock_ 22.07.33<br>&gt; the "weekly meeting with James" worked initially, but=
 quite often it created lot of delay	<br>&gt; <br>&gt; dazo 22.07.47<br>&gt=
; and I know plaisthos will come with some socket.c clean-up too	<br>&gt; <=
br>&gt; novaflash 22.07.50<br>&gt; jamesyonan: remove your GPL license and =
let us fork you a couple of times so there's more of you to spread around	<=
br>&gt; <br>&gt; mattock_ 22.08.30<br>&gt; there's also the option of stopp=
ing all the interesting side-projects?<br>&gt; I'm constantly struggling wi=
th that myself 22.08.43<br>&gt; 22.08.48<br>&gt;  <br>&gt; dazo 22.09.21<br=
>&gt; *would like to reduce the openvpn side-project, so he could focus mor=
e on his own eurephia project *	<br>&gt; <br>&gt; mattock_ 22.09.44<br>&gt;=
 dazo: how's the openvpn linux gui side-project going? 	<br>&gt; <br>&gt; j=
amesyonan 22.09.44<br>&gt; it's easier for me to spend a couple hours a wee=
k with undivided attention than to multitask off-and-on into community disc=
ussions	<br>&gt; <br>&gt; dazo 22.09.53<br>&gt; oh true<br>&gt; GUI program=
ming is a mess 22.10.03<br>&gt; even GTK 22.10.11<br>&gt;  <br>&gt; novafla=
sh 22.10.19<br>&gt; dazo is developing a gui for linux? awesome!	<br>&gt; <=
br>&gt; dazo 22.10.32<br>&gt; I've took over the maintenance of gopenvpn <b=
r>&gt; the previous maintainer didn't have much time for it any more 22.10.=
46<br>&gt;  <br>&gt; jamesyonan 22.11.17<br>&gt; dazo: have you looked at S=
RP ( http://en.wikipedia.org/wiki/Secure_Remote_Password_protocol )?	<br>&g=
t; <br>&gt; vpnHelper 22.11.18<br>&gt; Title: Secure Remote Password protoc=
ol - Wikipedia, the free encyclopedia (at en.wikipedia.org)	<br>&gt; <br>&g=
t; cron2 22.11.40<br>&gt; dazo: is that a useful thing to have, gopenvpn, a=
s to "make the integration in NM better" (as everybody seems to go to NM an=
yway)	<br>&gt; <br>&gt; mattock_ 22.12.01<br>&gt; jamesyonan: we haven't ha=
d "classic" IRC meeting on Thursdays for a while, because things have worke=
d fine without them	<br>&gt; <br>&gt; dazo 22.12.31<br>&gt; cron2: NM is us=
eful for "I just need one VPN tunnel" .... but I usually use 3 in parallel,=
 and gopenvpn is somewhat closer in behaviour to the Windows GUI .... using=
 real config files	<br>&gt; <br>&gt; cron2 22.12.56<br>&gt; dazo: ah, so NM=
 cannot do multiple tunnels?  Indeed, that would be a good reason for "some=
thing better"	<br>&gt; <br>&gt; dazo 22.13.12<br>&gt; jamesyonan: nope ... =
but that looks interesting (at least if I don't have to go to deep on the m=
athematics 	<br>&gt; <br>&gt; cron2 22.13.17<br>&gt; *is confused by graphi=
cal stuff*	<br>&gt; <br>&gt; dazo 22.13.32<br>&gt; cron2: and if NM looses =
the wireless for a second ... it disconnects/stops all VPN tunnels	<br>&gt;=
 <br>&gt; mattock_ 22.13.36<br>&gt; jamesyonan: it'd be great if you could,=
 say, check openvpn-devel list 2-3 times a week and then immediately close =
the email client 	<br>&gt; <br>&gt; dazo 22.13.43<br>&gt; that's my second =
big complaint about NM	<br>&gt; <br>&gt; mattock_ 22.13.58<br>&gt; that str=
ategy saves my nerves and improves my focus  	<br>&gt; <br>&gt; dazo 22.14.=
01<br>&gt; (to fix that, it seems the core NM needs to be reworked)	<br>&gt=
; <br>&gt; cron2 22.14.15<br>&gt; mattock: and you compensate by hanging in=
 IRC all day 	<br>&gt; <br>&gt; dazo 22.14.21<br>&gt; hehe	<br>&gt; <br>&gt=
; mattock_ 22.14.27<br>&gt; well, yes... but I hate email more than I hate =
IRC<br>&gt; email =3D&gt; somebody wants me to do something 22.14.46<br>&gt=
;  <br>&gt; novaflash 22.14.55<br>&gt; as it appears that the main agenda p=
oints have been handled (unless our illustrious leaders indicate otherwise)=
 i am going to go get some things sorted here and head off to bed.	<br>&gt;=
 <br>&gt; mattock_ 22.15.04<br>&gt; novaflash: good idea	<br>&gt; <br>&gt; =
cron2 22.15.08<br>&gt; dazo: seems we really need to sit together with d12f=
k @FOSDEM to sort out the privilege separation / gui / service stuff<br>&gt=
; that should happen "soon" now... 22.15.16<br>&gt; novaflash: good night 2=
2.15.24<br>&gt;  <br>&gt; mattock_ 22.15.36<br>&gt; and we should book the =
flights / hotels soon, before the prices start climbing up	<br>&gt; <br>&gt=
; dazo 22.15.59<br>&gt; cron2: agreed ...  that's 2.4 material<br>&gt; and =
if jamesyonan will be present at FOSDEM ... it would be natural to gain fro=
m his experience there as well 22.16.30<br>&gt;  <br>&gt; mattock_ 22.16.39=
<br>&gt; oh, one more thing<br>&gt; I want to set a time when James comes h=
ere to be moved to wonderful world of Git and 2.3.x 22.17.01<br>&gt; jamesy=
onan: please pick a date and time 22.17.25<br>&gt;  <br>&gt; jamesyonan 22.=
17.46<br>&gt; yes, I do like git, but I'm still stuck with svn for now	<br>=
&gt; <br>&gt; mattock_ 22.17.47<br>&gt; I can take care of the Git part, I'=
ve been dazo's apprentice<br>&gt; how do we get you unstuck? how can we hel=
p? 22.18.04<br>&gt;  <br>&gt; cron2 22.18.12<br>&gt; "rpm -e svn"	<br>&gt; =
<br>&gt; jamesyonan 22.18.26<br>&gt; rpm: not found	<br>&gt; <br>&gt; matto=
ck_ 22.18.33<br>&gt; uh	<br>&gt; <br>&gt; dazo 22.18.40<br>&gt; heh	<br>&gt=
; <br>&gt; cron2 22.18.49<br>&gt; jamesyonan: now I think dazo will stop ta=
lking to you...!	<br>&gt; <br>&gt; dazo 22.19.07<br>&gt; hmmmm 	<br>&gt; <b=
r>&gt; jamesyonan 22.19.17<br>&gt; actually I use mac most of the time	<br>=
&gt; <br>&gt; mattock_ 22.19.49<br>&gt; jamesyonan: next Thursday, same tim=
e, same place?	<br>&gt; <br>&gt; jamesyonan 22.19.53<br>&gt; sure	<br>&gt; =
<br>&gt; mattock_ 22.20.02<br>&gt; ok, excellent<br>&gt; I think we're done=
, then 22.20.18<br>&gt; any objections? 22.20.58<br>&gt;  <br>&gt; cron2 22=
.21.49<br>&gt; *is fine*	<br>&gt; <br>&gt; jamesyonan 22.22.23<br>&gt; fine=
 here	<br>&gt; <br>&gt; ecrist 22.22.24<br>&gt; none from me	<br>&gt; <br>&=
gt; mattock_ 22.23.07<br>&gt; nice!	<br>&gt; <br>&gt; dazo 22.23.08<br>&gt;=
 *is fine*	<br>&gt; <br>&gt; mattock_ 22.23.25<br>&gt; ok, next meeting nex=
t week this time<br>&gt; I'll send a summary tomorrow 22.23.36<br>&gt;  <br=
>&gt; dazo 22.23.41<br>&gt; thx all!	<br>&gt; <br>&gt; mattock_ 22.26.54<br=
>&gt; good night!<br>&gt; or midday, or whatever 22.27.00<br>&gt; <br>&gt; =
------------------------------<br>&gt; <br>&gt; ---------------------------=
---------------------------------------------------<br>&gt; Keep yourself c=
onnected to Go Parallel: <br>&gt; TUNE You got it built. Now make it sing. =
Tune shows you how.<br>&gt; http://goparallel.sourceforge.net<br>&gt; <br>&=
gt; ------------------------------<br>&gt; <br>&gt; _______________________=
________________________<br>&gt; Openvpn-devel mailing list<br>&gt; Openvpn=
-devel@lists.sourceforge.net<br>&gt; https://lists.sourceforge.net/lists/li=
stinfo/openvpn-devel<br>&gt; <br>&gt; <br>&gt; End of Openvpn-devel Digest,=
 Vol 78, Issue 6<br>&gt; ********************************************<br></=
div></div> 		 	   		  </div></body>
</html>=

--_da811ac6-cf01-4074-9acb-3cdc1f82c4b5_--

