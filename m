Message-ID: <55890A3E.4010200@...1856...>
Date: Tue, 23 Jun 2015 09:26:54 +0200
From: Steffan Karger <steffan@...1856...>
MIME-Version: 1.0
References: <55882EBE.9030503@...1147...> <55887C2D.6080203@...1490...>
In-Reply-To: <55887C2D.6080203@...1490...>
Subject: Re: [Openvpn-devel] about client-cert-not-required
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On 22-06-15 23:20, Jason Haar wrote:
> On 23/06/15 03:50, Jan Just Keijser wrote:
>> 1) do we think it's valuable to add something like this (currently NO 
>> cert checks are done when 'client-cert-not-required' is used) ?
> 
> sounds like what you really want is for this to be renamed
> "--verify-client-cert (none|optional|required)" - with the
> default still being "required" of course - sort of like Apache's
> SSLVerifyClient

This makes sense to me.  I agree that the current
client-cert-not-required behaviour is error-prone.  But I am reluctant
to break setups that rely on this behaviour by changing
client-cert-not-required.  Jason's proposal gives us a nice way to deal
with this:

In 2.3:
 * Add soon-to-be-deprecated message to --client-cert-not-required man
page entry.

In 2.4:
 * add --verify-client-cert (none|optional|required)
 * add a clear deprecation message  when client-cert-not-required is used

In 2.5+:
 * Only support --verify-client-cert (none|optional|required)

Jan Just, if you could to the OpenSSL part, that would be great.  I can
do the polarssl/mbedtls equivalent if needed.

-Steffan

