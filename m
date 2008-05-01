Message-ID: <481A3F37.5010509@...41...>
Date: Thu, 01 May 2008 16:07:51 -0600
From: James Yonan <jim@...41...>
MIME-Version: 1.0
References: <4811E5AA.8060900@...1090...> <4818EF70.6060900@...41...>
	<m38wyuew7i.fsf@...1043...>
In-Reply-To: <m38wyuew7i.fsf@...1043...>
Subject: Re: [Openvpn-devel] [patch] OpenVPN 2.1_rc7, multihome and 64 bit
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Marko Rauhamaa <marko@...1042...>
Cc: openvpn-devel@lists.sourceforge.net

Marko Rauhamaa wrote:
> James Yonan <jim@...41...>:
>
>   
>> Interesting.  I wonder if a better solution might be to bracket the 
>> struct openvpn_pktinfo definition with
>>
>> #pragma pack(1)
>> ...
>> #pragma pack()
>>     
>
> Yes, although gcc is allergic to #pragma's. The gcc way of expressing it
> is:
>
>           struct __attribute__ ((__packed__)) my_packed_struct
>             {
>                char c;
>                int  i;
>                struct my_unpacked_struct s;
>             };
>
> (from "info gcc" -> "C Extensions" -> "Type Attributes").
>
>
> Marko
>   

gcc does support #pragma pack:

http://gcc.gnu.org/onlinedocs/gcc/Structure_002dPacking-Pragmas.html

James


