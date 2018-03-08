References: <1477918318-18561-1-git-send-email-davids@...515...>
 <1477918318-18561-2-git-send-email-davids@...515...>
 <a1d526a0-3203-2033-5e95-b912c3793414@...1227...>
Reply-To: openvpn-devel@lists.sourceforge.net
From: David Sommerseth <openvpn@...2080...>
Message-ID: <bbdbdbe9-9cde-2137-9e99-1f7a1a35155d@...2080...>
Date: Thu, 8 Mar 2018 15:25:00 +0100
MIME-Version: 1.0
In-Reply-To: <a1d526a0-3203-2033-5e95-b912c3793414@...1227...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH 1/2] Refactor to provide struct context
 object inside key_method_2_read()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Arne Schwabe <arne@...1227...>, Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

On 08/03/18 15:18, Arne Schwabe wrote:
> Am 31.10.16 um 13:51 schrieb David Sommerseth:
>> This refactors the call chain of  tls_multi_process(), tls_process()
>> and key_method_2_read() so the the latter function have access
>> to the struct context object.
>>
>> This change is needed for the following patch where verify_user_pass()
>> will need to call send_auth_failed(), which depends on direct access
>> to the the context object.
>>
>> Signed-off-by: David Sommerseth <davids@...515...>
>> ---
>>  src/openvpn/forward.c |  2 +-
>>  src/openvpn/ssl.c     | 28 ++++++++++++++++------------
>>  src/openvpn/ssl.h     |  6 +-----
>>  3 files changed, 18 insertions(+), 18 deletions(-)
>>
>> diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
>> index b3077ed..7dafd53 100644
>> --- a/src/openvpn/forward.c
>> +++ b/src/openvpn/forward.c
>> @@ -96,7 +96,7 @@ check_tls_dowork (struct context *c)
>>  
>>    if (interval_test (&c->c2.tmp_int))
>>      {
>> -      const int tmp_status = tls_multi_process
>> +      const int tmp_status = tls_multi_process(c, &wakeup);
>>  	(c->c2.tls_multi, &c->c2.to_link, &c->c2.to_link_addr,
>>
> 
> This part of the patch looks just wrong. The
> 
>  	(c->c2.tls_multi, &c->c2.to_link, &c->c2.to_link_addr,
>  	 get_link_socket_info (c), &wakeup);
> 
> will stand alone.

Yeah, that gotta be a commit error.  That said, I remember Steffan not
agreeing with this re-factoring approach.  As, we're passing quite some data
around in these large and more global structs.  We need to look into how to
make send_auth_failed() work in a smaller set of context than the main 'c'
context.


-- 
kind regards,

David Sommerseth
OpenVPN Inc


