References: <33ef1f35-333c-cb25-bdbe-194f03e6ba4f@...515...>
From: Jan Just Keijser <janjust@...1147...>
Message-ID: <32d9790b-0dd3-e7db-5a29-120359d08400@...1147...>
Date: Wed, 24 Oct 2018 15:02:32 +0200
MIME-Version: 1.0
In-Reply-To: <33ef1f35-333c-cb25-bdbe-194f03e6ba4f@...515...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] Adding Google Analytics code to Trac?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"; format="flowed"
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

On 24/10/18 13:47, Samuli Sepp=E4nen wrote:
> Hi,
>
> The OpenVPN Inc. webmaster would like to add Google Analytics to
> community.openvpn.net, i.e. our Trac wiki/bug tracker. I said we need to
> consult the community first because GA can be seen as a form of spying.
> Here's our webmaster's view on this subject:
>
> ---
>
> "The goal of this would be to understand what information first-time
> users are finding the most valuable on community.openvpn.net."
>
> "As this is a publicly accessible community without the requirement to
> join to read the articles, it would be advantageous for all to
> understand which pieces of content the public are finding the most
> useful, what encourages them to become a part of the community, and what
> potentially persuaded them to use start using a commercial product."
>
> "As openvpn.net links to community.openvpn.net and vice versa this will
> also help us to understand the complete journey of a user and help to
> improve the website experience, which can only be seen as a positive."
>
> ---
>
> In today's community meeting there was some concern about the spying
> aspect of Google Analytics, but nobody was strongly opposed. This was I
> believe, in part, because it is fairly easy to block Google Analytics if
> one so wishes.
>
>
just make sure to remain GDPR compliant:

- update the privacy policy to CLEARLY state that you are doing this and wh=
y:
 =A0=A0=A0 What information is being collected?
 =A0=A0=A0 Who is collecting it?
 =A0=A0=A0 How is it collected?
 =A0=A0=A0 Why is it being collected?
 =A0=A0=A0 How will it be used?
 =A0=A0=A0 Who will it be shared with?
 =A0=A0=A0 What will be the effect of this on the individuals concerned?
 =A0=A0=A0 Is the intended use likely to cause individuals to object or com=
plain?
- this privacy policy must be presented to the user the first time {s}he ac=
cess Trac, asking for consent
- build an opt-in/opt-out mechanism
- honor a user's GDPR right to be "forgotten" ie offer the ability to remov=
e my data whenever I request it.

Having said that, my browser always blocks GA so you'll learn nothing from =
me ;)

but in short: do you REALLY want to go through all that trouble just to col=
lect some lousy statistics?

Even shorter answer: I strongly oppose adding GA and might/will refrain fro=
m using OpenVPN Trac as a result.

JM2CW,

JJK



