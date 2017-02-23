References: <003bd3ed-9a64-3e77-cd06-2212b82a6165@...515...>
	<6a8f8780-a49c-9d1f-30ac-d3b804e9476b@...1435...>
From: James Yonan <james@...515...>
Message-ID: <5cab0f4b-c40e-c11d-25e7-dc276d18317c@...515...>
Date: Thu, 23 Feb 2017 14:41:29 -0700
MIME-Version: 1.0
In-Reply-To: <6a8f8780-a49c-9d1f-30ac-d3b804e9476b@...1435...>
Subject: Re: [Openvpn-devel] Should we use mbedTLS certificate profiles?
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
To: openvpn-devel@lists.sourceforge.net

On 23/02/2017 01:22, Steffan Karger wrote:

> Hi James,
>
> On 22-02-17 19:48, James Yonan wrote:
>> mbedTLS 2 has a new feature that allows rejection of certificates if the
>> key size is too small or the signing hash is weak.
>>
>> The feature is controlled via struct mbedtls_x509_crt_profile.
>>
>> For example, you could specify that certificates must be at least 2048
>> bits and use a SHA-2 signing alg.
>>
>> Wondering if we should enable this via an option, or tie it into the
>> existing tls-version-min.
>>
>> The granular approach would be to have specific options for each limit,
>> such as ssl-min-key-size, ssl-require-sha2
>>
>> The bundled approach would be to take an existing option such as
>> tls-version-min and add additional constraints onto it.  For example, if
>> tls-version-min is 1.2 or higher, then also require minimum key size to
>> be 2048 and certificate signing hash to be SHA-2.
> OpenVPN 2.4 currently just uses mbed TLS' default profile, and we tell
> people to use stronger keys (RSA 2048+ / ECDSA) or a stronger hash
> function (SHA1+) if that causes trouble.
>
> If we are going to make this configurable, I think we should separate it
> from tls-version-min.  The main use case I see for using a lower
> security setting would be an out-of-the-admins-control CA, or something
> like (old) smart cards that don't support RSA-2048.  I wouldn't want to
> block people from enforcing TLS 1.2, because their smart card is crappy.
>
> So I think we'll have to add the relevant --tls-rsa-key-size-min,
> --tls-curves (could replace --ecdh-curves), --tls-digests options.  If
> we want to make it configurable, that is.

I think it needs to be configurable to allow for transitions to stronger 
keys.

For naming, how about --tls-rsa-key-size-min and --tls-cert-sign-min?

For --tls-cert-sign-min, the choices could be "none" (anything allowed 
by the underlying SSL lib) or "sha2" (requiring sha256 or higher).

Wondering what the defaults should be.

James

>
> -Steffan
>
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, SlashDot.org! http://sdm.link/slashdot
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel


