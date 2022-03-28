Message-ID: <7fd53653-8078-eef8-dd4e-a9170a0c5e0b@...1227...>
Date: Mon, 28 Mar 2022 21:29:18 +0200
MIME-Version: 1.0
Content-Language: en-GB
References: <400a4652-39d6-ec8d-6f58-824f552e0440@...2666...>
 <9f710eb5-007c-cc8e-56b0-1b00c3f12c19@...1227...>
 <1315401d-b450-6db4-08f5-fed79f51a205@...2666...>
 <889af1a8-eee2-d869-00ef-29ada1db2bb6@...1227...>
 <bac3c082-face-b0a7-e041-00c9ffe7a7a2@...2181...>
 <9800b0fd-1788-da6e-9e0d-fdfc1f82a40b@...2666...>
 <Yj36ETvmHJhN9lSt@...1296...>
 <ff63f5a6-be8f-192f-8ecd-a2a595844338@...2666...>
 <126f691a-67bc-b9fb-bbe7-ab9fd35fa446@...1227...>
 <ce91fa90-df25-5f5a-1fff-07b0411b471e@...2666...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <ce91fa90-df25-5f5a-1fff-07b0411b471e@...2666...>
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
To: Michael Baentsch <info@...2666...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


>> Allow non-standard EC groups with OpenSSL3
> This statement just is not correct: This has not a lot to do with EC. 
> What about "Enable setting any TLS1.3 group [provided by the underlying 
> crypto libraries]. "?

A bit long for a commit subject. Maybe just:

Enable usage of TLS groups not identified by a NID in OpenSSL 3


>> OpenSSL3 no longer uses the NID to identify TLS groups, instead it uses
>> names. This allows also to use groups from external provider. It also 
>> recognises secp256r1 as the same group as prime256v1.
> This statement also is not quite right: OpenSSL3 still uses NIDs to 
> identify some groups, notably those not implemented by a provider, i.e., 
> legacy/"classic" crypto. I would agree with the statement that "OpenSSL3 
> prefers the use of names over NIDs for the identification of TLS1.3 
> groups, including EC groups." Lastly, the "it" in your statement above 
> is unclear (at least to me as a non-native speaker): What about 
> explicitly stating "OpenSSL3 also recognises secp256r1 as the same group 
> as prime256v1"? This fact of course has nothing to do with this patch.

This fact has to do with the patch since you no longer doing that dance 
with that curve for the new code that affects OpenSSL 3, so pointing 
that out in the commit message helps to understand the code change.

Maybe like this:

OpenSSL3 prefers to specify groups (including EC groups) with names 
instead of NID to allow also groups provided by providers.
This commits also remove the mapping of secp256r1 to prime256v1 for the 
OpenSSL3 code path as OpenSSL 3.0 recognises secp256r1.

Arne

