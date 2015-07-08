Message-ID: <559D4FD9.4090006@...1147...>
Date: Wed, 08 Jul 2015 18:29:13 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <55950ACC.1000909@...1147...> <20150702123852.GS382@...1296...>
	<55953B78.8090904@...1147...>
In-Reply-To: <55953B78.8090904@...1147...>
Subject: Re: [Openvpn-devel] [PATCH v2] Add TFTP and WPAD DHCP options
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
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

Jan Just Keijser wrote:
> Gert Doering wrote:
>> On Thu, Jul 02, 2015 at 11:56:28AM +0200, Jan Just Keijser wrote:
>>  
>>> +    write_dhcp_str (buf, 66, o->tftp, &error);
>>> +    write_dhcp_str (buf, 150, o->tftp, &error);
>>>     
>>
>> This does not look safe to me (or I'm overlooking something) - if 
>> o->tftp is not set, it will do "strlen(o->tftp)" inside 
>> write_dhcp_str()...
>>
>> (And we generally shouldn't set options that we do not have anything 
>> to say for :) ).
>>
>>   
> I fully agree. Here's v2 with Jonathan's remarks addressed as well.

I just discovered that my patch does not set the (poorly documented) 
Cisco TFTP options; I'm working on rev3 which does set them correctly 
(at least, Wireshark says I am setting them now correctly). Stay tuned :)

JJK


