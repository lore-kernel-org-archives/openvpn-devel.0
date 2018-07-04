References: <DM5PR2101MB1112D9B5D70AC19014BC5BEDB0420@...2412...>
 <MW2PR2101MB09219BB9BA77ADD409D3DFECAB410@...2433...>
 <MW2PR2101MB0921EB014B7B72E679386A98AB410@...2433...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <38c08cf3-23d0-9f73-f333-f4121241cc17@...1435...>
Date: Wed, 4 Jul 2018 12:32:42 +0200
MIME-Version: 1.0
In-Reply-To: <MW2PR2101MB0921EB014B7B72E679386A98AB410@...2433...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] Upstreaming pqcrypto changes from
 microsoft/openvpn
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi Kevin,

On 04-07-18 02:39, Kevin Kane via Openvpn-devel wrote:
> Thanks to Jon for making the introduction. My team works on
> post-quantum (PQ) cryptography, which is algorithms used by regular
> computers but which are resistant to attack by a sufficiently
> powerful quantum computer. This OpenVPN fork is an example
> application we released so the public could experiment with it.
> 
> The following sites have information on what we're doing:
> 
> Our openvpn, openvpn-build, and openvpn-gui forks are subprojects of
> the following repo: https://github.com/Microsoft/PQCrypto-VPN
> 
> I just realized there are no back-pointers from the subprojects back
> to the main repo. I've just corrected that.
> 
> On this site are scripts and instructions for doing our custom build
> of OpenVPN for Windows and Linux, to use the PQ crypto-enabled fork
> of OpenSSL we use, and how to properly configure it for PQ crypto. We
> also provide instructions for building an image for a Raspberry Pi to
> be used as a wifi access point that tunnels all traffic to a remote
> server protected by PQ key exchange. We also have released pre-built
> Linux x64 and Windows binaries. Our current build process works but
> there is plenty of room for improvement.
> 
> A more in-depth description of the PQ VPN is here:
> https://www.microsoft.com/en-us/research/project/post-quantum-crypto-vpn/
>
>  And our introduction to post-quantum cryptography overall is here:
> https://www.microsoft.com/en-us/research/project/post-quantum-cryptography/
>
>  As Jon said, these algorithms are experimental and so it would be
> inappropriate to introduce them into production code until the
> standardization and thorough analysis by the cryptographic community
> are completed. When that happens, we want to be ready to quickly
> integrate these algorithms into existing software. My colleagues are
> already contributing to a PQ crypto-enabled fork of OpenSSL
> (https://github.com/open-quantum-safe/openssl), and similarly we
> believe there is value in maintaining a PQ-enabled fork of OpenVPN,
> so that both are ready when there is consensus on a standard.
> 
> I will be updating the fork to track the forward progress of both the
> PQ-enabled OpenSSL fork and OpenVPN as time allows, but I welcome the
> participation of anyone who's interested in helping with the updates
> or making other improvements, as well as any suggestions you may have
> on future directions for this work.

That's cool, and nice to see you sharing your results.  I agree that
this is experimental.  It definitely has it's purpose, but should not be
integrated into the stable product until there are standards and IETF
codepoints.

We (Fox-IT) have been working on post-quantum crypto for OpenVPN too.
Our approach is different: add a post-quantum key exchange (the very
conservative Classic McEliece) to the OpenVPN key exchange.  Since that
happens over the TLS channel, we have more freedom to use this
conservative key exchange which has quite large pubkeys.  We
collaborated on this with the author of
http://essay.utwente.nl/70677/1/2016-08-09%20MSc%20Thesis%20Simon%20de%20Vries%20final%20color.pdf.

We are planning to integrate this into OpenVPN-NL (which we maintain),
but are not sure if this will ever make upstream.

The long-term path for OpenVPN itself is likely that we will support the
post-quantum methods that our crypto backends implement, and leave the
real crypto to the backend (as we always have).

In any case, we're always interested to hear about new PQ initiatives
and experiments :)

-Steffan

