MIME-Version: 1.0
In-Reply-To: <20180824191654.GK997@...1296...>
References: <149619ba-265f-1a7a-6403-f99c6f4b7eac@...1227...>
 <f89c1cbd-4899-432a-5288-1055b5045318@...2080...>
 <20180824191654.GK997@...1296...>
From: Derek Zimmer <derek@...2095...>
Date: Sun, 26 Aug 2018 17:55:53 -0500
Message-ID: <CAJY0qZ+RSaUQZ28EMjkr0B5i-wT4ZG--YB6jsgBBiMKby2vh1A@...278...>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Cc: openvpn-devel@lists.sourceforge.net

There's always the option of not allowing encryption to be enabled
with compression enabled. This keeps things like using OpenVPN as
fancy proxy working without endangering the privacy VPN use-case.

This gives users the on/off switch and explicitly shows them that
encryption + compression is not safe (because they have to disable it
and get ugly cipher none warnings).

The idea about the extra command to allow compression with a warning
in the actual command itself also works well, as long as the logs
throw big ugly warnings.

JM2C,

Derek Zimmer
Chief Executive Officer
Open Source Technology Improvement Fund


On Fri, Aug 24, 2018 at 2:16 PM, Gert Doering <gert@...1296...> wrote:
> Hi,
>
> On Fri, Aug 24, 2018 at 04:31:44PM +0200, David Sommerseth wrote:
>> > Open Points:
>> >
>> > - Gert strongly thinks that some people might want to continue having
>> > full compression despite the risks. I think it is reasonable to expect
>> > them to add 'compress-direction full' and push "compress-direction full"
>> >  to the server configuration, so touching clients is not needed.
>>
>> I do disagree with Gert on this topic.  I think it is stupid to openly allow
>> people to shoot themselves in the foot, even if we tell them in clear text it
>> is stupid and kittens will die.  I can understand there are some use cases
>> where these risks doesn't matter, but in this case this is not a strong enough
>> argument to improve the overall situation for a clearly defined threat.
>
> You do not need to agree with me on this, you just need to accept this
> as a fact of life.  I will resist any change that removes useful
> functionality from the "swiss tool kit of VPN" side of OpenVPN just
> because users could "get it wrong".
>
> I'm fine with compromising on making this an explicit "expert mode" knob.
>
>> There are tons of blog posts on the interwebs which will get this wrong, no
>> matter how much we warn about it, and users will go "oh, this blog told me to
>> do so".
>
> We're not going to save the world, and I refuse crippling my tools because
> someone else is refusing to read the manual about "do not turn on expert
> mode if you do not know what this is for".
>
>
> Again: OpenVPN is much more versatile than "VPN for dummies, with
> no switches provided, because someone could get them wrong".  This is
> why I am interested in this project - the flexibility of OpenVPN to
> handle setups where more "basic" VPN projects hit their limits.
>
> [..]
>> Just look at the "bypass-dhcp" flag to --redirect-gateway is widely
>> found on many blog posts - including those you would thought had better
>> capacity to understand that DHCP flags in a routed tun setup does not make any
>> sense at all.  Yes, I am looking and pointing sharply at you Digital Ocean.
>> Yes, they even tell people to build a CA on a publicly available server
>> without even having the CA private key password protected (!).  And people
>> blindly tag along thinking they have a safe and cool setup.  Because it works!
>
> So we should remove X509 mode because people find bad instructions on
> how to run their CA on the web?
>
> See where your arguments lead?
>
> [..]
>> OpenVPN simply has too many users and use cases that we can consider the
>> usefulness of compression which  a smaller minority group of users really can
>> use safely.  There are too many who will do this wrong.
>
> I do not care.  Really.  If people enable an expert mode switch without
> reading a warning label, they get what they asked for *and this is the
> way it needs to be*.
>
> We're not removing root accounts and sudo from unix, just because people
> can be told to do "curl $somesite | sudo bash", no?
>
>
>> This swiss-army knife idea about OpenVPN is dangerous, because of the amount
>> of possible insecure configurations.  And we have already killed off and will
>> remove several options which are equally bad.  We no longer have --no-iv and
>> --key-method.  We will remove several insecure ciphers (and BF is definitely
>> quite fast on smaller hardware without any hardware acceleration support,
>> compared to AES-128-CBC - the same "swiss-knife" argument can be applied here
>> too to keep BF) ... and there will be more options too facing the same
>> destiny.  Just as a parallel, SSL libraries has kicked out MD5 support for
>> certificate signing, which surely could be used safely in closed laboratory
>> networks where this kind of security issues does not apply.  You can find
>> millions of reasons why to keep a specific feature you care for, if you just
>> dig long enough.  But it does not necessarily give any valid reasons why to
>> keep it.
>
> Changing ciphers and hash algorithms does not really take functionality away.
>
>
>> Therefore, my conclusion is:  We cannot keep a feature in OpenVPN which
>> benefits the few but puts the larger user base at risk due to bad configurations.
>>
>> Compression and encryption does not belong together.  Period.
>>
>> There is only one small tiny compromise I can be willing to consider:
>>
>>     ./configure --enable-insecure-and-risky-voracle-attack-vector \
>>                 --enable-yes-I-really-know-what-I-am-doing
>
>
> No, because this is silly.   By your own argument, people are not expected
> to compile openvpn nowadays ("this is what distribution maintainers will
> do for you"), and we're *removing* #ifdefs, not adding new ones.
>
>
> I'm not here to protect users that are unwilling to read documentation.
>
> I'm here to build and maintain a versatile VPN solution that can do
> everything that more dumbed down software can not do.
>
> gert
> --
> "If was one thing all people took for granted, was conviction that if you
>  feed honest figures into a computer, honest figures come out. Never doubted
>  it myself till I met a computer with a sense of humor."
>                              Robert A. Heinlein, The Moon is a Harsh Mistress
>
> Gert Doering - Munich, Germany                             gert@...1296...
>
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

