Message-ID: <5200CB9D.1020101@...1147...>
Date: Tue, 06 Aug 2013 12:10:37 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <kt8j7m$c5m$1@...1062...>
	<20130730145731.GW13127@...1152...>	<20130730151406.GQ16543@...1296...>	<51FA324F.1090108@...1147...>	<20130801143058.GM16543@...1296...>	<51FA79C6.1020405@...1147...>
	<51FEA1BF.9000905@...515...>	<A3805A26-5FA4-461D-88C3-45E018208FD7@...277...>
	<5200C76B.5030008@...1114...>
In-Reply-To: <5200C76B.5030008@...1114...>
Subject: Re: [Openvpn-devel] [Openvpn-users] why doesn't openvpn negotiate
 settings?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net
Cc: dan farmer <zenfish@...277...>, "openvpn-users@lists.sourceforge.net" <openvpn-users@lists.sourceforge.net>

Hi David,

nice answer, David, and thanks for promoting the book ;)

Your basic points are correct , of course:
- networking is hard
- security is hard

Configuring openvpn can be daunting at first, but it is not nearly as=20
bad as configuring PPTP , or - GASP! - IPSec+L2TP.
Documentation can help , of course, but to do things right will always=20
require work.
Also, each setup is unique: there are some default setups, of course,=20
most/some of which are covered in my cookbook, but after answering a lot=20
of questions on the mailing list and forums I've found that each=20
networking setup is unique and openvpn needs to be adjusted for it. I've=20
always found the flexibility of openvpn its true power - but with great=20
power (flexibility) comes great responsibility (about documenting things).

Dan also has a point however: we should watch out for introducing new=20
features that nobody really understands how to use or why you would use=20
them - the docs should be kept up to par with the features. My cookbook,=20
for example, does not cover any of the features found in 2.3 like IPv6 -=20
I hope I can write an update in the near future.=20
I was and am hoping that an auto-negotiate feature would improve the=20
usability of openvpn - if you can negotiate and or push more settings=20
from the server to the clients then the client configs can be as simple=20
as possible , which should reduce complexity.

JM2CW,

JJK



David Sommerseth wrote:
> On 05/08/13 19:52, dan farmer wrote:
>=20=20=20
>> To start with - I really, really appreciate the work that's gone into th=
e program.
>> I've released stuff myself, and it's not an easy process, especially for=
 something
>> as complex and with so much functionality as openvpn.  I get that.
>>
>> But from a user's perspective - anything that can make the horror known =
as=20
>> openvpn configuration easier would improve openvpn's adoption considerab=
ly.
>>
>> Here's a true tale.  I'm writing a little thing to use openvpn.  I'd lik=
e to think I know=20
>> networks a bit - more on the theory at times than implementation, but wh=
atever.
>>
>> OpenVPN ranks up there with pgp and openssh for the most fucked up and=20
>> mysterious configurations I've ever seen (it is not a coincidence that t=
hey're
>> all crypto programs, I believe.)  It is legendary among non-openvpn peop=
le to
>> be ridiculously difficult.   I'm actually pretty sure that if one is an =
openvpn person
>> who knows you're doing it's not that bad, or even makes some internal se=
nse.=20=20
>> But I'd wager that high-ninety% of your user base doesn't fall into that=
 camp.=20=20
>> Well, of your potential user base, that is, most don't get that far.
>>
>> I am not saying this to say "everything is fuxx3d up" or something.  I'm=
 telling
>> you because it took me a couple of days to get even the most basic thing=
 really
>> working on a not-terribly-complex setup.  And while I understand the con=
ceptual
>> matters of your program, honestly, I fear to set it up, and have little =
faith that even
>> if I get it running it'll do what I want it to.
>>
>> I'm not even complaining for myself - I'm a big guy, I can take care of =
myself,=20
>> and take it or leave it - but for others=85..
>>=20=20=20=20=20
>
> [...snip...]
>
> The documentation to OpenVPN might feel daunting, but it really isn't
> that bad if you just get started on the easy paths.  And if you really
> want a hand-held guide through setting up OpenVPN ... go grab this book:
>
> <http://www.packtpub.com/openvpn-2-cookbook/book>
>
> I'm not aiming this message against you, Dan, so please don't take it as
> an personal attack of any kind.
>
> The biggest problem, from my experience, isn't that people don't
> understand the official docs.  But they use external sources for setting
> up OpenVPN, like random blog or forum posts on sites not controlled by
> the OpenVPN community at all.  And really, in 99% of all those posts,
> they contradict each other or basically recommend completely clueless
> setups which are just plain wrong.  Why?  Because these writers often
> don't understand NETWORKING at all.
>
> First of all, if you want to setup any kind of VPN, you NEED to
> understand basic networking.  If your network experience is based on
> setting up a home router and you got it working, then you know NOTHING
> about networking.  Go read about how TCP/IP functions and at minimum
> learn the BASIC ROUTING.  Without that, you're going to get lost.
>
> Next, OpenVPN configurations are basically 2 parts.  It's the security
> part, which involves setting up security parameters (ciphers, keys, etc)
> and which host to connect to.  The other part is NETWORK ROUTING.  No
> matter what kind of VPN setup you configure, you must understand
> routing.  Then there is the more advanced parts, such as firewalling,
> MTU, fragmentation, and similar topics.
>
> Most people I've met on #openvpn, in this mailing lists and those times
> I've looked at our forum, they struggle with the latter.  Almost
> everyone manages to set up and configure OpenVPN server and clients and
> make them connect without much help at all (when having issues, it's
> mostly related to PKI setups).  They usually show up when their brand
> new OpenVPN setup doesn't pass traffic through their OpenVPN server or
> client.  Which really makes me repeat what I've said in the two past
> paragraphs: To setup VPN you MUST UNDERSTAND BASIC NETWORK ROUTING.  You
> say "briding"? I'll repeat: NETWORK ROUTING.  Really!
>
> And many of those who begin to struggle, seek help in various wikis,
> blogs and whatever else they find.  But the *minority* of these sources
> explains things correctly.  I think I've seen just a handful of those
> thousands of blogs which really makes sense.  Unfortunately, I've not
> indexed the good sources.
>
> At the end, I'll provide a few pointers which hopefully can help people
> solving their issues.
>
> * Learn about TCP/IP networking, read especially chapter 3.1 in this
> book: <http://www.redbooks.ibm.com/redbooks/pdfs/gg243376.pdf>.  I'll
> repeat: You MUST know how network traffic travels between hosts and route=
rs.
>
> * Then first configure a very simple OpenVPN setup, based on this HOWTO:
> <http://openvpn.net/index.php/open-source/documentation/miscellaneous/sta=
tic-key-mini-howto.html>
>
> Go through this one, step by step.
>
> * Use the man page as a companion and read about what each option used
> above does:
> <https://community.openvpn.net/openvpn/wiki/Openvpn23ManPage>
>
> * Extend the configuration above with a PKI setup (enhacned security):
> <http://openvpn.net/index.php/open-source/documentation/howto.html#pki>
>
> * Set up a reasonable routed network configuration with firewalling,
> based on this one:
> <https://community.openvpn.net/openvpn/wiki/BridgingAndRouting#Usingrouti=
ng>
>
>
> By going through these steps, I believe most users should be able to set
> up a working VPN.
>
> But it's a lot to learn, if you haven't done this before.  There are no
> shortcuts into setting up a VPN.  You simply must learn these basic
> steps.  The cookbook I mentioned in the beginning might make things
> easier to get started, but you still need to do some learning; at least
> when things doesn't work as expected.
>
>
>=20=20=20



