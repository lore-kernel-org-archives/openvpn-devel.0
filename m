Message-ID: <50BC7FBC.6000605@...1147...>
Date: Mon, 03 Dec 2012 11:32:28 +0100
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <50B8A888.40109@...515...>
In-Reply-To: <50B8A888.40109@...515...>
Content-Type: multipart/alternative;
	boundary="------------000508060709070805090104"
Subject: Re: [Openvpn-devel] Summary of the IRC meeting (29th Nov 2012)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------000508060709070805090104
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi all,

Samuli Sepp=E4nen wrote:
> Hi,
>
> Here's the summary of the previous IRC meeting.
>
>
>=20=20=20
it's great to hear that the openvpn community is getting together again=20
at FOSDEM 2013 !
One small practial remark , however:  the train schedule between=20
Amsterdam en Brussels is about to change; the train andj and I took last=20
year no longer runs in 2013; instead you have to make a reservation for=20
a new *faster* train , the Fyra. If somebody is interested in taking=20
this route (Amsterdam/Schiphol -> Brussels)  then contact me for details.


And it's great to hear that an iOS client is forthcoming - people have=20
been pestering me about that for ages!

cheers,

JJK


> COMMUNITY MEETING
>
> Place: #openvpn-devel on irc.freenode.net
> Date: Thursday 29th Nov 2012
> Time: 18:00 UTC
>
> Planned meeting topics for this meeting were on this page:
>
> <https://community.openvpn.net/openvpn/wiki/Topics-2012-11-29>
>
> Next meeting will be announced in advance, but will probably be on the sa=
me
> weekday and at the same time. Your local meeting time is easy to check
> from services such as
>
> <http://www.timeanddate.com/worldclock>
>
> or with
>
> $ date -u
>
>
> SUMMARY
>
> cron2, dazo, ecrist, krzee, jamesyonan, mattock, novaflash, plaisthos,
> raidz and swg0101 participated in this meeting.
>
> --
>
> Started the meeting with short round of introductions. Some were not
> formally introduced, but are included here. On the community side:
>
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
>
> On the company side:
>
> - jamesyonan: Father of OpenVPN (United States/Colorado)
> - mattock: Community manager, server administrator, does OSS releases,
> testing, etc. (Finland)
> - novaflash: Support technician (Netherlands)
> - raidz: Support engineer, network engineer, and janitor (United
> States/California)
> - swg0101: Support and development (United States)
>
> A few non-participants were also mentioned:
>
> - andj: Added polarssl support to openvpn and is maintaining that part
> (Netherlands)
> - juanjo: The other IPv6 guy who we seldom see (from where?)
>
> ---
>
> Jamesyonan gave a short introduction of the new C++ codebase:
>
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
>
> Some more technical tidbits:
>
> - core leverages on Boost Asio as it's async i/o layer
> - C++ is really ready for prime time in system programming / networking
> space
> - C++ 2003 that's used seems to work very well on different compilers
> - C++ static polymorphism (templates) is great for network programming
> where we have small objects that have polymorphic properties, such as
> IPv4 vs IPv6 addresses
>
> ---
>
> Discussed open sourcing the C++ codebase:
>
> According to jamesyonan, the plan is to release this probably under GPL
> within the next couple months, but the company needs the ability to
> relicense the C++ core because of (Apple) app store issues. It was
> agreed that having OpenVPN on that platform is a must. To accomplish
> this, relicensing the codebase is necessary. The consensus was that this
> can be done in a way that's acceptable to all parties, without resorting
> to the classic "copyright handover" scheme, which was not ok for everyone.
>
> The alternative would be to release the C++ codebase under a permissive
> license (e.g. BSD), but that would allow companies such as Apple or
> Microsoft to "steal" it. This was not seen as a good option, either.
>
> ---
>
> Discussed the role of OpenVPN 2.3 within the company:
>
> The company is planning to migrate the Access Server to OpenVPN 2.3*.
> Before the meeting mattock had already managed to get the Access Server
> running with OpenVPN-2.3-rc1 in a few hours, with only few minor
> modifications. Tests run by raidz during the meeting revealed no further
> issues. More details will follow later.
>
> ---
>
> Discussed having a joint company/community meeting in FOSDEM
> (https://fosdem.org/2013). Most of the present developers seem to be
> coming, but nobody has dared book the flights or hotel yet.
>
> ---
>
> Decided to arrange a second meeting next Thursday at the same time. The
> meeting will focus on helping James move to 2.3 and Git (from 2.1.x and
> SVN).
>
> ---
>
> Full chatlog as an attachment
>
>=20=20=20
> ------------------------------------------------------------------------
>
> -------------------------------------------------------------------------=
-----
> Keep yourself connected to Go Parallel:=20
> TUNE You got it built. Now make it sing. Tune shows you how.
> http://goparallel.sourceforge.net
> ------------------------------------------------------------------------
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel


--------------000508060709070805090104
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Hi all,<br>
<br>
Samuli Sepp&auml;nen wrote:
<blockquote cite="mid:50B8A888.40109@...515..." type="cite">
  <pre wrap="">Hi,

Here's the summary of the previous IRC meeting.


  </pre>
</blockquote>
it's great to hear that the openvpn community is getting together again
at FOSDEM 2013 !<br>
One small practial remark , however:&nbsp; the train schedule between
Amsterdam en Brussels is about to change; the train andj and I took
last year no longer runs in 2013; instead you have to make a
reservation for a new *faster* train , the Fyra. If somebody is
interested in taking this route (Amsterdam/Schiphol -&gt; Brussels)&nbsp;
then contact me for details.<br>
<br>
<br>
And it's great to hear that an iOS client is forthcoming - people have
been pestering me about that for ages!<br>
<br>
cheers,<br>
<br>
JJK<br>
<br>
<br>
<blockquote cite="mid:50B8A888.40109@...515..." type="cite">
  <pre wrap="">COMMUNITY MEETING

Place: #openvpn-devel on irc.freenode.net
Date: Thursday 29th Nov 2012
Time: 18:00 UTC

Planned meeting topics for this meeting were on this page:

<a class="moz-txt-link-rfc2396E" href="https://community.openvpn.net/openvpn/wiki/Topics-2012-11-29">&lt;https://community.openvpn.net/openvpn/wiki/Topics-2012-11-29&gt;</a>

Next meeting will be announced in advance, but will probably be on the same
weekday and at the same time. Your local meeting time is easy to check
from services such as

<a class="moz-txt-link-rfc2396E" href="http://www.timeanddate.com/worldclock">&lt;http://www.timeanddate.com/worldclock&gt;</a>

or with

$ date -u


SUMMARY

cron2, dazo, ecrist, krzee, jamesyonan, mattock, novaflash, plaisthos,
raidz and swg0101 participated in this meeting.

--

Started the meeting with short round of introductions. Some were not
formally introduced, but are included here. On the community side:

- cron2: The OpenVPN IPv6+BSD+Solaris developer, buildbot farmer (Germany)
- dazo:  master of plugins and git, does patch management, cleanups and
lots of other good work (Norway)
- d12fk: develops the new openvpn-gui for Windows (Germany)
- ecrist: takes care of forums, easy-rsa maintenance, #openvpn channel,
etc. (Unites States)
- krzee: takes care of the forums and IRC with ecrist; a mystical figure
(somewhere in the Caribbean)
- plaisthos: did the Android port; in charge of overhauling the socket.c
code (Germany)

On the company side:

- jamesyonan: Father of OpenVPN (United States/Colorado)
- mattock: Community manager, server administrator, does OSS releases,
testing, etc. (Finland)
- novaflash: Support technician (Netherlands)
- raidz: Support engineer, network engineer, and janitor (United
States/California)
- swg0101: Support and development (United States)

A few non-participants were also mentioned:

- andj: Added polarssl support to openvpn and is maintaining that part
(Netherlands)
- juanjo: The other IPv6 guy who we seldom see (from where?)

---

Jamesyonan gave a short introduction of the new C++ codebase:

- about 30K lines of C++ code
- an object-oriented rethinking of openvpn from the ground up
- design similar to original OpenVPN 3.0:
<a class="moz-txt-link-rfc2396E" href="http://community.openvpn.net/openvpn/wiki/RoadMap">&lt;http://community.openvpn.net/openvpn/wiki/RoadMap&gt;</a>
- is very modular in the sense that SSL/crypto libraries, transport
protocols, etc. can be modularized
- fairly prototypical/incomplete at this stage; only the client-side has
been implemented
- has been tested against Access Server (based on OpenVPN 2.1.x) and
OpenVPN 2.3* servers
- is 100% protocol compatible with 2.x branches
- has most 2.x's options
- is being used in the OpenVPN tech android client and the upcoming iOS
client
- may (at some point) supplant the 2.x branch, but that'll probably take
at least 1-2 years

Some more technical tidbits:

- core leverages on Boost Asio as it's async i/o layer
- C++ is really ready for prime time in system programming / networking
space
- C++ 2003 that's used seems to work very well on different compilers
- C++ static polymorphism (templates) is great for network programming
where we have small objects that have polymorphic properties, such as
IPv4 vs IPv6 addresses

---

Discussed open sourcing the C++ codebase:

According to jamesyonan, the plan is to release this probably under GPL
within the next couple months, but the company needs the ability to
relicense the C++ core because of (Apple) app store issues. It was
agreed that having OpenVPN on that platform is a must. To accomplish
this, relicensing the codebase is necessary. The consensus was that this
can be done in a way that's acceptable to all parties, without resorting
to the classic "copyright handover" scheme, which was not ok for everyone.

The alternative would be to release the C++ codebase under a permissive
license (e.g. BSD), but that would allow companies such as Apple or
Microsoft to "steal" it. This was not seen as a good option, either.

---

Discussed the role of OpenVPN 2.3 within the company:

The company is planning to migrate the Access Server to OpenVPN 2.3*.
Before the meeting mattock had already managed to get the Access Server
running with OpenVPN-2.3-rc1 in a few hours, with only few minor
modifications. Tests run by raidz during the meeting revealed no further
issues. More details will follow later.

---

Discussed having a joint company/community meeting in FOSDEM
(<a class="moz-txt-link-freetext" href="https://fosdem.org/2013">https://fosdem.org/2013</a>). Most of the present developers seem to be
coming, but nobody has dared book the flights or hotel yet.

---

Decided to arrange a second meeting next Thursday at the same time. The
meeting will focus on helping James move to 2.3 and Git (from 2.1.x and
SVN).

---

Full chatlog as an attachment

  </pre>
  <pre wrap=""><pre wrap="">
<hr size="4" width="90%">
------------------------------------------------------------------------------
Keep yourself connected to Go Parallel: 
TUNE You got it built. Now make it sing. Tune shows you how.
<a class="moz-txt-link-freetext" href="http://goparallel.sourceforge.net">http://goparallel.sourceforge.net</a></pre><pre wrap="">
<hr size="4" width="90%">
_______________________________________________
Openvpn-devel mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@lists.sourceforge.net</a>
<a class="moz-txt-link-freetext" href="https://lists.sourceforge.net/lists/listinfo/openvpn-devel">https://lists.sourceforge.net/lists/listinfo/openvpn-devel</a>
</pre></pre>
</blockquote>
<br>
</body>
</html>

--------------000508060709070805090104--

