References: <149619ba-265f-1a7a-6403-f99c6f4b7eac@...1227...>
 <f89c1cbd-4899-432a-5288-1055b5045318@...2080...>
 <20180824191654.GK997@...1296...>
 <a94f7c1d-9d84-477c-0c0c-cc10ba589186@...2080...>
From: Jan Just Keijser <janjust@...1147...>
Message-ID: <db32e7b7-9c8c-6913-eb28-973f3275ec66@...1147...>
Date: Wed, 29 Aug 2018 17:18:23 +0200
MIME-Version: 1.0
In-Reply-To: <a94f7c1d-9d84-477c-0c0c-cc10ba589186@...2080...>
Content-Language: nl-NL
Subject: Re: [Openvpn-devel] Discussion: Moving forward with compression and
 voracle
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net, David Sommerseth <openvpn@...2080...>, Gert Doering <gert@...1296...>

On 27/08/18 14:46, David Sommerseth wrote:
> On 24/08/18 21:16, Gert Doering wrote:
>> You do not need to agree with me on this, you just need to accept this
>> as a fact of life.  I will resist any change that removes useful
>> functionality from the "swiss tool kit of VPN" side of OpenVPN just
>> because users could "get it wrong".
> The only thing I am willing to agree to here, is that we have very differ=
ent
> views of how to ensure OpenVPN provides a secure VPN solution and how to
> achieve that goal.
>
>  From my point of view, in the moment a VPN is susceptible to not provide=
 a
> solid protection of a connections content, it is no longer a Virtual _Pri=
vate_
> Network.  It is just a virtual network.  And that is an entirely different
> product.
>
> I'm not going to argue the other points of yours, as I do not see this le=
ading
> this discussion forward.  I just disagree with your point of view and thi=
nk
> they do not move OpenVPN in the right direction of the security requireme=
nts
> of the 21th century.  My stance is clear: Compression and encryption does=
 not
> belong together.
I don't think anyone disagrees with you taht compression+encryption is=20
unsafe. However, the dangers or compression+encryption are overstated,=20
IMHO.
However, I happen to agree with Gert that OpenVPN is a Swiss army knife=20
VPN toolbox, and if one of those tools makes a user's VPN unsafe, then=20
so be it.=A0=A0 I have good use for disabling encryption in a VPN tunnel - =

fully well knowing that it makes things unsafe. I may be warned about=20
this, but if a tool prohibits me from doing something stupid then it is=20
IMO a bad tool.

>> No, because this is silly.   By your own argument, people are not expect=
ed
>> to compile openvpn nowadays ("this is what distribution maintainers will
>> do for you"), and we're *removing* #ifdefs, not adding new ones.
> Wrong.  We have those #ifdefs already, it just needs to be reverted and a=
dd an
> additional logic in configure.ac to "unlock" unsafe features.  Look for
> ENABLE_LZO and ENABLE_LZ4 in the code.
>
> And I still believe features which enables known attack vectors mandates
> compile time configuration.  Those sites really requiring this feature sh=
ould
> be capable of rolling their own builds.
>
> Further, some metrics would be good to have in this discussion as well:
>
>   - How efficient is compression on today's tunnels? Both in special use =
case
>     scenarios as well as the more common and average use cases.
>
>   - How many sites demands and depends on compression, where their use ca=
se
>     really results in a noticeable results with compression?
>
> This kind of metrics is the only thing which truly can make me reconsider=
 my
> view.  And it needs to be a considerable amount of use cases, as it is wa=
ste
> of time and energy to keep specific features alive if there is just 2-3% =
of
> the user base really needing and requiring it - especially when the risk =
for
> weakened security for the 97-98% of users is considerably higher.
These are interesting metrics - and I suspect that for more users=20
compression does more harm than good in terms of performance. However, I=20
do not think it is up to the developers (you/we) to decide whether a=20
user can enable encryption or not.

> But, there is one aspect we have not touched.  Things are moving forward =
with
> the transport plug-in patches, even though the primary goal currently is =
to
> handle obfuscation.  It should be investigated whether compression can be=
 put
> in as part of this plug-in API.  This means you can have your compression
> feature and the core of OpenVPN itself can be without compression.  I wil=
l not
> object to such an approach.
>
A transport plugin to handle encryption/obfuscation would work, I guess,=20
but then you run into the problem of running OpenVPN with "safe" or=20
"unsafe" plugins - should we warn users about that? prohibit it?=A0 Again, =

I would not like a tool that prohibits me from doing stupid : that's the=20
whole Unix/Linux philosophy I guess. Since when can I not type in
 =A0 rm -rf /
any more ?=A0 did someone build in a flag into the "rm" command to stop me =

from doing so? I sure hope not.

JM2CW,

JJK



