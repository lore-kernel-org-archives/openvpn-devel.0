Message-ID: <52C0AF83.5010501@...1856...>
Date: Mon, 30 Dec 2013 00:25:55 +0100
From: Steffan Karger <steffan@...1856...>
MIME-Version: 1.0
References: <52ADF633.8040003@...1856...> <20131216073024.GC161@...1296...>
In-Reply-To: <20131216073024.GC161@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Use RSA_generate_key_ex() instead of
 deprecated, RSA_generate_key()
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On 16-12-13 08:30, Gert Doering wrote:
> Hi,
> 
> On Sun, Dec 15, 2013 at 07:34:27PM +0100, Steffan Karger wrote:
>> One note on the implementation though; the code generates one
>> ephemeral RSA key that is used during the entire lifetime of an
>> OpenVPN process. If OpenSSL requests a new (ephemeral) key, it
>> will keep on returning the same (usually rather small) key. Not
>> the best solution.
>> 
>> To actually run this code, I had to force usage by selecting the 
>> TLS-RSA-EXPORT-WITH-DES40-CBC-SHA tls-cipher. That generated a
>> 512-bit ephemeral RSA key, and uses the outdated DES encryption
>> protocol.
> 
> I'm not sure I understand the whole picture here.  What is
> happening in the "normal" scenario, and why is this particular
> cipher calling a different code path inside OpenVPN?

In the 'normal' scenario, one would use diffie-hellman for key
exchange (or ephemeral diffie-hellman for forward secrecy). When using
(E)DH, there is no need for ephemeral RSA keys. Some TLS ciphers (if I
understand correctly, only EXPORT ciphers) use ephemeral RSA to bump
their signed but restricted-length (e.g. 512-bit) key to a larger -
generated - key for the connection. The OpenSSL manpage states:
"Additionally, the use of ephemeral RSA key exchange is only allowed
in the TLS standard, when the RSA key can be used for signing only,
that is for export ciphers."
> 
>> Using this mode could lead to a false sense of security. Then
>> again, one should be using (Ephemeral) Diffie-Hellman anyway, and
>> OpenVPN requires a tls-server to supply dh parameters. A user
>> would need to deliberately choose a weak tls-cipher like
>> TLS-RSA-EXPORT-WITH-DES40-CBC-SHA, which would be aligning a gun
>> with his foot anyway. If one would decide this implementation is
>> not good enough anymore, I'd suggest to just strip out support
>> for this completely.
> 
> I'm tempted to agree with this :) - single-DES (and 40 bit to
> that!) really isn't what we want to use.
> 
> So what would happen if we remove this code, and a user tries to
> use this tls-cipher?

OpenVPN would not be able to use the cipher and report OpenSSL's error
"1408A0C1:SSL routines:SSL3_GET_CLIENT_HELLO:no shared cipher", which
makes sense if you already know what is happening: the cipher chosen
is not supported by (one of) the endpoints.

I've given the stripping out a little more thought and think I'm in
favour of stripping this out of 2.4, but keep support in 2.3 to not
break anything for minor releases. Removing this cipher mode sounds
like a feature to me ;)

-Steffan

