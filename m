MIME-Version: 1.0
In-Reply-To: <CAKuzo_jN9EOK5aPr2dn+m+ynarY-Snt2pwOmz9cV32BpKSFq=w@...278...>
References: <1515959073-10376-1-git-send-email-selva.nair@...277...>
 <1515959073-10376-3-git-send-email-selva.nair@...277...>
 <e059b07e-5684-1dbe-cfdf-1271efc594dc@...1227...>
 <CAKuzo_jN9EOK5aPr2dn+m+ynarY-Snt2pwOmz9cV32BpKSFq=w@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 16 Jan 2018 23:24:58 -0500
Message-ID: <CAKuzo_hYwcRDJjYW7i=Ekmi93TAXRb+n=sNyi4y=+gS+vbbtAA@...278...>
Subject: Re: [Openvpn-devel] [PATCH 2/3] Allow external EC key through
 --management-external-key
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

> On Tue, Jan 16, 2018 at 5:40 PM, Arne Schwabe <arne@...1227...> wrote:
>> Am 14.01.18 um 20:44 schrieb selva.nair@...277...:
>>> From: Selva Nair <selva.nair@...277...>
>>>
>>> - This automatically supports EC certificates through
>>>   --management-external-cert
>>> - EC signature request from management has the same format
>>>   as for rsa with >RSA_SIGN replaced by >ECDSA_SIGN
>>>   Response should be of the form 'ecdsa-sig' followed
>>>   by DER encoded signature as base64 followed by 'END'
>>>
>>

snipped..

>>
>>>  static void
>>> +man_ecdsa_sig(struct management *man)
>>> +{
>>> +    struct man_connection *mc = &man->connection;
>>> +    if (mc->ext_key_state == EKS_SOLICIT)
>>> +    {
>>> +        mc->ext_key_state = EKS_INPUT;
>>> +        mc->in_extra_cmd = IEC_ECDSA_SIGN;
>>> +        in_extra_reset(mc, IER_NEW);
>>> +    }
>>> +    else
>>> +    {
>>> +        msg(M_CLIENT, "ERROR: The ecdsa-sig command is not currently available");
>>> +    }
>>> +}
>>> +
>>
>> This function is almost identical to man_rsa_sign. I would like to have
>> them both combined into one and then called by man_ecdsa_sig/man_rsa_sig.

Refactored code that addresses this and other suggestions is here
https://github.com/selvanair/openvpn/commits/external-ec-cert
(last 3 commits left unsquashed for now).

Will send in v2 after testing and squashing but comments welcome.

Regarding amending --management-external-cert command, better to
address it separately, so not handled here.

Also I'm toying with the idea of renaming ecdsa-sig/ECDSA-SIGN by
pkey-sig/PKEY-SIGN so that eventually we may be able to use it for
all types of keys and retire rsa-sig. Any thoughts on that?

Selva

