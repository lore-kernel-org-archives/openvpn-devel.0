References: <c39d1e54-04f8-8ca3-34dc-5d023078286a@...2181...>
 <1505457556-8557-1-git-send-email-steffan.karger@...1435...>
 <af093d4a-50c1-d18c-11d7-1f6a84fa130c@...2080...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <3dadff5b-c169-30b1-c4fe-27f9dd39edae@...1856...>
Date: Mon, 25 Sep 2017 18:22:51 +0200
MIME-Version: 1.0
In-Reply-To: <af093d4a-50c1-d18c-11d7-1f6a84fa130c@...2080...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v2] pf: clean up temporary files if
 plugin init fails
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On 21-09-17 23:03, David Sommerseth wrote:
> On 15/09/17 08:39, Steffan Karger wrote:
>> close_instance() tries to remove the file in c2.pf.filename, but that only
>> works if we actually set that if we fail.  So, set that filename as soon
>> as we know we've created the file.
>>
>> Signed-off-by: Steffan Karger <steffan.karger@...1435...>
>> ---
>> v2: As suggested by Antionio, get rid of local 'gc' and 'file' vars.
>>
>>  src/openvpn/pf.c | 10 ++++------
>>  1 file changed, 4 insertions(+), 6 deletions(-)
>>
>> diff --git a/src/openvpn/pf.c b/src/openvpn/pf.c
>> index 5fe1734..7479347 100644
>> --- a/src/openvpn/pf.c
>> +++ b/src/openvpn/pf.c
>> @@ -618,19 +618,18 @@ pf_load_from_buffer_list(struct context *c, const struct buffer_list *config)
>>  void
>>  pf_init_context(struct context *c)
>>  {
>> -    struct gc_arena gc = gc_new();
>>  #ifdef PLUGIN_PF
>>      if (plugin_defined(c->plugins, OPENVPN_PLUGIN_ENABLE_PF))
>>      {
>> -        const char *pf_file = create_temp_file(c->options.tmp_dir, "pf", &gc);
>> -        if (pf_file)
>> +        c->c2.pf.filename = create_temp_file(c->options.tmp_dir, "pf",
>> +                                             &c->c2.gc);
> 
> Patch looks good.  But it introduces a new compile warning.
> 
> pf.c: In function ‘pf_init_context’:
> pf.c:624:27: warning: assignment discards ‘const’ qualifier from pointer target type [enabled by default]
>          c->c2.pf.filename = create_temp_file(c->options.tmp_dir, "pf",
> 
> I'm pondering if we need create_temp_file() to actually return
> a const char * - wouldn't just a plain char * be enough?

Good point.  But I think it's best to return a const char * here,
because the memory is allocated through a gc and therefore should also
be free'd through the gc.  The const modifier prevents freeing the data
without a warning (as long as you keep smacking me for discarding const
qualifiers, or we add a -Werror compile flag ;-) ).

> The alternative is to cast the const away here; but that just
> feels too hacky in this code path.

Or change c->c2.filename to be const char *.  I think that's the way to
go here.  And possibly reject a NULL gc argument in create_temp_file(),
because that would make the function leak memory...

What do you think?

-Steffan

