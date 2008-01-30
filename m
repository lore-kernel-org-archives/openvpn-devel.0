Message-ID: <47A00806.1080109@...41...>
Date: Tue, 29 Jan 2008 22:15:50 -0700
From: James Yonan <jim@...41...>
MIME-Version: 1.0
References: <20071011233158.GC1416@...1048...>
	<20080130043336.GH31211@...1048...>
In-Reply-To: <20080130043336.GH31211@...1048...>
Subject: Re: [Openvpn-devel] [Patch] Fix Null-Pointer bug in init_ssl() when
 no '--ca' is set but '--capath'
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
To: Openvpn-devel@lists.sourceforge.net

Maximilian Wilhelm wrote:
> Am Friday, den 12 October hub Maximilian Wilhelm folgendes in die Tasten:
>
> Hi!
>
> What about this patch?
> I think it should be included in the next -rc as it fixes a crash.
>
>
>   
>> This little patch fixes a silly bug in init_ssl() in ssl.c where
>> options->ca_file is accessed without prior check if it's not NULL.
>>     
>
>   
>> The bug was introduced in revision 784.
>>     
>
>
>   
>> diff --git a/ssl.c b/ssl.c
>> index 85e9c6f..868edc2 100644
>> --- a/ssl.c
>> +++ b/ssl.c
>> @@ -1228,7 +1228,7 @@ init_ssl (const struct options *options)
>>        int status;
>>  
>>  #if ENABLE_INLINE_FILES
>> -      if (!strcmp (options->ca_file, INLINE_FILE_TAG) && options->ca_file_inline)
>> +      if (options->ca_file && !strcmp (options->ca_file, INLINE_FILE_TAG) && options->ca_file_inline)
>>  	{
>>  	  status = use_inline_load_verify_locations (ctx, options->ca_file_inline);
>>  	}
>>     
>
> Ciao
> Max
>   


This was fixed in 2.1-rc5:

------------------------------------------------------------------------
r2635 | james | 2008-01-20 20:39:01 -0700 (Sun, 20 Jan 2008) | 3 lines
Changed paths:
  M /branches/BETA21/openvpn/ssl.c

Simple fix where options->ca_file was used without
first being checked against NULL.

------------------------------------------------------------------------

James


