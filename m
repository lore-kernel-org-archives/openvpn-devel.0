Message-ID: <cb45bf27-ee10-f4d0-fdd6-aecf7cecb895@...1227...>
Date: Tue, 29 Nov 2022 12:29:59 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20221127203228.3543200-1-arne@...1227...>
 <Y4SI7ZhCsT0wgvv7@...2678...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <Y4SI7ZhCsT0wgvv7@...2678...>
Subject: Re: [Openvpn-devel] [PATCH] Add section about common error with
 OpenVPN 2.6 and OpenSSL 3.0
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
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net


> 
>> +  for more details (Available online under
>> +  https://github.com/OpenVPN/openvpn/blob/master/doc/man-sections/cipher-negotiation.rst)
> 
> Might want to use https://build.openvpn.net/man/openvpn-2.6/openvpn.8.html#data-channel-cipher-negotiation instead?
> Doesn't exist yet, but will be created on Alpha release.

Hm yes. The rendering on the 2.5 page is very barebone, the github 
version looks actually a lot better. I would keep it this way for now 
and after branching of the 2.6 branch we update both references of 
github.com in this document to  manual section to fixed 2.6 links

>> +
>> +- Use of a legacy 64bit block ciphers or another deprecated cipher
> 
> "another" -> "other"
> "cipher" -> "ciphers"
> 
>> +
>> +  OpenSSL 3.0 no longer a number of insecure and outdated ciphers. Some of
> 
> missing "supports"?
> 
>> +  these cipehrs are known vulnerable (SWEET32 attack).
> 
> "ciphers"
> 
>> +
>> +  This will typically manifest itself in messages like::
>> +
>> +      OpenSSL: error:0308010C:digital envelope routines::unsupported
>> +      Cipher algorithm 'BF-CBC' not found
>> +      Unsupported cipher in --data-ciphers: BF-CBC
>> +
>> +  If your OpenSSL distribution comes with the legacy provider, it will allow to
>> +  load a legacy provider that contains the old providers. In this case you can
> 
> "it will allow ..." -> "you can load it to enable support for the old ciphers".
> Remove "In this case".
> 
>> +  use ``--providers legacy default`` to load the legacy cipher provider.
>> +
>> +- OpenVPN version not supporting TLS 1.2 or later
>> +
>> +  The default in OpenVPN 2.6 and also in many distributions is now TLS 1.2.
>> +  Connecting to peer that does not support this will results in messages like::
> 
> "a peer"
> 
>> +
>> +    TLS error: Unsupported protocol. This typically indicates that client and server have no common TLS version enabled. This can be caused by mismatched tls-version-min and tls-version-max options on client and server. If your OpenVPN client is between v2.3.6 and v2.3.2 try adding tls-version-min 1.0 to the client configuration to use TLS 1.0+ instead of TLS 1.0 only
> 
> Line breaks?

Good question. The original message does not have any. I will break it 
up into multiple lines for the next patch version.

Arne



