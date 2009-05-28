Date: Thu, 28 May 2009 13:26:18 +0400
From: Victor Wagner <vitus@...1066...>
Message-ID: <20090528092618.GA31165@...1066...>
References: <f9615cc80905271048v646f546fod19ecec32c2a172a@...278...>
	<20090528055401.GB24851@...1066...>
	<f9615cc80905272317pa53b833vbe66477de31537b9@...278...>
MIME-Version: 1.0
In-Reply-To: <f9615cc80905272317pa53b833vbe66477de31537b9@...278...>
Subject: Re: [Openvpn-devel] Unable to use -OFB or -CFB ciphers in OpenVPN
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On 2009.05.27 at 23:17:39 -0700, Frank Yellin wrote:

>    [Just to you, not the list.]
>    I figured that someone had to have noticed this problem before.  But
>    when I googled "OpenVPN BF-OFB"  or  "OpenVPN BF-CFB", I couldn't find
>    anything.

Of course you haven't find anything about Blowfish cipher. 
If you ask about GOST 28147-89, you might be more lucky.

Really, mentioned GOST (Russian State Standard) doesn't specify CBC mode
at all. It specifies CNT (gammirovanie) and CFB (gammirovanie s obrantoy
sv'az'u).  RFC 4357 does add CBC mode for GOST, but RFC is just "request
for comments", and if I want to deploy OpenVPN in some Russian goverment
organization, they would ask for national standard ciphers, not for RFC
compliant. So, gost-cbc wasn't added to OpenSSL 1.0 while CFB (named
gost89) and gost-cnt were.

So, when adding GOST support into OpenVPN (really, that means support
for GOST ciphers and TLS ciphersuides, if underlying OpenSSL supports them)
I have to use CFB.


>    This bug is particularly strange because just before the bug, there is
>    code that's supposed to deal with -CFB and -OFB mode.  But then it
>    doesn't do anything.  It almost feels like this code was never tested.

It seems so. We haven't yet investigated all problems we encountered
with openvpn + gost CFB. Some of our problems was rather related with
oldish TUN driver for Solaris (which are hopefully solved). And we have
a lot of other OpenSSL-based applications besides OpenVPN to test.

>    I didn't have any trouble with my brief tests using BF-CFB over UDP,

I'll note it. May be we should add this cipher into our test suite to
isolate CFB-related problem from problems with dynamically loadable
engines (GOST is implemented as engine) and problems with non-HMAC macs
(which required a lot more patching than CFB, because at the time
OpenVPN was designed, OpenSSL has no support form non-hmac MACs)

>    once I deleted the offending line.  But I wasn't trying anything
>    difficult.  Mainly just making sure the connection was there and that
>    it didn't die.

We typically do following:

1. Start the connection
2. Download some file from peer via HTTP (using wget)
3. Download another, bigger file, to be sure that key renegotiation
occur.

