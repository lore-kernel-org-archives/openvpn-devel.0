MIME-version: 1.0
Message-id: <4F2EA949.4050400@...384...>
Date: Sun, 05 Feb 2012 17:07:37 +0100
From: David Sommerseth <openvpn.list@...1114...>
References: <1328442685-8550-1-git-send-email-dejong@...1435...>
	<1328442685-8550-2-git-send-email-dejong@...1435...>
	<20120205155727.GA9813@...1296...>
In-reply-to: <20120205155727.GA9813@...1296...>
Subject: Re: [Openvpn-devel] [PATCH 2/2] Removed support for calling
	gc_malloc	with a NULL gc_arena struct
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

On 05/02/12 16:57, Gert Doering wrote:
> Hi,
>
> On Sun, Feb 05, 2012 at 12:51:25PM +0100, Adriaan de Jong wrote:
>> Signed-off-by: Adriaan de Jong<dejong@...1435...>
>> ---
>>   buffer.c |   29 ++++++++++-------------------
>>   1 files changed, 10 insertions(+), 19 deletions(-)
>>
>> diff --git a/buffer.c b/buffer.c
>> index 2f8e4b8..c39bbcb 100644
>> --- a/buffer.c
>> +++ b/buffer.c
>> @@ -310,28 +310,19 @@ gc_malloc (size_t size, bool clear, struct gc_arena *a)
>>   #endif
>>   {
>>     void *ret;
>> -  if (a)
>> -    {
>> -      struct gc_entry *e;
>
> NACK on that.  We discovered that there are use cases where "second-level"
> callers pass NULL, seemingly on purpose to allocate global memory instead
> of "in the GC".
>
> main(), in openvpn.c:
>
>            /* initialize environmental variable store */
>            c.es = env_set_create (NULL);
>
> ... which calls into misc.c:
>
> struct env_set *
> env_set_create (struct gc_arena *gc)
> {
>    struct env_set *es;
>    ALLOC_OBJ_CLEAR_GC (es, struct env_set, gc);
>    es->list = NULL;
>    es->gc = gc;
>    return es;
> }
>
> ... and boom, assert() fail.
>
>
> Adriaan saw the crash ("my nice OpenBSD test run!!!") and promised to work
> on this on the way back in the train.

But should this actually call gc_malloc() in this case?  gc_malloc is 
for things which are supposed to be tackled by the garbage collector.

Things aren't too easy here - but I'd rather see us cleaning up this 
instead of making gc_malloc() vague in its purpose.

$ git grep env_set_create
init.c:  c->c2.es = env_set_create (NULL);
manage.c:  struct env_set *es = env_set_create (&gc);
misc.c:env_set_create (struct gc_arena *gc)
misc.h:struct env_set *env_set_create (struct gc_arena *gc);
multi.c:    es = env_set_create (&gc);
openvpn.c:        c.es = env_set_create (NULL);

There are two places where env_set_create() is called with NULL.  Let's 
rather see if we can provide a gc_arena pointer those places instead. 
Or do something which is more clear in regards to memory allocation in 
env_set_create().


kind regards,

David Sommerseth

