References: <20210412164545.11151-1-maximilian.fillinger@...2507...>
 <E1lVzi7-00011Y-AY@...2479...>
 <dcd5b87c-6a68-a191-dae9-cc35ecb99b65@...2181...>
 <8c219b3e-18e0-db0a-e9ae-25d279a5e8ba@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <5bf8ca09-7993-86a2-0c3e-1780dfe0a800@...2181...>
Date: Wed, 14 Apr 2021 11:34:29 +0200
MIME-Version: 1.0
In-Reply-To: <8c219b3e-18e0-db0a-e9ae-25d279a5e8ba@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v2 1/2] In init_ssl,
 open the correct CRL path pre-chroot
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Arne Schwabe <arne@...1227...>, Max Fillinger <maximilian.fillinger@...2507...>, openvpn-devel@lists.sourceforge.net



On 14/04/2021 11:29, Arne Schwabe wrote:
> 
>>
>>> +        if (options->chroot_dir == NULL || in_chroot || options->crl_file_inline)
>>> +        {
>>> +            tls_ctx_reload_crl(new_ctx, options->crl_file, options->crl_file_inline);
>>> +        }
>>> +        else
>>> +        {
>>> +            struct gc_arena gc = gc_new();
>>> +            struct buffer crl_file_buf = prepend_chroot(options->chroot_dir, options->crl_file, &gc);
>>> +            tls_ctx_reload_crl(new_ctx, BSTR(&crl_file_buf), options->crl_file_inline);
>>> +            gc_free(&gc);
>>> +        }
>>
>> Arne: any opinion on using c->c2.gc here? init_ssl() is invoked once per
>> instance and re-invoked upon SIGUSR1. I believe it is fine to use the
>> c2's gc?
>>
> 
> I would prefer a local gc here. It is easier to see that the memory can
> be freed right now and we don't add this unecessary depenendency on c2.
> Also c2 is not clear on renegotiations, so we will collect one string
> per renegotiation here.

This routine is invoked upon SIGUSR1, not upon renegotiation. And I
believe c2 is cleaned upon SIGUSR1. SO I would consider this memory
allocation the same as other options we have.

However, I do agree with your point that limiting the scope is better.

Regards,

-- 
Antonio Quartulli

