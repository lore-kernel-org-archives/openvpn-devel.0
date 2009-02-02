Message-ID: <49875059.4040700@...41...>
Date: Mon, 02 Feb 2009 12:58:17 -0700
From: James Yonan <jim@...41...>
MIME-Version: 1.0
References: <20090127154806.GA38604@...33...>	<9e0cf0bf0901270831l72b16993p1037df311fb50c74@...278...>
	<499929A843E2C541A8AD31A881A2B6A202DAB494@...1006...>
In-Reply-To: <499929A843E2C541A8AD31A881A2B6A202DAB494@...1006...>
Subject: Re: [Openvpn-devel] OVPN patching process RE: [PATCH] Fix non-C89
 comments
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
To: David Balazic <David.Balazic@...1005...>
Cc: Alon Bar-Lev <alon.barlev@...277...>, openvpn-devel@lists.sourceforge.net

David,

A couple issues with the patch:

* sscanf usage doesn't check for buffer overflow.

* You use gw_if_name in some places and gw_ifname in other places.  To 
eliminate confusion it would be best to use a consistent form.

Also, to reiterate, try submitting the patch as an attachment to deal 
with email client munging issues.

Thanks,
James

David Balazic wrote:
> Hi!
> 
> I sent a patch recently to the openvpn-devel list and got
> no reply whatsoever. Did I miss something ? Is there a procedure
> that I did not follow ?
> 
> That patch is to fix a longstanding bug that users encountered.
> 
> Regards,
> David
> 
> PS: the mail message in question is :
> Fix for "Cannot read current default gateway" problem on Linux
> http://article.gmane.org/gmane.network.openvpn.devel/2472
> 
>> -----Original Message-----
>> From: Alon Bar-Lev [mailto:alon.barlev@...277...] 
>> Sent: Tuesday, January 27, 2009 5:32 PM
>> To: openvpn-devel@lists.sourceforge.net
>> Subject: Re: [Openvpn-devel] [PATCH] Fix non-C89 comments
>>
>> Sent this to James.
>> Did not apply.
>>
>> My queue is at:
>> http://svn.openvpn.net/projects/openvpn/contrib/alon
>>
>> On 1/27/09, Matthias Andree 
>> <ma+ovpnd@...31...> wrote:
>>> Hi,
>>>
>>>  openvpn uses non-C89 //-style comments in two places. 
>> Patch to convert
>>>  these to /* ... */ style comments attached.
>>>
>>>  Best
>>>
>>>  --
>>>
>>> Matthias Andree
>>>
>>>
>> --------------------------------------------------------------
>> ----------------
>>>  This SF.net email is sponsored by:
>>>  SourcForge Community
>>>  SourceForge wants to tell your story.
>>>  http://p.sf.net/sfu/sf-spreadtheword
>>> _______________________________________________
>>>  Openvpn-devel mailing list
>>>  Openvpn-devel@lists.sourceforge.net
>>>  https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>>>
>>>
>>>
>> --------------------------------------------------------------
>> ----------------
>> This SF.net email is sponsored by:
>> SourcForge Community
>> SourceForge wants to tell your story.
>> http://p.sf.net/sfu/sf-spreadtheword
>> _______________________________________________
>> Openvpn-devel mailing list
>> Openvpn-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>>
> 
> ------------------------------------------------------------------------------
> This SF.net email is sponsored by:
> SourcForge Community
> SourceForge wants to tell your story.
> http://p.sf.net/sfu/sf-spreadtheword
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

