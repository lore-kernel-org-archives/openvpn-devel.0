Message-ID: <277ec823-65c5-89f4-e6bf-c2b081d58936@...1227...>
Date: Fri, 30 Jun 2023 15:50:19 +0300
MIME-Version: 1.0
Content-Language: en-GB
References: <20230629215611.3292788-1-arne@...1227...>
 <20230629215611.3292788-4-arne@...1227...>
 <8d7daa83f0fe41d180f2e819b6038546@...2507...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <8d7daa83f0fe41d180f2e819b6038546@...2507...>
Subject: Re: [Openvpn-devel] [PATCH 2/2] Implement using --peer-fingerprint
 without CA certificates
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Maximilian Fillinger <maximilian.fillinger@...2507...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 30.06.23 um 15:31 schrieb Maximilian Fillinger:
> The grammar in the 3rd sentence in the comment below is messed up. (I think I understand it, but I'm not sure.)
> 
>> +    if (session->opt->verify_hash_no_ca)
>> +    {
>> +        /*
>> +         * If we decide to verify the peer certificate based on the fingerprint
>> +         * we ignore wrong dates and the certificate not being trusted.
>> +         * Any other problem with the certificate (wrong key, bad cert,...)
>> +         * will still trigger an error.
>> +         * Clearing these flags relies on verify_cert will later rejecting a
>> +         * certificate that has no matching fingerprint.
>> +         */
>> +        uint32_t flags_ignore = MBEDTLS_X509_BADCERT_NOT_TRUSTED
>> +                                | MBEDTLS_X509_BADCERT_EXPIRED
>> +                                | MBEDTLS_X509_BADCERT_FUTURE;
>> +        *flags = *flags & ~flags_ignore;
>> +    }
>> +
> 
> Also, this comment is copied verbatim from Jason's commit 423ced962d which has been reverted. I'm not a lawyer, but since comments are relatively easy to rephrase, I think it's better to do that. My suggestion:

The comment is already mine. Jason never included an mBed TLS 
implementation. I attributed the commit to Jason but some of the code 
and this comment is already written by me.

Arne

