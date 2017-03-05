MIME-Version: 1.0
Sender: emmanueldeloget53@...277...
In-Reply-To: <3af72d9f-1d38-f9c7-8ebd-3ac16baa09c4@...1856...>
References: <79d89580db6fd92c059dabc4f5f4d83b72bb9d3d.1487859361.git.logout@...260...>
	<201703050953.v259rZMs067447@...2054...>
	<3af72d9f-1d38-f9c7-8ebd-3ac16baa09c4@...1856...>
From: Emmanuel Deloget <logout@...260...>
Date: Sun, 5 Mar 2017 13:08:09 +0100
Message-ID: <CAKh=nwEE3vXYcmtr5cvcCjQMjY2SZNGwAjY8eMzEh1wxHUJTrw@...278...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: OpenSSL: don't use direct
 access to the internal of RSA_METHOD
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
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On Sun, Mar 5, 2017 at 11:29 AM, Steffan Karger <steffan@...1856...> wrote:
>
> On 05-03-17 10:53, Gert Doering wrote:
>> Small side note: I assume that RSA_meth_new() can fail and return NULL
>> in OpenSSL 1.1?  Because for 1.0, the "check_malloc_return(rsa_meth)" call
>> isn't necessary, as ALLOC_OBJ_CLEAR() would call ALLOC_OBJ() and that
>> already checks...  (mentioning this here in case someone wonders and goes
>> to the list archives).
>
> For the archives: yes, RSA_meth_new() indeed returns NULL if it's
> internal malloc() call fails.

Yes, indeed. And that's the reason why I have a check_malloc_return()
here. I'm perfectly conscious that for OpenSSL < 1.1 we're checking
the pointer twice but on the other hand I would have missed the check
with OpenSSL 1.1. A solution would have been to use a direct
malloc()/calloc() call instead of ALLOC_OBJ_CLEAR() in the
compatibility code, but that would have looked weird. Another solution
would have been to encapsulate RSA_meth_new() but I don't think that
would have been a good idea (yet, I might be wrong on that one). So I
did this choice -- I don't like it much either but I cannot think of a
better solution.

> -Steffan

Best regards,

-- Emmanuel Deloget

