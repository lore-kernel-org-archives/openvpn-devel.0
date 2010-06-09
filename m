Message-ID: <4C0F89D5.6040603@...1147...>
Date: Wed, 09 Jun 2010 14:32:21 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <4BF14A59.2000200@...1369...>	<4C0E6EAB.3040304@...1369...>	<4C0F3F06.2030004@...1114...>
	<4C0F4620.7030100@...1369...>
In-Reply-To: <4C0F4620.7030100@...1369...>
Subject: Re: [Openvpn-devel] openvpn-2.1.0-r1: easy-rsa tools creates broken
 client CERTs unusable for TLS
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Martin Mokrejs <mmokrejs@...1369...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

Martin Mokrejs wrote:
> Hi,
>
> David Sommerseth wrote:
>=20=20=20
>> On 08/06/10 18:24, Martin Mokrejs wrote:
>>=20=20=20=20=20
>>> Hi,
>>>   I had a look into the original bug report I sent and the summary is t=
his:
>>> at some version openvpn implemented a more strict check for certificate
>>> values and if teh cjeck fails one yields "unsupported certificate purpo=
se"
>>> message.
>>>=20=20=20=20=20=20=20
>>>   I figured out that few more allowed values have to be included in the
>>> certificate so that openVPN does not complain anymore. Basically, the p=
atch
>>> synchronizes the current openVPN behavior with the easy-rsa/ tools.
>>>=20=20=20=20=20=20=20
>>>   Is it clearer now? I attached to the bugreport at Gentoo an older ver=
sion
>>> of the patch to hopefully help you better with understanding what I tri=
ed.
>>> What I believe should happen that somebody documents better what requir=
ements
>>> are for the server/client certifices in openVPN. The patch(es) show what
>>> fields you should describe in docs and some version of the patch be com=
mitted
>>> over easy-rsa/openssl.cf as well (or loosen the checks back in openVPN =
sources).
>>> Martin
>>>=20=20=20=20=20=20=20
>> Ahoj Martin,
>>
>> Thanks a lot for your patch and your investigations!  That is very much
>> appreciated!
>>
>> Your issues was discussed in the last developers meeting (Thu June 3rd)
>> and it is not clear to us why you experiences this problem.  I believe
>> Jan Just Keiser told that he had quite recently tested out easy-rsa-2.0
>> and he had no issues at all.
>>
>> I am also running a OpenVPN server on a Gentoo box, even though on this
>> box I'm using TinyCA, so it is not directly comparable.  Anyhow, the
>> X509v3 extensions are not that far away from what I do see easy-rsa-2.0
>> should normally set:
>>
>>         X509v3 extensions:
>>             X509v3 Basic Constraints:
>>                 CA:FALSE
>>             Netscape Cert Type:
>>                 SSL Client, S/MIME, Object Signing
>>
>> I do see however that you are having mentioned Netscape Cert Type in
>> your bug report.
>>
>> Could this be related to some trickery patches Gentoo does to OpenVPN or
>> OpenSSL?  Or that it is related to the OpenSSL version?
>>=20=20=20=20=20
>
> I have no idea what is patched on Gentoo and why, but I found lots of tho=
se
> "unsupported certificate purpose" reports through Google, with very few r=
eal
> answers. I don't believe it is Gentoo specific.
>
>
> On the client:
> I use net-misc/openvpn-2.1.0-r1, I see there are two patches applying to
> my systems (no IPv6 patch):
>         epatch "${FILESDIR}/${PN}-2.1_rc13-peercred.patch"
>         epatch "${FILESDIR}/${PN}-2.1_rc20-pkcs11.patch"
> I use dev-libs/openssl-0.9.8n.
>
> On the server:
> net-misc/openvpn-2.1.0-r1
> dev-libs/openssl-0.9.8n
>
>
>=20=20=20
>> Would you mind sharing your configuration files and information about
>> the OpenSSL version you are using?
>>=20=20=20=20=20
>
> The client and server configs are attached.
>
>
>=20=20=20
here's what I just did:

- downloaded openssl 0.9.8n
- ran
  ./config shared
  make
on it
- reconfigured openvpn 2.1.1 to make use of this version of openssl
- ran
  ./configure ...
  make clean
  make
on it

- set up a new CA + server cert + client server using umodified easy-rsa=20
2.0 scripts from the openvpn distro
- set up client and server config files pretty much like the ones attached

Result: Both server and client start without problems. I can even add
  remote-cert-tls client
to the server config and the thing still starts. In other words: I=20
cannot reproduce the bug.

When I took a closer look at the original Ubuntu bug report it suggests=20
that the original server cert was not built correctly:

May 17 14:33:20 vrapenec openvpn[21477]: ++ Certificate has key usage  0080,
expects 00a0
May 17 14:33:20 vrapenec openvpn[21477]: ++ Certificate has key usage  0080,
expects 0088
May 17 14:33:20 vrapenec openvpn[21477]: VERIFY KU ERROR

the key usage found (0080) is for a *client* certificate, not a server cert=
ificate.=20
The server certificate should eku '00a0' set, as the log file later on in t=
he bug report
shows.

Martin, can you
- use the stock easy-rsa scripts (i.e. not the ones from ubuntu)
- create a new CA and client server and server cert (build-ca, build-key=20
, build-key-server)
- rerun your test

If this still fails then Ubuntu may have added a patch that broke something.

cheers,

JJK

>>
>>=20=20=20=20=20
>>>> Hi,
>>>>
>>>> We discussed your bug report in last week's public IRC meeting:
>>>>
>>>> <http://thread.gmane.org/gmane.network.openvpn.devel/3748>
>>>>
>>>> In a nutshell, we had difficulties understanding what is required to
>>>> reproduce this bug. Unfortunately the discussion logs were lost so I
>>>> can't be any more specific. Would you like help us understand this iss=
ue
>>>> by chatting with our devs on #openvpn-devel@...1334...? Or
>>>> alternatively by sending mail to openvpn-devel mailinglist:
>>>>
>>>> <http://sourceforge.net/mail/?group_id=3D48978>
>>>>
>>>> All the best,
>>>>
>>>> -- Samuli Sepp=C3=A4nen Community Manager OpenVPN Technologies, Inc ir=
c freenode net: mattock=20
>>>>=20=20=20=20=20=20=20=20=20
>>>> Martin Mokrejs wrote:
>>>>=20=20=20=20=20=20=20=20=20
>>>>> Hi,
>>>>>   I think the easy-rsa/openssl.cnf file should be modified so thet cl=
ient
>>>>> CERTs would match current openVPN expectations. Please see my bug rep=
ort
>>>>> at http://bugs.gentoo.org/show_bug.cgi?id=3D320171 . For convenience,=
 I am
>>>>> attaching the patch here. Did I get it right what has to be done? Wou=
ld
>>>>> someone fix the HOWTO and FAQ documentation to describe the keyUsage
>>>>> fields and what is actually required for what? There is too many hit
>>>>>=20=20=20=20=20=20=20=20=20=20=20


