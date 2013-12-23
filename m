Message-ID: <52B79339.2040202@...1800...>
Date: Sun, 22 Dec 2013 20:34:49 -0500
From: Mike Tancsa <mike@...1800...>
MIME-Version: 1.0
References: <l8qvsn$jif$1@...1062...>
In-Reply-To: <l8qvsn$jif$1@...1062...>
Subject: Re: [Openvpn-devel] Easy-RSA v3 release planning
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Josh Cepek <josh.cepek@...1085...>, openvpn-devel@lists.sourceforge.net

On 12/17/2013 9:05 PM, Josh Cepek wrote:
> Here's an update about Easy-RSA v3 in case there were any
> lingering contributions or ideas. At this point, the notable thing
> missing compared to the 2.x-series is PKCS#11 support. My thought
> here is that it should either have universal support for both
> Windows and *nix platforms or be exposed as distro-centric
> additions. I'd rather see a pkcs11 frontend script that is targeted
> to each platform, and envision this as a 3.1 release target 
> feature.

Hi,
Its been a while since I tried / checked, but is there any support for
generating keys on an actual hardware token in Windows ?
Specifically, it would be great if I could do this with the
Safenet/Aladin java etoken.

I can do it on Unix using the older non java version keys, but I never
quite figured out how to do it in Windows, and there is no Java etoken
support that I have found on FreeBSD as it requires pkcs15 via OpenSC.

	---Mike

-- 
-------------------
Mike Tancsa, tel +1 519 651 3400
Sentex Communications, mike@...1800...
Providing Internet services since 1994 www.sentex.net
Cambridge, Ontario Canada   http://www.tancsa.com/

