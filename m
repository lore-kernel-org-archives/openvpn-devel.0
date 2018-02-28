MIME-Version: 1.0
In-Reply-To: <2cdaf8b4-cc76-d7e5-a718-bd321d575acd@...1227...>
References: <20180228131918.12954-1-davids@...515...>
 <20180228131918.12954-3-davids@...515...>
 <2cdaf8b4-cc76-d7e5-a718-bd321d575acd@...1227...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 28 Feb 2018 10:35:35 -0500
Message-ID: <CAKuzo_hHiMs4V6AiPo31pcZSRGb2aLHK0E9=GkDjFkw8gNk=Jw@...278...>
Subject: Re: [Openvpn-devel] [PATCH 3/3] management: Warn if TCP port is
 used without password
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>
Cc: David Sommerseth <davids@...515...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On Wed, Feb 28, 2018 at 8:34 AM, Arne Schwabe <arne@...1227...> wrote:
> Am 28.02.18 um 14:19 schrieb David Sommerseth:
>> It is not recommended to use --management on a TCP port without also
>> adding a password authentication, as this can easily be abused by other
>> users or processes being able to connect to the managmement interface.
>>
>> Thus issue a warning that this configuration is strongly discouraged.
>>
>> Signed-off-by: David Sommerseth <davids@...515...>
>> ---
>>  src/openvpn/options.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
>> index 41a42cf2..e0c0894b 100644
>> --- a/src/openvpn/options.c
>> +++ b/src/openvpn/options.c
>> @@ -2170,6 +2170,14 @@ options_postprocess_verify_ce(const struct options *options, const struct connec
>>      {
>>          msg(M_USAGE, "--management-client-(user|group) can only be used on unix domain sockets");
>>      }
>> +
>> +    if (!(options->management_flags & MF_UNIX_SOCK)
>> +        && (!options->management_user_pass))
>> +    {
>> +        msg(M_WARN, "WARNING: Using --management on a TCP port WITHOUT "
>> +            "passwords is STRONGLY discouraged and considered insecure");
>> +    }
>> +
>>  #endif
>>
>>      /*
>>
>
> Does not break existing configs and warns about a real problem. Some
> users of management might scream that, users now get a warning none was
> before but honestely I don't care.
>
> @All does our own Windows UI use management and if yes does it set a
> random user/pw to connect to it?

Yes and yes.

Selva

