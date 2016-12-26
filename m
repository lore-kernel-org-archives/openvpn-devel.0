MIME-Version: 1.0
In-Reply-To: <965a4c27-5e16-59a8-db9c-930f1216f22c@...1856...>
References: <1482079255-15159-1-git-send-email-steffan@...1856...>
	<20161218212659.GY78624@...1296...>
	<965a4c27-5e16-59a8-db9c-930f1216f22c@...1856...>
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Sun, 25 Dec 2016 22:18:49 -0500
Message-ID: <CAEsd45SxHOVk1PpsU-W8MUti1TmzYa7_BR1cAbUZ+mHxqfYEpg@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Use SHA256 for the internal digest,
 instead of MD5
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On Sun, Dec 25, 2016 at 6:20 PM, Steffan Karger <steffan@...1856...> wrote:
> Hi,
>
> On 18-12-16 22:26, Gert Doering wrote:
>> On Sun, Dec 18, 2016 at 05:40:55PM +0100, Steffan Karger wrote:
>>> Our internal options digest uses MD5 hashes to store the state, instead of
>>> storing the full options string.  There's nothing wrong with that, but it
>>> would still be better to use SHA256 because:
>>>  * That makes it easier to make OpenVPN "FIPS-compliant" (forbids MD5)
>>>  * We don't have to explain anymore that MD5 is fine too
>>>
>>> The slightly less bytes for the digest (16 instead of 32) and operations
>>> per connection setup are not worth sticking to MD5.
>>
>> I can't find very clear information on "which versions of OpenSSL do
>> support sha256", but since we have a trac ticket about our windows
>> builds having issues with sha256 certificates we might take this
>> opportunity to revisit minimum OpenSSL versions supported in master
>> from now on...
>
> The oldest OpenSSL we support in release/2.4 and master is 0.9.8, and
> has SHA256 support (was introduced in 2004).  Also, the --tls-crypt
> feature already unconditionally requires SHA256 to be available.

The OpenSSL included in macOS  (was OS X) 10.11 and 10.12 (the two
most recent versions) is 0.9.8zh (an Apple-patched version) and as far
as I can tell, it does not seem to include SHA256 (i.e., "openssl sha1
foo" works but "openssl sha256 foo" doesn't).

That's not a problem for Tunnelblick because Tunnelblick static-links
in a more recent version of OpenSSL. But it could be a problem for
anyone who uses a non-Tunnelblick OpenVPN binary from the command
line.

- Jon

