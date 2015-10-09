References: <20140827093409.GA659@...1900...> <20150223155132.GA28440@...2018...>
	<CAEW7GUsCzQ-=QaQdihm8pnFmm9LCPD43hQtDLOPu+prjsEsi_g@...278...>
	<5617DCCF.7080401@...1114...>
	<CAEW7GUsrWQuoWs_ob4fqsuTBkax4-D9hZyY46YXq_zOSiC-qSg@...278...>
From: David Sommerseth <openvpn.list@...1114...>
Message-ID: <5617E6B1.6030702@...1114...>
Date: Fri, 9 Oct 2015 18:09:21 +0200
MIME-Version: 1.0
In-Reply-To: <CAEW7GUsrWQuoWs_ob4fqsuTBkax4-D9hZyY46YXq_zOSiC-qSg@...278...>
Subject: Re: [Openvpn-devel] Fwd: Add support for Keying Material Exporter
 [RFC 5705]
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
To: daniel kubec <niel@...1898...>, openvpn-devel@lists.sourceforge.net

On 09/10/15 17:54, daniel kubec wrote:
> Hi David,
> 
> Thank You for your comments. It makes sense to me.
> Can you apply your fixes into patches or it's up to me ?
> 

As this has been lingering just way too long, I can do these changes this
weekend and get it apply.


-- 
kind regards,

David Sommerseth

> 
> On 9 October 2015 at 17:27, David Sommerseth
> <openvpn.list@...1114...> wrote:
>> On 23/02/15 17:02, daniel kubec wrote:
>>> ---------- Forwarded message ----------
>>> From: Daniel Kubec <niel@...1898...>
>>> Date: 23 February 2015 at 16:51
>>> Subject: Add support for Keying Material Exporter [RFC 5705]
>>> To: openvpn-devel@lists.sourceforge.net
>>>
>>>
>>> Hi David,
>>>
>>> Keying Material Exporter [RFC 5705] Patch rebased to actual master
>>> branch.
>>>
>>> Daniel
>>
>> Hi,
>>
>> I've finally had time to do some review.  Your patches work, but I have a few
>> comments.
>>
>>
>> * openvpn-rfc5705-sample.patch
>> - The client config is missing a 'pull'.  I tried running this with a server
>>   running in a VM, and the client running outside of the server VM had no IP
>>   address or routing configured.  Adding 'pull' to the client config solved
>>   it.
>> - You've called the plug-in and 'sso'.  I'd try to avoid such a vague name, as
>>   it may be misunderstood to do something else.  I'd suggest using a more
>>   related name, for example 'keying-material-exporter-demo'.
>>
>>
>> * openvpn-rfc5705-doc-v3.patch
>> - The 'OpenVPN Configuration' example is missing a leading dash.  It now says
>>   -keying-material-exporter, but should say --keying-material-exporter.
>>
>>
>> * openvpn-rfc5705-v3.patch
>>   The code looks good to me, I share the same comment to the man page as
>>   Steffan had too, to also document the upper bound of 4095 bytes.
>>
>>
>> If we can agree on these changes, I'll ensure it gets applied fairly quickly.
>>
>>
>> --
>> kind regards,
>>
>> David Sommerseth
> 


