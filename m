References: <20161129063843.14526-1-a@...2181...>
	<aca99453-61e3-05aa-f683-cf385a7e90f6@...1435...>
	<20161130011609.GO19791@...2182...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <c31d4b2f-7c98-8482-1985-ace1d3fb4d01@...1435...>
Date: Wed, 30 Nov 2016 09:27:01 +0100
MIME-Version: 1.0
In-Reply-To: <20161130011609.GO19791@...2182...>
Subject: Re: [Openvpn-devel] [PATCH] reload CRL only if file was modified
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On 30-11-16 02:16, Antonio Quartulli wrote:
> Do I really need to split declaration and definition? Or can I just
> doxy-document the definition in the same place where it is now?

Well, either add a declaration at the top of the file (before the first
usage), or move the function up to before the first usage and document
it without splitting it.

>> This can be done without the 'reload' argument too, something like:
>>
>>   /* if something goes wrong with stat(), we'll store 0 as mtime */
>>   platform_stat_t crl_stat = {0};
>>
>>   if (crl_file_inline)
>>     {
>>       /*
>>        * an inline CRL can't change at runtime, therefore there is no
>> need to
>>        * reload it. It will be reloaded upon config change + SIGHUP.
>>        */
>>       if (ssl_ctx->crl_last_mtime.tv_sec)
>> 	return;
>>       else
>>         crl_stat.st_mtime = now; /* Set dummy mtime */
>>     }
>>   else
>>     {
>>       platform_stat (crl_file, &crl_stat);
>>     }
>>
>>   /*
>>    * If this is not a reload, update the CRL right away.
>>    * Otherwise, update only if the CRL file was modified after the last
>> reload.
>>    * Note: Windows does not support tv_nsec.
>>    */
>>   if (ssl_ctx->crl_last_mtime.tv_sec <= crl_stat.st_mtime)
>>     {
>>       ssl_ctx->crl_last_mtime.tv_sec = crl_stat.st_mtime;
>>       backend_tls_ctx_reload_crl (ssl_ctx, crl_file, crl_file_inline);
>>     }
>>
>> I slightly prefer this over adding the extra argument, but can live with
>> your approach just fine too.  Pick what you like best :)
> 
> I guess the assumption here is that crl_last_mtime.tv_sec is initialized with 0.
> This would make your code work. And yeah, I also prefer to avoid the reload
> argument ;)

Correct.  This might not be immediately clear in the code, but we have
the good habit of zero-initilializing structs like this :)

> Will make these changes and resend the patch.

Thanks!

-Steffan


