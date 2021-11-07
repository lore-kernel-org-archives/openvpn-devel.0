Message-ID: <dc3a4862-c794-00b2-7ef7-87a1b6bc82fb@...1227...>
Date: Sun, 7 Nov 2021 13:29:41 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20211107090138.3150187-1-arne@...1227...>
 <5fa04cf3-c7b7-7e26-db95-ee734b0001ea@...68...>
 <9ab3a55c-062a-d849-0434-0df90bea4224@...1227...>
 <eaaa8190-3418-c155-4459-a12e853c9eda@...68...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <eaaa8190-3418-c155-4459-a12e853c9eda@...68...>
Subject: Re: [Openvpn-devel] [PATCH] Completely remove DES checks
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
To: Matthias Andree <matthias.andree@...68...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


>>
>> The patch removes checking for weak keys and making DES just like any
>> other CBC cipher and not doing extra checks for this. It basically
>> removes the special treatment of DES.
> 
> 
> After this, do we have any DES functionality left in OpenVPN? If so, we
> should remove it.
> 

After this patch, no special handling for DES anymore. YOu can still use 
DES but it is handled like any other cipher, e.g. BF-CBC, AES-CBC

Arne

