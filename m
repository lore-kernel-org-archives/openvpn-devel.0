References: <2b5fbffa-6b18-2226-5b29-7c6be670413b@...1800...>
 <20200421183735.GB1431@...1296...> <20200421185953.GC1431@...1296...>
 <59fc004a-b2d7-3f7a-6f61-683acd04215e@...1147...>
 <7b513593-81ce-d5ca-80a7-fd90fe290b4c@...1227...>
From: Jan Just Keijser <janjust@...1147...>
Message-ID: <45a53cab-2678-d71c-8d8d-280b7403f36f@...1147...>
Date: Wed, 22 Apr 2020 10:27:40 +0200
MIME-Version: 1.0
In-Reply-To: <7b513593-81ce-d5ca-80a7-fd90fe290b4c@...1227...>
Content-Language: nl-NL
Subject: Re: [Openvpn-devel] [Openvpn-users] new openssl = new OpenVPN
 release ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: Arne Schwabe <arne@...1227...>, Gert Doering <gert@...1296...>, mike tancsa <mike@...1800...>
Cc: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

Hi Arne,

On 22/04/20 10:13, Arne Schwabe wrote:
>>> SSL_check_chain() function".
>>>
>>> Which we don't, I just grepped through our source tree.
>>>
>>> So, unless I misunderstand something about OpenSSL intricacies, I think
>>> we're safe - no new installers needed, and OpenVPN is not in risk.
>>>
>>>
>> the advisory applies only to application that use the SSL_check_chain()
>> function as part of a TLS 1.3 handshake. AFAIK, iIn OpenVPN 2.4 we don't
>> do anything with TLS 1.3 just yet, so this security advisory does not
>> apply to OpenVPN. Also note that this bug appears only in OpenSSL 1.1.1
>> [d-f] , so anything older is fine as well.
> Hu? OpenVPN 2.4 supports TLS 1.3 just fine. We have support for it in
> tls-version-min and also tls-ciphersuites which is TLS 1.3 specific.
>
>
what I meant was that OpenVPN 2.4 does not do any *specific* with any of 
the new features of TLS 1.3, like the new psk callbacks etc. If the 
control session is negotiated using TLS 1.3 then sure, OpenVPN will use 
that, but other that OpenVPN does not make use of any of the new 
features or crypto algorithms that come with OpenSSL 1.1.1 or TLS 1.3 
(chacha20 anyone ;) ? )

cheers,

JJK


