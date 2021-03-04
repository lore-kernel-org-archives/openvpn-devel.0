References: <20200907161849.20508-1-arne@...1227...>
 <0a95b96c-1849-4b8a-fba8-a398d452e8c3@...2080...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <0cc639f6-64f4-5c21-622c-cfa0302f5601@...1227...>
Date: Fri, 5 Mar 2021 00:14:38 +0100
MIME-Version: 1.0
In-Reply-To: <0a95b96c-1849-4b8a-fba8-a398d452e8c3@...2080...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH] Ignore --cipher for cipher negotiation
 in server client mode
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: David Sommerseth <openvpn@...2080...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

> 
> Ignoring --cipher in a future release will have quite a higher
> probability of breaking existing configurations.  Now, this is set in
> context of --data-ciphers, which is very different code wise.  But the
> code for --ciphers is essentially the same as --data-ciphers-fallback.

It is not the same. After this change the following will happen:

--cipher sets *ONLY* the OCC cipher that we announce during the
handshake and give a cipher that it is being ignored.

--data-cipher-fallback sets the OCC cipher that we announcer *AND*
determines what cipher to use if and only the other side does not
announce any cipher.

> I am therefore of the opinion, based on the prior --udp-mtu discussion,
> that --ciphers should be an alias to --data-ciphers-fallback.
> 
> In addition, since adding a warning about using the deprecated --udp-mtu
> option and put up a plan for removing it was also considered too much, I
> don't see why that argument would be much different with --ciphers.

I think again the difference here is that we want to change what the
cipher directives and I think we can agree on:

- data-ciphers-fallback behaviour that is only useful for 2.3 and
earlier clients with --enable-small does not need to be turned on by
default anymore in 2.6. It is already turned off by default in 2.5 if
you have no '--cipher' in your config.

The --data-ciphers-fallback option is an option that allows you to
workaround these situations where the fallback is needed. We should keep
it as is.

Going forward we need:

A way that sets the cipher that will be announced in OCC to keep older
(everything 2.4 and below) happy, especially servers/clients that have
occ strict enabled.

Making --cipher only setting the OCC cipher allows us to be compatible
in this as long server/client are 2.4+ as these will negotiate to
AES-256-GCM.

One thing that we could discuss is if --cipher should add itself to
data-ciphers. But if it does we need another switch/option that disables
that behaviour again. Otherwise there is no way of migrating (in the
sense of not allowing) the cipher used by --cipher.

So in summary the options do a combination from:

a) set the occ cipher
b) set the fallback cipher when the peer is a non-OCC openvpn version
c) add themselves to data-ciphers

Currently in 2.5:

no '--cipher' in config: a) with BF-CBC

--cipher xyz in config a), b) and c) if not in --data-ciphers
                       a) but not b) when in --data-ciphers

--data-ciphers-fallback a), b) but not c)

Basically the idea was that when you ensured that data-ciphers is
correct or data-ciphers-fallback was used, you already configured the
config with the new NCP in mind.

My proposal for 2.6:

--cipher just does a)
--data-ciphers-fallback does a) and b)


