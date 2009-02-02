Message-ID: <49874712.2030402@...41...>
Date: Mon, 02 Feb 2009 12:18:42 -0700
From: James Yonan <jim@...41...>
MIME-Version: 1.0
References: <499929A843E2C541A8AD31A881A2B6A202DF38BE@...1006...>
	<200902021218.12326.alon.barlev@...277...>
In-Reply-To: <200902021218.12326.alon.barlev@...277...>
Subject: [Openvpn-devel] Submitting patches to openvpn-devel
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
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net, David Balazic <David.Balazic@...1005...>

I know that many open source projects ask for patches to be submitted 
inline, rather than via email attachment.  Quite honestly, I don't think 
this approach works in practice.  Many email clients in popular use will 
munge the patch making it unusable.  This creates a hassle for the 
maintainers as they must request the patch to be resubmitted.

I know that in the past, the OpenVPN Project has echoed the common 
practice of asking for patches to be submitted inline.  I would like to 
change that practice now.  So please, in the future, submit patches as 
attachments.  For trivial patches, it's okay paste them inline for 
discussion purposes as long as they are also included as an attachment.

Thanks,
James

Alon Bar-Lev wrote:
> On Monday 02 February 2009 11:49:50 David Balazic wrote:
>> diff -u openvpn_trunk/route.c openvpn_patched/route.c
>> --- openvpn_trunk/route.c	2009-01-29 15:00:04.525034400 +0100
>> +++ openvpn_patched/route.c	2009-01-29 15:03:41.116012000 +0100
>> @@ -45,7 +45,7 @@
>>  
>>  static void add_route (struct route *r, const struct tuntap *tt, unsigned int flags, const struct env_set *es);
>>  static void delete_route (const struct route *r, const struct tuntap *tt, unsigned int flags, const struct env_set *es);
>> -static bool get_default_gateway (in_addr_t *ret);
>> +static bool get_default_gateway (in_addr_t *ret, char *gw_if_name);
>>  
>>  struct route_option_list *
>>  new_route_option_list (struct gc_arena *a)
> 
> Which version of diffutils do you use?
> How come there is a tab after file name in the header?
> How come the above hank has 8 lines but reported as 7 lines?
> 
> Alon.
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

