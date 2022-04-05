Message-ID: <d7fe7278-2c35-c54c-dd60-469ef6af40e4@...2181...>
Date: Tue, 5 Apr 2022 13:24:55 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220402070902.30282-1-a@...2181...>
 <20220402070902.30282-7-a@...2181...>
 <1653915871.596525.1649153663382@...2642...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <1653915871.596525.1649153663382@...2642...>
Subject: Re: [Openvpn-devel] [PATCH 6/7] ovpn-dco-win: introduce windows
 data-channel offload support
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
To: Frank Lichtenheld <frank@...2641...>, openvpn-devel@lists.sourceforge.net
Cc: Lev Stipakov <lev@...515...>

Hi,

On 05/04/2022 12:14, Frank Lichtenheld wrote:
> 
> 
>> Antonio Quartulli <a@...2181...> hat am 02.04.2022 09:09 geschrieben:
> [...]
>> diff --git a/README.dco.md b/README.dco.md
>> index 27c166b9..d3599727 100644
>> --- a/README.dco.md
>> +++ b/README.dco.md
>> @@ -109,6 +116,8 @@ Limitations by design
>>   - topology subnet is the only supported `--topology` for servers
>>   - iroute directives install routes on the host operating system, see also
>>     routing with ovpn-dco
>> +- (ovpn-dco-win) client and p2p mode only
>> +- (ovpn-dco-win) only AES-GCM-128/192/256 cipher support
> 
> This seems to be out-of-sync with the code. The code seems to add CHACHA20-POLY1305 support
> on Windows 11.

You are correct - this should be changed.

Regards,

-- 
Antonio Quartulli

