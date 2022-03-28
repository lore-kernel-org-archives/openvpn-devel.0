Message-ID: <ce91fa90-df25-5f5a-1fff-07b0411b471e@...2666...>
Date: Mon, 28 Mar 2022 15:56:38 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <400a4652-39d6-ec8d-6f58-824f552e0440@...2666...>
 <9f710eb5-007c-cc8e-56b0-1b00c3f12c19@...1227...>
 <1315401d-b450-6db4-08f5-fed79f51a205@...2666...>
 <889af1a8-eee2-d869-00ef-29ada1db2bb6@...1227...>
 <bac3c082-face-b0a7-e041-00c9ffe7a7a2@...2181...>
 <9800b0fd-1788-da6e-9e0d-fdfc1f82a40b@...2666...>
 <Yj36ETvmHJhN9lSt@...1296...>
 <ff63f5a6-be8f-192f-8ecd-a2a595844338@...2666...>
 <126f691a-67bc-b9fb-bbe7-ab9fd35fa446@...1227...>
From: Michael Baentsch <info@...2666...>
In-Reply-To: <126f691a-67bc-b9fb-bbe7-ab9fd35fa446@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Enablement of quantum-safe key
 establishment
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
To: Arne Schwabe <arne@...1227...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 28.03.22 um 13:52 schrieb Arne Schwabe:
> Am 27.03.22 um 17:52 schrieb Michael Baentsch:
>> Thanks again for your explanations: I finally figured out to correct 
>> my git send-email configuration `smtpencryption` to be set to "ssl" 
>> (instead of "tls": The latter caused a hang that I debugged for way 
>> too long :-(. Maybe worth while adding to some FAQ for newbies? The 
>> guidance at 
>> https://github.com/git/git/blob/master/Documentation/git-send-email.txt 
>> was clearly wrong.
>>
>> Please let me know if that submission now arrived and meets your 
>> requirements.
>
> The commit message is still not great. Something I would have used 
> instead:
Well....
>
> Allow non-standard EC groups with OpenSSL3
This statement just is not correct: This has not a lot to do with EC. 
What about "Enable setting any TLS1.3 group [provided by the underlying 
crypto libraries]. "?
>
> OpenSSL3 no longer uses the NID to identify TLS groups, instead it uses
> names. This allows also to use groups from external provider. It also 
> recognises secp256r1 as the same group as prime256v1.
This statement also is not quite right: OpenSSL3 still uses NIDs to 
identify some groups, notably those not implemented by a provider, i.e., 
legacy/"classic" crypto. I would agree with the statement that "OpenSSL3 
prefers the use of names over NIDs for the identification of TLS1.3 
groups, including EC groups." Lastly, the "it" in your statement above 
is unclear (at least to me as a non-native speaker): What about 
explicitly stating "OpenSSL3 also recognises secp256r1 as the same group 
as prime256v1"? This fact of course has nothing to do with this patch.
>
>
>
>>
>> One further question: Is there interest on your side to add 
>> more/better support for quantum-safe crypto to OpenVPN? 
>
> Depends on what changes you are proposing. There is certainly some 
> interest but depends on what exactly we are talking about.
I'll flesh that out. It mostly has to do with modifications to "easyrsa" 
- see below.
>
>> easyrsa isn't geared for that right now (let alone suitably named 
>> :-), but openssl3 (with our oqsprovider) can generate quantum-safe 
>> PKI (CA and client certs) without problems.
>
> Easyrsa has become also separate project. Development and maintainance 
> of easyrsa have become quite slow in the last years.
That statement is very helpful, thanks. It might then be sensible (for 
me) to start a script from scratch that does not have such strong 
dependency on legacy crypto. Will report back when I have something of 
interest.
>
>> Quantum-safe key exchange works in OpenVPN just fine when the PR lands.
>>
Thanks in advance for any guidance how to proceed with the PR now.


