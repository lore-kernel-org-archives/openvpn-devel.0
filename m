Message-ID: <53579A7B.2040505@...1435...>
Date: Wed, 23 Apr 2014 12:48:27 +0200
From: Steffan Karger <steffan.karger@...1435...>
MIME-Version: 1.0
References: <1393370880-28553-1-git-send-email-steffan@...1856...>
	<1393370880-28553-3-git-send-email-steffan@...1856...>
	<53579122.1090200@...1227...>
In-Reply-To: <53579122.1090200@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 2/2] Add an elliptic curve testing cert
 chain to the sample keys
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

On 04/23/2014 12:08 PM, Arne Schwabe wrote:
> ACK.

Thanks for reviewing. Yesterday evening I've been reworking these
patches a bit however. I want to have three things resolved:
1) PolarSSL 1.3 is already in master, and supports elliptic curve
crypto, so the --show-curves and --ecdh-curve options need to be
implemented for polarssl too.
2) Some distro's (notably, RHEL) ship without EC in openssl, so I needed
to add a number of #ifdefs to deal with that.
3) While I'm at it, improve the error reporting a bit.

I expect to send out reworked patches later this week.

> I don't think that adding sample keys is a good idea. Having a script
> which generates sample dummy key is probably a much better idea. I am
> acking this on the basis that we do the same stuff for RSA.

I agree. Let's do that in a separate patch set.

-Steffan


