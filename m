MIME-Version: 1.0
In-Reply-To: <CAP+U6t+A2X1xtEt-ZGZfByjJ=Cipx0LwBYRupY9NdXiiCUbK6w@...278...>
References: <1333041552-6752-1-git-send-email-alon.barlev@...277...>
	<1333366661-6711-1-git-send-email-alon.barlev@...277...>
	<CAP+U6t+A2X1xtEt-ZGZfByjJ=Cipx0LwBYRupY9NdXiiCUbK6w@...278...>
Date: Thu, 26 Apr 2012 19:08:52 +0300
Message-ID: <CAOazyz0aA-RSHnSLo3STqJAS+xUK8warVS0oK3gs7g7x52=hkw@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] cleanup: add .gitattributes to control
 eol style explicitly
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Fabian Knittel <fabian.knittel@...1547...>
Cc: Openvpn-devel@lists.sourceforge.net

On Thu, Apr 26, 2012 at 3:45 PM, Fabian Knittel
<fabian.knittel@...1547...> wrote:
> Hi Alon,
>
> 2012/4/2 Alon Bar-Lev <alon.barlev@...277...>:
>> Having the text auto detection is a risk, as the detection may detect
>> text files that are not text and vise versa.
>>
>> Having global setting will create confusion and differentiate between
>> users. So this patch also move this to local repository.
>
> IMHO, this is a real benefit. Reduces the number of steps necessary to
> contribute and avoids line-ending mistakes for new contributions.
>
>> Having git to check out files differently in different OS is also
>> a not correct, as checkouts may be used in shares or in *NIX emulation
>> environments, so it have no effect.
>>
>> Another issue is packaging, if we change out the tree differently
>> in several OSes, we may have different package content, which is
>> something that should be avoided.
>>
>> Currently any editor of MS supports LF end of lines, so there is no
>> need to convert source files while checking out.
>>
>> The visual studio files should be stored as CRLF as they are generated
>> by visual studio every save, in a way that CRLF are added.
>>
>> I handled only the files that may be touch by MS users.
>
> The rest I generally agree with, but don't have strong feelings about them.
>
>> diff --git a/.gitattributes b/.gitattributes
>> new file mode 100644
>> index 0000000..34463f9
>> --- /dev/null
>> +++ b/.gitattributes
>> @@ -0,0 +1,7 @@
>> +*.c eol=lf
>> +*.h eol=lf
>> +*.rc eol=lf
>> +*.txt eol=lf
>> +*.bat eol=lf
>> +*.vc*proj* eol=crlf
>> +*.sln eol=crlf
>
> Why not .rc and .bat as crlf too?

These sources are valid as LF only, unlike the .vc*, .sln they are not
re-generated in different format every time saved, so keeping them in
"UNIX" style will make it easier to maintain.

>
> Apart from that, ACK.
>
> Cheers
> Fabian

