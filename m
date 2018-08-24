Reply-To: openvpn-devel@lists.sourceforge.net
References: <149619ba-265f-1a7a-6403-f99c6f4b7eac@...1227...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <f89c1cbd-4899-432a-5288-1055b5045318@...2080...>
Date: Fri, 24 Aug 2018 16:31:44 +0200
MIME-Version: 1.0
In-Reply-To: <149619ba-265f-1a7a-6403-f99c6f4b7eac@...1227...>
Content-Language: en-GB
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
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On 24/08/18 13:11, Arne Schwabe wrote:
> Hey,
[...snip...]
> - Introduce compress-direction asym|full This will control if we
> actively try to compress or just allow receiving of compressed packets

I'm not sold on this one at all.

> - change the default mode to be asymmetrical.

Agreed.  Local side sends uncompressed data always, but can receive compressed
data if the remote side does send it compressed.  This is the best way to
achieve backwards compatibility during a migration phase.  At some point in
the future, we should also remove compression support completely (we can keep
the framing support, but never do compression)

> - If compress-direction is missing from the config but comp-lzo/compress
> are present inform the user "WARN: Compression mode set to assymetrical
> to avoid VORACLE like attacks. See the man page on compress-direction
> for more details".

If compression is enabled with --comp-lzo {yes,adaptive} or --compress
{lzo,lz4} (or rather non-empty string), such a warning is definitely appropriate.

> Open Points:
> 
> - Gert strongly thinks that some people might want to continue having
> full compression despite the risks. I think it is reasonable to expect
> them to add 'compress-direction full' and push "compress-direction full"
>  to the server configuration, so touching clients is not needed.

I do disagree with Gert on this topic.  I think it is stupid to openly allow
people to shoot themselves in the foot, even if we tell them in clear text it
is stupid and kittens will die.  I can understand there are some use cases
where these risks doesn't matter, but in this case this is not a strong enough
argument to improve the overall situation for a clearly defined threat.

There are tons of blog posts on the interwebs which will get this wrong, no
matter how much we warn about it, and users will go "oh, this blog told me to
do so".  Just look at the "bypass-dhcp" flag to --redirect-gateway is widely
found on many blog posts - including those you would thought had better
capacity to understand that DHCP flags in a routed tun setup does not make any
sense at all.  Yes, I am looking and pointing sharply at you Digital Ocean.
Yes, they even tell people to build a CA on a publicly available server
without even having the CA private key password protected (!).  And people
blindly tag along thinking they have a safe and cool setup.  Because it works!

Ignoring the fact that simply too many bloggers are generally too stupid to
understand what they write about and that Google etc are too good at finding
these blogs just tells me that NOT killing compression support will simply not
resolve the VORACLE issue in the long run.  Yes, we can say "But we warned you
about it".  But that's simply not good enough for me, it doesn't secure
OpenVPN in reality - WE put the gun at their feet.  It's not a question "if"
but "when" blog posts will appear saying "setting this option boosted my
speedtest from 10Mbit/s to 300Mbit/s despite my DSL link being 15Mbit/s.
OpenVPN is soooo coool!".  Because security is boring and annoying - and what
is even more boring is to try to understand why such results are completely
bogus. (I encourage anyone not believing me to hang out for a longer time on
the #openvpn irc channel).

OpenVPN simply has too many users and use cases that we can consider the
usefulness of compression which  a smaller minority group of users really can
use safely.  There are too many who will do this wrong.

This swiss-army knife idea about OpenVPN is dangerous, because of the amount
of possible insecure configurations.  And we have already killed off and will
remove several options which are equally bad.  We no longer have --no-iv and
--key-method.  We will remove several insecure ciphers (and BF is definitely
quite fast on smaller hardware without any hardware acceleration support,
compared to AES-128-CBC - the same "swiss-knife" argument can be applied here
too to keep BF) ... and there will be more options too facing the same
destiny.  Just as a parallel, SSL libraries has kicked out MD5 support for
certificate signing, which surely could be used safely in closed laboratory
networks where this kind of security issues does not apply.  You can find
millions of reasons why to keep a specific feature you care for, if you just
dig long enough.  But it does not necessarily give any valid reasons why to
keep it.

Therefore, my conclusion is:  We cannot keep a feature in OpenVPN which
benefits the few but puts the larger user base at risk due to bad configurations.

Compression and encryption does not belong together.  Period.

There is only one small tiny compromise I can be willing to consider:

    ./configure --enable-insecure-and-risky-voracle-attack-vector \
                --enable-yes-I-really-know-what-I-am-doing

where both is really needed and will put annoying messages in the log file -
preferably on each initiated connection.  But if I see any distribution at all
enabling this by default ... then this opening goes away.

Default behaviour should be: Never send compressed packets but accept
compressed packets from the remote - until we can finally just whack sending
compressed packets too in a further future release.


-- 
kind regards,

David Sommerseth
OpenVPN Inc


