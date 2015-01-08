Message-ID: <54AEACA0.6030500@...1147...>
Date: Thu, 08 Jan 2015 17:13:20 +0100
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <20141208115202.GA4807@...2009...>
	<20141212165220.GA4575@...2009...>	<548B32D4.1060607@...1227...>
	<20150105102207.GA9055@...2009...>	<1420561439.29022.195.camel@...1866...>
	<20150106171923.GZ8134@...1296...>
In-Reply-To: <20150106171923.GZ8134@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Add Mac OS X keychain support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net, David Woodhouse <dwmw2@...1866...>, Anton Karpov <tokza@...2010...>

Hi *,

On 06/01/15 18:19, Gert Doering wrote:
> Hi,
>
> On Tue, Jan 06, 2015 at 04:23:59PM +0000, David Woodhouse wrote:
>> That is, after all, fairly much what PKCS#11 was *designed* to provide.
> Thanks for that hint.  Seems we (as in "the currently active developers")
> really need to look more closely into the gifts we inherited :-)
>
>> In fact, doesn't such an implementation already exist at
>> https://github.com/slushpupie/KeychainToken ?
> This looks quite promising :-)  (if a bit "dead", hope it still works)
>
when reading this thread I also thought of "that's what we have pkcs#11 
for" . However, a pkcs#11 interface is a clunky thing - we could also 
consider a different (longer-term) approach:

- create a higher level interface/plugin that allows OpenVPN to use an 
external certificate store
- this plugin/interface could then have implementations for
   + Microsoft CryptoAPI
   + Mac OS Keychain
   + PKCS#11
   + Linux keyring-like drivers (kwallet? gnome-keyring?)

- the plugin/interface should be able to offer most of what pkcs#11 
offers: key+cert storage, possibly offloading of certain 
encryption/decryption operations.

Writing a pkcs#11 shim that talks to the mac OS keychain, which itself 
can talk to pkcs#11 drivers seems a bit overkill to me. BTW, the same 
thing can be said about the MS CryptoAPI: there are pkcs#11 driver shims 
that utilize the Windows CryptoStore, which itself can use pkcs#11 
devices ...

JM2CW,

JJK


