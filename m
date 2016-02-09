References: <1454874438-5081-1-git-send-email-steffan@...1856...>
	<1454874438-5081-10-git-send-email-steffan@...1856...>
	<56B8BC53.40805@...1227...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <56BA02BF.5090208@...2080...>
Date: Tue, 9 Feb 2016 16:16:15 +0100
MIME-Version: 1.0
In-Reply-To: <56B8BC53.40805@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 09/10] Add cipher name translation for
 OpenSSL.
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

On 08/02/16 17:03, Arne Schwabe wrote:
> 
> 
> Am 07.02.16 um 20:47 schrieb Steffan Karger:
>> This keeps naming consistent. For example, instead of id-aes128-GCM use
>> AES-128-GCM, which is more like AES-128-CBC.
>>
>> +
>> +  if (NULL == pair)
>> +    return cipher_name;
>> +
> I like the pair == NULL style more.

I "kind of" agree, as that's what we've grown up with.  However, from a
defensive programming style, this is a far better approach.  A mistyping using
'=' will in 'NULL = pair' case cause a compile failure.  The other way around
will compile just fine with a nice ugly bug attached with it ... So I'm trying
to get used to his "flipped around" style.

Especially for OpenVPN, I believe a defensive style is very much appropriate.


-- 
kind regards,

David Sommerseth

