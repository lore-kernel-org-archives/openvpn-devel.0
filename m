MIME-Version: 1.0
In-Reply-To: <CAKuzo_jcPpCDeaL281O2j55m5m_X8TrMbY2nPgixm7O5KhQ3Fg@...278...>
References: <1476214507-4055-1-git-send-email-steffan@...1856...>
	<CAKuzo_jcPpCDeaL281O2j55m5m_X8TrMbY2nPgixm7O5KhQ3Fg@...278...>
From: Steffan Karger <steffan@...1856...>
Date: Wed, 12 Oct 2016 09:31:28 +0200
Message-ID: <CAA1AbxK+21uBLt2S4Og_mbCUM7zjf+uj3NxAuOA=0GwT44ZE-g@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Check --ncp-ciphers list on startup
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
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On 11 October 2016 at 22:11, Selva Nair <selva.nair@...277...> wrote:
> To nit-pick,

Yes, please!

> On Tue, Oct 11, 2016 at 3:35 PM, Steffan Karger <steffan@...1856...> wrote:
>>
>> +bool
>> +tls_check_ncp_cipher_list(const char *list) {
>> +  char *tmp_ciphers = string_alloc (list, NULL);
>> +  char *tmp_ciphers_orig = tmp_ciphers;
>> +  bool unsupported_cipher_found = false;
>> +
>> +  const char *token = strtok (tmp_ciphers, ":");
>> +  while (token)
>> +    {
>> +      if (!cipher_kt_get (translate_cipher_name_from_openvpn (token)))
>> +       {
>> +         msg (M_WARN, "Unsupported cipher in --ncp-ciphers: %s", token);
>> +         unsupported_cipher_found = true;
>> +       }
>> +      token = strtok (NULL, ":");
>> +    }
>> +  free (tmp_ciphers_orig);
>
> the extra "tmp_ciphers_orig" is redundant. Just "free (tmp_ciphers)" will
> do.

Indeed, will fix.

>> +
>> +  return list && 0 < strlen(list) && !unsupported_cipher_found;
>
> Checking for list == NULL here looks too late. If list is null, so is
> tmp_ciphers and then the first call to strtok will not reset the internal
> state of strtok(). The behaviour of strtok then depends on whether any
> previous use of it was was iterated to the end or not.
>
> If list could be NULL, better check it and do an early return from the top.

list can not be NULL, but that should indeed be ASSERT()ed at the top,
instead of 'checked' here. Will fix too.

I'll send a v2 in a minute.

-Steffan

