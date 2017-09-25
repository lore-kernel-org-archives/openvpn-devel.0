References: <1505424872-27434-1-git-send-email-steffan.karger@...1435...>
 <97d5028c-4861-320b-c5ef-3e09de45e983@...2181...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <00bccb6d-164e-3773-105a-9d2e7014ba9f@...1856...>
Date: Mon, 25 Sep 2017 18:05:43 +0200
MIME-Version: 1.0
In-Reply-To: <97d5028c-4861-320b-c5ef-3e09de45e983@...2181...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 1/2] Don't throw fatal errors from
 create_temp_file()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On 21-09-17 19:15, Antonio Quartulli wrote:
> On 15/09/17 05:34, Steffan Karger wrote:
>> diff --git a/src/openvpn/pf.c b/src/openvpn/pf.c
>> index 5cb002b..5fe1734 100644
>> --- a/src/openvpn/pf.c
>> +++ b/src/openvpn/pf.c
>> @@ -639,10 +639,10 @@ pf_init_context(struct context *c)
>>                  }
>>  #endif
>>              }
>> -            else
>> -            {
>> -                msg(M_WARN, "WARNING: OPENVPN_PLUGIN_ENABLE_PF disabled");
>> -            }
> 
> Why removing this chunk above? Isn't that supposed to be printed when
> the init function of the plugin fails?

Because it's no longer true; instead of disabling the firewall, we will
now reject the connection.  I tried to explain that in the commit message:

> On 15/09/17 05:34, Steffan Karger wrote:
>> Note that this changes the behavior for pf plugins: instead of just not
>> initializing the firewall rules and happily continuing, this now rejects
>> the client in the case of an (unlikely) failure to initialize the pf.

I think rejecting a client is the sensible thing to do when initializing
the firewall failed.  (Rather than accepting the client and not
enforcing the firewall rules.)

>> +        }
>> +        if (!c->c2.pf.enabled)
>> +        {
>> +            register_signal(c, SIGUSR1, "plugin-pf-init-failed");
>>          }
> 
> Maybe it's just me missing how the signaling part really works, but what
> happens on the server when the SIGUSR1 is delivered? And why registering
> the signal when PF is disabled? I am missing something I think...

This registers a SIGUSR1 on the instance context, not the top-level
context.  This leads to an instance reset.  See e.g. check_tls_errors(),
which does the same in case of an error (or even uses SIGTERM, if
--tls-exit is used).

Registering a signal is how error reporting is this part of the code works.

>>      }
>>  #endif /* ifdef PLUGIN_PF */
>> diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
>> index 9cd36d7..df2736c 100644
>> --- a/src/openvpn/ssl_verify.c
>> +++ b/src/openvpn/ssl_verify.c
>> @@ -547,14 +547,14 @@ verify_cert_export_cert(openvpn_x509_cert_t *peercert, const char *tmp_dir, stru
>>      FILE *peercert_file;
>>      const char *peercert_filename = "";
>>  
>> -    if (!tmp_dir)
>> +    /* create tmp file to store peer cert */
>> +    if (!tmp_dir ||
>> +        !(peercert_filename = create_temp_file(tmp_dir, "pcf", gc)))
> 
> || at the beginning of the next line (as mentioned in my previous email)

Will do, once we agree on the above discussion points.

Hope this clarifies things.

-Steffan

