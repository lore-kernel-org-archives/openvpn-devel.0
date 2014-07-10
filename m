Message-ID: <53BEB037.5080301@...1516...>
Date: Thu, 10 Jul 2014 17:24:39 +0200
From: Holger Kummert <Holger.Kummert@...1516...>
MIME-Version: 1.0
References: <1397645317-20116-1-git-send-email-Holger.Kummert@...1516...>	<1397645317-20116-2-git-send-email-Holger.Kummert@...1516...>	<20140602182009.GP1118@...1296...>
	<538F27C6.2030203@...1516...>
In-Reply-To: <538F27C6.2030203@...1516...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] Get NTLMv1 and NTLMv2 up and running
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net


Hello,

Am 04.06.2014 16:05, schrieb Holger Kummert:
>> Is this used - and thus tested - by you only, or is it used by UTM
>> customers?  (This would give us confidence that it's tested by a larger
>> user base, and those tend to uncover issues :-) ).
>
> Well, I thought I let it pass through the review process of the group
> first before pushing it to customers.
> But if it would help the review we could do it the other way
> round and give it to customers first.
> No problem.

in the meantime I got feedback from a customer who successfully tested 
both patches.
His environment is Win7 on client side, and Win2012R2 on server side.

I also tested the implementation against a Win2003R2 server successfully
(this server used utf8-encoding and NTLMv2sec, too). The client was
a Win7 Ultimate with SP1.

So we know now that the NTLM-patches work against Win2003R2, Win2008R2,
Win2012R2 and squid (the latter was reported by David Woodhouse).



Regards,
Holger

